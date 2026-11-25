<!-- Generated from the CBOR key registry by is-common scripts/cbor_registry.py docs -- do not edit. Change the registry or the data_sets.h member comments instead. -->

# CBOR Parameters

Every DID and field a host can read or write through `DID_CBOR` messages, and the keys of the messages themselves. The message format is described in [CBOR Messaging](cbor.md). Names are those the SDK and cltool accept; on the wire each is its integer key.

## DIDs

| DID | Key | Served by | Access | Stored | Binary DID |
|---|---|---|---|---|---|
| [`FLASH_CFG`](#flash_cfg) | 12 | IMX-5, IMX-6 | read, write | yes | `DID_FLASH_CONFIG` |
| [`CAN_CONFIG`](#can_config) | 90 | IMX-5, IMX-6 | read, write | yes | `DID_CAN_CONFIG` |
| [`GPX_FLASH_CFG`](#gpx_flash_cfg) | 121 | GPX-1 | read, write | yes | `DID_GPX_FLASH_CFG` |
| [`CONFIG_SYSTEM`](#config_system) | `0x0102` (258) | IMX-5, IMX-6, GPX-1 | read, write | yes | none (CBOR only) |
| [`CONFIG_INS`](#config_ins) | `0x0103` (259) | IMX-5, IMX-6 | read, write | yes | none (CBOR only) |
| [`CONFIG_MAG`](#config_mag) | `0x0104` (260) | IMX-5, IMX-6 | read, write | yes | none (CBOR only) |
| [`CONFIG_GROUND_VEHICLE`](#config_ground_vehicle) | `0x0105` (261) | IMX-5, IMX-6 | read, write | yes | none (CBOR only) |
| [`CONFIG_PORTS`](#config_ports) | `0x0106` (262) | IMX-5, IMX-6, GPX-1 | read, write | yes | none (CBOR only) |
| [`CONFIG_SENSORS`](#config_sensors) | `0x0107` (263) | IMX-5, IMX-6 | read, write | yes | none (CBOR only) |
| [`CONFIG_IO`](#config_io) | `0x0108` (264) | IMX-5, IMX-6 | read, write | yes | none (CBOR only) |
| [`CONFIG_GNSS`](#config_gnss) | `0x0109` (265) | IMX-5, IMX-6, GPX-1 | read, write | yes | none (CBOR only) |
| [`CONFIG_CAN`](#config_can) | `0x010A` (266) | IMX-5, IMX-6 | read, write | yes | none (CBOR only) |
| [`STATE`](#state) | `0x010B` (267) | IMX-5, IMX-6 | read, write | yes | none (CBOR only) |
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
| 51 | `sensorConfig2` | uint32 | `0` | Additional sensor config: extended-range (high-g) accelerometer full-scale range and per-IMU disable (see eSensorConfig2) |

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

## CONFIG_SYSTEM

Key `0x0102` (258). Served by IMX-5, IMX-6, GPX-1; read, write; stored in flash. Its keys are the same on every device type. `Name[enum]` is a map keyed by the values of that [enum](#values-of-enumerated-keys), and the key path shows `*` for its key. A plural such as `Receivers` holds values common to every instance, which an instance's own value overrides. A device stores and accepts only the keys listed as stored on it.

| Key | Name | Type | Default | Stored on | Description |
|---|---|---|---|---|---|
| `0` | `navPeriodMs` | uint32 | set by the firmware | IMX-5, IMX-6 | (ms) Navigation output period at startup. |
| `1` | `imuOdr` | uint32 | `1` | IMX-5, IMX-6 | IMU output data rate at startup (eImuOdr). Raised if its period would exceed navPeriodMs; IMU_ODR_DISABLED stops IMU sampling. |
| `2` | `ledsEnabled` | bool | `true` | IMX-5, IMX-6 | Drive the status LEDs. |
| `3` | `brownOutLevel` | uint8 | `0` | IMX-5, IMX-6, GPX-1 | MCU brown-out reset threshold level. |
| `4` | `bitOnStartup` | bool | `true` | IMX-5, IMX-6 | Run the built-in test (BIT) automatically at startup. |
| `5` | `platform` | map | | | The carrier board the module is on, which selects the GNSS and I/O defaults. |
| `5.0` | `platform.type` | uint8 | set by the firmware | IMX-5, IMX-6 | Carrier board type (PLATFORM_CFG_TYPE_*). Overrides the factory default; absent, the factory default applies. |
| `5.1` | `platform.preset` | uint8 | `0` | IMX-5, IMX-6 | Carrier-specific configuration preset. |
| `5.2` | `platform.ioExpanderBits` | uint8 | `0` | IMX-5, IMX-6 | Raw I/O expander bits, used only when presets are disabled. |
| `6` | `debug` | uint8 | set by the firmware | IMX-5, IMX-6, GPX-1 | Internal diagnostics settings. |

## CONFIG_INS

Key `0x0103` (259). Served by IMX-5, IMX-6; read, write; stored in flash. Its keys are the same on every device type. `Name[enum]` is a map keyed by the values of that [enum](#values-of-enumerated-keys), and the key path shows `*` for its key. A plural such as `Receivers` holds values common to every instance, which an instance's own value overrides. A device stores and accepts only the keys listed as stored on it.

| Key | Name | Type | Default | Stored on | Description |
|---|---|---|---|---|---|
| `0` | `rotation` | float32[3] | `[0, 0, 0]` | IMX-5, IMX-6 | (rad) Rotation about X, Y, Z from the sensor frame to the intermediate output frame, applied Z, Y, X. |
| `1` | `offset` | float32[3] | `[0, 0, 0]` | IMX-5, IMX-6 | (m) X, Y, Z offset from the intermediate output frame to the INS output frame. |
| `2` | `nedOrigin` | float64[3] | set by the firmware | IMX-5, IMX-6 | (deg, deg, m) Latitude, longitude and height above the ellipsoid of the origin for north-east-down positions. |
| `3` | `dynamicModel` | uint8 | `8` | IMX-5, IMX-6 | INS dynamic platform model (eDynamicModel), which balances noise against responsiveness. |
| `4` | `ekfEnabled` | bool | `true` | IMX-5, IMX-6 | Run the INS extended Kalman filter updates. |
| `5` | `deadReckoningTimeoutS` | uint8 | `30` | IMX-5, IMX-6 | (s) Time without position, velocity or wheel aiding after which the INS drops from NAV to AHRS mode. 0 never times out. |
| `6` | `lastPositionUpdateDistanceM` | float32 | `1000` | IMX-5, IMX-6 | (m) Distance from the stored last position that triggers an update of STATE.lastPosition. |
| `7` | `referenceImu` | bool | `false` | IMX-5, IMX-6 | Use the reference IMU in the EKF instead of the onboard IMU. |
| `8` | `stationaryOnStrobe` | bool | `false` | IMX-5, IMX-6 | Treat the reference point as stationary while the strobe input is asserted. |
| `9` | `fusion` | map | | | Aiding sources fused in the INS. GNSS fusion is per receiver: CONFIG_GNSS Receiver fusionEnabled. |
| `9.0` | `fusion.mag` | bool | `true` | IMX-5, IMX-6 | Fuse the magnetometer. |
| `9.1` | `fusion.baro` | bool | `true` | IMX-5, IMX-6 | Fuse the barometer. |
| `9.2` | `fusion.wheel` | bool | `true` | IMX-5, IMX-6 | Fuse the wheel encoders. |
| `10` | `zeroVelocity` | map | | | Zero-velocity and zero-angular-rate updates. |
| `10.0` | `zeroVelocity.rotation` | float32[3] | `[0, 0, 0]` | IMX-5, IMX-6 | (rad) Euler rotation from the sensor frame to the intermediate zero-velocity frame, applied heading, pitch, roll. |
| `10.1` | `zeroVelocity.offset` | float32[3] | `[0, 0, 0]` | IMX-5, IMX-6 | (m) X, Y, Z offset from the intermediate zero-velocity frame to the zero-velocity frame. |
| `10.2` | `zeroVelocity.autoZupt` | bool | `true` | IMX-5, IMX-6 | Apply zero-velocity updates (ZUPT) automatically. |
| `10.3` | `zeroVelocity.autoZaru` | bool | `true` | IMX-5, IMX-6 | Apply zero-angular-rate updates (ZARU) automatically. |
| `11` | `shock` | map | | | IMU shock detection and rejection. |
| `11.0` | `shock.enabled` | bool | `false` | IMX-5, IMX-6 | Detect IMU shocks and reject the IMU data during them. |
| `11.1` | `shock.fastRecovery` | bool | `true` | IMX-5, IMX-6 | Minimise attitude error after a shock that happens during rotation, at the cost of more error during the shock. |
| `11.2` | `shock.detectLatencyMs` | uint8 | `10` | IMX-5, IMX-6 | (ms) Detection latency, the time the EKF rewinds so a shock does not influence its estimates. |
| `11.3` | `shock.rejectLatchMs` | uint8 | `5` | IMX-5, IMX-6 | (ms) Time after a shock ends before shock rejection is released. |
| `11.4` | `shock.deltaAccHigh` | uint8 | `20` | IMX-5, IMX-6 | (m/s^2) Minimum acceleration difference between IMUs that starts a shock. |
| `11.5` | `shock.deltaAccLow` | uint8 | `3` | IMX-5, IMX-6 | (m/s^2) Maximum acceleration difference between IMUs, within the latch time, that ends a shock. |
| `11.6` | `shock.deltaGyroHigh` | uint8 | `120` | IMX-5, IMX-6 | (deg/s) Minimum angular rate difference between IMUs that starts a shock. |
| `11.7` | `shock.deltaGyroLow` | uint8 | `12` | IMX-5, IMX-6 | (deg/s) Maximum angular rate difference between IMUs, within the latch time, that ends a shock. |
| `12` | `faultDetect` | map | | | Multiple-IMU fault detection. |
| `12.0` | `faultDetect.gyr` | bool | `false` | IMX-5, IMX-6 | Detect gyro faults across IMUs. Required by the other gyro fault detection modes. |
| `12.1` | `faultDetect.acc` | bool | `false` | IMX-5, IMX-6 | Detect accelerometer faults across IMUs. Required by the other accelerometer fault detection modes. |
| `12.2` | `faultDetect.gyroRejectThreshLow` | uint8 | `2` | IMX-5, IMX-6 | Gyro fault rejection threshold, low. |
| `12.3` | `faultDetect.gyroRejectThreshHigh` | uint8 | `3` | IMX-5, IMX-6 | Gyro fault rejection threshold, high. |
| `13` | `complementaryFilter` | map | | | Complementary filter gains. 0 disables the correction. |
| `13.0` | `complementaryFilter.bKpqr` | float32 | set by the firmware | IMX-5, IMX-6 | Gyro bias estimation gain. |
| `13.1` | `complementaryFilter.bKuvw` | float32 | set by the firmware | IMX-5, IMX-6 | Accelerometer bias estimation gain. |
| `13.2` | `complementaryFilter.oKat1` | float32 | set by the firmware | IMX-5, IMX-6 | Attitude level observer gain (accelerometer). |
| `13.3` | `complementaryFilter.oKat2` | float32 | set by the firmware | IMX-5, IMX-6 | Attitude heading observer gain (magnetometer). |
| `13.4` | `complementaryFilter.oKuvw` | float32 | set by the firmware | IMX-5, IMX-6 | Velocity observer alpha gain (GNSS). |
| `13.5` | `complementaryFilter.oKlla` | float32 | set by the firmware | IMX-5, IMX-6 | Position observer alpha gain (GNSS). |

## CONFIG_MAG

Key `0x0104` (260). Served by IMX-5, IMX-6; read, write; stored in flash. Its keys are the same on every device type. `Name[enum]` is a map keyed by the values of that [enum](#values-of-enumerated-keys), and the key path shows `*` for its key. A plural such as `Receivers` holds values common to every instance, which an instance's own value overrides. A device stores and accepts only the keys listed as stored on it.

| Key | Name | Type | Default | Stored on | Description |
|---|---|---|---|---|---|
| `0` | `continuousCal` | bool | `false` | IMX-5, IMX-6 | Calibrate the magnetometer slowly in the background, in the EKF. |
| `1` | `autoRecal` | bool | `false` | IMX-5, IMX-6 | Recalibrate the magnetometer automatically. |
| `2` | `recalMode` | uint8 | `1` | IMX-5, IMX-6 | Magnetometer recalibration mode (eMagCalState): 1 = multi-axis, 2 = single-axis. The mag calibration command also sets it. |
| `3` | `interferenceThreshold` | float32 | `3` | IMX-5, IMX-6 | Magnetic interference detection sensitivity. Typically 2 to 10; 1000 disables interference detection. |
| `4` | `calQualityThreshold` | float32 | `10` | IMX-5, IMX-6 | Calibration quality sensitivity. Typically 10 to 20; 1000 disables the check, so the calibration is always treated as good. |
| `5` | `declination` | map | | | Magnetic declination, the heading offset of magnetic north from true north. |
| `5.0` | `declination.valueRad` | float32 | `0` | IMX-5, IMX-6 | (rad) Declination. |
| `5.1` | `declination.estimate` | bool | `true` | IMX-5, IMX-6 | Estimate the declination in the EKF. |
| `5.2` | `declination.useWmm` | bool | `false` | IMX-5, IMX-6 | Set the declination from the World Magnetic Model. |

## CONFIG_GROUND_VEHICLE

Key `0x0105` (261). Served by IMX-5, IMX-6; read, write; stored in flash. Its keys are the same on every device type. `Name[enum]` is a map keyed by the values of that [enum](#values-of-enumerated-keys), and the key path shows `*` for its key. A plural such as `Receivers` holds values common to every instance, which an instance's own value overrides. A device stores and accepts only the keys listed as stored on it.

| Key | Name | Type | Default | Stored on | Description |
|---|---|---|---|---|---|
| `0` | `transform` | map | | | The transform from the IMU (body) frame to the wheel frame, at the centre of the non-steering axle. |
| `0.0` | `transform.rotation` | float32[3] | `[0, 0, 0]` | IMX-5, IMX-6 | (rad) Euler angles of the rotation from the body frame to the wheel frame. |
| `0.1` | `transform.rotationSigma` | float32[3] | `[0.0174532924, 0.0174532924, 0.0174532924]` | IMX-5, IMX-6 | (rad) Standard deviation of the rotation. |
| `0.2` | `transform.translation` | float32[3] | `[0, 0, 0]` | IMX-5, IMX-6 | (m) Translation from the body frame to the wheel frame origin, in the body frame. |
| `0.3` | `transform.translationSigma` | float32[3] | `[0.300000012, 0.300000012, 0.300000012]` | IMX-5, IMX-6 | (m) Standard deviation of the translation. |
| `1` | `trackWidthM` | float32 | `0` | IMX-5, IMX-6 | (m) Distance between the left and right wheels. |
| `2` | `radiusM` | float32 | `0` | IMX-5, IMX-6 | (m) Wheel radius estimate. |
| `3` | `controlEnabled` | bool | `false` | IMX-5, IMX-6 | Enable wheel-based velocity control. |
| `4` | `encoder` | map | | | The wheel encoders. |
| `4.0` | `encoder.enabled` | bool | `false` | IMX-5, IMX-6 | Enable the wheel encoders. Their fusion in the INS is CONFIG_INS.fusion.wheel. |
| `4.1` | `encoder.source` | uint8 | `0` | IMX-5, IMX-6 | Where the wheel encoder hardware is connected: 0 = the module, 1 = the evaluation board. |
| `4.2` | `encoder.reverseLeft` | bool | `false` | IMX-5, IMX-6 | Reverse the reported direction of the left wheel. |
| `4.3` | `encoder.reverseRight` | bool | `false` | IMX-5, IMX-6 | Reverse the reported direction of the right wheel. |

## CONFIG_PORTS

Key `0x0106` (262). Served by IMX-5, IMX-6, GPX-1; read, write; stored in flash. Its keys are the same on every device type. `Name[enum]` is a map keyed by the values of that [enum](#values-of-enumerated-keys), and the key path shows `*` for its key. A plural such as `Receivers` holds values common to every instance, which an instance's own value overrides. A device stores and accepts only the keys listed as stored on it.

| Key | Name | Type | Default | Stored on | Description |
|---|---|---|---|---|---|
| `0` | `Ports` | map | | | Settings common to every port. A port's own value, in Port, overrides them. |
| `0.1` | `Ports.gsvBands` | uint8[9] | set by the firmware | IMX-5, IMX-6 | NMEA GSV frequency bands reported per constellation, indexed by eSatSvGnssId (NMEA_GNGSV_FREQ_*_BIT). |
| `1` | `Port[port_id]` | map | | | Settings per port, keyed by port_id. |
| `1.*.0` | `Port[port_id].baudRate` | uint32 | `921600` | IMX-5, IMX-6, GPX-1 | (bps) Baud rate. |

## CONFIG_SENSORS

Key `0x0107` (263). Served by IMX-5, IMX-6; read, write; stored in flash. Its keys are the same on every device type. `Name[enum]` is a map keyed by the values of that [enum](#values-of-enumerated-keys), and the key path shows `*` for its key. A plural such as `Receivers` holds values common to every instance, which an instance's own value overrides. A device stores and accepts only the keys listed as stored on it.

| Key | Name | Type | Default | Stored on | Description |
|---|---|---|---|---|---|
| `0` | `rotation` | uint8 | `0` | IMX-5, IMX-6 | Mounting rotation of the IMUs and magnetometer (SENSOR_CFG_SENSOR_ROTATION_*). |
| `1` | `Imus` | map | | | Settings common to every IMU. An IMU's own value, in Imu, overrides them. |
| `1.1` | `Imus.Gyr[imu_channel]` | map | | | Gyro channels, keyed by imu_channel. |
| `1.1.*.0` | `Imus.Gyr[imu_channel].fullScale` | uint8 | set by the firmware | IMX-5, IMX-6 | Full-scale range code: SENSOR_CFG_GYR_FS_* for a gyro, SENSOR_CFG_ACC_FS_* or SENSOR_CFG2_ACC_HG_FS_* for an accelerometer. |
| `1.1.*.1` | `Imus.Gyr[imu_channel].dlpf` | uint8 | `0` | IMX-5, IMX-6 | Digital low-pass filter bandwidth code (SENSOR_CFG_*_DLPF_*). |
| `1.2` | `Imus.Acc[imu_channel]` | map | | | Accelerometer channels, keyed by imu_channel: the primary channel, and the high-g channel used above the primary range. |
| `1.2.*.0` | `Imus.Acc[imu_channel].fullScale` | uint8 | set by the firmware | IMX-5, IMX-6 | Full-scale range code: SENSOR_CFG_GYR_FS_* for a gyro, SENSOR_CFG_ACC_FS_* or SENSOR_CFG2_ACC_HG_FS_* for an accelerometer. |
| `1.2.*.1` | `Imus.Acc[imu_channel].dlpf` | uint8 | `0` | IMX-5, IMX-6 | Digital low-pass filter bandwidth code (SENSOR_CFG_*_DLPF_*). |
| `2` | `Imu[imu_slot]` | map | | | Settings per IMU, keyed by imu_slot. |
| `2.*.0` | `Imu[imu_slot].enabled` | bool | `true` | IMX-5, IMX-6 | Sample the IMU and use it. |
| `3` | `Mags` | map | | | Settings common to every magnetometer. |
| `3.0` | `Mags.enabled` | bool | `true` | IMX-5, IMX-6 | Sample the sensor. |
| `5` | `Baros` | map | | | Settings common to every barometer. |
| `5.0` | `Baros.enabled` | bool | `true` | IMX-5, IMX-6 | Sample the sensor. |

## CONFIG_IO

Key `0x0108` (264). Served by IMX-5, IMX-6; read, write; stored in flash. Its keys are the same on every device type. `Name[enum]` is a map keyed by the values of that [enum](#values-of-enumerated-keys), and the key path shows `*` for its key. A plural such as `Receivers` holds values common to every instance, which an instance's own value overrides. A device stores and accepts only the keys listed as stored on it.

| Key | Name | Type | Default | Stored on | Description |
|---|---|---|---|---|---|
| `0` | `strobeActiveHigh` | bool | set by the firmware | IMX-5, IMX-6 | Strobe input and output trigger on the rising edge. False triggers on the falling edge. |
| `1` | `Pin[pin_id]` | map | | | Pin functions, keyed by pin_id. A pair of pins that is configured together has one entry. |
| `1.*.0` | `Pin[pin_id].function` | uint8 | set by the firmware | IMX-5, IMX-6 | What the pin, or pin pair, is used for. The values are the pin's own IO_CONFIG_* (or IO_CFG2_*) field values, unshifted. |

## CONFIG_GNSS

Key `0x0109` (265). Served by IMX-5, IMX-6, GPX-1; read, write; stored in flash. Its keys are the same on every device type. `Name[enum]` is a map keyed by the values of that [enum](#values-of-enumerated-keys), and the key path shows `*` for its key. A plural such as `Receivers` holds values common to every instance, which an instance's own value overrides. A device stores and accepts only the keys listed as stored on it.

| Key | Name | Type | Default | Stored on | Description |
|---|---|---|---|---|---|
| `0` | `periodMs` | uint32 | `200` | IMX-5, IMX-6, GPX-1 | (ms) GNSS measurement period at startup. 200 ms minimum. |
| `1` | `primaryReceiver` | uint8 | `0` | IMX-5, IMX-6 | The receiver (receiver_id) used as the NMEA data source. |
| `2` | `timeSync` | map | | | Synchronisation to GPS time. |
| `2.0` | `timeSync.periodMs` | uint32 | `1000` | IMX-5, IMX-6, GPX-1 | (ms) Time between GPS time synchronisation pulses. Takes effect after a reset. |
| `2.1` | `timeSync.userDelayS` | float32 | `0` | IMX-5, IMX-6, GPX-1 | (s) Delay added to GPS time, for example to account for antenna cable delay. |
| `3` | `externalAiding` | map | | | External aiding observations the device outputs. |
| `3.0` | `externalAiding.fixedLatency` | bool | `false` | GPX-1 | Timestamp external aiding position and velocity with a fixed latency instead of GNSS time of week, for a consumer that has no GNSS time. |
| `4` | `Receivers` | map | | | Settings common to every receiver. A receiver's own value, in Receiver, overrides them. |
| `4.5` | `Receivers.signals` | uint16 | `5119` | IMX-5, IMX-6, GPX-1 | Satellite constellations and signals used in the solution (eGnssSatSigConst bits). |
| `4.6` | `Receivers.minElevation` | float32 | `0.17453292` | IMX-5, IMX-6, GPX-1 | (rad) Minimum elevation above the horizon of a satellite used in the solution. |
| `4.7` | `Receivers.cn0Min` | uint8 | `30` | IMX-5, IMX-6, GPX-1 | (dBHz) Absolute minimum carrier-to-noise density of a signal used in the RTK solution. |
| `4.8` | `Receivers.cn0DynOffset` | uint8 | `20` | IMX-5, IMX-6, GPX-1 | (dBHz) A signal more than this far below the strongest signal's carrier-to-noise density is not used in the RTK solution. 0 disables the dynamic threshold. |
| `4.9` | `Receivers.dynamicModel` | uint8 | `8` | GPX-1 | The receiver's dynamic platform model (eDynamicModel). |
| `5` | `Receiver[receiver_id]` | map | | | Settings per receiver, keyed by receiver_id. |
| `5.*.0` | `Receiver[receiver_id].type` | uint8 | set by the firmware | IMX-5, IMX-6 | Receiver type (IO_CONFIG_GNSS_TYPE_*): none, u-blox, NMEA, GPX, Septentrio or host pass-through. |
| `5.*.1` | `Receiver[receiver_id].port` | uint8 | set by the firmware | IMX-5, IMX-6 | Port the receiver is connected on (IO_CONFIG_GNSS_SOURCE_*): disabled, or serial port 0, 1 or 2. |
| `5.*.2` | `Receiver[receiver_id].ppsPin` | uint8 | set by the firmware | IMX-5, IMX-6 | Pin the receiver's PPS (time pulse) arrives on. |
| `5.*.3` | `Receiver[receiver_id].configure` | bool | set by the firmware | IMX-5, IMX-6 | Configure the receiver at startup. When false the receiver is used as it is already configured. |
| `5.*.4` | `Receiver[receiver_id].fusionEnabled` | bool | `true` | IMX-5, IMX-6 | Use the receiver's measurements in the INS solution. |
| `6` | `Antennas` | map | | | Settings common to every antenna. An antenna's own value, in Antenna, overrides them. |
| `6.2` | `Antennas.offsetEstimation` | bool | `false` | IMX-5, IMX-6 | Estimate the rover antenna offset in RTK compassing mode. |
| `6.3` | `Antennas.powerEnabled` | bool | `true` | GPX-1 | Power the active antenna (VCC_RF). |
| `7` | `Antenna[antenna_id]` | map | | | Settings per antenna, keyed by antenna_id. |
| `7.*.1` | `Antenna[antenna_id].offset` | float32[3] | `[0, 0, 0]` | IMX-5, IMX-6, GPX-1 | (m) X, Y, Z offset from the sensor frame origin to the antenna, in the sensor frame. |
| `8` | `Rtk` | map | | | RTK rover and base settings. |
| `8.0` | `Rtk.mode` | uint8 | `0` | IMX-5, IMX-6, GPX-1 | RTK rover mode (RTK_CFG_BITS_ROVER_MODE_* bits): positioning, dual-receiver compassing, or both. |
| `8.1` | `Rtk.basePosition` | float64[3] | `[0, 0, 0]` | GPX-1 | (deg, deg, m) Latitude, longitude and height above the ellipsoid of the RTK base, set directly or by survey-in. |
| `8.2` | `Rtk.basePositionMoving` | bool | `false` | IMX-5, IMX-6, GPX-1 | The base is moving. Reserved: not implemented, and must be false. |
| `8.3` | `Rtk.baseIdenticalToRover` | bool | `false` | IMX-5, IMX-6, GPX-1 | The base is the same hardware as this rover, which lets the solution reach a fix faster. |
| `8.4` | `Rtk.passThrough` | bool | `false` | IMX-5, IMX-6, GPX-1 | Forward every message between the receiver and the serial port. Disable for base use, to forward only raw measurements and use basePosition. |
| `8.5` | `Rtk.multipathMitigation` | bool | `false` | IMX-5, IMX-6, GPX-1 | Detect and mitigate multipath in the RTK solution. |
| `8.6` | `Rtk.BaseOutput[base_stream]` | map | | | As an RTK base, the ports each correction stream (base_stream: receiver and format) is sent on. |
| `8.6.*.0` | `Rtk.BaseOutput[base_stream].ser0` | bool | `false` | IMX-5, IMX-6, GPX-1 | Send this correction stream on serial port 0. |
| `8.6.*.1` | `Rtk.BaseOutput[base_stream].ser1` | bool | `false` | IMX-5, IMX-6, GPX-1 | Send this correction stream on serial port 1. |
| `8.6.*.2` | `Rtk.BaseOutput[base_stream].ser2` | bool | `false` | IMX-5, IMX-6, GPX-1 | Send this correction stream on serial port 2. |
| `8.6.*.3` | `Rtk.BaseOutput[base_stream].usb` | bool | `false` | IMX-5, IMX-6, GPX-1 | Send this correction stream on the USB port. |

## CONFIG_CAN

Key `0x010A` (266). Served by IMX-5, IMX-6; read, write; stored in flash. Its keys are the same on every device type. `Name[enum]` is a map keyed by the values of that [enum](#values-of-enumerated-keys), and the key path shows `*` for its key. A plural such as `Receivers` holds values common to every instance, which an instance's own value overrides. A device stores and accepts only the keys listed as stored on it.

| Key | Name | Type | Default | Stored on | Description |
|---|---|---|---|---|---|
| `0` | `bitRateKbps` | uint16 | `100` | IMX-5, IMX-6 | (kbps) CAN bus bit rate (can_baudrate_t). |
| `1` | `fdEnabled` | bool | `false` | IMX-5, IMX-6 | Use CAN FD framing with bit-rate switching for messages over 8 bytes, on hardware that supports it. |
| `2` | `receiveAddress` | uint32 | `0` | IMX-5, IMX-6 | CAN identifier the device receives on. |
| `3` | `Message[can_message]` | map | | | Broadcast messages, keyed by can_message. With CAN FD enabled the same slots hold the CAN FD messages. |
| `3.*.0` | `Message[can_message].periodMultiple` | uint16 | `0` | IMX-5, IMX-6 | Broadcast period, as a multiple of the navigation period. 0 disables the message. |
| `3.*.1` | `Message[can_message].transmitAddress` | uint32 | `0` | IMX-5, IMX-6 | CAN identifier the message is sent with. 0, or a value above 0x1FFFFFFF, takes a default identifier. |

## STATE

Key `0x010B` (267). Served by IMX-5, IMX-6; read, write; stored in flash. Its keys are the same on every device type. `Name[enum]` is a map keyed by the values of that [enum](#values-of-enumerated-keys), and the key path shows `*` for its key. A plural such as `Receivers` holds values common to every instance, which an instance's own value overrides. A device stores and accepts only the keys listed as stored on it.

| Key | Name | Type | Default | Stored on | Description |
|---|---|---|---|---|---|
| `0` | `lastPosition` | map | | | The last known position, written by the firmware as the device moves. |
| `0.0` | `lastPosition.lla` | float64[3] | `[0, 0, 0]` | IMX-5, IMX-6 | (deg, deg, m) Latitude, longitude and height above the ellipsoid. |
| `0.1` | `lastPosition.timeOfWeekMs` | uint32 | `0` | IMX-5, IMX-6 | (ms) GPS time of week of the position. |
| `0.2` | `lastPosition.week` | uint32 | `0` | IMX-5, IMX-6 | GPS week of the position. |
| `1` | `Mag[mag_id]` | map | | | Magnetometer calibration state, keyed by mag_id. |
| `1.*.0` | `Mag[mag_id].coverage` | map | | | Which directions the magnetometer calibration has sampled: a count per cell of an equal-area grid over the sphere of field directions. |
| `1.*.0.1` | `Mag[mag_id].coverage.counts` | uint8[64] | `0` | IMX-5, IMX-6 | A 4-bit saturating sample count per cell, two cells per byte, the even-numbered cell in the low nibble. All zero means no map. |
| `1.*.0.2` | `Mag[mag_id].coverage.sampleCount` | uint32 | `0` | IMX-5, IMX-6 | The number of samples in the calibration's least-squares accumulator when the map was saved. The map belongs to the calibration with this count. |
| `1.*.1` | `Mag[mag_id].solver` | map | | | The magnetometer calibration solver's state, kept so a calibration in progress survives a reset. |
| `1.*.1.0` | `Mag[mag_id].solver.dtd` | float32[100] | `0` | IMX-5, IMX-6 | The least-squares accumulator (DtD) of the in-field magnetometer calibration. |

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
| `MAG_CAL_MAP` | `0x0101` (257) |
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

### can_message

| Name | Value |
|---|---|
| `INS_TIME` | 0 |
| `INS_STATUS` | 1 |
| `INS_EULER` | 2 |
| `INS_QUATN2B` | 3 |
| `INS_QUATE2B` | 4 |
| `INS_UVW` | 5 |
| `INS_VE` | 6 |
| `INS_LAT` | 7 |
| `INS_LON` | 8 |
| `INS_ALT` | 9 |
| `INS_NORTH_EAST` | 10 |
| `INS_DOWN` | 11 |
| `INS_ECEF_X` | 12 |
| `INS_ECEF_Y` | 13 |
| `INS_ECEF_Z` | 14 |
| `INS_MSL` | 15 |
| `PREINT_PX` | 16 |
| `PREINT_QY` | 17 |
| `PREINT_RZ` | 18 |
| `DUAL_PX` | 19 |
| `DUAL_QY` | 20 |
| `DUAL_RZ` | 21 |
| `GNSS1_POS` | 22 |
| `GNSS2_POS` | 23 |
| `GNSS1_RTK_POS_REL` | 24 |
| `GNSS2_RTK_CMP_REL` | 25 |
| `ROLL_ROLLRATE` | 26 |

### receiver_id

| Name | Value |
|---|---|
| `GNSS1` | 0 |
| `GNSS2` | 1 |

### antenna_id

| Name | Value |
|---|---|
| `ANT1` | 0 |
| `ANT2` | 1 |

### base_stream

| Name | Value |
|---|---|
| `GNSS1_UBLOX` | 0 |
| `GNSS1_RTCM3` | 1 |
| `GNSS2_UBLOX` | 2 |
| `GNSS2_RTCM3` | 3 |

### pin_id

| Name | Value |
|---|---|
| `G1G2` | 0 |
| `G5G8` | 1 |
| `G6G7` | 2 |
| `G9` | 3 |
| `G11` | 4 |
| `G12` | 5 |
| `G13` | 6 |
| `G15` | 7 |

### imu_slot

| Name | Value |
|---|---|
| `IMU1` | 0 |
| `IMU2` | 1 |
| `IMU3` | 2 |
| `IMU4` | 3 |
| `IMU5` | 4 |

### imu_channel

| Name | Value |
|---|---|
| `PRIMARY` | 0 |
| `HIGH_G` | 1 |

### mag_id

| Name | Value |
|---|---|
| `MAG1` | 0 |

### baro_id

| Name | Value |
|---|---|
| `BARO1` | 0 |

### port_id

| Name | Value |
|---|---|
| `SER0` | 0 |
| `SER1` | 1 |
| `SER2` | 2 |
| `USB` | 3 |
| `SPI` | 4 |
