# External Aiding

## Overview

External aiding lets a host computer or an external sensor feed position and velocity observations directly into the IMX EKF, independent of any GNSS receiver. This is useful when the platform has a position/velocity source the IMX cannot otherwise see — for example a second INS, a vision or SLAM system, an alternate GNSS receiver, or an RTK correction service running on the host.

Two data sets are used:

| DID                  | Struct              | Observation |
| -------------------- | -------------------- | ----------- |
| `DID_EXT_AIDING_POS`  | `ext_aiding_pos_t`   | Position    |
| `DID_EXT_AIDING_VEL`  | `ext_aiding_vel_t`   | Velocity    |

Both are independent — you may supply position only, velocity only, or both. Each carries its own GPS time of week, the frame the measurement was taken in, the offset of the point of measurement from the IMU origin, and a per-axis observation variance.

!!! important
    A zero variance on any axis causes the entire observation to be discarded by the EKF. `var` must always reflect a realistic (non-zero) uncertainty of the measurement — do not use zero to mean "perfect" or "unknown."

## Data Structures

```c
/** Frame of measurement for an external aiding observation, held in the low nibble of
 *  ext_aiding_pos_t.status / ext_aiding_vel_t.status. Note 0 is not a valid frame. */
enum eExtAidingFrame
{
    EXT_AIDING_FRAME_MASK    = 0x0000000F,  // Mask for the frame of measurement
    EXT_AIDING_FRAME_ECEF    = 1,           // ECEF frame
    EXT_AIDING_FRAME_NED     = 2,           // NED frame
    EXT_AIDING_FRAME_BODY    = 3            // Body frame
};

/** (DID_EXT_AIDING_POS) External aiding position observation, supplied by a host or external
 *  sensor as an input to the INS/EKF. Position is expected in ECEF; var is expected in NED. */
typedef struct PACKED
{
    uint32_t   timeOfWeekMs; // GPS time of week (since Sunday morning) in milliseconds
    uint32_t   status;       // Frame of measurement, 1=ECEF, 2=NED, 3=Body (see eExtAidingFrame)
    double     pos[3];       // position {x,y,z} (m)
    float      offset[3];    // point of measurement relative to IMU origin in IMU/body frame {x,y,z} (m)
    float      var[3];       // observation variance, per axis, in NED (m^2). Must be non-zero or the observation is discarded.
} ext_aiding_pos_t;

/** (DID_EXT_AIDING_VEL) External aiding velocity observation, supplied by a host or external
 *  sensor as an input to the INS/EKF. Velocity is expected in ECEF; var is expected in NED. */
typedef struct PACKED
{
    uint32_t   timeOfWeekMs; // GPS time of week (since Sunday morning) in milliseconds
    uint32_t   status;       // Frame of measurement, 1=ECEF, 2=NED, 3=Body (see eExtAidingFrame)
    float      vel[3];       // velocity {vx,vy,vz} (m/s)
    float      offset[3];    // point of measurement relative to IMU origin in IMU/body frame {x,y,z} (m)
    float      var[3];       // observation variance, per axis, in NED (m^2/s^2). Must be non-zero or the observation is discarded.
} ext_aiding_vel_t;
```

- **`timeOfWeekMs`** — GPS time of week the observation was taken. Used by the EKF to align the observation against its own delayed-state history. If the observation is more than 200 ms old relative to the IMX's current IMU time, its timestamp is clamped and the fix loses some of its benefit — keep aiding latency well under this.
- **`status`** — the coordinate frame the measurement was taken in (see `eExtAidingFrame`). `pos`/`vel` are expected in ECEF and `var` is always expressed in NED regardless of `status`.
- **`offset`** — the lever arm from the IMU origin to the point of measurement (e.g. the antenna phase center of an external GNSS receiver), expressed in the IMU/body frame. Set to `[0,0,0]` if the source measures at the IMU origin.
- **`var`** — per-axis observation variance in NED. This is what the EKF weights the observation by, and what its outlier (NIS) gate checks the innovation against — report your source's actual uncertainty rather than an optimistic value.

## Sending Data to the IMX

