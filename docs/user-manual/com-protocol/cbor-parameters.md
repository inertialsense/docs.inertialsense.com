<!-- Generated from the CBOR key registry by is-common scripts/cbor_registry.py docs -- do not edit. Change the registry or the data_sets.h member comments instead. -->

# CBOR Parameters

Every DID and field a host can read or write through `DID_CBOR` messages, and the keys of the messages themselves. The message format is described in [CBOR Messaging](cbor.md). Names are those the SDK and cltool accept; on the wire each is its integer key.

## DIDs

| DID | Key | Served by | Access | Stored | Binary DID |
|---|---|---|---|---|---|
| [`FLASH_CFG`](#flash_cfg) | 12 | IMX-5, IMX-6 | read, write | yes | `DID_FLASH_CONFIG` |
| [`CAN_CONFIG`](#can_config) | 90 | IMX-5, IMX-6 | read, write | yes | `DID_CAN_CONFIG` |
| [`GPX_FLASH_CFG`](#gpx_flash_cfg) | 121 | GPX-1 | read, write | yes | `DID_GPX_FLASH_CFG` |
| [`CAPABILITIES`](#capabilities) | `0x7FFC` (32764) | IMX-5, IMX-6, GPX-1 | read | no | none (CBOR only) |
| [`RMC_STORED`](#rmc_stored) | `0x7FFD` (32765) | IMX-5, IMX-6 | read, write | yes | none (CBOR only) |
| [`ROUTE_FILTER`](#route_filter) | `0x7FFF` (32767) | IMX-5, IMX-6 | read | no | none (CBOR only) |

A device lists the DIDs and fields it serves in [`CAPABILITIES`](#capabilities). A GPX connected through an IMX is reached by addressing it (see [Addressing](cbor.md#addressing)).

## FLASH_CFG

Key 12. Served by IMX-5, IMX-6; read, write; stored in flash. The fields of the binary `DID_FLASH_CONFIG` (`nvm_flash_cfg_t`), keyed by field.

| Key | Name | Type | Default | Description |
|---|---|---|---|---|
| 0 | `startupImuOdr` | uint32 | `1` | IMU output data rate set on startup (see eImuOdr). Raised if its sample period would be larger than startupNavDtMs. IMU_ODR_DISABLED disables sensor/IMU sampling. |
| 1 | `startupNavDtMs` | uint32 | set by the firmware | (ms) Navigation filter (system output) output period set on startup.  Used to initialize sysParams.navOutputPeriodMs. |
| 2 | `ser0BaudRate` | uint32 | `921600` | (bps) Serial port 0 baud rate |
| 3 | `ser1BaudRate` | uint32 | `921600` | (bps) Serial port 1 baud rate |
| 4 | `insRotation` | float32[3] | `[0, 0, 0]` | (rad) Rotation about the X,Y,Z axes from Sensor Frame to Intermediate Output Frame.  Order applied: Z,Y,X. |
| 5 | `insOffset` | float32[3] | `[0, 0, 0]` | (m) X,Y,Z offset from Intermediate Output Frame to INS Output Frame. |
| 6 | `gnss1AntOffset` | float32[3] | `[0, 0, 0]` | (m) X,Y,Z offset in Sensor Frame to GNSS 1 antenna. |
| 7 | `dynamicModel` | uint8 | `8` | INS dynamic platform model (see eDynamicModel).  Options are: 0=PORTABLE, 2=STATIONARY, 3=PEDESTRIAN, 4=GROUND VEHICLE, 5=SEA, 6=AIRBORNE_1G, 7=AIRBORNE_2G, 8=AIRBORNE_4G, 9=WRIST.  Used to balance noise and performance characteristics of the system.  The dynamics selected here must be at least as fast as your system or you experience accuracy error.  This is tied to the GNSS position estimation model and intend in the future to be incorporated into the INS position model. |
| 8 | `debug` | uint8 | `0` | Debug |
| 9 | `gnssSatSigConst` | uint16 | `5119` | Satellite system constellation used in GNSS solution (see eGnssSatSigConst). 0x0003=GPS, 0x000C=QZSS, 0x0030=Galileo, 0x00C0=Beidou, 0x0300=GLONASS, 0x1000=SBAS |
| 10 | `sysCfgBits` | uint32 | `256` | System configuration bits (see eSysConfigBits). |
| 11 | `refLla` | float64[3] | set by the firmware | (deg, deg, m) Reference latitude, longitude and height above ellipsoid for north east down (NED) calculations |
| 12 | `lastLla` | float64[3] | set by the firmware | (deg, deg, m) Last latitude, longitude, HAE (height above ellipsoid) used to aid GNSS startup.  Updated when the distance between current LLA and lastLla exceeds lastLlaUpdateDistance. |
| 13 | `lastLlaTimeOfWeekMs` | uint32 | set by the firmware | (ms) Last LLA GPS time since week start (Sunday morning) |
| 14 | `lastLlaWeek` | uint32 | set by the firmware | Last LLA GPS number of weeks since January 6th, 1980 |
| 15 | `lastLlaUpdateDistance` | float32 | `1000` | (m) Distance between current and last LLA that triggers an update of lastLla |
| 16 | `ioConfig` | uint32 | set by the firmware | Hardware interface configuration bits (see eIoConfig). |
| 17 | `platformConfig` | uint32 | set by the firmware | Hardware platform specifying the IMX carrier board type (i.e. RUG, EVB, IG) and configuration bits (see ePlatformConfig).  The platform type is used to simplify the GNSS and I/O configuration process.  Bit PLATFORM_CFG_UPDATE_IO_CONFIG is excluded from the flashConfig checksum and from determining whether to upload. |
| 18 | `gnss2AntOffset` | float32[3] | `[0, 0, 0]` | (m) X,Y,Z offset in Sensor Frame origin to GNSS 2 antenna. |
| 19 | `zeroVelRotation` | float32[3] | `[0, 0, 0]` | (rad) Euler (roll, pitch, yaw) rotation from INS Sensor Frame to Intermediate ZeroVelocity Frame.  Order applied: heading, pitch, roll. |
| 20 | `zeroVelOffset` | float32[3] | `[0, 0, 0]` | (m) X,Y,Z offset from Intermediate ZeroVelocity Frame to Zero Velocity Frame. |
| 21 | `gnssTimeUserDelay` | float32 | `0` | (sec) User defined delay for GPS time.  This parameter can be used to account for GNSS antenna cable delay. |
| 22 | `magDeclination` | float32 | `0` | (rad) Earth magnetic field (magnetic north) declination (heading offset from true north) |
| 23 | `gnssTimeSyncPeriodMs` | uint32 | `1000` | (ms) Time between GPS time synchronization pulses.  Requires reboot to take effect. |
| 24 | `startupGnssDtMs` | uint32 | `200` | (ms) GNSS measurement (system input) update period set on startup. 200ms minimum (5Hz max). |
| 25 | `RTKCfgBits` | uint32 | `0` | RTK configuration bits (see eRTKConfigBits). |
| 26 | `sensorConfig` | uint32 | `119` | Sensor config to specify the full-scale sensing ranges and output rotation for the IMU and magnetometer (see eSensorConfig) |
| 27 | `gnssMinimumElevation` | float32 | `0.17453292` | (rad) Minimum elevation of a satellite above the horizon to be used in the solution. Low elevation satellites may provide degraded accuracy, due to the long signal path through the atmosphere. |
| 28 | `ser2BaudRate` | uint32 | `921600` | (bps) Serial port 2 baud rate |
| 29 | `wheelConfig.bits` | uint32 | `0` | Config bits (see eWheelCfgBits) |
| 30 | `wheelConfig.transform.e_b2w` | float32[3] | `[0, 0, 0]` | (rad) Euler angles describing the rotation from imu (body) to the wheel frame (center of the non-steering axle) |
| 31 | `wheelConfig.transform.e_b2w_sigma` | float32[3] | `[0.0174532924, 0.0174532924, 0.0174532924]` | (rad) Euler angle standard deviation of measurements describing the rotation from imu (body) to the wheel frame (center of the non-steering axle) |
| 32 | `wheelConfig.transform.t_b2w` | float32[3] | `[0, 0, 0]` | (m) Translation from the imu (body) to the wheel frame origin (center of the non-steering axle), expressed in the imu (body) frame |
| 33 | `wheelConfig.transform.t_b2w_sigma` | float32[3] | `[0.300000012, 0.300000012, 0.300000012]` | (m) Translation standard deviation from the imu (body) to the wheel frame origin (center of the non-steering axle), expressed in the imu (body) frame |
| 34 | `wheelConfig.track_width` | float32 | `0` | (m) Distance between the left and right wheels |
| 35 | `wheelConfig.radius` | float32 | `0` | (m) Estimate of wheel radius |
| 36 | `magInterferenceThreshold` | float32 | `3` | Magnetometer interference sensitivity threshold. Typical range is 2-10 (3 default) and 1000 to disable mag interference detection. |
| 37 | `magCalibrationQualityThreshold` | float32 | `10` | Magnetometer calibration quality sensitivity threshold. Typical range is 10-20 (10 default) and 1000 to disable mag calibration quality check, forcing it to be always good. |
| 38 | `gnssCn0Minimum` | uint8 | `30` | (dBHz) GNSS CN0 absolute minimum threshold for signals.  Used to filter signals in RTK solution. |
| 39 | `gnssCn0DynMinOffset` | uint8 | `20` | (dBHz) GNSS CN0 dynamic minimum threshold offset below max CN0 across all satellites. Used to filter signals used in RTK solution. To disable, set gnssCn0DynMinOffset to zero and increase gnssCn0Minimum. |
| 40 | `imuRejectThreshGyroLow` | uint8 | `2` | IMU gyro fault rejection threshold low |
| 41 | `imuRejectThreshGyroHigh` | uint8 | `3` | IMU gyro fault rejection threshold high |
| 42 | `imuShockDetectLatencyMs` | uint8 | `10` | (ms) IMU shock detection latency.  Time used for EKF rewind to prevent shock from influencing EKF estimates. |
| 43 | `imuShockRejectLatchMs` | uint8 | `5` | (ms) IMU shock rejection latch time.  Time required following detected shock end to disable shock rejection. |
| 44 | `imuShockOptions` | uint8 | `2` | IMU shock rejection options (see eImuShockOptions) |
| 45 | `imuShockDeltaAccHighThreshold` | uint8 | `20` | (m/s^2) IMU shock detection. Min acceleration difference between the 3 IMUs to detect the start of a shock. |
| 46 | `imuShockDeltaAccLowThreshold` | uint8 | `3` | (m/s^2) IMU shock detection. Max acceleration difference between the 3 IMUs within the latch time to detect the end of a shock. |
| 47 | `imuShockDeltaGyroHighThreshold` | uint8 | `120` | (deg/s) IMU shock detection. Min angular rate difference between the 3 IMUs to detect the start of a shock. |
| 48 | `imuShockDeltaGyroLowThreshold` | uint8 | `12` | (deg/s) IMU shock detection. Max angular rate difference between the 3 IMUs within the latch time to detect the end of a shock. |
| 49 | `ioConfig2` | uint8 | set by the firmware | Hardware interface configuration bits for GNSS2 PPS (see eIoConfig2). |
| 50 | `deadReckoningTimeout` | uint8 | `30` | (s) Time without any position, velocity, or wheel/kinematic aiding after which the INS drops from NAV to AHRS mode.  0 = never time out. |

## CAN_CONFIG

Key 90. Served by IMX-5, IMX-6; read, write; stored in flash. The fields of the binary `DID_CAN_CONFIG` (`can_config_t`), keyed by field.

| Key | Name | Type | Default | Description |
|---|---|---|---|---|
| 0 | `can_period_mult` | uint16[27] | `0` | Broadcast period multiple for each CAN message. 0 disables the message. Indices 0..NUM_CIDS-1 correspond to classic can_cid_t values. In CAN-FD mode the same array is reused: indices 0..NUM_FDCIDS-1 correspond to canfd_cid_t values (FDCID_INS_1=0, FDCID_INS_2=1, …). NUM_FDCIDS < NUM_CIDS so there is no overlap. |
| 1 | `can_transmit_address` | uint32[27] | `0` | Transmit address for each CAN message. Indices 0..NUM_CIDS-1 correspond to classic can_cid_t values. In CAN-FD mode indices 0..NUM_FDCIDS-1 correspond to canfd_cid_t values and are validated / defaulted by CAN_init() when FD is enabled. |
| 2 | `can_setting` | uint16 | `100` | Baud rate (kbps) (See can_baudrate_t for valid baud rates). Bit 15 (CAN_BAUDRATE_KBPS_FD_ENABLE) enables CAN-FD on capable hardware. |
| 3 | `can_receive_address` | uint32 | `0` | Receive address |

## GPX_FLASH_CFG

Key 121. Served by GPX-1; read, write; stored in flash. The fields of the binary `DID_GPX_FLASH_CFG` (`gpx_flash_cfg_t`), keyed by field.

| Key | Name | Type | Default | Description |
|---|---|---|---|---|
| 0 | `ser0BaudRate` | uint32 | `921600` | (bps) Serial port 0 baud rate |
| 1 | `ser1BaudRate` | uint32 | `921600` | (bps) Serial port 1 baud rate |
| 2 | `ser2BaudRate` | uint32 | `921600` | (bps) Serial port 2 baud rate |
| 3 | `startupGnssDtMs` | uint32 | `200` | (ms) GNSS measurement (system input data) update period set on startup. 200ms minimum (5Hz max). |
| 4 | `gnss1AntOffset` | float32[3] | `[0, 0, 0]` | (m) X,Y,Z offset in Sensor Frame to GNSS 1 antenna |
| 5 | `gnss2AntOffset` | float32[3] | `[0, 0, 0]` | (m) X,Y,Z offset in Sensor Frame to GNSS 2 antenna |
| 6 | `gnssSatSigConst` | uint16 | `5119` | Satellite system constellation used in GNSS solution (see eGnssSatSigConst). 0x0003=GPS, 0x000C=QZSS, 0x0030=Galileo, 0x00C0=Beidou, 0x0300=GLONASS, 0x1000=SBAS |
| 7 | `dynamicModel` | uint8 | `8` | Dynamic platform model (see eDynamicModel). Options are: 0=PORTABLE, 1=FIXED POSITION, 2=STATIONARY, 3=PEDESTRIAN, 4=GROUND VEHICLE, 5=SEA, 6=AIRBORNE_1G, 7=AIRBORNE_2G, 8=AIRBORNE_4G, 9=WRIST. Used to balance noise and performance characteristics of the system. The dynamics selected here must be at least as fast as your system or you experience accuracy error. This is tied to the GNSS position estimation model and intended in the future to be incorporated into the INS position model. |
| 8 | `debug` | uint8 | `32` | Debug |
| 9 | `gnssTimeSyncPeriodMs` | uint32 | `1000` | (ms) Time between GPS time synchronization pulses. Requires reboot to take effect. |
| 10 | `gnssTimeUserDelay` | float32 | `0` | (sec) User defined delay for GPS time. This parameter can be used to account for GNSS antenna cable delay. |
| 11 | `gnssMinimumElevation` | float32 | `0.17453292` | (rad) Minimum elevation of a satellite above the horizon to be used in the solution. Low elevation satellites may provide degraded accuracy, due to the long signal path through the atmosphere. |
| 12 | `RTKCfgBits` | uint32 | `0` | RTK configuration bits (see eRTKConfigBits). |
| 13 | `gnssCn0Minimum` | uint8 | `30` | (dBHz) GNSS CN0 absolute minimum threshold for signals. Used to filter signals in RTK solution. |
| 14 | `gnssCn0DynMinOffset` | uint8 | `20` | (dBHz) GNSS CN0 dynamic minimum threshold offset below max CN0 across all satellites. Used to filter signals used in RTK solution. To disable, set gnssCn0DynMinOffset to zero and increase gnssCn0Minimum. |
| 15 | `sysCfgBits` | uint32 | `0` | System configuration bits (see eGpxSysConfigBits). |
| 16 | `refLla` | float64[3] | `[0, 0, 0]` | (deg, deg, m) Reference latitude, longitude and height above ellipsoid for north east down (NED) calculations |

## CAPABILITIES

Key `0x7FFC` (32764). Served by IMX-5, IMX-6, GPX-1; read. A CBOR-only DID.

Read-only. The reply holds one entry per DID the device serves, keyed by the DID, whose value is the array of field keys the device serves for it. The `CAPABILITIES` entry itself lists the DIDs. A `GET` may select DIDs: `{CAPABILITIES: [FLASH_CFG]}`.

## RMC_STORED

Key `0x7FFD` (32765). Served by IMX-5, IMX-6; read, write; stored in flash. A CBOR-only DID.

Field key *n* is port *n* (0 to 5). Each port is a map of per-port options and one entry per subscribed DID, keyed by the DID (or an [NMEA pseudo-DID](#nmea-pseudo-dids)), whose value is `{SUB_RATE_MULTI: m}`, a multiple of the DID's source period. A multiple of 0 removes the DID. `SUB_RATE_PERIOD` and `MSG_FIELDS` are rejected with `BAD_VALUE` until subscriptions in ms are supported.

**Per-port options**

| Key | Name | Type | Default | Description |
|---|---|---|---|---|
| `0x8001` (32769) | `RMC_PRESET` | uint8 ([rmc_preset](#rmc_preset)) | `NONE` | Replaces the port's DIDs with the preset's, applied before the DID entries. Not reported on read. |
| `0x8002` (32770) | `NMEA_SPEED_FILTER` | uint8 ([nmea_speed_filter](#nmea_speed_filter)) | `DEFAULT` | NMEA speed filtering. |

**DID-level options** (written at the DID level, beside the ports)

| Key | Name | Type | Default | Description |
|---|---|---|---|---|
| `0x8000` (32768) | `RMC_SAVE_PORTS` | array of uint8, up to 6 |  | Copies these ports' current runtime subscriptions to the stored table, before the port entries are applied. |

## ROUTE_FILTER

Key `0x7FFF` (32767). Served by IMX-5, IMX-6; read. A CBOR-only DID.

Field key *n* is rule *n* (0 to 7), checked in order; the first rule that matches decides. A message no rule matches is forwarded.

| Key | Name | Type | Default | Description |
|---|---|---|---|---|
| 0 | `MATCH_DEV` | uint64 |  | Device filter the destination must match. |
| 1 | `MATCH_MSG` | array of uint8, up to 3 |  | Message types the rule applies to; absent = all. |
| 2 | `MATCH_DIDS` | array of uint16, up to 16 |  | DIDs the rule applies to; absent = all. |
| 3 | `ACTION` | uint8 ([route_action](#route_action)) | `DENY` | What a matching message gets. |

## NMEA pseudo-DIDs

Keys for NMEA sentences inside [`RMC_STORED`](#rmc_stored) port entries: `0x3F00` + the NMEA message ID. The stream itself is sent as ASCII NMEA.

| Key | Name |
|---|---|
| `0x3F01` | `NMEA_PIMU` |
| `0x3F02` | `NMEA_PPIMU` |
| `0x3F03` | `NMEA_PRIMU` |
| `0x3F04` | `NMEA_PINS1` |
| `0x3F05` | `NMEA_PINS2` |
| `0x3F06` | `NMEA_PGPSP` |
| `0x3F07` | `NMEA_GNGGA` |
| `0x3F08` | `NMEA_GNGLL` |
| `0x3F09` | `NMEA_GNGSA` |
| `0x3F0A` | `NMEA_GNRMC` |
| `0x3F0B` | `NMEA_GNZDA` |
| `0x3F0C` | `NMEA_PASHR` |
| `0x3F0D` | `NMEA_PSTRB` |
| `0x3F0E` | `NMEA_INFO` |
| `0x3F0F` | `NMEA_GNGSV` |
| `0x3F10` | `NMEA_GNVTG` |
| `0x3F11` | `NMEA_INTEL` |
| `0x3F12` | `NMEA_POWGPS` |
| `0x3F13` | `NMEA_POWTLV` |

## Reserved for later releases

| DID | Key |
|---|---|
| `RMC` | `0x7FFE` (32766) |

## Message keys

Keys at the root of a message (the envelope), beside the DID keys. `MSG_STATUS`, `MSG_ERR_KEYS` and `MSG_FIELDS` also appear inside a DID.

| Key | Name | Type | Default | Description |
|---|---|---|---|---|
| `0xC000` (49152) | `MSG_TYPE` | uint8 ([msg_type](#msg_type)) |  | Operation and flags. Absent: a message with values is DATA, one with keys only is GET. |
| `0xC001` (49153) | `MSG_SRC_DEV_ID` | uint64 | `0` | Unique ID of the sender. 0 = a host; devices always send it. |
| `0xC002` (49154) | `MSG_DST_DEV_FILTER` | uint64 |  | Device filter of the destination. Absent: the device on the other end of the link, not forwarded. |
| `0xC003` (49155) | `MSG_REQ_ID` | uint16 |  | Request ID, echoed in the replies. Absent: unsolicited. |
| `0xC004` (49156) | `MSG_ACK_TYPE` | uint8 ([ack_type](#ack_type)) | `ACK_MINIMAL` | How much a reply to DATA reports. |
| `0xC005` (49157) | `MSG_ROUTE` | array of uint8, up to 4 |  | Ports a forwarded message passed through. Set by devices. |
| `0xC006` (49158) | `MSG_TIME_GPS_NS` | uint64 |  | GPS time of the data, when GNSS time is synced. |
| `0xC007` (49159) | `MSG_UPTIME_NS` | uint64 |  | Device uptime, when GNSS time is not synced. |
| `0xC008` (49160) | `MSG_STATUS` | uint8 ([msg_status](#msg_status)) | `OK` | Outcome of a message or of one DID. |
| `0xC009` (49161) | `MSG_ERR_KEYS` | key_paths |  | Keys (or key paths) of the values a status refers to. |
| `0xC00A` (49162) | `MSG_FIELDS` | key_paths |  | Fields selected; absent = every field. |
| `0xC00C` (49164) | `MSG_OPTION_NO_TIME` | bool | `false` | Leave the time keys out of the reply. |

**Subscription options** (in `RMC_STORED` entries)

| Key | Name | Type | Default | Description |
|---|---|---|---|---|
| `0x9300` (37632) | `SUB_RATE_PERIOD` | uint32 |  | Period in ms (not yet supported). |
| `0x9301` (37633) | `SUB_RATE_MULTI` | uint32 |  | Multiple of the DID's source period. |

## Values of enumerated keys

### msg_type

| Name | Value |
|---|---|
| `DATA` | 1 |
| `GET` | 2 |
| `SUBSCRIBE` | 3 |

### msg_type_flag

| Name | Value |
|---|---|
| `REPLY` | 0x80 |

### msg_status

| Name | Value |
|---|---|
| `OK` | 0 |
| `BAD_REQUEST` | 1 |
| `BAD_VALUE` | 2 |
| `UNSUPPORTED` | 3 |
| `RESP_TOO_LARGE` | 4 |
| `FORWARD_DENIED` | 5 |
| `READ_ONLY` | 6 |
| `ERROR` | 7 |
| `REQ_TOO_LARGE` | 8 |
| `UNREACHABLE` | 9 |

### ack_type

| Name | Value |
|---|---|
| `ACK_NONE` | 0 |
| `ACK_MINIMAL` | 1 |
| `ACK_DETAILED` | 2 |

### rmc_preset

| Name | Value |
|---|---|
| `NONE` | 0 |
| `IMX_PPD_NO_IMU` | 1 |
| `IMX_PPD` | 2 |
| `IMX_PPD_IMUS_RAW` | 3 |
| `IMX_PPD_IMUS_UNCAL` | 4 |
| `INS` | 5 |
| `IMX_PPD_RTK_DBG` | 6 |
| `IMX_PPD_GROUND_VEHICLE` | 7 |
| `ALLAN_VARIANCE` | 8 |
| `ALLAN_VARIANCE_IMUS` | 9 |
| `GNSS` | 10 |
| `GPX_PPD` | 11 |

### nmea_speed_filter

| Name | Value |
|---|---|
| `DEFAULT` | 0 |
| `ENABLE` | 1 |
| `DISABLE` | 2 |

### route_action

| Name | Value |
|---|---|
| `DENY` | 0 |
| `ALLOW` | 1 |
