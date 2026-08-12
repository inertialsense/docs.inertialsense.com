# External Aiding

## Overview

External aiding lets a host computer or an external sensor feed observations directly into the IMX EKF, independent of any GNSS receiver. This is useful when the platform has a sensor the IMX cannot otherwise see — for example a second INS, a vision or SLAM system, an alternate GNSS receiver, an airspeed/pitot sensor, a compass, or an RTK correction service running on the host.

Seven data sets are available:

| DID                          | Struct                    | Observation                          | Fused by the EKF |
| ----------------------------- | -------------------------- | ------------------------------------- | :---------------: |
| `DID_EXT_AIDING_POS`          | `ext_aiding_pos_t`         | Position                              | Yes |
| `DID_EXT_AIDING_VEL`          | `ext_aiding_vel_t`         | Velocity                              | Yes |
| `DID_EXT_AIDING_SPEED`        | `ext_aiding_speed_t`       | Scalar speed (3D or horizontal)       | Yes |
| `DID_EXT_AIDING_DIR_SPEED`    | `ext_aiding_dir_speed_t`   | Directional speed (e.g. airspeed)     | Yes |
| `DID_EXT_AIDING_HEADING`      | `ext_aiding_heading_t`     | Heading (true, magnetic, or course)   | Yes |
| `DID_EXT_AIDING_ATTITUDE`     | `ext_aiding_attitude_t`    | Full attitude (euler or quaternion)   | Yes |
| `DID_EXT_IMU`                 | `imu_t`                    | Gyro/accel                            | No — see [below](#did_ext_imu) |

All seven are independent — supply whichever ones match the sensors you have. Each carries its own GPS time of week and a discard-on-invalid observation variance (or, for attitude, a full covariance matrix).

!!! important
    A non-positive variance (or, for `DID_EXT_AIDING_ATTITUDE`, a non-positive covariance diagonal) causes the entire observation to be discarded by the EKF. Variance must always reflect a realistic (non-zero) uncertainty of the measurement — do not use zero to mean "perfect" or "unknown."

## Position and Velocity

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
- **`var`** — per-axis observation variance in NED; report your source's actual uncertainty, since this is what the EKF weights the observation by and what its outlier (NIS) gate checks the innovation against. In dynamic environments, inflate it to also cover the error that `timeOfWeekMs` timestamp uncertainty induces from vehicle motion — for a position observation this is timestamp uncertainty × speed, and for a velocity observation it's timestamp uncertainty × acceleration — not just the sensor's own noise.

## Speed

`DID_EXT_AIDING_SPEED` carries a scalar speed with no direction — for example a wheel-speed sensor or a GNSS-derived ground speed that doesn't expose a velocity vector.

```c
enum eExtAidingSpeedType
{
    EXT_AIDING_SPEED_TYPE_MASK       = 0x0000000F,
    EXT_AIDING_SPEED_TYPE_3D         = 1,  // full 3D velocity magnitude, |v|
    EXT_AIDING_SPEED_TYPE_HORIZONTAL = 2   // horizontal (ground) velocity magnitude only, |v_NE|
};

/** (DID_EXT_AIDING_SPEED) External aiding scalar speed observation. */
typedef struct PACKED
{
    uint32_t   timeOfWeekMs; // GPS time of week (since Sunday morning) in milliseconds
    uint32_t   status;       // Speed type, 1=3D magnitude, 2=horizontal magnitude (see eExtAidingSpeedType)
    float      speed;        // speed (m/s)
    float      var;          // observation variance (m^2/s^2). Must be positive or the observation is discarded.
    float      offset[3];    // point of measurement relative to IMU origin in IMU/body frame {x,y,z} (m)
} ext_aiding_speed_t;
```

## Directional Speed (Airspeed)

`DID_EXT_AIDING_DIR_SPEED` carries a speed measured along a fixed direction in the IMU/body frame — the natural fit for an airspeed/pitot sensor, which measures flow along the direction it's pointed (typically the body X axis).

```c
/** (DID_EXT_AIDING_DIR_SPEED) External aiding directional speed observation. `direction` is a
 *  unit vector in the IMU/body frame (e.g. [1,0,0] for a forward-pointing airspeed sensor);
 *  `speed` is the velocity component along that direction at the point of measurement. */
typedef struct PACKED
{
    uint32_t   timeOfWeekMs; // GPS time of week (since Sunday morning) in milliseconds
    uint32_t   status;       // reserved, set to 0
    float      speed;        // speed along `direction` (m/s)
    float      var;          // observation variance (m^2/s^2). Must be non-zero or the observation is discarded.
    float      offset[3];    // point of measurement relative to IMU origin in IMU/body frame {x,y,z} (m)
    float      direction[3]; // unit vector, in IMU/body frame, along which `speed` is measured
} ext_aiding_dir_speed_t;
```

## Heading

`DID_EXT_AIDING_HEADING` carries a single heading angle, in one of three senses:

```c
enum eExtAidingHeadingType
{
    EXT_AIDING_HEADING_TYPE_MASK     = 0x0000000F,
    EXT_AIDING_HEADING_TYPE_TRUE     = 1, // true heading (body X axis bearing relative to true north)
    EXT_AIDING_HEADING_TYPE_MAGNETIC = 2, // magnetic heading (converted to true using the EKF's declination estimate)
    EXT_AIDING_HEADING_TYPE_COURSE   = 3  // course over ground (direction of travel — not necessarily the same as body heading)
};

/** (DID_EXT_AIDING_HEADING) External aiding heading observation. */
typedef struct PACKED
{
    uint32_t   timeOfWeekMs; // GPS time of week (since Sunday morning) in milliseconds
    uint32_t   status;       // Heading type, 1=true, 2=magnetic, 3=course over ground (see eExtAidingHeadingType)
    float      heading;      // heading (rad), 0 = north, positive clockwise, range [-pi, pi]
    float      var;          // observation variance (rad^2). Must be non-zero or the observation is discarded.
} ext_aiding_heading_t;
```

!!! note
    `TRUE`/`MAGNETIC` heading are treated as an attitude observation (the bearing the vehicle is physically pointed). `COURSE` (over ground) is treated as a velocity-direction observation instead — the direction the vehicle is actually moving, which can differ from body heading under sideslip, wind, or current. Don't use `COURSE` in place of `TRUE`/`MAGNETIC` if what you actually have is a compass.

## Attitude

`DID_EXT_AIDING_ATTITUDE` carries a full 3-axis attitude, from a source such as a second INS, with a full 3x3 attitude-error covariance rather than a per-axis variance.

```c
enum eExtAidingAttitudeType
{
    EXT_AIDING_ATTITUDE_TYPE_MASK       = 0x0000000F,
    EXT_AIDING_ATTITUDE_TYPE_EULER      = 1, // att = {roll, pitch, yaw} (rad); att[3] unused
    EXT_AIDING_ATTITUDE_TYPE_QUATERNION = 2  // att = {w, x, y, z}
};

/** (DID_EXT_AIDING_ATTITUDE) External aiding attitude observation. `var` is the 3x3
 *  attitude-error covariance (row-major), expressed as a small-angle roll/pitch/yaw rotation
 *  vector regardless of whether `att` is euler or quaternion. */
typedef struct PACKED
{
    uint32_t   timeOfWeekMs; // GPS time of week (since Sunday morning) in milliseconds
    uint32_t   status;       // Attitude representation, 1=euler, 2=quaternion (see eExtAidingAttitudeType)
    float      att[4];       // attitude, interpreted per `status`: euler {roll,pitch,yaw,-} or quaternion {w,x,y,z}
    float      var[9];       // 3x3 row-major attitude-error covariance (rad^2). Must have a non-zero diagonal or the observation is discarded.
} ext_aiding_attitude_t;
```

## DID_EXT_IMU

`DID_EXT_IMU` carries a raw gyro/accel sample from an external IMU. It reuses the SDK's existing `imu_t` — the same struct as `DID_IMU`/`DID_IMU_RAW`/`DID_REFERENCE_IMU` — rather than a bespoke type. Unlike the other six types, **it is not currently fused by the EKF** — the DID exists so an external IMU can be streamed to and logged by the IMX (e.g. for offline analysis or a future consistency-check/blended time-update path), but it has no effect on the navigation solution today.

```c
/** (DID_IMU, DID_IMU_RAW, DID_REFERENCE_IMU, DID_EXT_IMU) Single combined Inertial Measurement
 *  Unit (IMU) sample, in body/sensor frame. */
typedef struct PACKED
{
    double      time;    // Time since boot up in seconds. Convert to GPS time of week by adding gps.towOffset
    uint32_t    status;  // IMU status flags (eImuStatus)
    imui_t      I;       // Combined IMU sample: angular rate and acceleration
} imu_t;

/** Single IMU sample: angular rate and acceleration, in the sensor/body frame. */
typedef struct PACKED
{
    float       pqr[3];  // Gyroscope P, Q, R (angular rate about body X, Y, Z) in radians/second
    float       acc[3];  // Acceleration X, Y, Z in meters/second^2, in body frame
} imui_t;
```

Because `DID_EXT_IMU` reuses `imu_t` as-is, its `time` field is seconds since boot (matching `DID_IMU`'s convention), not the GPS time-of-week-in-milliseconds convention the other six external aiding types use — convert using the same `gps.towOffset` relationship other IMU DIDs use if you need GPS time.

!!! note
    `DID_EXT_IMU` also has no relay/logging RMC bit (unlike the six fused types below), so it can't be relayed to another port for logging the way the others can — poll or stream it directly from the port it's written to.

## Sending Data to the IMX

All seven DIDs are writable. A host streams an observation to the IMX using the SDK's [Set Data](../com-protocol/isb.md#setting-data) method on any connected port, the same as any other writable DID. Each write is consumed on arrival — there is no need to hold a channel open or stream continuously; send an observation whenever a new one is available from your source.

For bring-up or quick testing, an observation can be injected directly with the CLTool:

```
cltool -c /dev/ttyUSB0 -set "{DID_EXT_AIDING_POS: {status: 1, timeOfWeekMs: <tow>, pos: [<x>, <y>, <z>], offset: [0,0,0], var: [4.0, 4.0, 9.0]}}"

cltool -c /dev/ttyUSB0 -set "{DID_EXT_AIDING_VEL: {status: 1, timeOfWeekMs: <tow>, vel: [<vx>, <vy>, <vz>], offset: [0,0,0], var: [0.25, 0.25, 0.25]}}"

cltool -c /dev/ttyUSB0 -set "{DID_EXT_AIDING_SPEED: {status: 1, timeOfWeekMs: <tow>, speed: <s>, offset: [0,0,0], var: 0.25}}"

cltool -c /dev/ttyUSB0 -set "{DID_EXT_AIDING_DIR_SPEED: {status: 0, timeOfWeekMs: <tow>, speed: <s>, offset: [0,0,0], direction: [1,0,0], var: 0.25}}"

cltool -c /dev/ttyUSB0 -set "{DID_EXT_AIDING_HEADING: {status: 1, timeOfWeekMs: <tow>, heading: <rad>, var: 0.01}}"

cltool -c /dev/ttyUSB0 -set "{DID_EXT_AIDING_ATTITUDE: {status: 1, timeOfWeekMs: <tow>, att: [<roll>,<pitch>,<yaw>,0], var: [0.01,0,0, 0,0.01,0, 0,0,0.01]}}"
```

## Logging Received Observations

Whatever external aiding observations the IMX receives — from a host or from a GPX-1 (see below) — are relayed unmodified to any other port that has the corresponding RMC bit enabled, so the aiding data supplied to the IMX can be logged or inspected on a host PC:

| RMC Bit                        | Relays          |
| -------------------------------- | ---------------- |
| `RMC_BITS_EXT_AIDING_POS`        | `DID_EXT_AIDING_POS` |
| `RMC_BITS_EXT_AIDING_VEL`        | `DID_EXT_AIDING_VEL` |
| `RMC_BITS_EXT_AIDING_SPEED`      | `DID_EXT_AIDING_SPEED` |
| `RMC_BITS_EXT_AIDING_DIR_SPEED`  | `DID_EXT_AIDING_DIR_SPEED` |
| `RMC_BITS_EXT_AIDING_HEADING`    | `DID_EXT_AIDING_HEADING` |
| `RMC_BITS_EXT_AIDING_ATTITUDE`   | `DID_EXT_AIDING_ATTITUDE` |

`DID_EXT_IMU` has no RMC bit and is not relayed (see [above](#did_ext_imu)). All six bits above are included in the IMX PPD presets by default. All seven DIDs appear in the EvalTool's **Data Sets** and **Logger** tabs.

!!! note
    Enabling these bits on the IMX only controls whether received observations are relayed back out for logging — it has no effect on whether the EKF consumes them. The EKF always fuses whatever valid external aiding data it receives on any port (except `DID_EXT_IMU`, which it doesn't consume at all today).

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
- (IMX/SDK) SN-8318 — `DID_EXT_AIDING_SPEED`/`DID_EXT_AIDING_DIR_SPEED`/`DID_EXT_AIDING_HEADING`/`DID_EXT_AIDING_ATTITUDE`/`DID_EXT_IMU` added.

<a href="https://inertialsense.com/"><center>

![Logo](../images/IS_LOGO_BLACK_F03.svg)

</center></a>
