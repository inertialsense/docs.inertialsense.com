# GNSS Configuration

The IMX INS/EKF accepts aiding from one or two externally connected GNSS receivers. Support for multiple GNSS manufacturers and protocols allows receiver selection to suit the application. The IMX manages receiver communication and fuses position, velocity, and optional dual-antenna heading data into the EKF solution.

This section describes the settings and checks common to all receivers. Receiver-specific details are on the pages for each type.

## Supported Receivers

| Receiver | GNSS Type (value) | Protocol | Receivers and antennas | Dual-antenna RTK compassing (GNSS1 to GNSS2 antenna heading) |
| -------- | ----------------- | -------- | ---------------------- | ------------------------------------------------------------ |
| [u-blox ZED-F9P, ZED-X20](imx_gnss_ublox.md) | u-blox (1) | u-blox binary, RTCM3 | One receiver per antenna: GNSS1 and GNSS2 | Computed between the GNSS1 and GNSS2 receivers |
| [Septentrio Mosaic-G5](imx_gnss_septentrio.md) | Septentrio (4) | Septentrio Binary Format (SBF) | One receiver, two antenna inputs (Main and Aux1) | Computed inside the receiver |
| [Inertial Sense GPX-1](imx_gnss_gpx.md) | GPX (3) | Inertial Sense Binary (ISB) | Two receivers: GNSS1 and GNSS2 | Computed between the GNSS1 and GNSS2 receivers |
| [NMEA receiver](imx_gnss_nmea.md) | NMEA (2) | NMEA ASCII | One receiver (GNSS1, or GNSS2 via `ioConfig2`) | [TO CONFIRM] |
| [Host or other Inertial Sense device](imx_gnss_isb.md) | ISB (5) | ISB DID messages | Supplied by host | Supplied by host (`DID_GNSS2_RTK_CMP_REL`) |