`DID_EXT_AIDING_POS` and `DID_EXT_AIDING_VEL` are writable. A host streams an observation to the IMX using the SDK's [Set Data](../com-protocol/isb.md#setting-data) method on any connected port, the same as any other writable DID. Each write is consumed on arrival — there is no need to hold a channel open or stream continuously; send an observation whenever a new one is available from your source.

For bring-up or quick testing, an observation can be injected directly with the CLTool:

```
cltool -c /dev/ttyUSB0 -set "{DID_EXT_AIDING_POS: {status: 1, timeOfWeekMs: <tow>, pos: [<x>, <y>, <z>], offset: [0,0,0], var: [4.0, 4.0, 9.0]}}"

cltool -c /dev/ttyUSB0 -set "{DID_EXT_AIDING_VEL: {status: 1, timeOfWeekMs: <tow>, vel: [<vx>, <vy>, <vz>], offset: [0,0,0], var: [0.25, 0.25, 0.25]}}"
```

## Logging Received Observations

Whatever external aiding observations the IMX receives — from a host or from a GPX-1 (see below) — are relayed unmodified to any other port that has the corresponding RMC bit enabled, so the aiding data supplied to the IMX can be logged or inspected on a host PC:

| RMC Bit                     | Relays          |
| ---------------------------- | ---------------- |
| `RMC_BITS_EXT_AIDING_POS`    | `DID_EXT_AIDING_POS` |
| `RMC_BITS_EXT_AIDING_VEL`    | `DID_EXT_AIDING_VEL` |

Both bits are included in the IMX PPD presets by default. `DID_EXT_AIDING_POS` and `DID_EXT_AIDING_VEL` also appear in the EvalTool's **Data Sets** and **Logger** tabs.

!!! note
    Enabling these bits on the IMX only controls whether received observations are relayed back out for logging — it has no effect on whether the EKF consumes them. The EKF always fuses whatever valid `DID_EXT_AIDING_POS`/`DID_EXT_AIDING_VEL` data it receives on any port.

## Using a GPX-1 as an External Aiding Source

The GPX-1 can restate its own GNSS1 position/velocity solution as external aiding observations and stream them to a connected IMX, providing a ready-made source for exercising the IMX's external aiding path without a separate host integration.

This is enabled per output port with two opt-in GRMC bits, set on `DID_GPX_RMC.bits` the same way as any other GPX RMC bit (see [GPX-1 Quick Start](../../getting-started/GPX-1.md)):

| GRMC Bit                     | Emits             |
| ------------------------------ | ----------------- |
| `GRMC_BITS_EXT_AIDING_POS`     | `DID_EXT_AIDING_POS` |
| `GRMC_BITS_EXT_AIDING_VEL`     | `DID_EXT_AIDING_VEL` |

Behavior:

- Observations are emitted once per GNSS1 epoch, alongside `DID_GNSS1_POS`. GNSS2 is not supported — it is the compassing/moving-base receiver and does not carry a navigation solution.
- The fix must be at least 3D-class (3D, GNSS+dead-reckoning, DGPS, SBAS, or any RTK fix level). 2D, dead-reckoning-only, time-only, and surveyed/reference-position fixes are excluded.
- `var` is derived from the receiver's reported `hAcc`/`vAcc`/`sAcc`, floored at 0.01 m (position) / 0.01 m/s (velocity) so an optimistic or unreported accuracy is never presented as noise-free.
- `offset` is taken from `gnss1AntOffset` in the GPX's flash configuration.

!!! important
    These bits are deliberately excluded from `GRMC_PRESET_GPX_IMX`. If the IMX is already using this same GPX-1 as its GNSS receiver, also enabling external aiding from it would fuse the same solution into the EKF twice. Only enable these bits when the GPX-1's GNSS solution is being used to aid an *independent* IMX, or for bench testing the external aiding path itself.

## Related Change Log Entries

- (IMX/SDK) SN-8317, SN-8318 — `DID_EXT_AIDING_POS`/`DID_EXT_AIDING_VEL` added.
- (GPX-1) SN-8472 — GPX-1 restates its GNSS1 solution as external aiding observations.
- (IMX/EvalTool) SN-8317 — external aiding relay/logging support.

<a href="https://inertialsense.com/"><center>

![Logo](../images/IS_LOGO_BLACK_F03.svg)

</center></a>