The number in parentheses is the value written to the GNSS type field of `ioConfig` (see the [Settings Reference](#settings-reference)).

Concurrent constellations: ZED-F9 receivers and the GPX-1 support 4 concurrent constellations (see [GNSS Satellite Constellations](../../gnss/gnss_constellations.md)). Septentrio supports 4 concurrent constellations:

- GPS: L1C/A, L1C, L2C, L2PY, L5
- GLONASS: L1CA, L2CA, L2P, L3 CDMA
- BeiDou: B1I, B1C, B2a, B2I, B2b, B3I
- Galileo: E1, E5a, E5b, E6
- QZSS: L1C/A, L1 C/B, L2C, L5, L6
- NavIC: [TO CONFIRM: signals not provided]

## Configuration Procedure

1. Connect the receiver to an IMX serial port (Serial 0, 1 or 2; 3.3 V TTL UART). On Rugged products the port is set by the platform and I/O preset; see the product hardware page and [Platform Configuration](../application-config/platform_configuration.md).
2. Set the port baud rate (`ser0BaudRate`, `ser1BaudRate` or `ser2BaudRate`) to the receiver rate. The IMX configures the Septentrio and GPX-1 automatically. A baud-rate change takes effect after a reset [TO CONFIRM].
3. Set the GNSS1 source and type (and GNSS2 if used) in `ioConfig` or the EvalTool GNSS Settings tab.
4. Set the PPS (timepulse) source if the receiver PPS is wired to the IMX.
5. Set the RTK rover mode in `RTKCfgBits` if RTK positioning or compassing is used. See [RTK Positioning](../../gnss/rtk_positioning_overview.md) and [RTK Compassing](../../gnss/rtk_compassing.md).
6. Set the antenna offsets, dynamic model and constellations (`gnssSatSigConst`).
7. Save the configuration and verify the receiver (see [Verify the Receiver](#verify-the-receiver)).

## Settings Reference

Change one field at a time. Writing a new value to the whole `ioConfig` also overwrites the GNSS, PPS and strobe fields. Use read-modify-write (the SDK macros `SET_IO_CFG_GNSS1_SOURCE`, `SET_IO_CFG_GNSS1_TYPE` and similar).

### ioConfig

`DID_FLASH_CONFIG.ioConfig`

| Field | Bits | Values |
| ----- | ---- | ------ |
| GNSS1 source | 16 to 18 | 0 disabled, 3 Ser0, 4 Ser1, 5 Ser2 |
| GNSS2 source | 19 to 21 | As GNSS1 source |
| GNSS1 type | 22 to 24 | 0 none, 1 u-blox, 2 NMEA, 3 GPX, 4 Septentrio, 5 ISB |
| GNSS2 type | 25 to 27 | As GNSS1 type |
| GNSS1 no-init | 12 (0x1000) | 1 = skip GNSS1 initialization |
| GNSS2 no-init | 28 (0x10000000) | 1 = skip GNSS2 initialization |
| GNSS1 PPS source | 13 to 15 | 0 disabled, 1 G15, 3 G2, 4 G5, 5 G12, 6 G9 |

### ioConfig2

`DID_FLASH_CONFIG.ioConfig2`

| Field | Bits | Values |
| ----- | ---- | ------ |
| GNSS2 PPS source | 6 to 7 | 0 disabled, 1 G8, 2 G11, 3 G13 |
| Use GNSS2 as NMEA source | 5 (0x20) | 1 = GNSS2 instead of GNSS1 |

Assigning a pin to a GNSS PPS source and to a strobe input at the same time is not supported.

### RTKCfgBits

`DID_FLASH_CONFIG.RTKCfgBits`

| Bit | Name | Meaning |
| --- | ---- | ------- |
| 0x00000002 | `RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING` | RTK positioning on GNSS1 |
| 0x00000004 | `RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING` | Dual-GNSS RTK compassing (GNSS2 relative to GNSS1) |
| 0x00000001, 0x00000008 | `..._DEPRECATED` | Deprecated; do not set |
| 0x00000100, 0x00000200, 0x00000400, 0x00000800 | `RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_SER0`, `_SER1`, `_SER2`, `_USB` | Base station: output GNSS1 RTCM3 on that port |
| 0x00000010 to 0x00000080 | `RTK_CFG_BITS_BASE_OUTPUT_GNSS1_UBLOX_*` | Base station: output GNSS1 u-blox data on that port |
| 0x00400000 | `RTK_CFG_BITS_RTK_BASE_IS_IDENTICAL_TO_ROVER` | Base hardware is identical to the rover |

### Examples

[EXAMPLE] `ioConfig` GNSS fields only (other bits unchanged):

- GNSS1 on Ser1, u-blox: `(4 << 16) | (1 << 22)` = `0x00440000`
- GNSS1 on Ser1 and GNSS2 on Ser0, both u-blox: `0x025C0000`
- GNSS1 on Ser2, Septentrio: `(5 << 16) | (4 << 22)` = `0x01050000`
- GNSS1 on Ser1, NMEA: `(4 << 16) | (2 << 22)` = `0x00840000`

### Other Settings

| Setting | Field | Notes |
| ------- | ----- | ----- |
| Antenna offset | `gnss1AntOffset[3]`, `gnss2AntOffset[3]` (m) | Sensor Frame origin to antenna. Required when the antenna is 40 cm or more from the IMX. |
| Dynamic model | `dynamicModel` | Applies to the INS and the receiver engines. Receiver mode for each value: [TO CONFIRM]. |
| Constellations and bands | `gnssSatSigConst` (`eGnssSatSigConst`; GPX-1 band bits in `eGpxGnssSatSigConst`) | Recommended four-constellation value: `0x13FF` (GPS/QZSS, Galileo, GLONASS, BeiDou, SBAS). |
| Minimum elevation | `gnssMinimumElevation` (rad) | Satellites below this elevation are not used. |
| Minimum C/N0 | `gnssCn0Minimum`, `gnssCn0DynMinOffset` (dBHz) | Defaults 30 and 20. The SDK describes them as filters for signals used in the RTK solution. Effect on the non-RTK solution: [TO CONFIRM]. |

### GNSS Antenna Offset

If the setup includes a significant distance (40cm or more) between the GNSS antenna and the IMX central unit, enter a non-zero value for the GNSS antenna lever arm, `DID_FLASH_CONFIG.gnss1AntOffset` (or `DID_FLASH_CONFIG.gnss2AntOffset`) X,Y,Z offset in meters from the [Sensor Frame](../application-config/imu_ins_configuration.md#coordinate-frame-relationship) origin to the GNSS antenna.  The Sensor Frame origin and Hardware Frame origin are always at the same location but may differ in direction according to the Sensor Rotation.

### INS-GNSS Dynamic Model

The `DID_FLASH_CONFIG.dynamicModel` setting allows the user to adjust how the EKF and GNSS receivers behave in different dynamic environments. This parameter is applied to the GNSS receiver(s) engine as well as the INS EKF.

## Verify the Receiver

| Check | Where | Expected |
| ----- | ----- | -------- |
| Receiver identified | [DID_GNSS1_VERSION](../../com-protocol/DID-descriptions.md#did_gnss1_version), `DID_GNSS2_VERSION` | Receiver and firmware strings populated |
| No initialization fault | [DID_SYS_PARAMS](../../com-protocol/DID-descriptions.md#did_sys_params)`.genFaultCode` | `GFC_GNSS1_INIT` (0x00000800) and `GFC_GNSS2_INIT` (0x00001000) clear |
| Satellites received | `hdwStatus` (see [IMX System Status](../../reference/IMX_system_status.md)) | `HDW_STATUS_GNSS_SATELLITE_RX_VALID` (0x10) set |
| Position and fix | `status` in [DID_GNSS1_POS](../../com-protocol/DID-descriptions.md#did_gnss1_pos), `DID_GNSS2_POS` | A 3D, DGPS, SBAS or RTK fix type (`GNSS_STATUS_FIX_*`) and `GNSS_STATUS_FLAGS_FIX_OK` set |
| Signal quality | [DID_GNSS1_SAT](../../com-protocol/DID-descriptions.md#did_gnss1_sat), [DID_GNSS1_SIG](../../com-protocol/DID-descriptions.md#did_gnss1_sig), EvalTool GNSS tab | Per-signal C/N0; `SAT_SIG_STATUS_USED_IN_SOLUTION` set for signals in use |
| PPS | `hdwStatus`, `DID_GNSS1_TIMEPULSE` | `HDW_STATUS_ERR_NO_GNSS_PPS` (0x00040000) clear; `GNSS_STATUS_FLAGS_GNSS_PPS_TIMESYNC` set |
| RTK compassing | `status` in `DID_GNSS1_POS` and `DID_GNSS2_POS`; heading in [DID_GNSS2_RTK_CMP_REL](../../com-protocol/DID-descriptions.md#did_gnss2_rtk_cmp_rel) | `GNSS_STATUS_FLAGS_GNSS2_RTK_COMPASS_VALID` set |

Mean C/N0 should ideally be above 38 to 40 dBHz (see [IMX Firmware Troubleshooting](../../troubleshooting/gnss.md#satellite-cno-strength-rfi-and-emi)).

## Troubleshooting

| Symptom | Check |
| ------- | ----- |
| No GNSS data | Source and type match the port and receiver; no-init bits clear; Tx and Rx crossed and ground common; baud rate matches; `genFaultCode` GNSS init flags. |
| Receiver responds, 0 satellites | Antenna connected and powered (active antenna); sky view; correct antenna port (Rugged MMCX port 1 is GNSS1, port 2 is GNSS2). Swap the antennas between ports to separate an antenna fault from a unit fault. |
| No PPS | PPS source matches the wired pin; `HDW_STATUS_ERR_NO_GNSS_PPS`; the pin is not also a strobe input. |
| No RTK | RTK mode bits; corrections reach the receiver; base flags such as `GNSS_STATUS_FLAGS_GNSS1_RTK_BASE_DATA_MISSING`. |
| GNSS settings changed unexpectedly | The whole `ioConfig` was overwritten. Use read-modify-write. |

See also [IMX Firmware Troubleshooting](../../troubleshooting/gnss.md).
