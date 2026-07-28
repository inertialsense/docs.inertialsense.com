

## Data Sets (DIDs)

Data Sets in the form of C structures are available through binary protocol and provide access to system configuration and output data. The data sets are defined in SDK/src/data_sets.h of the InertialSense SDK.

### INS / AHRS Output

#### DID_INS_1

`ins_1_t`

| Field | Type | Description |
|-------|------|-------------|
| week | uint32_t | GPS number of weeks since January 6th, 1980 |
| timeOfWeek | double | GPS time of week (since Sunday morning) in seconds |
| insStatus | uint32_t | INS status flags (eInsStatusFlags). Copy of DID_SYS_PARAMS.insStatus |
| hdwStatus | uint32_t | Hardware status flags (eHdwStatusFlags). Copy of DID_SYS_PARAMS.hdwStatus |
| theta | float[3] | Euler angles: roll, pitch, yaw in radians with respect to NED |
| uvw | float[3] | Velocity U, V, W in meters/second, in body frame. Convert to NED velocity using "vectorBodyToReference(uvw, theta, vel_ned)". |
| lla | double[3] | WGS84 latitude, longitude, height above ellipsoid (degrees, degrees, meters) |
| ned | float[3] | North, east, down (meters) offset from reference latitude, longitude, and altitude to current latitude, longitude, and altitude |


#### DID_INS_2

`ins_2_t`

| Field | Type | Description |
|-------|------|-------------|
| week | uint32_t | GPS number of weeks since January 6th, 1980 |
| timeOfWeek | double | GPS time of week (since Sunday morning) in seconds |
| insStatus | uint32_t | INS status flags (eInsStatusFlags). Copy of DID_SYS_PARAMS.insStatus |
| hdwStatus | uint32_t | Hardware status flags (eHdwStatusFlags). Copy of DID_SYS_PARAMS.hdwStatus |
| qn2b | float[4] | Quaternion body rotation with respect to NED: W, X, Y, Z |
| uvw | float[3] | Velocity U, V, W in meters/second, in body frame. Convert to NED velocity using "quatRot(vel_ned, qn2b, uvw)". |
| lla | double[3] | WGS84 latitude, longitude, height above ellipsoid in meters (not MSL) |


#### DID_INS_3

`ins_3_t`

| Field | Type | Description |
|-------|------|-------------|
| week | uint32_t | GPS number of weeks since January 6th, 1980 |
| timeOfWeek | double | GPS time of week (since Sunday morning) in seconds |
| insStatus | uint32_t | INS status flags (eInsStatusFlags). Copy of DID_SYS_PARAMS.insStatus |
| hdwStatus | uint32_t | Hardware status flags (eHdwStatusFlags). Copy of DID_SYS_PARAMS.hdwStatus |
| qn2b | float[4] | Quaternion body rotation with respect to NED: W, X, Y, Z |
| uvw | float[3] | Velocity U, V, W in meters/second, in body frame. Convert to NED velocity using "quatRot(vel_ned, qn2b, uvw)". |
| lla | double[3] | WGS84 latitude, longitude, height above ellipsoid in meters (not MSL) |
| msl | float | Height above mean sea level (MSL) in meters |


#### DID_INS_4

`ins_4_t`

| Field | Type | Description |
|-------|------|-------------|
| week | uint32_t | GPS number of weeks since January 6th, 1980 |
| timeOfWeek | double | GPS time of week (since Sunday morning) in seconds |
| insStatus | uint32_t | INS status flags (eInsStatusFlags). Copy of DID_SYS_PARAMS.insStatus |
| hdwStatus | uint32_t | Hardware status flags (eHdwStatusFlags). Copy of DID_SYS_PARAMS.hdwStatus |
| qe2b | float[4] | Quaternion body rotation with respect to ECEF: W, X, Y, Z |
| ve | float[3] | Velocity in ECEF (earth-centered earth-fixed) frame in meters per second |
| ecef | double[3] | Position in ECEF (earth-centered earth-fixed) frame in meters |


### Inertial Measurement Unit (IMU)

#### DID_IMU

`imu_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds. Convert to GPS time of week by adding gps.towOffset |
| status | uint32_t | IMU status flags (eImuStatus) |
| I | imui_t | Combined Inertial Measurement Unit (IMU) sample: angular rate and acceleration |


#### DID_IMUS

`imus_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds. Convert to GPS time of week by adding gps.towOffset |
| status | uint32_t | IMUs status flags (eImusStatus) |
| I | imui_t[1] | Per-device Inertial Measurement Unit (IMU) samples: angular rate and acceleration |


#### DID_IMUS_RAW

Multiple IMU data calibrated from DID_IMUS_UNCAL.  We recommend use of DID_IMU or DID_PIMU as they are oversampled and contain less noise. 

`imus_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds. Convert to GPS time of week by adding gps.towOffset |
| status | uint32_t | IMUs status flags (eImusStatus) |
| I | imui_t[1] | Per-device Inertial Measurement Unit (IMU) samples: angular rate and acceleration |


#### DID_IMU_RAW

IMU data averaged from DID_IMUS_RAW.  Use this IMU data for output data rates faster than DID_FLASH_CONFIG.startupNavDtMs.  Otherwise we recommend use of DID_IMU or DID_PIMU as they are oversampled and contain less noise. 

`imu_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds. Convert to GPS time of week by adding gps.towOffset |
| status | uint32_t | IMU status flags (eImuStatus) |
| I | imui_t | Combined Inertial Measurement Unit (IMU) sample: angular rate and acceleration |


#### DID_PIMU

`pimu_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds. Convert to GPS time of week by adding gps.towOffset |
| dt | float | Integration period in seconds for delta theta and delta velocity. Configured using DID_FLASH_CONFIG.startupNavDtMs |
| status | uint32_t | IMU status flags (eImuStatus) |
| theta | float[3] | IMU delta theta: gyroscope {p,q,r} integral over dt, in radians, in sensor/body frame |
| vel | float[3] | IMU delta velocity: accelerometer {x,y,z} integral over dt, in meters/second, in sensor/body frame |


### Sensor Output

#### DID_BAROMETER

`barometer_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds. Convert to GPS time of week by adding gps.towOffset |
| bar | float | Barometric pressure in kilopascals (kPa) |
| mslBar | float | MSL altitude derived from barometric pressure sensor, in meters |
| barTemp | float | Temperature of barometric pressure sensor in Celsius |
| humidity | float | Relative humidity as a percent (%rH). Range is 0% - 100% |


#### DID_MAGNETOMETER

`magnetometer_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds. Convert to GPS time of week by adding gps.towOffset |
| mag | float[3] | Magnetometer X, Y, Z in microtesla (uT), in body frame |


#### DID_MAG_CAL

`mag_cal_t`

| Field | Type | Description |
|-------|------|-------------|
| state | uint32_t | Mag recalibration command/status.  COMMANDS: 1=multi-axis, 2=single-axis, 101=abort, STATUS: 200=running, 201=done (see eMagCalState) |
| progress | float | (%) Mag recalibration progress indicator: 0-100 |
| declination | float | (rad) Magnetic declination estimate |


#### DID_SYS_SENSORS

`sys_sensors_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up, in seconds. Convert to GPS time of week by adding gps.towOffset |
| temp | float | IMU temperature, in Celsius |
| pqr | float[3] | Gyros {p,q,r}, in radians/second |
| acc | float[3] | Accelerometers {x,y,z}, in meters/second^2 |
| mag | float[3] | Magnetometers {x,y,z} (uncalibrated units) |
| bar | float | Barometric pressure, in kilopascals |
| barTemp | float | Temperature of barometric pressure sensor, in Celsius |
| mslBar | float | MSL altitude derived from barometric pressure sensor, in meters |
| humidity | float | Relative humidity as a percent (%rH). Range is 0% - 100% |
| vin | float | EVB system input voltage, in volts. uINS pin 5 (G2/AN2). Use 10K/1K resistor divider between Vin and GND. |
| ana1 | float | ADC analog input, in volts. uINS pin 4 (G1/AN1) |
| ana3 | float | ADC analog input, in volts. uINS pin 19 (G3/AN3) |
| ana4 | float | ADC analog input, in volts. uINS pin 20 (G4/AN4) |


### GPS / GNSS

#### DID_GNSS1_POS

`gnss_pos_t`

| Field | Type | Description |
|-------|------|-------------|
| week | uint32_t | GPS number of weeks since January 6th, 1980 |
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| status | uint32_t | GNSS status (see eGnssStatus): [0x000000xx] number of satellites used, [0x0000xx00] fix type, [0x00xx0000] status flags, NMEA input flag |
| ecef | double[3] | Position in ECEF {x,y,z}, in meters |
| lla | double[3] | Position in WGS84 latitude, longitude, height above ellipsoid (not MSL), in degrees, degrees, meters |
| hMSL | float | Height above mean sea level (MSL), in meters |
| hAcc | float | Horizontal accuracy, in meters |
| vAcc | float | Vertical accuracy, in meters |
| pDop | float | Position dilution of precision (unitless) |
| cnoMean | float | Average of all non-zero satellite carrier to noise ratios (signal strengths), in dBHz |
| towOffset | double | Time sync offset between local time since boot up and GPS time of week, in seconds. Add this to IMU and sensor time to get GPS time of week in seconds. |
| leapS | uint8_t | GPS leap second (GPS-UTC) offset, in seconds. Receiver's best knowledge of the leap seconds offset from UTC to GPS time. Subtract from GPS time of week to get UTC time of week. (18 seconds as of December 31, 2016) |
| satsUsed | uint8_t | Number of satellites used in the position solution |
| cnoMeanSigma | uint8_t | Standard deviation of cnoMean over the past 5 seconds, in dBHz x10 |
| status2 | uint8_t | Secondary GNSS status byte (see eGnssStatus2): [0x0X] spoofing/jamming status, [0xX0] unused |


#### DID_GNSS1_RCVR_POS

GNSS 1 position data from GNSS receiver. 

`gnss_pos_t`

| Field | Type | Description |
|-------|------|-------------|
| week | uint32_t | GPS number of weeks since January 6th, 1980 |
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| status | uint32_t | GNSS status (see eGnssStatus): [0x000000xx] number of satellites used, [0x0000xx00] fix type, [0x00xx0000] status flags, NMEA input flag |
| ecef | double[3] | Position in ECEF {x,y,z}, in meters |
| lla | double[3] | Position in WGS84 latitude, longitude, height above ellipsoid (not MSL), in degrees, degrees, meters |
| hMSL | float | Height above mean sea level (MSL), in meters |
| hAcc | float | Horizontal accuracy, in meters |
| vAcc | float | Vertical accuracy, in meters |
| pDop | float | Position dilution of precision (unitless) |
| cnoMean | float | Average of all non-zero satellite carrier to noise ratios (signal strengths), in dBHz |
| towOffset | double | Time sync offset between local time since boot up and GPS time of week, in seconds. Add this to IMU and sensor time to get GPS time of week in seconds. |
| leapS | uint8_t | GPS leap second (GPS-UTC) offset, in seconds. Receiver's best knowledge of the leap seconds offset from UTC to GPS time. Subtract from GPS time of week to get UTC time of week. (18 seconds as of December 31, 2016) |
| satsUsed | uint8_t | Number of satellites used in the position solution |
| cnoMeanSigma | uint8_t | Standard deviation of cnoMean over the past 5 seconds, in dBHz x10 |
| status2 | uint8_t | Secondary GNSS status byte (see eGnssStatus2): [0x0X] spoofing/jamming status, [0xX0] unused |


#### DID_GNSS1_RTK_POS

GNSS RTK position data 

`gnss_pos_t`

| Field | Type | Description |
|-------|------|-------------|
| week | uint32_t | GPS number of weeks since January 6th, 1980 |
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| status | uint32_t | GNSS status (see eGnssStatus): [0x000000xx] number of satellites used, [0x0000xx00] fix type, [0x00xx0000] status flags, NMEA input flag |
| ecef | double[3] | Position in ECEF {x,y,z}, in meters |
| lla | double[3] | Position in WGS84 latitude, longitude, height above ellipsoid (not MSL), in degrees, degrees, meters |
| hMSL | float | Height above mean sea level (MSL), in meters |
| hAcc | float | Horizontal accuracy, in meters |
| vAcc | float | Vertical accuracy, in meters |
| pDop | float | Position dilution of precision (unitless) |
| cnoMean | float | Average of all non-zero satellite carrier to noise ratios (signal strengths), in dBHz |
| towOffset | double | Time sync offset between local time since boot up and GPS time of week, in seconds. Add this to IMU and sensor time to get GPS time of week in seconds. |
| leapS | uint8_t | GPS leap second (GPS-UTC) offset, in seconds. Receiver's best knowledge of the leap seconds offset from UTC to GPS time. Subtract from GPS time of week to get UTC time of week. (18 seconds as of December 31, 2016) |
| satsUsed | uint8_t | Number of satellites used in the position solution |
| cnoMeanSigma | uint8_t | Standard deviation of cnoMean over the past 5 seconds, in dBHz x10 |
| status2 | uint8_t | Secondary GNSS status byte (see eGnssStatus2): [0x0X] spoofing/jamming status, [0xX0] unused |


#### DID_GNSS1_RTK_POS_MISC

`gnss_rtk_misc_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning), in milliseconds |
| accuracyPos | float[3] | Accuracy: estimated standard deviations of the position solution assuming the a priori error model and error parameters used by the positioning options. []: {ECEF x,y,z} or {north,east,down}, in meters |
| accuracyCov | float[3] | Accuracy: estimated covariance of the position solution. []: absolute value of the square root of the estimated covariance {NE, EU, UN}, in meters |
| arThreshold | float | Ambiguity resolution threshold for validation (unitless) |
| gDop | float | Geometric dilution of precision (unitless) |
| hDop | float | Horizontal dilution of precision (unitless) |
| vDop | float | Vertical dilution of precision (unitless) |
| baseLla | double[3] | Base station position: latitude, longitude, height (deg, deg, m) |
| cycleSlipCount | uint32_t | Cycle slip counter |
| roverGpsObservationCount | uint32_t | Rover GPS observation element counter |
| baseGpsObservationCount | uint32_t | Base station GPS observation element counter |
| roverGlonassObservationCount | uint32_t | Rover GLONASS observation element counter |
| baseGlonassObservationCount | uint32_t | Base station GLONASS observation element counter |
| roverGalileoObservationCount | uint32_t | Rover Galileo observation element counter |
| baseGalileoObservationCount | uint32_t | Base station Galileo observation element counter |
| roverBeidouObservationCount | uint32_t | Rover BeiDou observation element counter |
| baseBeidouObservationCount | uint32_t | Base station BeiDou observation element counter |
| roverQzsObservationCount | uint32_t | Rover QZSS observation element counter |
| baseQzsObservationCount | uint32_t | Base station QZSS observation element counter |
| roverGpsEphemerisCount | uint32_t | Rover GPS ephemeris element counter |
| baseGpsEphemerisCount | uint32_t | Base station GPS ephemeris element counter |
| roverGlonassEphemerisCount | uint32_t | Rover GLONASS ephemeris element counter |
| baseGlonassEphemerisCount | uint32_t | Base station GLONASS ephemeris element counter |
| roverGalileoEphemerisCount | uint32_t | Rover Galileo ephemeris element counter |
| baseGalileoEphemerisCount | uint32_t | Base station Galileo ephemeris element counter |
| roverBeidouEphemerisCount | uint32_t | Rover BeiDou ephemeris element counter |
| baseBeidouEphemerisCount | uint32_t | Base station BeiDou ephemeris element counter |
| roverQzsEphemerisCount | uint32_t | Rover QZSS ephemeris element counter |
| baseQzsEphemerisCount | uint32_t | Base station QZSS ephemeris element counter |
| roverSbasCount | uint32_t | Rover SBAS element counter |
| baseSbasCount | uint32_t | Base station SBAS element counter |
| baseAntennaCount | uint32_t | Base station antenna position element counter |
| ionUtcAlmCount | uint32_t | Ionosphere model, UTC, and almanac element counter |
| correctionChecksumFailures | uint32_t | Number of checksum failures from received corrections |
| timeToFirstFixMs | uint32_t | Time to first RTK fix, in milliseconds |


#### DID_GNSS1_RTK_POS_REL

`gnss_rtk_rel_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning), in milliseconds |
| differentialAge | float | Age of differential corrections, in seconds |
| arRatio | float | Ambiguity resolution ratio factor for validation (unitless; higher indicates greater confidence the fixed integer ambiguity is correct) |
| baseToRoverVector | float[3] | Vector from base to rover {x,y,z} in ECEF, in meters. If compassing is enabled, this is instead the 3-vector from antenna 2 (GNSS2) to antenna 1 (GNSS1) |
| baseToRoverDistance | float | Distance from base to rover (baseline length), in meters |
| baseToRoverHeading | float | Angle from north to baseToRoverVector in the local tangent plane, in radians |
| baseToRoverHeadingAcc | float | Accuracy (standard deviation) of baseToRoverHeading, in radians |
| status | uint32_t | GNSS status (see eGnssStatus): [0x000000xx] number of satellites used, [0x0000xx00] fix type, [0x00xx0000] status flags, NMEA input flag |


#### DID_GNSS1_SAT

`gnss_sat_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| numSats | uint32_t | Number of satellites in the sky (valid entries in the sat[] list below) |
| sat | gnss_sat_sv_t[50] | Per-satellite tracking information list |


#### DID_GNSS1_VEL

`gnss_vel_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| vel | float[3] | GNSS velocity, in meters/second. In ECEF {vx,vy,vz} if status bit GNSS_STATUS_FLAGS_GNSS_NMEA_DATA (0x00008000) is NOT set; in local tangent plane with no vertical velocity {vNorth, vEast, 0} if that bit IS set. |
| sAcc | float | Speed accuracy, in meters/second |
| status | uint32_t | GNSS status (see eGnssStatus): [0x000000xx] number of satellites used, [0x0000xx00] fix type, [0x00xx0000] status flags, NMEA input flag |


#### DID_GNSS1_VERSION

`gnss_version_t`

| Field | Type | Description |
|-------|------|-------------|
| swVersion | uint8_t[30] | GNSS receiver software version string |
| hwVersion | uint8_t[10] | GNSS receiver hardware version string |
| extension | gnss_extension_ver_t[6] | Additional 30-byte extension version-info strings reported by the receiver |


#### DID_GNSS2_POS

GNSS 2 position data 

`gnss_pos_t`

| Field | Type | Description |
|-------|------|-------------|
| week | uint32_t | GPS number of weeks since January 6th, 1980 |
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| status | uint32_t | GNSS status (see eGnssStatus): [0x000000xx] number of satellites used, [0x0000xx00] fix type, [0x00xx0000] status flags, NMEA input flag |
| ecef | double[3] | Position in ECEF {x,y,z}, in meters |
| lla | double[3] | Position in WGS84 latitude, longitude, height above ellipsoid (not MSL), in degrees, degrees, meters |
| hMSL | float | Height above mean sea level (MSL), in meters |
| hAcc | float | Horizontal accuracy, in meters |
| vAcc | float | Vertical accuracy, in meters |
| pDop | float | Position dilution of precision (unitless) |
| cnoMean | float | Average of all non-zero satellite carrier to noise ratios (signal strengths), in dBHz |
| towOffset | double | Time sync offset between local time since boot up and GPS time of week, in seconds. Add this to IMU and sensor time to get GPS time of week in seconds. |
| leapS | uint8_t | GPS leap second (GPS-UTC) offset, in seconds. Receiver's best knowledge of the leap seconds offset from UTC to GPS time. Subtract from GPS time of week to get UTC time of week. (18 seconds as of December 31, 2016) |
| satsUsed | uint8_t | Number of satellites used in the position solution |
| cnoMeanSigma | uint8_t | Standard deviation of cnoMean over the past 5 seconds, in dBHz x10 |
| status2 | uint8_t | Secondary GNSS status byte (see eGnssStatus2): [0x0X] spoofing/jamming status, [0xX0] unused |


#### DID_GNSS2_RTK_CMP_MISC

RTK Dual GNSS RTK compassing related data. 

`gnss_rtk_misc_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning), in milliseconds |
| accuracyPos | float[3] | Accuracy: estimated standard deviations of the position solution assuming the a priori error model and error parameters used by the positioning options. []: {ECEF x,y,z} or {north,east,down}, in meters |
| accuracyCov | float[3] | Accuracy: estimated covariance of the position solution. []: absolute value of the square root of the estimated covariance {NE, EU, UN}, in meters |
| arThreshold | float | Ambiguity resolution threshold for validation (unitless) |
| gDop | float | Geometric dilution of precision (unitless) |
| hDop | float | Horizontal dilution of precision (unitless) |
| vDop | float | Vertical dilution of precision (unitless) |
| baseLla | double[3] | Base station position: latitude, longitude, height (deg, deg, m) |
| cycleSlipCount | uint32_t | Cycle slip counter |
| roverGpsObservationCount | uint32_t | Rover GPS observation element counter |
| baseGpsObservationCount | uint32_t | Base station GPS observation element counter |
| roverGlonassObservationCount | uint32_t | Rover GLONASS observation element counter |
| baseGlonassObservationCount | uint32_t | Base station GLONASS observation element counter |
| roverGalileoObservationCount | uint32_t | Rover Galileo observation element counter |
| baseGalileoObservationCount | uint32_t | Base station Galileo observation element counter |
| roverBeidouObservationCount | uint32_t | Rover BeiDou observation element counter |
| baseBeidouObservationCount | uint32_t | Base station BeiDou observation element counter |
| roverQzsObservationCount | uint32_t | Rover QZSS observation element counter |
| baseQzsObservationCount | uint32_t | Base station QZSS observation element counter |
| roverGpsEphemerisCount | uint32_t | Rover GPS ephemeris element counter |
| baseGpsEphemerisCount | uint32_t | Base station GPS ephemeris element counter |
| roverGlonassEphemerisCount | uint32_t | Rover GLONASS ephemeris element counter |
| baseGlonassEphemerisCount | uint32_t | Base station GLONASS ephemeris element counter |
| roverGalileoEphemerisCount | uint32_t | Rover Galileo ephemeris element counter |
| baseGalileoEphemerisCount | uint32_t | Base station Galileo ephemeris element counter |
| roverBeidouEphemerisCount | uint32_t | Rover BeiDou ephemeris element counter |
| baseBeidouEphemerisCount | uint32_t | Base station BeiDou ephemeris element counter |
| roverQzsEphemerisCount | uint32_t | Rover QZSS ephemeris element counter |
| baseQzsEphemerisCount | uint32_t | Base station QZSS ephemeris element counter |
| roverSbasCount | uint32_t | Rover SBAS element counter |
| baseSbasCount | uint32_t | Base station SBAS element counter |
| baseAntennaCount | uint32_t | Base station antenna position element counter |
| ionUtcAlmCount | uint32_t | Ionosphere model, UTC, and almanac element counter |
| correctionChecksumFailures | uint32_t | Number of checksum failures from received corrections |
| timeToFirstFixMs | uint32_t | Time to first RTK fix, in milliseconds |


#### DID_GNSS2_RTK_CMP_REL

Dual GNSS RTK compassing / moving base to rover (GNSS 1 to GNSS 2) relative info. 

`gnss_rtk_rel_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning), in milliseconds |
| differentialAge | float | Age of differential corrections, in seconds |
| arRatio | float | Ambiguity resolution ratio factor for validation (unitless; higher indicates greater confidence the fixed integer ambiguity is correct) |
| baseToRoverVector | float[3] | Vector from base to rover {x,y,z} in ECEF, in meters. If compassing is enabled, this is instead the 3-vector from antenna 2 (GNSS2) to antenna 1 (GNSS1) |
| baseToRoverDistance | float | Distance from base to rover (baseline length), in meters |
| rtkHeading | float | Angle from north to baseToRoverVector in the local tangent plane, in radians |
| baseToRoverHeadingAcc | float | Accuracy (standard deviation) of baseToRoverHeading, in radians |
| status | uint32_t | GNSS status (see eGnssStatus): [0x000000xx] number of satellites used, [0x0000xx00] fix type, [0x00xx0000] status flags, NMEA input flag |


#### DID_GNSS2_SAT

GNSS 2 GNSS satellite information: sat identifiers, carrier to noise ratio, elevation and azimuth angles, pseudo range residual. 

`gnss_sat_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| numSats | uint32_t | Number of satellites in the sky (valid entries in the sat[] list below) |
| sat | gnss_sat_sv_t[50] | Per-satellite tracking information list |


#### DID_GNSS2_VEL

GNSS 2 velocity data 

`gnss_vel_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| vel | float[3] | GNSS velocity, in meters/second. In ECEF {vx,vy,vz} if status bit GNSS_STATUS_FLAGS_GNSS_NMEA_DATA (0x00008000) is NOT set; in local tangent plane with no vertical velocity {vNorth, vEast, 0} if that bit IS set. |
| sAcc | float | Speed accuracy, in meters/second |
| status | uint32_t | GNSS status (see eGnssStatus): [0x000000xx] number of satellites used, [0x0000xx00] fix type, [0x00xx0000] status flags, NMEA input flag |


#### DID_GNSS2_VERSION

GNSS 2 version info 

`gnss_version_t`

| Field | Type | Description |
|-------|------|-------------|
| swVersion | uint8_t[30] | GNSS receiver software version string |
| hwVersion | uint8_t[10] | GNSS receiver hardware version string |
| extension | gnss_extension_ver_t[6] | Additional 30-byte extension version-info strings reported by the receiver |


#### DID_GNSS_RTK_OPT

RTK options - requires little endian CPU. 

`gnss_rtk_opt_t`

| Field | Type | Description |
|-------|------|-------------|
| mode | int32_t | Positioning mode (PMODE_???: e.g. single, DGPS, kinematic, static, moving-baseline) |
| soltype | int32_t | Solution type (0 = forward, 1 = backward, 2 = combined forward/backward) |
| nf | int32_t | Number of frequencies used (1 = L1, 2 = L1+L2, 3 = L1+L2+L5) |
| navsys | int32_t | Navigation systems bitmask (GPS/GLONASS/Galileo/BeiDou/QZSS/SBAS, SYS_??? bits) |
| elmin | float | Elevation mask angle, satellites below this are excluded (rad) |
| snrmin | int32_t | Minimum SNR/Cno for a satellite to be considered for RTK (0.25 dB-Hz units, see obsd_t.SNR) |
| snrrange | int32_t | SNR range from the highest-SNR satellite to consider (overrides snrmin if non-zero) |
| modear | int32_t | Integer ambiguity resolution (AR) mode (0 = off, 1 = continuous, 2 = instantaneous, 3 = fix-and-hold, 4 = PPP-AR) |
| glomodear | int32_t | GLONASS ambiguity resolution mode (0 = off, 1 = on, 2 = auto-calibrate inter-frequency bias, 3 = external calibration) |
| sbsmodear | int32_t | SBAS ambiguity resolution mode (0 = off, 1 = on) |
| bdsmodear | int32_t | BeiDou ambiguity resolution mode (0 = off, 1 = on) |
| arfilter | int32_t | Ambiguity-resolution filtering to reject bad satellites (0 = off, 1 = on) |
| maxout | int32_t | Consecutive observation outage count before resetting a satellite's carrier-phase bias |
| maxrej | int32_t | Consecutive rejection count before resetting a satellite's carrier-phase bias |
| minlock | int32_t | Minimum lock (continuous-tracking) count required before fixing an ambiguity |
| minfixsats | int32_t | Minimum number of satellites required to fix integer ambiguities |
| minholdsats | int32_t | Minimum number of satellites required to hold fixed integer ambiguities |
| mindropsats | int32_t | Minimum number of satellites below which satellites are dropped during ambiguity resolution |
| rcvstds | int32_t | Use receiver-reported stdev estimates to scale measurement variances (0 = off, 1 = on) |
| minfix | int32_t | Minimum consecutive fix count required before holding an ambiguity |
| armaxiter | int32_t | Maximum number of iterations used to resolve integer ambiguities |
| dynamics | int32_t | Dynamics model used by the filter (0 = none, 1 = velocity, 2 = acceleration) |
| intpref | int32_t | Interpolate reference (base) observations, used for post-mission processing (0 = off, 1 = on) |
| rovpos | int32_t | Rover position mode for fixed-position solutions |
| refpos | int32_t | Base station position mode for relative-positioning solutions |
| err | float[12] | Measurement error factor coefficients (indexed by error model term) |
| std | float[3] | Initial-state standard deviations: [0] carrier-phase bias, [1] ionosphere, [2] troposphere |
| prn | float[6] | Process-noise standard deviations: [0] bias, [1] iono, [2] trop, [3] horizontal accel, [4] vertical accel, [5] position |
| sclkstab | double | Satellite clock stability (sec/sec, i.e. fractional frequency error) |
| thresar | float[8] | Ambiguity-resolution validation thresholds (e.g. ratio test and related AR acceptance criteria) |
| elmaskar | float | Elevation mask for ambiguity resolution of a newly rising satellite (rad) |
| elmaskhold | float | Elevation mask below which a held ambiguity is dropped (rad) |
| thresslip | float | Cycle-slip detection threshold on the geometry-free phase combination (m) |
| thresdop | float | Cycle-slip detection threshold based on Doppler-predicted phase (m) |
| varholdamb | float | Variance assigned to fix-and-hold pseudo-measurements of ambiguity (cycle^2) |
| gainholdamb | float | Gain applied to GLONASS and SBAS satellites when adjusting held ambiguities |
| maxtdiff | float | Maximum allowed time difference between rover and base observations (sec) |
| fix_reset_base_msgs | int | Number of base messages without a fix after which satellite biases are reset |
| maxinno | float[2] | Innovation (measurement residual) rejection thresholds: [0] carrier-phase, [1] code/pseudorange (m) |
| maxnis_lo | float[2] | Lower normalized innovation squared (NIS) rejection thresholds: [0] phase, [1] code |
| maxnis_hi | float[2] | Upper normalized innovation squared (NIS) rejection thresholds: [0] phase, [1] code |
| maxgdop | double | Rejection threshold on geometric dilution of precision (GDOP) |
| baseline | float[3] | Baseline length constraint: {constrained length, sigma before fix, sigma after fix} (m) |
| max_baseline_error | float | Maximum allowed baseline length error before the solution is considered invalid (m) |
| reset_baseline_error | float | Baseline length error above which the filter is reset (m) |
| max_ubx_error | float | Maximum error with respect to the receiver's (u-blox) reported position, triggers a reset if exceeded (m) |
| ru | double[3] | Rover position for fixed-position mode {x,y,z} (ECEF, m) |
| rb | double[3] | Base station position for relative-positioning mode {x,y,z} (ECEF, m) |
| maxaveep | int32_t | Maximum number of epochs used when averaging a position |
| outsingle | int32_t | Output a single-point solution on DGPS/float/fixed/PPP outage (0 = off, 1 = on) |
| velcon | float[2] | Velocity constraint variance in compassing/moving-baseline mode: {before fix, after fix} (m^2/s^2) |
| mp_bias_lpf_alpha | float | Low-pass-filter alpha for multipath bias estimation; smaller values apply heavier filtering |
| mp_var_lpf_alpha | float | Low-pass-filter alpha for multipath variance estimation; smaller values apply heavier filtering |


### GPX

#### DID_GPX_DEV_INFO

GPX device information 

`dev_info_t`

| Field | Type | Description |
|-------|------|-------------|
| reserved | uint8_t | Reserved bits |
| buildFlags | uint8_t | Build flags: 0x1=debug mode, 0x2=dirty (see eBuildFlags) |
| hardwareType | uint8_t | Hardware Type: 1=uINS, 2=EVB, 3=IMX, 4=GPX (see eIsHardwareType) |
| hdwRunState | uint8_t | Device Run State: Bootloader, App, etc (see eHdwRunStates) |
| serialNumber | uint32_t | Serial number |
| hardwareVer | uint8_t[4] | Hardware version |
| firmwareVer | uint8_t[4] | Firmware (software) version |
| buildNumber | uint32_t | Build number |
| protocolVer | uint8_t[4] | Communications protocol version |
| repoRevision | uint32_t | Repository revision number |
| manufacturer | char[24] | Manufacturer name |
| buildType | uint8_t | Build type (0=production, 'c'=release candidate, 'b'=beta, 'a'=alpha, 'd'=developer, 's'=snapshot, '^'=dirty) |
| buildYear | uint8_t | Build date year - 2000 |
| buildMonth | uint8_t | Build date month |
| buildDay | uint8_t | Build date day |
| buildHour | uint8_t | Build time hour |
| buildMinute | uint8_t | Build time minute |
| buildSecond | uint8_t | Build time second |
| buildMillisecond | uint8_t | Build time millisecond |
| addInfo | char[24] | Additional info |


#### DID_GPX_FLASH_CFG

`nvm_flash_cfg_t`

| Field | Type | Description |
|-------|------|-------------|
| size | uint32_t | Size of group or union, which is nvm_group_x_t + padding |
| checksum | uint32_t | Checksum, excluding size and checksum.  0xFFFFFFFF is invalid. |
| key | uint32_t | Manufacturer method for restoring flash defaults |
| startupImuDtMs | uint32_t | (ms) IMU sample (system input) period set on startup. Cannot be larger than startupNavDtMs. Zero disables sensor/IMU sampling. |
| startupNavDtMs | uint32_t | (ms) Navigation filter (system output) output period set on startup.  Used to initialize sysParams.navOutputPeriodMs. |
| ser0BaudRate | uint32_t | (bps) Serial port 0 baud rate |
| ser1BaudRate | uint32_t | (bps) Serial port 1 baud rate |
| insRotation | float[3] | (rad) Rotation about the X,Y,Z axes from Sensor Frame to Intermediate Output Frame.  Order applied: Z,Y,X. |
| insOffset | float[3] | (m) X,Y,Z offset from Intermediate Output Frame to INS Output Frame. |
| gnss1AntOffset | float[3] | (m) X,Y,Z offset in Sensor Frame to GNSS 1 antenna. |
| dynamicModel | uint8_t | INS dynamic platform model (see eDynamicModel).  Options are: 0=PORTABLE, 2=STATIONARY, 3=PEDESTRIAN, 4=GROUND VEHICLE, 5=SEA, 6=AIRBORNE_1G, 7=AIRBORNE_2G, 8=AIRBORNE_4G, 9=WRIST.  Used to balance noise and performance characteristics of the system.  The dynamics selected here must be at least as fast as your system or you experience accuracy error.  This is tied to the GNSS position estimation model and intend in the future to be incorporated into the INS position model. |
| debug | uint8_t | Debug |
| gnssSatSigConst | uint16_t | Satellite system constellation used in GNSS solution (see eGnssSatSigConst). 0x0003=GPS, 0x000C=QZSS, 0x0030=Galileo, 0x00C0=Beidou, 0x0300=GLONASS, 0x1000=SBAS |
| sysCfgBits | uint32_t | System configuration bits (see eSysConfigBits). |
| refLla | double[3] | (deg, deg, m) Reference latitude, longitude and height above ellipsoid for north east down (NED) calculations |
| lastLla | double[3] | (deg, deg, m) Last latitude, longitude, HAE (height above ellipsoid) used to aid GNSS startup.  Updated when the distance between current LLA and lastLla exceeds lastLlaUpdateDistance. |
| lastLlaTimeOfWeekMs | uint32_t | (ms) Last LLA GPS time since week start (Sunday morning) |
| lastLlaWeek | uint32_t | Last LLA GPS number of weeks since January 6th, 1980 |
| lastLlaUpdateDistance | float | (m) Distance between current and last LLA that triggers an update of lastLla |
| ioConfig | uint32_t | Hardware interface configuration bits (see eIoConfig). |
| platformConfig | uint32_t | Hardware platform specifying the IMX carrier board type (i.e. RUG, EVB, IG) and configuration bits (see ePlatformConfig).  The platform type is used to simplify the GNSS and I/O configuration process.  Bit PLATFORM_CFG_UPDATE_IO_CONFIG is excluded from the flashConfig checksum and from determining whether to upload. |
| gnss2AntOffset | float[3] | (m) X,Y,Z offset in Sensor Frame origin to GNSS 2 antenna. |
| zeroVelRotation | float[3] | (rad) Euler (roll, pitch, yaw) rotation from INS Sensor Frame to Intermediate ZeroVelocity Frame.  Order applied: heading, pitch, roll. |
| zeroVelOffset | float[3] | (m) X,Y,Z offset from Intermediate ZeroVelocity Frame to Zero Velocity Frame. |
| gnssTimeUserDelay | float | (sec) User defined delay for GPS time.  This parameter can be used to account for GNSS antenna cable delay. |
| magDeclination | float | (rad) Earth magnetic field (magnetic north) declination (heading offset from true north) |
| gnssTimeSyncPeriodMs | uint32_t | (ms) Time between GPS time synchronization pulses.  Requires reboot to take effect. |
| startupGnssDtMs | uint32_t | (ms) GNSS measurement (system input) update period set on startup. 200ms minimum (5Hz max). |
| RTKCfgBits | uint32_t | RTK configuration bits (see eRTKConfigBits). |
| sensorConfig | uint32_t | Sensor config to specify the full-scale sensing ranges and output rotation for the IMU and magnetometer (see eSensorConfig) |
| gnssMinimumElevation | float | (rad) Minimum elevation of a satellite above the horizon to be used in the solution. Low elevation satellites may provide degraded accuracy, due to the long signal path through the atmosphere. |
| ser2BaudRate | uint32_t | (bps) Serial port 2 baud rate |
| wheelConfig | wheel_config_t | Wheel encoder: euler angles describing the rotation from imu to left wheel, plus track width/radius and config bits (see eWheelCfgBits) |
| magInterferenceThreshold | float | Magnetometer interference sensitivity threshold. Typical range is 2-10 (3 default) and 1000 to disable mag interference detection. |
| magCalibrationQualityThreshold | float | Magnetometer calibration quality sensitivity threshold. Typical range is 10-20 (10 default) and 1000 to disable mag calibration quality check, forcing it to be always good. |
| gnssCn0Minimum | uint8_t | (dBHz) GNSS CN0 absolute minimum threshold for signals.  Used to filter signals in RTK solution. |
| gnssCn0DynMinOffset | uint8_t | (dBHz) GNSS CN0 dynamic minimum threshold offset below max CN0 across all satellites. Used to filter signals used in RTK solution. To disable, set gnssCn0DynMinOffset to zero and increase gnssCn0Minimum. |
| imuRejectThreshGyroLow | uint8_t | IMU gyro fault rejection threshold low |
| imuRejectThreshGyroHigh | uint8_t | IMU gyro fault rejection threshold high |
| imuShockDetectLatencyMs | uint8_t | (ms) IMU shock detection latency.  Time used for EKF rewind to prevent shock from influencing EKF estimates. |
| imuShockRejectLatchMs | uint8_t | (ms) IMU shock rejection latch time.  Time required following detected shock end to disable shock rejection. |
| imuShockOptions | uint8_t | IMU shock rejection options (see eImuShockOptions) |
| imuShockDeltaAccHighThreshold | uint8_t | (m/s^2) IMU shock detection. Min acceleration difference between the 3 IMUs to detect the start of a shock. |
| imuShockDeltaAccLowThreshold | uint8_t | (m/s^2) IMU shock detection. Max acceleration difference between the 3 IMUs within the latch time to detect the end of a shock. |
| imuShockDeltaGyroHighThreshold | uint8_t | (deg/s) IMU shock detection. Min angular rate difference between the 3 IMUs to detect the start of a shock. |
| imuShockDeltaGyroLowThreshold | uint8_t | (deg/s) IMU shock detection. Max angular rate difference between the 3 IMUs within the latch time to detect the end of a shock. |
| ioConfig2 | uint8_t | Hardware interface configuration bits for GNSS2 PPS (see eIoConfig2). |


#### DID_GPX_RMC

GPX rmc  

`rmc_t`

| Field | Type | Description |
|-------|------|-------------|
| bits | uint64_t | Data stream enable bits for the specified ports (see RMC_BITS_...) |
| options | uint32_t | Options to select alternate ports to output data, persist across reboot, NMEA speed filtering, etc. (see RMC_OPTIONS_...) |


#### DID_GPX_STATUS

`gpx_status_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | (ms) GPS time of week (since Sunday morning) |
| status | uint32_t | Status (see eGpxStatus) |
| grmcBitsSer0 | uint64_t | GRMC message enable bits for serial port 0 (see GRMC_BITS_...) |
| grmcBitsSer1 | uint64_t | GRMC message enable bits for serial port 1 (see GRMC_BITS_...) |
| grmcBitsSer2 | uint64_t | GRMC message enable bits for serial port 2 (see GRMC_BITS_...) |
| grmcBitsUSB | uint64_t | GRMC message enable bits for USB (see GRMC_BITS_...) |
| grmcNMEABitsSer0 | uint64_t | NMEA message enable bits for serial port 0 (see NMEA_MSG_ID...) |
| grmcNMEABitsSer1 | uint64_t | NMEA message enable bits for serial port 1 (see NMEA_MSG_ID...) |
| grmcNMEABitsSer2 | uint64_t | NMEA message enable bits for serial port 2 (see NMEA_MSG_ID...) |
| grmcNMEABitsUSB | uint64_t | NMEA message enable bits for USB (see NMEA_MSG_ID...) |
| hdwStatus | uint32_t | Hardware status flags (see eGPXHdwStatusFlags) |
| mcuTemp | float | (C) MCU temperature (GPX_INVALID_MCU_TEMP if not available) |
| navOutputPeriodMs | uint32_t | (ms) Navigation output period |
| flashCfgChecksum | uint32_t | Flash config checksum used with host SDK synchronization |
| rtkMode | uint32_t | RTK mode bits (see eRTKConfigBits) |
| gnssStatus | gpx_gnss_status_t[2] | Per-GNSS-receiver driver status (GNSS1, GNSS2) |
| gpxSourcePort | uint8_t | Port this status message was sourced from |
| upTime | double | (s) Time since system was started |


### Raw GPS Data

Raw GPS data is contained in the `DID_GNSS1_RAW`, `DID_GNSS2_RAW`, and `DID_GNSS_BASE_RAW` messages of type `gnss_raw_t`.  The actual raw data is contained in the union member `gnss_raw_t.data` and should be interpreted based on the value of `gnss_raw_t.dataType` (i.e. as observation, ephemeris, SBAS, or base station position).

#### DID_GNSS1_RAW

GNSS raw data for rover (observation, ephemeris, etc.) - requires little endian CPU. The contents of data can vary for this message and are determined by dataType field. RTK positioning or RTK compassing must be enabled to stream this message. 

`gnss_raw_t`

| Field | Type | Description |
|-------|------|-------------|
| receiverIndex | uint8_t | Source receiver: 1=RECEIVER_INDEX_GNSS1, 2=RECEIVER_INDEX_EXTERNAL_BASE, 3=RECEIVER_INDEX_GNSS2 |
| dataType | uint8_t | Type of data in the data union (see eRawDataType): 1=observations, 2=ephemeris, 3=glonassEphemeris, 4=SBAS, 5=baseAntenna, 6=IonosphereModel |
| obsCount | uint8_t | Number of observations (obsd_t elements) present in data.obs when dataType==1 (raw_data_type_observation) |
| reserved | uint8_t | Reserved for alignment / future use |
| data | uGnssRawData | Raw data payload; interpret based on dataType (see eRawDataType) |


#### DID_GNSS2_RAW

GNSS raw data for rover (observation, ephemeris, etc.) - requires little endian CPU. The contents of data can vary for this message and are determined by dataType field. RTK positioning or RTK compassing must be enabled to stream this message. 

`gnss_raw_t`

| Field | Type | Description |
|-------|------|-------------|
| receiverIndex | uint8_t | Source receiver: 1=RECEIVER_INDEX_GNSS1, 2=RECEIVER_INDEX_EXTERNAL_BASE, 3=RECEIVER_INDEX_GNSS2 |
| dataType | uint8_t | Type of data in the data union (see eRawDataType): 1=observations, 2=ephemeris, 3=glonassEphemeris, 4=SBAS, 5=baseAntenna, 6=IonosphereModel |
| obsCount | uint8_t | Number of observations (obsd_t elements) present in data.obs when dataType==1 (raw_data_type_observation) |
| reserved | uint8_t | Reserved for alignment / future use |
| data | uGnssRawData | Raw data payload; interpret based on dataType (see eRawDataType) |


#### DID_GNSS_BASE_RAW

`gnss_raw_t`

| Field | Type | Description |
|-------|------|-------------|
| receiverIndex | uint8_t | Source receiver: 1=RECEIVER_INDEX_GNSS1, 2=RECEIVER_INDEX_EXTERNAL_BASE, 3=RECEIVER_INDEX_GNSS2 |
| dataType | uint8_t | Type of data in the data union (see eRawDataType): 1=observations, 2=ephemeris, 3=glonassEphemeris, 4=SBAS, 5=baseAntenna, 6=IonosphereModel |
| obsCount | uint8_t | Number of observations (obsd_t elements) present in data.obs when dataType==1 (raw_data_type_observation) |
| reserved | uint8_t | Reserved for alignment / future use |
| data | uGnssRawData | Raw data payload; interpret based on dataType (see eRawDataType) |


#### Raw GPS Data Buffer Union

`uGnssRawData`

| Field | Type | Description |
|-------|------|-------------|
| obs | obsd_t[] | Satellite observation data, valid when dataType == raw_data_type_observation |
| eph | eph_t | Satellite non-GLONASS ephemeris data (GPS, Galileo, Beidou, QZSS), valid when dataType == raw_data_type_ephemeris |
| gloEph | geph_t | Satellite GLONASS ephemeris data, valid when dataType == raw_data_type_glonass_ephemeris |
| sbas | sbsmsg_t | Satellite-Based Augmentation Systems (SBAS) data, valid when dataType == raw_data_type_sbas |
| sta | sta_t | Base station information (base position, antenna position, antenna height, etc.), valid when dataType == raw_data_type_base_station_antenna_position |
| ion | ion_model_utc_alm_t | Ionosphere model and UTC parameters, valid when dataType == raw_data_type_ionosphere_model_utc_alm |
| buf | uint8_t[1000] | Byte buffer providing untyped access to the same union storage |


#### GPS Galileo QZSS Ephemeris

`eph_t`

| Field | Type | Description |
|-------|------|-------------|
| sat | int32_t | Satellite number in RTKLIB notation. GPS: 1-32, GLONASS: 33-59, Galileo: 60-89, SBAS: 90-95 |
| iode | int32_t | IODE, Issue Of Data Ephemeris (ephemeris data-set version number) |
| iodc | int32_t | IODC, Issue Of Data Clock (clock data-set version number) |
| sva | int32_t | SV accuracy (URA index), see IS-GPS-200/IRN-IS-200H p.97 |
| svh | int32_t | SV health for GPS/QZS (0 = ok) |
| week | int32_t | Ephemeris reference week number: GPS week for GPS/QZS, Galileo week (GST week) for GAL |
| code | int32_t | GPS/QZS: code on L2 (00 = invalid, 01 = P-code on, 11 = C/A-code on, 11 = invalid). GAL/CMP (BeiDou): data source indicator |
| flag | int32_t | GPS/QZS: L2 P-code data flag (nonzero indicates the NAV data stream is commanded OFF on the P-code of the L2 in-phase component). CMP (BeiDou): nav message type |
| toe | gtime_t | Time Of Ephemeris: ephemeris reference epoch (GPST) |
| toc | gtime_t | Clock data reference time (GPST), see IS-GPS-200 20.3.4.5 |
| ttr | gtime_t | Transmission time of the message, T_trans (GPST) |
| A | double | Orbit semi-major axis (m) |
| e | double | Orbit eccentricity (dimensionless) |
| i0 | double | Orbit inclination angle at reference time (rad) |
| OMG0 | double | Longitude of ascending node of orbit plane at the weekly epoch (rad) |
| omg | double | Argument of perigee (rad) |
| M0 | double | Mean anomaly at reference time (rad) |
| deln | double | Mean motion difference from computed value, delta-n (rad/s) |
| OMGd | double | Rate of right ascension / longitude of ascending node, OMEGA-dot (rad/s) |
| idot | double | Rate of inclination angle, i-dot (rad/s) |
| crc | double | Amplitude of the cosine harmonic correction term to the orbit radius (m) |
| crs | double | Amplitude of the sine harmonic correction term to the orbit radius (m) |
| cuc | double | Amplitude of the cosine harmonic correction term to the argument of latitude (rad) |
| cus | double | Amplitude of the sine harmonic correction term to the argument of latitude (rad) |
| cic | double | Amplitude of the cosine harmonic correction term to the angle of inclination (rad) |
| cis | double | Amplitude of the sine harmonic correction term to the angle of inclination (rad) |
| toes | double | Time Of Ephemeris in seconds within the week (s), the double-precision counterpart of toe above. toe is computed as eph->toe = gst2time(week, eph->toes); this value is the ephemeris expiration reference and is generally ~2 hours ahead of the current time |
| fit | double | Curve-fit interval (h) (0 = 4 hours, 1 = greater than 4 hours) |
| f0 | double | SV clock bias, af0 (s) |
| f1 | double | SV clock drift, af1 (s/s, dimensionless) |
| f2 | double | SV clock drift rate, af2 (s/s^2) |
| tgd | double[4] | Group delay parameters. GPS/QZS: tgd[0] = TGD (IRN-IS-200H p.103). Galileo: tgd[0] = BGD E5a/E1, tgd[1] = BGD E5b/E1. BeiDou: tgd[0] = BGD1, tgd[1] = BGD2 |
| Adot | double | Semi-major axis rate, A-dot, for CNAV messages; not used |
| ndot | double | First derivative of mean motion n (equivalently second derivative of mean anomaly M), n-dot, for CNAV messages (rad/s^2); not used |


#### GLONASS Ephemeris

`geph_t`

| Field | Type | Description |
|-------|------|-------------|
| sat | int32_t | Satellite number in RTKLIB notation. GPS: 1-32, GLONASS: 33-59, Galileo: 60-89, SBAS: 90-95 |
| iode | int32_t | IODE, derived from bits 0-6 of the tb (time interval index) field |
| frq | int32_t | Satellite frequency channel number (GLONASS FDMA slot, -7..+13) |
| svh | int32_t | Satellite health flag |
| sva | int32_t | Satellite accuracy (URA-like indicator) |
| age | int32_t | Satellite age of operation (days) |
| toe | gtime_t | Ephemeris reference epoch within the week, GPS time system (GPST) |
| tof | gtime_t | Message frame transmission time, GPS time system (GPST) |
| pos | double[3] | Satellite position at toe (ECEF) (m) |
| vel | double[3] | Satellite velocity at toe (ECEF) (m/s) |
| acc | double[3] | Satellite (luni-solar) acceleration at toe (ECEF) (m/s^2) |
| taun | double | SV clock bias, -tau_n (s) |
| gamn | double | Relative frequency bias, gamma_n (dimensionless, s/s) |
| dtaun | double | Time delay between the L1 and L2 signal transmissions (s) |


#### SBAS

`sbsmsg_t`

| Field | Type | Description |
|-------|------|-------------|
| week | int32_t | GPS week number of message reception |
| tow | int32_t | Time of week of message reception (s) |
| prn | int32_t | SBAS satellite PRN number |
| msg | uint8_t[29] | Raw SBAS message payload (226 bits), zero-padded to 29 bytes |
| reserved | uint8_t[3] | Reserved/unused (padding for alignment) |


#### Station Parameters

`sta_t`

| Field | Type | Description |
|-------|------|-------------|
| deltype | int32_t | Antenna delta (offset) type: 0 = e/n/u (east/north/up), 1 = x/y/z (ECEF) |
| pos | double[3] | Station reference position (ECEF) (m) |
| del | double[3] | Antenna position delta from the station reference position, interpreted per deltype: e/n/u or x/y/z (m) |
| hgt | double | Antenna height above the marker/reference point (m) |
| stationId | int32_t | Station identifier (e.g. RTCM/RINEX station ID) |


#### Satellite Observation

`obs_t`

| Field | Type | Description |
|-------|------|-------------|
| n | uint32_t | Number of observation slots currently used (valid entries in data[]) |
| nmax | uint32_t | Number of observation slots allocated in data[] |
| data | obsd_t | Pointer to the observation data buffer, an array of obsd_t records |


#### Satellite information

`gnss_sat_sv_t`

| Field | Type | Description |
|-------|------|-------------|
| gnssId | uint8_t | GNSS constellation identifier (see eSatSvGnssId) |
| svId | uint8_t | Satellite identifier (PRN/slot number, meaning depends on gnssId) |
| elev | int8_t | Elevation, in degrees (range: +/-90) |
| azim | int16_t | Azimuth, in degrees (range: +/-180) |
| cno | uint8_t | Carrier to noise ratio (signal strength), in dBHz |
| status | uint16_t | Satellite status bitflags (see eSatSvStatus) |


#### Inertial Measurement Unit (IMU)

`imui_t`

| Field | Type | Description |
|-------|------|-------------|
| pqr | float[3] | Gyroscope P, Q, R (angular rate about body X, Y, Z) in radians/second |
| acc | float[3] | Acceleration X, Y, Z in meters/second^2, in body frame |


### Configuration

#### DID_FLASH_CONFIG

`nvm_flash_cfg_t`

| Field | Type | Description |
|-------|------|-------------|
| size | uint32_t | Size of group or union, which is nvm_group_x_t + padding |
| checksum | uint32_t | Checksum, excluding size and checksum.  0xFFFFFFFF is invalid. |
| key | uint32_t | Manufacturer method for restoring flash defaults |
| startupImuDtMs | uint32_t | (ms) IMU sample (system input) period set on startup. Cannot be larger than startupNavDtMs. Zero disables sensor/IMU sampling. |
| startupNavDtMs | uint32_t | (ms) Navigation filter (system output) output period set on startup.  Used to initialize sysParams.navOutputPeriodMs. |
| ser0BaudRate | uint32_t | (bps) Serial port 0 baud rate |
| ser1BaudRate | uint32_t | (bps) Serial port 1 baud rate |
| insRotation | float[3] | (rad) Rotation about the X,Y,Z axes from Sensor Frame to Intermediate Output Frame.  Order applied: Z,Y,X. |
| insOffset | float[3] | (m) X,Y,Z offset from Intermediate Output Frame to INS Output Frame. |
| gnss1AntOffset | float[3] | (m) X,Y,Z offset in Sensor Frame to GNSS 1 antenna. |
| dynamicModel | uint8_t | INS dynamic platform model (see eDynamicModel).  Options are: 0=PORTABLE, 2=STATIONARY, 3=PEDESTRIAN, 4=GROUND VEHICLE, 5=SEA, 6=AIRBORNE_1G, 7=AIRBORNE_2G, 8=AIRBORNE_4G, 9=WRIST.  Used to balance noise and performance characteristics of the system.  The dynamics selected here must be at least as fast as your system or you experience accuracy error.  This is tied to the GNSS position estimation model and intend in the future to be incorporated into the INS position model. |
| debug | uint8_t | Debug |
| gnssSatSigConst | uint16_t | Satellite system constellation used in GNSS solution (see eGnssSatSigConst). 0x0003=GPS, 0x000C=QZSS, 0x0030=Galileo, 0x00C0=Beidou, 0x0300=GLONASS, 0x1000=SBAS |
| sysCfgBits | uint32_t | System configuration bits (see eSysConfigBits). |
| refLla | double[3] | (deg, deg, m) Reference latitude, longitude and height above ellipsoid for north east down (NED) calculations |
| lastLla | double[3] | (deg, deg, m) Last latitude, longitude, HAE (height above ellipsoid) used to aid GNSS startup.  Updated when the distance between current LLA and lastLla exceeds lastLlaUpdateDistance. |
| lastLlaTimeOfWeekMs | uint32_t | (ms) Last LLA GPS time since week start (Sunday morning) |
| lastLlaWeek | uint32_t | Last LLA GPS number of weeks since January 6th, 1980 |
| lastLlaUpdateDistance | float | (m) Distance between current and last LLA that triggers an update of lastLla |
| ioConfig | uint32_t | Hardware interface configuration bits (see eIoConfig). |
| platformConfig | uint32_t | Hardware platform specifying the IMX carrier board type (i.e. RUG, EVB, IG) and configuration bits (see ePlatformConfig).  The platform type is used to simplify the GNSS and I/O configuration process.  Bit PLATFORM_CFG_UPDATE_IO_CONFIG is excluded from the flashConfig checksum and from determining whether to upload. |
| gnss2AntOffset | float[3] | (m) X,Y,Z offset in Sensor Frame origin to GNSS 2 antenna. |
| zeroVelRotation | float[3] | (rad) Euler (roll, pitch, yaw) rotation from INS Sensor Frame to Intermediate ZeroVelocity Frame.  Order applied: heading, pitch, roll. |
| zeroVelOffset | float[3] | (m) X,Y,Z offset from Intermediate ZeroVelocity Frame to Zero Velocity Frame. |
| gnssTimeUserDelay | float | (sec) User defined delay for GPS time.  This parameter can be used to account for GNSS antenna cable delay. |
| magDeclination | float | (rad) Earth magnetic field (magnetic north) declination (heading offset from true north) |
| gnssTimeSyncPeriodMs | uint32_t | (ms) Time between GPS time synchronization pulses.  Requires reboot to take effect. |
| startupGnssDtMs | uint32_t | (ms) GNSS measurement (system input) update period set on startup. 200ms minimum (5Hz max). |
| RTKCfgBits | uint32_t | RTK configuration bits (see eRTKConfigBits). |
| sensorConfig | uint32_t | Sensor config to specify the full-scale sensing ranges and output rotation for the IMU and magnetometer (see eSensorConfig) |
| gnssMinimumElevation | float | (rad) Minimum elevation of a satellite above the horizon to be used in the solution. Low elevation satellites may provide degraded accuracy, due to the long signal path through the atmosphere. |
| ser2BaudRate | uint32_t | (bps) Serial port 2 baud rate |
| wheelConfig | wheel_config_t | Wheel encoder: euler angles describing the rotation from imu to left wheel, plus track width/radius and config bits (see eWheelCfgBits) |
| magInterferenceThreshold | float | Magnetometer interference sensitivity threshold. Typical range is 2-10 (3 default) and 1000 to disable mag interference detection. |
| magCalibrationQualityThreshold | float | Magnetometer calibration quality sensitivity threshold. Typical range is 10-20 (10 default) and 1000 to disable mag calibration quality check, forcing it to be always good. |
| gnssCn0Minimum | uint8_t | (dBHz) GNSS CN0 absolute minimum threshold for signals.  Used to filter signals in RTK solution. |
| gnssCn0DynMinOffset | uint8_t | (dBHz) GNSS CN0 dynamic minimum threshold offset below max CN0 across all satellites. Used to filter signals used in RTK solution. To disable, set gnssCn0DynMinOffset to zero and increase gnssCn0Minimum. |
| imuRejectThreshGyroLow | uint8_t | IMU gyro fault rejection threshold low |
| imuRejectThreshGyroHigh | uint8_t | IMU gyro fault rejection threshold high |
| imuShockDetectLatencyMs | uint8_t | (ms) IMU shock detection latency.  Time used for EKF rewind to prevent shock from influencing EKF estimates. |
| imuShockRejectLatchMs | uint8_t | (ms) IMU shock rejection latch time.  Time required following detected shock end to disable shock rejection. |
| imuShockOptions | uint8_t | IMU shock rejection options (see eImuShockOptions) |
| imuShockDeltaAccHighThreshold | uint8_t | (m/s^2) IMU shock detection. Min acceleration difference between the 3 IMUs to detect the start of a shock. |
| imuShockDeltaAccLowThreshold | uint8_t | (m/s^2) IMU shock detection. Max acceleration difference between the 3 IMUs within the latch time to detect the end of a shock. |
| imuShockDeltaGyroHighThreshold | uint8_t | (deg/s) IMU shock detection. Min angular rate difference between the 3 IMUs to detect the start of a shock. |
| imuShockDeltaGyroLowThreshold | uint8_t | (deg/s) IMU shock detection. Max angular rate difference between the 3 IMUs within the latch time to detect the end of a shock. |
| ioConfig2 | uint8_t | Hardware interface configuration bits for GNSS2 PPS (see eIoConfig2). |


#### DID_NMEA_BCAST_PERIOD

`nmea_msgs_t`

| Field | Type | Description |
|-------|------|-------------|
| options | uint32_t | Options: Port selection[0x0=current, 0x1=ser0, 0x2=ser1, 0x4=ser2, 0x8=USB, 0x100=preserve, 0x200=Persistent] (see RMC_OPTIONS_...) |
| nmeaBroadcastMsgs | nmeaBroadcastMsgPair_t[20] | NMEA message to be set.  Up to 20 message ID/period pairs.  Message ID of zero indicates the remaining pairs are not used. (see eNmeaMsgId) |


#### DID_RMC

`rmc_t`

| Field | Type | Description |
|-------|------|-------------|
| bits | uint64_t | Data stream enable bits for the specified ports (see RMC_BITS_...) |
| options | uint32_t | Options to select alternate ports to output data, persist across reboot, NMEA speed filtering, etc. (see RMC_OPTIONS_...) |


### Command

#### DID_SYS_CMD

is the bitwise inverse of command and must be sent in the same write for the command to be processed. 

`system_command_t`

| Field | Type | Description |
|-------|------|-------------|
| command | uint32_t | System command (see eSystemCommand) 1=save current persistent messages, 5=zero motion, 97=save flash, 99=software reset.  "invCommand" (following variable) must be set to bitwise inverse of this value for this command to be processed. |
| invCommand | uint32_t | Error checking field that must be set to bitwise inverse of command field for the command to take effect. |


### EVB-2

#### DID_EVB_FLASH_CFG

EVB configuration. 

`evb_flash_cfg_t`

| Field | Type | Description |
|-------|------|-------------|
| size | uint32_t | Size of this struct |
| checksum | uint32_t | Checksum, excluding size and checksum |
| key | uint32_t | Manufacturer method for restoring flash defaults |
| cbPreset | uint8_t | Communications bridge preset (see eEvb2ComBridgePreset) |
| reserved1 | uint8_t[3] | Reserved for 32-bit alignment |
| cbf | uint32_t[EVB2_PORT_COUNT] | Communications bridge forwarding, indexed by eEvb2CommPorts |
| cbOptions | uint32_t | Communications bridge options (see eEvb2ComBridgeOptions) |
| bits | uint32_t | Config bits (see eEvbFlashCfgBits) |
| radioPID | uint32_t | Radio preamble ID (PID), 0x0 to 0x9. Only radios with matching PIDs can communicate together. Different PIDs minimize interference between multiple sets of networks. Checked before the network ID. |
| radioNID | uint32_t | Radio network ID (NID), 0x0 to 0x7FFF. Only radios with matching NID can communicate together. Checked after the preamble ID. |
| radioPowerLevel | uint32_t | Radio transmitter output power level (XBee PRO SX 0=20dBm, 1=27dBm, 2=30dBm) |
| wifi | evb_wifi_t[3] | WiFi SSID and PSK presets |
| server | evb_server_t[3] | Server IP and port presets |
| encoderTickToWheelRad | float | (rad) Encoder tick to wheel rotation conversion factor. Encoder tick count per revolution on 1 channel x gear ratio x 2pi. |
| CANbaud_kbps | uint32_t | (kbps) CAN baudrate |
| can_receive_address | uint32_t | CAN receive address |
| uinsComPort | uint8_t | EVB port for uINS communications and SD card logging. 0=uINS-Ser0 (default), 1=uINS-Ser1, SP330=5, 6=GPIO_H8 (use eEvb2CommPorts) |
| uinsAuxPort | uint8_t | EVB port for uINS aux com and RTK corrections. 0=uINS-Ser0, 1=uINS-Ser1 (default), 5=SP330, 6=GPIO_H8 (use eEvb2CommPorts) |
| reserved2 | uint8_t[2] | Reserved to ensure 32-bit alignment |
| portOptions | uint32_t | Enable radio RTK filtering, etc. (see eEvb2PortOptions) |
| h3sp330BaudRate | uint32_t | (bps) Baud rate for EVB serial port H3 (SP330 RS233 and RS485/422) |
| h4xRadioBaudRate | uint32_t | (bps) Baud rate for EVB serial port H4 (TTL to external radio) |
| h8gpioBaudRate | uint32_t | (bps) Baud rate for EVB serial port H8 (TTL) |
| wheelCfgBits | uint32_t | Wheel encoder configuration (see eWheelCfgBits) |
| velocityControlPeriodMs | uint32_t | (ms) Wheel update period. Sets the wheel encoder and control update period. |


#### DID_EVB_STATUS

`evb_status_t`

| Field | Type | Description |
|-------|------|-------------|
| week | uint32_t | GPS number of weeks since January 6th, 1980 |
| timeOfWeekMs | uint32_t | (ms) GPS time of week (since Sunday morning) |
| firmwareVer | uint8_t[4] | Firmware (software) version |
| evbStatus | uint32_t | Status (see eEvbStatus) |
| loggerMode | uint32_t | Data logger control state (see eEvb2LoggerMode) |
| loggerElapsedTimeMs | uint32_t | (ms) Elapsed time of the current data log |
| wifiIpAddr | uint32_t | WiFi IP address |
| sysCommand | uint32_t | System command (see eSystemCommand). 99 = software reset |
| towOffset | double | (s) Time sync offset between local time since boot up to GPS time of week. Add this to IMU and sensor time to get GPS time of week in seconds. |


### General

#### DID_BIT

`bit_t`

| Field | Type | Description |
|-------|------|-------------|
| command | uint8_t | BIT input command (see eBitCommand).  Ignored when zero. |
| lastCommand | uint8_t | BIT last input command (see eBitCommand) |
| state | uint8_t | BIT current state (see eBitState) |
| reserved | uint8_t | Unused |
| hdwBitStatus | uint32_t | Hardware BIT status (see eHdwBitStatusFlags) |
| calBitStatus | uint32_t | Calibration BIT status (see eCalBitStatusFlags) |
| tcPqrBias | float | (rad/s) Gyro bias residual from temperature calibration |
| tcAccBias | float | (m/s^2) Accelerometer bias residual from temperature calibration |
| tcPqrSlope | float | (rad/s per deg C) Gyro temperature-compensation slope error |
| tcAccSlope | float | (m/s^2 per deg C) Accelerometer temperature-compensation slope error |
| tcPqrLinearity | float | (rad/s) Gyro temperature-compensation curve-fit linearity error |
| tcAccLinearity | float | (m/s^2) Accelerometer temperature-compensation curve-fit linearity error |
| pqr | float | (rad/s) Gyro angular rate error measured during BIT |
| acc | float | (m/s^2) Accelerometer error measured during BIT |
| pqrSigma | float | (rad/s) Standard deviation of the gyro angular rate error, over the BIT sample window |
| accSigma | float | (m/s^2) Standard deviation of the accelerometer error, over the BIT sample window |
| testMode | uint8_t | Self-test/fault-simulation mode (see eBitTestMode) |
| testVar | uint8_t | Self-test mode bi-directional variable used with testMode |
| detectedHardwareId | uint16_t | Detected hardware type (see "Product Hardware ID"), used to ensure correct firmware is used |


#### DID_CANFD_CONFIG

CAN FD configuration: FD message broadcast rates, transmit addresses, and baud rate. Shares the same data structure as DID_CAN_CONFIG. 

`can_config_t`

| Field | Type | Description |
|-------|------|-------------|
| can_period_mult | uint16_t[] | Broadcast period multiple for each CAN message. 0 disables the message. Indices 0..NUM_CIDS-1 correspond to classic can_cid_t values. In CAN-FD mode the same array is reused: indices 0..NUM_FDCIDS-1 correspond to canfd_cid_t values (FDCID_INS_1=0, FDCID_INS_2=1, …). NUM_FDCIDS < NUM_CIDS so there is no overlap. |
| can_transmit_address | uint32_t[] | Transmit address for each CAN message. Indices 0..NUM_CIDS-1 correspond to classic can_cid_t values. In CAN-FD mode indices 0..NUM_FDCIDS-1 correspond to canfd_cid_t values and are validated / defaulted by CAN_init() when FD is enabled. |
| can_setting | uint16_t | Baud rate (kbps) (See can_baudrate_t for valid baud rates). Bit 15 (CAN_BAUDRATE_KBPS_FD_ENABLE) enables CAN-FD on capable hardware. |
| can_receive_address | uint32_t | Receive address |


#### DID_CAN_CONFIG

Addresses for CAN messages

`can_config_t`

| Field | Type | Description |
|-------|------|-------------|
| can_period_mult | uint16_t[] | Broadcast period multiple for each CAN message. 0 disables the message. Indices 0..NUM_CIDS-1 correspond to classic can_cid_t values. In CAN-FD mode the same array is reused: indices 0..NUM_FDCIDS-1 correspond to canfd_cid_t values (FDCID_INS_1=0, FDCID_INS_2=1, …). NUM_FDCIDS < NUM_CIDS so there is no overlap. |
| can_transmit_address | uint32_t[] | Transmit address for each CAN message. Indices 0..NUM_CIDS-1 correspond to classic can_cid_t values. In CAN-FD mode indices 0..NUM_FDCIDS-1 correspond to canfd_cid_t values and are validated / defaulted by CAN_init() when FD is enabled. |
| can_setting | uint16_t | Baud rate (kbps) (See can_baudrate_t for valid baud rates). Bit 15 (CAN_BAUDRATE_KBPS_FD_ENABLE) enables CAN-FD on capable hardware. |
| can_receive_address | uint32_t | Receive address |


#### DID_DEV_INFO

`dev_info_t`

| Field | Type | Description |
|-------|------|-------------|
| reserved | uint8_t | Reserved bits |
| buildFlags | uint8_t | Build flags: 0x1=debug mode, 0x2=dirty (see eBuildFlags) |
| hardwareType | uint8_t | Hardware Type: 1=uINS, 2=EVB, 3=IMX, 4=GPX (see eIsHardwareType) |
| hdwRunState | uint8_t | Device Run State: Bootloader, App, etc (see eHdwRunStates) |
| serialNumber | uint32_t | Serial number |
| hardwareVer | uint8_t[4] | Hardware version |
| firmwareVer | uint8_t[4] | Firmware (software) version |
| buildNumber | uint32_t | Build number |
| protocolVer | uint8_t[4] | Communications protocol version |
| repoRevision | uint32_t | Repository revision number |
| manufacturer | char[24] | Manufacturer name |
| buildType | uint8_t | Build type (0=production, 'c'=release candidate, 'b'=beta, 'a'=alpha, 'd'=developer, 's'=snapshot, '^'=dirty) |
| buildYear | uint8_t | Build date year - 2000 |
| buildMonth | uint8_t | Build date month |
| buildDay | uint8_t | Build date day |
| buildHour | uint8_t | Build time hour |
| buildMinute | uint8_t | Build time minute |
| buildSecond | uint8_t | Build time second |
| buildMillisecond | uint8_t | Build time millisecond |
| addInfo | char[24] | Additional info |


#### DID_DIAGNOSTIC_MESSAGE

Diagnostic message 

`diag_msg_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning), in milliseconds |
| messageLength | uint32_t | Message length, including null terminator, in bytes |
| message | char[256] | Message data (null-terminated string); max size of message is 256 bytes |


#### DID_EVB_DEBUG_ARRAY



`debug_array_t`

| Field | Type | Description |
|-------|------|-------------|
| i | int32_t[9] | Debug integer values, meaning defined by current firmware debug build |
| f | float[9] | Debug float values, meaning defined by current firmware debug build |
| lf | double[3] | Debug double (long float) values, meaning defined by current firmware debug build |


#### DID_EVB_DEV_INFO

EVB device information 

`dev_info_t`

| Field | Type | Description |
|-------|------|-------------|
| reserved | uint8_t | Reserved bits |
| buildFlags | uint8_t | Build flags: 0x1=debug mode, 0x2=dirty (see eBuildFlags) |
| hardwareType | uint8_t | Hardware Type: 1=uINS, 2=EVB, 3=IMX, 4=GPX (see eIsHardwareType) |
| hdwRunState | uint8_t | Device Run State: Bootloader, App, etc (see eHdwRunStates) |
| serialNumber | uint32_t | Serial number |
| hardwareVer | uint8_t[4] | Hardware version |
| firmwareVer | uint8_t[4] | Firmware (software) version |
| buildNumber | uint32_t | Build number |
| protocolVer | uint8_t[4] | Communications protocol version |
| repoRevision | uint32_t | Repository revision number |
| manufacturer | char[24] | Manufacturer name |
| buildType | uint8_t | Build type (0=production, 'c'=release candidate, 'b'=beta, 'a'=alpha, 'd'=developer, 's'=snapshot, '^'=dirty) |
| buildYear | uint8_t | Build date year - 2000 |
| buildMonth | uint8_t | Build date month |
| buildDay | uint8_t | Build date day |
| buildHour | uint8_t | Build time hour |
| buildMinute | uint8_t | Build time minute |
| buildSecond | uint8_t | Build time second |
| buildMillisecond | uint8_t | Build time millisecond |
| addInfo | char[24] | Additional info |


#### DID_EVB_RTOS_INFO

sizes the task[] array and is not itself a task ID. 

`evb_rtos_info_t`

| Field | Type | Description |
|-------|------|-------------|
| freeHeapSize | uint32_t | Heap high water mark, in free bytes remaining (lowest historical value) |
| mallocSize | uint32_t | Total memory allocated using RTOS pvPortMalloc(), in bytes |
| freeSize | uint32_t | Total memory freed using RTOS vPortFree(), in bytes |
| task | rtos_task_t[] | Per-task status/profiling info, indexed by eEvbRtosTask |


#### DID_EVENT

`did_event_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time (uptime in seconds) |
| senderSN | uint32_t | Serial number of the device that generated this event |
| senderHdwId | uint16_t | Hardware type of the sender: 0=Host, 1=uINS, 2=EVB, 3=IMX, 4=GPX (see "Product Hardware ID") |
| priority | int8_t | Event priority/severity (see eEventPriority) |
| res8 | uint8_t | Reserved for byte alignment |
| msgTypeID | uint16_t | Type/format of the payload in data[] (see eEventMsgTypeID) |
| length | uint16_t | Number of valid payload bytes in data[] |
| data | uint8_t[1] | Variable-length payload, length bytes; interpretation depends on msgTypeID |


#### DID_EVENT_HEADER_SIZE

`did_event_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time (uptime in seconds) |
| senderSN | uint32_t | Serial number of the device that generated this event |
| senderHdwId | uint16_t | Hardware type of the sender: 0=Host, 1=uINS, 2=EVB, 3=IMX, 4=GPX (see "Product Hardware ID") |
| priority | int8_t | Event priority/severity (see eEventPriority) |
| res8 | uint8_t | Reserved for byte alignment |
| msgTypeID | uint16_t | Type/format of the payload in data[] (see eEventMsgTypeID) |
| length | uint16_t | Number of valid payload bytes in data[] |
| data | uint8_t[1] | Variable-length payload, length bytes; interpretation depends on msgTypeID |


#### DID_GNSS1_SIG

`gnss_sig_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| numSigs | uint32_t | Number of satellite signals in the following satellite signal list (valid entries in sig[] below) |
| sig | gnss_sig_sv_t[100] | Per-signal tracking information list |


#### DID_GNSS1_TIMEPULSE

GNSS1 PPS time synchronization. 

`gnss_timepulse_t`

| Field | Type | Description |
|-------|------|-------------|
| towOffset | double | Week seconds offset from MCU to GPS time, in seconds |
| towGps | double | Week seconds for next timepulse (from start of GPS week), in seconds |
| timeMcu | double | Local MCU week seconds, in seconds |
| msgTimeMs | uint32_t | Local timestamp of TIM-TP message used to validate timepulse, in milliseconds |
| plsTimeMs | uint32_t | Local timestamp of time sync pulse external interrupt used to validate timepulse, in milliseconds |
| syncCount | uint8_t | Counter for successful timesync events |
| badPulseAgeCount | uint8_t | Counter for failed timesync events |
| ppsInterruptReinitCount | uint8_t | Counter for GNSS PPS interrupt re-initialization |
| plsCount | uint8_t | Counter of GNSS PPS via GPIO, not interrupt |
| lastSyncTimeMs | uint32_t | Local timestamp of last valid PPS sync, in milliseconds |
| sinceLastSyncTimeMs | uint32_t | Time since last valid PPS sync, in milliseconds |


#### DID_GNSS2_SIG

GNSS 2 signal information. 

`gnss_sig_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| numSigs | uint32_t | Number of satellite signals in the following satellite signal list (valid entries in sig[] below) |
| sig | gnss_sig_sv_t[100] | Per-signal tracking information list |


#### DID_GNSS2_TIMEPULSE

GNSS2 PPS time synchronization. 

`gnss_timepulse_t`

| Field | Type | Description |
|-------|------|-------------|
| towOffset | double | Week seconds offset from MCU to GPS time, in seconds |
| towGps | double | Week seconds for next timepulse (from start of GPS week), in seconds |
| timeMcu | double | Local MCU week seconds, in seconds |
| msgTimeMs | uint32_t | Local timestamp of TIM-TP message used to validate timepulse, in milliseconds |
| plsTimeMs | uint32_t | Local timestamp of time sync pulse external interrupt used to validate timepulse, in milliseconds |
| syncCount | uint8_t | Counter for successful timesync events |
| badPulseAgeCount | uint8_t | Counter for failed timesync events |
| ppsInterruptReinitCount | uint8_t | Counter for GNSS PPS interrupt re-initialization |
| plsCount | uint8_t | Counter of GNSS PPS via GPIO, not interrupt |
| lastSyncTimeMs | uint32_t | Local timestamp of last valid PPS sync, in milliseconds |
| sinceLastSyncTimeMs | uint32_t | Time since last valid PPS sync, in milliseconds |


#### DID_GPX_BIT

`gpx_bit_t`

| Field | Type | Description |
|-------|------|-------------|
| results | uint32_t | GPX built-in test status (see eGPXBit_results) |
| command | uint8_t | Command (see eGPXBit_CMD) |
| port | uint8_t | Port used with the test |
| testMode | uint8_t | Self-test mode (see eGPXBit_test_mode) |
| state | uint8_t | Built-in self-test state (see eGPXBit_state) |
| detectedHardwareId | uint16_t | The hardware ID detected (see "Product Hardware ID").  This is used to ensure correct firmware is used. |
| reserved | uint8_t[2] | Unused |


#### DID_GPX_DEBUG_ARRAY

`debug_array_t`

| Field | Type | Description |
|-------|------|-------------|
| i | int32_t[9] | Debug integer values, meaning defined by current firmware debug build |
| f | float[9] | Debug float values, meaning defined by current firmware debug build |
| lf | double[3] | Debug double (long float) values, meaning defined by current firmware debug build |


#### DID_GPX_PORT_MONITOR

Data rate and status monitoring for each communications port. 

`port_monitor_t`

| Field | Type | Description |
|-------|------|-------------|
| port | port_stats_t[6] | Per-port data rate and status statistics, one entry per communications port (see port_stats_t) |
| activePorts | uint8_t | Number of ports in the port[] array. FIXME: This should be moved to BEFORE the port definition, so on the receiving end, we know how many ports to expect. |


#### DID_GPX_RTOS_INFO

`gpx_rtos_info_t`

| Field | Type | Description |
|-------|------|-------------|
| freeHeapSize | uint32_t | Heap high water mark, in free bytes remaining (lowest historical value) |
| mallocSize | uint32_t | Total memory allocated using RTOS pvPortMalloc(), in bytes |
| freeSize | uint32_t | Total memory freed using RTOS vPortFree(), in bytes |
| task | rtos_task_t[] | Per-task status/profiling info, indexed by eGpxRtosTask |


#### DID_GPX_SYS_FAULT

System fault information. This is broadcast automatically every 10s if a critical fault is detected. 

`system_fault_t`

| Field | Type | Description |
|-------|------|-------------|
| upTime | uint32_t | Time of fault, uptime in milliseconds |
| status | uint32_t | System fault status (see eSysFaultStatus) |
| fileNum | uint32_t | File number (source file identifier) where the fault occurred |
| lineNum | uint32_t | Line number within the file where the fault occurred |
| haltReason | uint32_t | Zephyr halt reason code |
| lr | uint32_t | Link register value at time of fault |
| pc | uint32_t | Program Counter value at time of fault |
| psr | uint32_t | Program Status Register value at time of fault |
| taskALastFeed | uint32_t | Milliseconds since task A last ran |
| taskBLastFeed | uint32_t | Milliseconds since task B last ran |
| wdtLastFeed | uint32_t | Milliseconds since the watchdog timer was last fed |
| var0 | uint32_t | Multi-purpose register 0, fault-specific diagnostic value |
| var1 | uint32_t | Multi-purpose register 1, fault-specific diagnostic value |
| var2 | uint32_t | Multi-purpose register 2, fault-specific diagnostic value |
| var3 | uint32_t | Multi-purpose register 3, fault-specific diagnostic value |


#### DID_GROUND_VEHICLE

`ground_vehicle_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | (ms) GPS time of week (since Sunday morning) |
| status | uint32_t | Ground vehicle status flags (see eGroundVehicleStatus) |
| mode | uint32_t | Current mode of the ground vehicle.  Use this field to apply commands. (see eGroundVehicleMode) |
| wheelConfig | wheel_config_t | Wheel transform, track width, and wheel radius |


#### DID_IMUS_UNCAL

`imus_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds. Convert to GPS time of week by adding gps.towOffset |
| status | uint32_t | IMUs status flags (eImusStatus) |
| I | imui_t[1] | Per-device Inertial Measurement Unit (IMU) samples: angular rate and acceleration |


#### DID_IMU_MAG

`imu_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds. Convert to GPS time of week by adding gps.towOffset |
| status | uint32_t | IMU status flags (eImuStatus) |
| I | imui_t | Combined Inertial Measurement Unit (IMU) sample: angular rate and acceleration |


#### DID_INFIELD_CAL

`infield_cal_t`

| Field | Type | Description |
|-------|------|-------------|
| state | uint32_t | Used to set and monitor the state of the infield calibration system. (see eInfieldCalState) |
| status | uint32_t | Infield calibration status. (see eInfieldCalStatus) |
| sampleTimeMs | uint32_t | (ms) Number of samples used in IMU average. sampleTimeMs = 0 means "imu" member contains the IMU bias from flash. |
| imu | imui_t[1] | Dual purpose variable.  1.) This is the averaged IMU sample when sampleTimeMs != 0.  2.) This is a mirror of the motion calibration IMU bias from flash when sampleTimeMs = 0. |
| calData | infield_cal_vaxis_t[3] | Collected data used to solve for the bias error and INS rotation.  Vertical axis: 0 = X, 1 = Y, 2 = Z |


#### DID_INL2_MAG_OBS_INFO

INL2 magnetometer calibration information. 

`inl2_mag_obs_info_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | (ms) GPS time of week |
| Ncal_samples | uint32_t | Number of calibration samples collected |
| ready | uint32_t | Data ready to be processed |
| calibrated | uint32_t | Calibration data present.  Set to -1 to force mag recalibration. |
| auto_recal | uint32_t | Allow mag to auto-recalibrate |
| outlier | uint32_t | Bad sample data detected/rejected |
| magHdg | float | (rad) Heading from magnetometer |
| insHdg | float | (rad) Heading from INS |
| magInsHdgDelta | float | (rad) Difference between mag heading and (INS heading plus mag declination) |
| nis | float | Normalized innovation squared (likelihood metric) of the current mag heading update |
| nis_threshold | float | Threshold for maximum NIS, above which the mag update is rejected as an outlier |
| Wcal | float[9] | Magnetometer calibration matrix (row-major 3x3). Must be initialized with a unit matrix, not zeros! |
| activeCalSet | uint32_t | Active calibration set (0 or 1) |
| magHdgOffset | float | (rad) Offset between magnetometer heading and estimated heading |
| Tcal | float | Scaled computed variance between calibrated magnetometer samples |
| bias_cal | float[3] | (uT) Magnetometer calibration bias. Calibrated magnetometer output can be produced using: Bcal = Wcal * (Braw - bias_cal) |


#### DID_INL2_NED_SIGMA

`inl2_ned_sigma_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | unsigned | (ms) GPS time of week (since Sunday morning) |
| StdPosNed | float[3] | (m) NED position error sigma |
| StdVelNed | float[3] | (m/s) NED velocity error sigma |
| StdAttNed | float[3] | (rad) NED attitude error sigma |
| StdAccBias | float[3] | (m/s^2) Acceleration bias error sigma |
| StdGyrBias | float[3] | (rad/s) Angular rate bias error sigma |
| StdBarBias | float | (m) Barometric altitude bias error sigma |
| StdMagDeclination | float | (rad) Mag declination error sigma |


#### DID_INL2_STATES

`inl2_states_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeek | double | GPS time of week (since Sunday morning), in seconds |
| qe2b | float[4] | Quaternion body rotation with respect to ECEF: W, X, Y, Z |
| ve | float[3] | Velocity in ECEF frame, in meters/second |
| ecef | double[3] | Position in ECEF frame, in meters |
| biasPqr | float[3] | Gyro bias estimate, in radians/second |
| biasAcc | float[3] | Accelerometer bias estimate, in meters/second^2 |
| biasBaro | float | Barometer bias estimate (altitude), in meters |
| magDec | float | Magnetic declination estimate, in radians |
| magInc | float | Magnetic inclination estimate, in radians |


#### DID_INL2_STATUS



`inl2_status_t`

| Field | Type | Description |
|-------|------|-------------|
| ahrs | int | Non-zero while the filter is running in AHRS-only mode (prior to full INS/GNSS navigation) |
| zero_accel | int | Non-zero when zero-acceleration condition is detected |
| zero_angrate | int | Non-zero when zero-angular-rate condition is detected |
| accel_motion | int | Non-zero when accelerometer-sensed motion is detected |
| rot_motion | int | Non-zero when rotational motion is detected |
| zero_vel | int | Non-zero when zero-velocity condition is detected |
| ahrs_gnss_cnt | int | Counter of sequential valid GNSS data (for switching from AHRS to navigation) |
| hdg_err | float | Estimated heading error, in radians |
| hdg_coarse | int | Flag whether a coarse (uncertain) initial heading has been established |
| hdg_aligned | int | Flag whether initial attitude error has converged (heading alignment complete) |
| hdg_aligning | int | Flag whether heading alignment is currently in progress |
| ekf_init_done | int | Hot EKF initialization completed |
| mag_cal_good | int | Flag whether the magnetometer calibration is good |
| mag_cal_done | int | Flag whether the magnetometer calibration process has completed |
| stat_magfield | int | Flag whether the magnetic field is stationary/consistent (suitable for mag calibration) |


#### DID_MANUFACTURING_INFO

`manufacturing_info_t`

| Field | Type | Description |
|-------|------|-------------|
| serialNumber | uint32_t | Inertial Sense serial number |
| hardwareId | uint16_t | Hardware ID: packed identifier, encoding the Hardware Type, hardwareVer Major, and hardwareVer Minor (see ENCODE_HDW_ID/DECODE_HDW_TYPE macros) |
| lotNumber | uint16_t | Inertial Sense lot number |
| date | char[16] | Inertial Sense manufacturing date (YYYYMMDDHHMMSS) |
| key | uint32_t | Key - write: unlock manufacturing info, read: number of times OTP has been set, 15 max |
| platformType | int32_t | Platform / carrier board (ePlatformConfig::PLATFORM_CFG_TYPE_MASK). Only valid if greater than zero. |
| reserved | int32_t | Reserved |
| uid | uint32_t[4] | Microcontroller unique identifier, 128 bits for SAM / 96 for STM32 |


#### DID_PIMU_MAG

`pimu_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds. Convert to GPS time of week by adding gps.towOffset |
| dt | float | Integration period in seconds for delta theta and delta velocity. Configured using DID_FLASH_CONFIG.startupNavDtMs |
| status | uint32_t | IMU status flags (eImuStatus) |
| theta | float[3] | IMU delta theta: gyroscope {p,q,r} integral over dt, in radians, in sensor/body frame |
| vel | float[3] | IMU delta velocity: accelerometer {x,y,z} integral over dt, in meters/second, in sensor/body frame |


#### DID_PORT_MONITOR

`port_monitor_t`

| Field | Type | Description |
|-------|------|-------------|
| port | port_stats_t[6] | Per-port data rate and status statistics, one entry per communications port (see port_stats_t) |
| activePorts | uint8_t | Number of ports in the port[] array. FIXME: This should be moved to BEFORE the port definition, so on the receiving end, we know how many ports to expect. |


#### DID_POSITION_MEASUREMENT

`pos_measurement_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeek | double | GPS time of week (since Sunday morning), s |
| ecef | double[3] | Position in ECEF (earth-centered earth-fixed) frame, m |
| psi | float | Heading with respect to NED frame, rad |
| accuracyCovUD | float[6] | Upper Diagonal of the 3x3 position accuracy covariance matrix (indices: [0 1 2 / _ 3 4 / _ _ 5]) |


#### DID_REFERENCE_IMU

Raw reference or truth IMU used for manufacturing calibration and testing. Input from testbed. 

`imu_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds. Convert to GPS time of week by adding gps.towOffset |
| status | uint32_t | IMU status flags (eImuStatus) |
| I | imui_t | Combined Inertial Measurement Unit (IMU) sample: angular rate and acceleration |


#### DID_REFERENCE_MAGNETOMETER

Reference or truth magnetometer used for manufacturing calibration and testing 

`magnetometer_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds. Convert to GPS time of week by adding gps.towOffset |
| mag | float[3] | Magnetometer X, Y, Z in microtesla (uT), in body frame |


#### DID_REFERENCE_PIMU

Reference or truth IMU used for manufacturing calibration and testing 

`pimu_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds. Convert to GPS time of week by adding gps.towOffset |
| dt | float | Integration period in seconds for delta theta and delta velocity. Configured using DID_FLASH_CONFIG.startupNavDtMs |
| status | uint32_t | IMU status flags (eImuStatus) |
| theta | float[3] | IMU delta theta: gyroscope {p,q,r} integral over dt, in radians, in sensor/body frame |
| vel | float[3] | IMU delta velocity: accelerometer {x,y,z} integral over dt, in meters/second, in sensor/body frame |


#### DID_ROS_COVARIANCE_POSE_TWIST

INL2 EKF 6x6 covariance matrices packed in arrays containing their elements on main diagonal and below 

`ros_covariance_pose_twist_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeek | double | GPS time of week (since Sunday morning), in seconds |
| covPoseLD | float[21] | Lower-diagonal pose covariance (attitude rad^2, position m^2); see index layout above |
| covTwistLD | float[21] | Lower-diagonal twist covariance (velocity (m/s)^2, angular rate (rad/s)^2); see index layout above |


#### DID_RTOS_INFO

`rtos_info_t`

| Field | Type | Description |
|-------|------|-------------|
| freeHeapSize | uint32_t | Heap high water mark, in free bytes remaining (lowest historical value) |
| mallocSize | uint32_t | Total memory allocated using RTOS pvPortMalloc(), in bytes |
| freeSize | uint32_t | Total memory freed using RTOS vPortFree(), in bytes |
| task | rtos_task_t[] | Per-task status/profiling info, indexed by eImxRtosTask |


#### DID_RUNTIME_PROFILER

System runtime profiler 

`runtime_profiler_t`

| Field | Type | Description |
|-------|------|-------------|
| p | runtime_profile_t[4] | Timing statistics for each profiled code section, RUNTIME_PROFILE_COUNT entries |


#### DID_SCOMP

`sensor_compensation_v1p4_t`

| Field | Type | Description |
|-------|------|-------------|
| timeMs | uint32_t | Time since boot up, in milliseconds |
| pqr | sensor_comp_unit_t[NUM_IMU_DEVICES_V1P4] | Per-IMU gyro temperature-compensation state |
| acc | sensor_comp_unit_t[NUM_IMU_DEVICES_V1P4] | Per-IMU accelerometer temperature-compensation state |
| mag | sensor_comp_unit_t[NUM_MAG_DEVICES_V1P4] | Per-magnetometer temperature-compensation state |
| referenceImu | imui_t | Reference/truth IMU sample used during calibration |
| referenceMag | float[3] | (uT) Reference/truth magnetometer sample used during calibration |
| sampleCount | uint32_t | Number of samples collected for the current calibration state |
| calState | uint32_t | Current calibration state/step |
| status | uint32_t | Calibration status flags |
| alignAccel | float[3] | (m/s^2) Accelerometer reading used for alignment/leveling during calibration |


#### DID_SENSORS_ADC

`sys_sensors_adc_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds |
| imu | sensors_imu_w_temp_t[1] | Per-device raw IMU (gyro/accel) + temperature samples |
| mag | sensors_mag_t[1] | Magnetometers |
| bar | float | Barometric pressure |
| barTemp | float | (°C) Temperature of barometric pressure sensor |
| humidity | float | Relative humidity as a percent (%rH).  Range is 0% - 100% |
| ana | float[4] | ADC analog input |


#### DID_SENSORS_ADC_SIGMA



`sys_sensors_adc_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds |
| imu | sensors_imu_w_temp_t[1] | Per-device raw IMU (gyro/accel) + temperature samples |
| mag | sensors_mag_t[1] | Magnetometers |
| bar | float | Barometric pressure |
| barTemp | float | (°C) Temperature of barometric pressure sensor |
| humidity | float | Relative humidity as a percent (%rH).  Range is 0% - 100% |
| ana | float[4] | ADC analog input |


#### DID_SENSORS_MCAL

Temperature compensated and motion calibrated IMU output. 

`sensors_w_temp_t`

| Field | Type | Description |
|-------|------|-------------|
| imus | imus_t | Per-device gyro/accelerometer samples (see imus_t) |
| temp | float[1] | (°C) Temperature of IMU.  Units only apply for calibrated data. |
| mag | mag_xyz_t[1] | (uT) Magnetometers.  Units only apply for calibrated data. |


#### DID_SENSORS_TCAL

Temperature compensated IMU output. 

`sensors_w_temp_t`

| Field | Type | Description |
|-------|------|-------------|
| imus | imus_t | Per-device gyro/accelerometer samples (see imus_t) |
| temp | float[1] | (°C) Temperature of IMU.  Units only apply for calibrated data. |
| mag | mag_xyz_t[1] | (uT) Magnetometers.  Units only apply for calibrated data. |


#### DID_SENSORS_TC_BIAS

`sensors_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds.  Convert to GPS time of week by adding gps.towOffset. Units only apply for calibrated data. |
| mpu | sensors_mpu_t[1] | Per-device combined IMU + magnetometer sample |


#### DID_SENSORS_UCAL

Uncalibrated IMU output. 

`sensors_w_temp_t`

| Field | Type | Description |
|-------|------|-------------|
| imus | imus_t | Per-device gyro/accelerometer samples (see imus_t) |
| temp | float[1] | (°C) Temperature of IMU.  Units only apply for calibrated data. |
| mag | mag_xyz_t[1] | (uT) Magnetometers.  Units only apply for calibrated data. |


#### DID_STROBE_IN_TIME

Timestamp for input strobe. 

`strobe_in_time_t`

| Field | Type | Description |
|-------|------|-------------|
| week | uint32_t | GPS number of weeks since January 6th, 1980 |
| timeOfWeekMs | uint32_t | (ms) GPS time of week (since Sunday morning) |
| pin | uint16_t | Strobe input pin (i.e. G1, G2, G5, G9, G11, G12, G13, G15) |
| count | uint16_t | Strobe serial index number, incremented once per detected strobe edge |


#### DID_SURVEY_IN

`survey_in_t`

| Field | Type | Description |
|-------|------|-------------|
| state | uint32_t | State of current survey (see eSurveyInStatus) |
| maxDurationSec | uint32_t | Maximum duration the survey will run, in seconds, if minAccuracy is not first achieved (ignored if 0) |
| minAccuracy | float | Required horizontal accuracy for the survey to complete before maxDurationSec elapses, in meters (ignored if 0) |
| elapsedTimeSec | uint32_t | Elapsed time of the survey, in seconds |
| hAccuracy | float | Approximate horizontal accuracy of the survey's current position estimate, in meters |
| lla | double[3] | Current surveyed position: latitude, longitude, altitude (deg, deg, m) |


#### DID_SYS_FAULT

instead encode a single small integer value (1-7) at SYS_FAULT_STATUS_CRITICAL_ERROR_pos identifying the specific critical fault that caused a reset, since only one critical fault can be active/reported at a time. 

`system_fault_t`

| Field | Type | Description |
|-------|------|-------------|
| upTime | uint32_t | Time of fault, uptime in milliseconds |
| status | uint32_t | System fault status (see eSysFaultStatus) |
| fileNum | uint32_t | File number (source file identifier) where the fault occurred |
| lineNum | uint32_t | Line number within the file where the fault occurred |
| haltReason | uint32_t | Zephyr halt reason code |
| lr | uint32_t | Link register value at time of fault |
| pc | uint32_t | Program Counter value at time of fault |
| psr | uint32_t | Program Status Register value at time of fault |
| taskALastFeed | uint32_t | Milliseconds since task A last ran |
| taskBLastFeed | uint32_t | Milliseconds since task B last ran |
| wdtLastFeed | uint32_t | Milliseconds since the watchdog timer was last fed |
| var0 | uint32_t | Multi-purpose register 0, fault-specific diagnostic value |
| var1 | uint32_t | Multi-purpose register 1, fault-specific diagnostic value |
| var2 | uint32_t | Multi-purpose register 2, fault-specific diagnostic value |
| var3 | uint32_t | Multi-purpose register 3, fault-specific diagnostic value |


#### DID_SYS_PARAMS

`sys_params_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| insStatus | uint32_t | INS status flags (see eInsStatusFlags) |
| hdwStatus | uint32_t | Hardware status flags (see eHdwStatusFlags) |
| imuTemp | float | IMU temperature, in Celsius |
| baroTemp | float | Barometer temperature, in Celsius |
| mcuTemp | float | MCU temperature, in Celsius (not available yet) |
| sysStatus | uint32_t | System status flags (see eSysStatusFlags) |
| imuSamplePeriodMs | uint32_t | IMU sample period, in milliseconds. Zero disables sampling. |
| navOutputPeriodMs | uint32_t | Preintegrated IMU (PIMU) integration period and navigation/AHRS filter output period, in milliseconds |
| sensorTruePeriod | double | Actual sample period relative to GNSS PPS, in seconds |
| flashCfgChecksum | uint32_t | Flash config checksum used with host SDK synchronization |
| navUpdatePeriodMs | uint32_t | Navigation/AHRS filter update period, in milliseconds |
| genFaultCode | uint32_t | General fault code descriptor (see eGenFaultCodes). Set to zero to reset fault code. |
| upTime | double | System up time, in seconds (double precision) |


#### DID_WHEEL_ENCODER

`wheel_encoder_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeek | double | (s) (Do not use, internal development only) Time of measurement, seconds into current GNSS week |
| status | uint32_t | Wheel encoder status bits |
| theta_l | float | (rad) (Do not use, internal development only) Left wheel angle |
| theta_r | float | (rad) (Do not use, internal development only) Right wheel angle |
| omega_l | float | (rad/s) Left wheel angular rate. Positive when wheel is turning toward the forward direction of the vehicle. Use WHEEL_CFG_BITS_DIRECTION_REVERSE_LEFT in DID_FLASH_CONFIG::wheelConfig to reverse this. |
| omega_r | float | (rad/s) Right wheel angular rate. Positive when wheel is turning toward the forward direction of the vehicle. Use WHEEL_CFG_BITS_DIRECTION_REVERSE_RIGHT in DID_FLASH_CONFIG::wheelConfig to reverse this. |
| wrap_count_l | uint32_t | (Do not use, internal development only) Left wheel revolution (wrap-around) count |
| wrap_count_r | uint32_t | (Do not use, internal development only) Right wheel revolution (wrap-around) count |
| var_wheel_omega | float | (rad^2/s^2) Wheel encoder velocity noise variance |
| var_wheel_theta | float | (rad^2) Wheel encoder angle noise variance |


#### DIDs

`gen_3axis_sensor_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time in seconds (meaning is source-dependent; typically time since boot up or GPS time of week) |
| val | float[3] | 3-axis sensor value {x,y,z} (units are source-dependent) |


## Enumerations and Defines

System status and configuration is made available through various enumeration and #defines.

### General

#### DID_FLASH_CONFIG.gnssSatSigConst

(eGnssSatSigConst)  

| Field | Value |
|-------|------|
| GNSS_SAT_SIG_CONST_GPS | 0x0003 |
| GNSS_SAT_SIG_CONST_QZS | 0x000C |
| GNSS_SAT_SIG_CONST_GAL | 0x0030 |
| GNSS_SAT_SIG_CONST_BDS | 0x00C0 |
| GNSS_SAT_SIG_CONST_GLO | 0x0300 |
| GNSS_SAT_SIG_CONST_SBS | 0x1000 |
| GNSS_SAT_SIG_CONST_IRN | 0x2000 |
| GNSS_SAT_SIG_CONST_IME | 0x4000 |


#### DID_FLASH_CONFIG.sensorConfig

(eSensorConfig)  

| Field | Value |
|-------|------|
| SENSOR_CFG_GYR_FS_250 | 0x00000000 |
| SENSOR_CFG_GYR_FS_500 | 0x00000001 |
| SENSOR_CFG_GYR_FS_1000 | 0x00000002 |
| SENSOR_CFG_GYR_FS_2000 | 0x00000003 |
| SENSOR_CFG_GYR_FS_4000 | 0x00000004 |
| SENSOR_CFG_GYR_FS_MAX | 0x00000007 |
| SENSOR_CFG_GYR_FS_MASK | 0x00000007 |
| SENSOR_CFG_GYR_FS_OFFSET |  (int)0 |
| SENSOR_CFG_ACC_FS_2G | 0x00000000 |
| SENSOR_CFG_ACC_FS_4G | 0x00000001 |
| SENSOR_CFG_ACC_FS_8G | 0x00000002 |
| SENSOR_CFG_ACC_FS_16G | 0x00000003 |
| SENSOR_CFG_ACC_FS_32G | 0x00000004 |
| SENSOR_CFG_ACC_FS_80G | 0x00000005 |
| SENSOR_CFG_ACC_FS_MAX | 0x00000007 |
| SENSOR_CFG_ACC_FS_MASK | 0x00000070 |
| SENSOR_CFG_ACC_FS_OFFSET |  (int)4 |
| SENSOR_CFG_GYR_DLPF_250HZ | 0x00000000 |
| SENSOR_CFG_GYR_DLPF_184HZ | 0x00000001 |
| SENSOR_CFG_GYR_DLPF_92HZ | 0x00000002 |
| SENSOR_CFG_GYR_DLPF_41HZ | 0x00000003 |
| SENSOR_CFG_GYR_DLPF_20HZ | 0x00000004 |
| SENSOR_CFG_GYR_DLPF_10HZ | 0x00000005 |
| SENSOR_CFG_GYR_DLPF_5HZ | 0x00000006 |
| SENSOR_CFG_GYR_DLPF_MASK | 0x00000F00 |
| SENSOR_CFG_GYR_DLPF_OFFSET |  (int)8 |
| SENSOR_CFG_ACC_DLPF_218HZ | 0x00000000 |
| SENSOR_CFG_ACC_DLPF_218HZb | 0x00000001 |
| SENSOR_CFG_ACC_DLPF_99HZ | 0x00000002 |
| SENSOR_CFG_ACC_DLPF_45HZ | 0x00000003 |
| SENSOR_CFG_ACC_DLPF_21HZ | 0x00000004 |
| SENSOR_CFG_ACC_DLPF_10HZ | 0x00000005 |
| SENSOR_CFG_ACC_DLPF_5HZ | 0x00000006 |
| SENSOR_CFG_ACC_DLPF_MASK | 0x0000F000 |
| SENSOR_CFG_ACC_DLPF_OFFSET |  (int)12 |
| SENSOR_CFG_SENSOR_ROTATION_MASK | 0x001F0000 |
| SENSOR_CFG_SENSOR_ROTATION_OFFSET |  (int)16 |
| SENSOR_CFG_SENSOR_ROTATION_0_0_0 |  (int)0 |
| SENSOR_CFG_SENSOR_ROTATION_0_0_90 |  (int)1 |
| SENSOR_CFG_SENSOR_ROTATION_0_0_180 |  (int)2 |
| SENSOR_CFG_SENSOR_ROTATION_0_0_N90 |  (int)3 |
| SENSOR_CFG_SENSOR_ROTATION_90_0_0 |  (int)4 |
| SENSOR_CFG_SENSOR_ROTATION_90_0_90 |  (int)5 |
| SENSOR_CFG_SENSOR_ROTATION_90_0_180 |  (int)6 |
| SENSOR_CFG_SENSOR_ROTATION_90_0_N90 |  (int)7 |
| SENSOR_CFG_SENSOR_ROTATION_180_0_0 |  (int)8 |
| SENSOR_CFG_SENSOR_ROTATION_180_0_90 |  (int)9 |
| SENSOR_CFG_SENSOR_ROTATION_180_0_180 |  (int)10 |
| SENSOR_CFG_SENSOR_ROTATION_180_0_N90 |  (int)11 |
| SENSOR_CFG_SENSOR_ROTATION_N90_0_0 |  (int)12 |
| SENSOR_CFG_SENSOR_ROTATION_N90_0_90 |  (int)13 |
| SENSOR_CFG_SENSOR_ROTATION_N90_0_180 |  (int)14 |
| SENSOR_CFG_SENSOR_ROTATION_N90_0_N90 |  (int)15 |
| SENSOR_CFG_SENSOR_ROTATION_0_90_0 |  (int)16 |
| SENSOR_CFG_SENSOR_ROTATION_0_90_90 |  (int)17 |
| SENSOR_CFG_SENSOR_ROTATION_0_90_180 |  (int)18 |
| SENSOR_CFG_SENSOR_ROTATION_0_90_N90 |  (int)19 |
| SENSOR_CFG_SENSOR_ROTATION_0_N90_0 |  (int)20 |
| SENSOR_CFG_SENSOR_ROTATION_0_N90_90 |  (int)21 |
| SENSOR_CFG_SENSOR_ROTATION_0_N90_180 |  (int)22 |
| SENSOR_CFG_SENSOR_ROTATION_0_N90_N90 |  (int)23 |
| SENSOR_CFG_MAG_ODR_100_HZ | 0x00200000 |
| SENSOR_CFG_DISABLE_MAGNETOMETER | 0x00400000 |
| SENSOR_CFG_DISABLE_BAROMETER | 0x00800000 |
| SENSOR_CFG_IMU_FAULT_DETECT_MASK | 0xFF000000 |
| SENSOR_CFG_IMU_FAULT_DETECT_GYR | 0x01000000 |
| SENSOR_CFG_IMU_FAULT_DETECT_ACC | 0x02000000 |
| SENSOR_CFG_IMU_FAULT_DETECT_OFFLINE | 0x04000000 |
| SENSOR_CFG_IMU_FAULT_DETECT_LARGE_BIAS | 0x08000000 |
| SENSOR_CFG_IMU_FAULT_DETECT_SENSOR_NOISE | 0x10000000 |


#### DID_FLASH_CONFIG.sysCfgBits

(eSysConfigBits)  

| Field | Value |
|-------|------|
| UNUSED1 | 0x00000001 |
| SYS_CFG_BITS_ENABLE_MAG_CONTINUOUS_CAL | 0x00000002 |
| SYS_CFG_BITS_AUTO_MAG_RECAL | 0x00000004 |
| SYS_CFG_BITS_DISABLE_MAG_DECL_ESTIMATION | 0x00000008 |
| SYS_CFG_BITS_DISABLE_LEDS | 0x00000010 |
| SYS_CFG_BITS_MAG_RECAL_MODE_MASK | 0x00000700 |
| SYS_CFG_BITS_MAG_RECAL_MODE_OFFSET | 8 |
| SYS_CFG_BITS_MAG_ENABLE_WMM_DECLINATION | 0x00000800 |
| SYS_CFG_BITS_DISABLE_MAGNETOMETER_FUSION | 0x00001000 |
| SYS_CFG_BITS_DISABLE_BAROMETER_FUSION | 0x00002000 |
| SYS_CFG_BITS_DISABLE_GNSS1_FUSION | 0x00004000 |
| SYS_CFG_BITS_DISABLE_GNSS2_FUSION | 0x00008000 |
| SYS_CFG_BITS_DISABLE_AUTO_ZERO_VELOCITY_UPDATES | 0x00010000 |
| SYS_CFG_BITS_DISABLE_AUTO_ZERO_ANGULAR_RATE_UPDATES | 0x00020000 |
| SYS_CFG_BITS_DISABLE_INS_EKF | 0x00040000 |
| SYS_CFG_BITS_DISABLE_AUTO_BIT_ON_STARTUP | 0x00080000 |
| SYS_CFG_BITS_DISABLE_WHEEL_ENCODER_FUSION | 0x00100000 |
| SYS_CFG_BITS_ENABLE_GNSS_ANTENNA_OFFSET_ESTIMATION | 0x00200000 |
| SYS_CFG_BITS_BOR_LEVEL_0 | 0x0 |
| SYS_CFG_BITS_BOR_LEVEL_1 | 0x1 |
| SYS_CFG_BITS_BOR_LEVEL_2 | 0x2 |
| SYS_CFG_BITS_BOR_LEVEL_3 | 0x3 |
| SYS_CFG_BITS_BOR_THRESHOLD_MASK | 0x00C00000 |
| SYS_CFG_BITS_BOR_THRESHOLD_OFFSET | 22 |
| SYS_CFG_USE_REFERENCE_IMU_IN_EKF | 0x01000000 |
| SYS_CFG_EKF_REF_POINT_STATIONARY_ON_STROBE_INPUT | 0x02000000 |


#### DID_GPX_FLASH_CFG.sysCfgBits

(eGpxSysConfigBits)  

| Field | Value |
|-------|------|
| GPX_SYS_CFG_BITS_DISABLE_VCC_RF | 0x00000001 |
| GPX_SYS_CFG_BITS_BOR_LEVEL_0 | 0x0 |
| GPX_SYS_CFG_BITS_BOR_LEVEL_1 | 0x1 |
| GPX_SYS_CFG_BITS_BOR_LEVEL_2 | 0x2 |
| GPX_SYS_CFG_BITS_BOR_LEVEL_3 | 0x3 |
| GPX_SYS_CFG_BITS_BOR_THRESHOLD_MASK | 0x00C00000 |
| GPX_SYS_CFG_BITS_BOR_THRESHOLD_OFFSET | 22 |


#### DID_GPX_STATUS.hdwStatus

(eGPXHdwStatusFlags)  

| Field | Value |
|-------|------|
| GPX_HDW_STATUS_GNSS1_SATELLITE_RX | 0x00000001 |
| GPX_HDW_STATUS_GNSS2_SATELLITE_RX | 0x00000002 |
| GPX_HDW_STATUS_GNSS1_TIME_OF_WEEK_VALID | 0x00000004 |
| GPX_HDW_STATUS_GNSS2_TIME_OF_WEEK_VALID | 0x00000008 |
| GPX_HDW_STATUS_GNSS1_RESET_COUNT_MASK | 0x00000070 |
| GPX_HDW_STATUS_GNSS1_RESET_COUNT_OFFSET | 4 |
| GPX_HDW_STATUS_FAULT_GNSS1_INIT | 0x00000080 |
| GPX_HDW_STATUS_GNSS1_FAULT_FLAG_OFFSET | 7 |
| GPX_HDW_STATUS_GNSS2_RESET_COUNT_MASK | 0x00000700 |
| GPX_HDW_STATUS_GNSS2_RESET_COUNT_OFFSET | 8 |
| GPX_HDW_STATUS_FAULT_GNSS2_INIT | 0x00000800 |
| GPX_HDW_STATUS_GNSS2_FAULT_FLAG_OFFSET | 11 |
| GPX_HDW_STATUS_GNSS_FW_UPDATE_REQUIRED | 0x00001000 |
| GPX_HDW_STATUS_LED_ENABLED | 0x00002000 |
| GPX_HDW_STATUS_SYSTEM_RESET_REQUIRED | 0x00004000 |
| GPX_HDW_STATUS_FLASH_WRITE_PENDING | 0x00008000 |
| GPX_HDW_STATUS_ERR_COM_TX_LIMITED | 0x00010000 |
| GPX_HDW_STATUS_ERR_COM_RX_OVERRUN | 0x00020000 |
| GPX_HDW_STATUS_ERR_COM_MASK | 0x00030000 |
| GPX_HDW_STATUS_ERR_NO_GNSS1_PPS | 0x00040000 |
| GPX_HDW_STATUS_ERR_NO_GNSS2_PPS | 0x00080000 |
| GPX_HDW_STATUS_ERR_PPS_MASK | 0x000C0000 |
| GPX_HDW_STATUS_ERR_LOW_CNO_GNSS1 | 0x00100000 |
| GPX_HDW_STATUS_ERR_LOW_CNO_GNSS2 | 0x00200000 |
| GPX_HDW_STATUS_ERR_CNO_GNSS1_IR | 0x00400000 |
| GPX_HDW_STATUS_ERR_CNO_GNSS2_IR | 0x00800000 |
| GPX_HDW_STATUS_ERR_CNO_MASK | 0x00F00000 |
| GPX_HDW_STATUS_BIT_RUNNING | 0x01000000 |
| GPX_HDW_STATUS_BIT_PASSED | 0x02000000 |
| GPX_HDW_STATUS_BIT_FAULT | 0x03000000 |
| GPX_HDW_STATUS_BIT_MASK | 0x03000000 |
| GPX_HDW_STATUS_BIT_OFFSET | 24 |
| GPX_HDW_STATUS_ERR_TEMPERATURE | 0x04000000 |
| GPX_HDW_STATUS_GNSS_PPS_TIMESYNC | 0x08000000 |
| GPX_HDW_STATUS_RESET_CAUSE_MASK | 0x70000000 |
| GPX_HDW_STATUS_RESET_CAUSE_BACKUP_MODE | 0x10000000 |
| GPX_HDW_STATUS_RESET_CAUSE_SOFT | 0x20000000 |
| GPX_HDW_STATUS_RESET_CAUSE_HDW | 0x40000000 |
| GPX_HDW_STATUS_FAULT_SYS_CRITICAL | 0x80000000 |


#### DID_GPX_STATUS.rtkMode

(eRTKConfigBits)  

| Field | Value |
|-------|------|
| RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING_DEPRECATED | 0x00000001 |
| RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING | 0x00000002 |
| RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING | 0x00000004 |
| RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING_DEPRECATED | 0x00000008 |
| RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING_MASK | (RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING\|RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING_DEPRECATED\) |
| RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING_MASK | (RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING\|RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING_DEPRECATED\) |
| RTK_CFG_BITS_ROVER_MODE_MASK | 0x0000000F |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_UBLOX_SER0 | 0x00000010 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_UBLOX_SER1 | 0x00000020 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_UBLOX_SER2 | 0x00000040 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_UBLOX_USB | 0x00000080 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_SER0 | 0x00000100 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_SER1 | 0x00000200 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_SER2 | 0x00000400 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_USB | 0x00000800 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_UBLOX_SER0 | 0x00001000 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_UBLOX_SER1 | 0x00002000 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_UBLOX_SER2 | 0x00004000 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_UBLOX_USB | 0x00008000 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_SER0 | 0x00010000 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_SER1 | 0x00020000 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_SER2 | 0x00040000 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_USB | 0x00080000 |
| RTK_CFG_BITS_BASE_POS_MOVING | 0x00100000 |
| RTK_CFG_BITS_RESERVED1 | 0x00200000 |
| RTK_CFG_BITS_RTK_BASE_IS_IDENTICAL_TO_ROVER | 0x00400000 |
| RTK_CFG_BITS_GNSS_PORT_PASS_THROUGH | 0x00800000 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_CUR_PORT | 0x01000000 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_CUR_PORT | 0x02000000 |
| RTK_CFG_BITS_BASE_OUTPUT_RTCM3_CLEAR_CUR_PORT | 0x04000000 |
| RTK_CFG_BITS_BASE_OUTPUT_RTCM3_CUR_PORT_MASK | (RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_CUR_PORT\|RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_CUR_PORT\) |
| RTK_CFG_BITS_BASE_UBLOX_MASK | (RTK_CFG_BITS_BASE_GNSS1_UBLOX_MASK\|RTK_CFG_BITS_BASE_GNSS2_UBLOX_MASK\) |
| RTK_CFG_BITS_BASE_RTCM3_MASK | (RTK_CFG_BITS_BASE_GNSS1_RTCM3_MASK\|RTK_CFG_BITS_BASE_GNSS2_RTCM3_MASK\) |
| RTK_CFG_BITS_BASE_MODE | (RTK_CFG_BITS_BASE_UBLOX_MASK\|RTK_CFG_BITS_BASE_RTCM3_MASK\) |
| RTK_CFG_BITS_ROVER_MODE_ONBOARD_MASK | (RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING_DEPRECATED\|RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING_DEPRECATED\) |
| RTK_CFG_BITS_ALL_MODES_MASK | (RTK_CFG_BITS_ROVER_MODE_MASK\|RTK_CFG_BITS_BASE_MODE\) |


#### DID_GPX_STATUS.status

(eGpxStatus)  

| Field | Value |
|-------|------|
| GPX_STATUS_COM_PARSE_ERR_COUNT_MASK | 0x0000000F |
| GPX_STATUS_COM_PARSE_ERR_COUNT_OFFSET | 0 |
| GPX_STATUS_COM0_RX_TRAFFIC_NOT_DETECTED | 0x00000010 |
| GPX_STATUS_COM1_RX_TRAFFIC_NOT_DETECTED | 0x00000020 |
| GPX_STATUS_COM2_RX_TRAFFIC_NOT_DETECTED | 0x00000040 |
| GPX_STATUS_USB_RX_TRAFFIC_NOT_DETECTED | 0x00000080 |
| GPX_STATUS_UPDATE_CONFIRMED | 0x00000100 |
| GPX_STATUS_GENERAL_FAULT_MASK | 0xFFFF0000 |
| GPX_STATUS_FAULT_RTK_QUEUE_LIMITED | 0x00010000 |
| GPX_STATUS_FAULT_GNSS_RCVR_TIME | 0x00100000 |
| GPX_STATUS_FAULT_RTOS_TASK_PERIOD_OVERRUN | 0x00200000 |
| GPX_STATUS_FAULT_DMA | 0x00800000 |
| GPX_STATUS_FATAL_MASK | 0x1F000000 |
| GPX_STATUS_FATAL_OFFSET | 24 |
| GPX_STATUS_FATAL_RESET_LOW_POW |  (int)1 |
| GPX_STATUS_FATAL_RESET_BROWN |  (int)2 |
| GPX_STATUS_FATAL_RESET_WATCHDOG |  (int)3 |
| GPX_STATUS_FATAL_CPU_EXCEPTION |  (int)4 |
| GPX_STATUS_FATAL_UNHANDLED_INTERRUPT |  (int)5 |
| GPX_STATUS_FATAL_STACK_OVERFLOW |  (int)6 |
| GPX_STATUS_FATAL_KERNEL_OOPS |  (int)7 |
| GPX_STATUS_FATAL_KERNEL_PANIC |  (int)8 |
| GPX_STATUS_FATAL_UNALIGNED_ACCESS |  (int)9 |
| GPX_STATUS_FATAL_MEMORY_ERROR |  (int)10 |
| GPX_STATUS_FATAL_BUS_ERROR |  (int)11 |
| GPX_STATUS_FATAL_USAGE_ERROR |  (int)12 |
| GPX_STATUS_FATAL_DIV_ZERO |  (int)13 |
| GPX_STATUS_FATAL_SER0_REINIT |  (int)14 |
| GPX_STATUS_FATAL_UNKNOWN | 0x1F |
| GPX_STATUS_FAULT_RP | 0x20000000 |
| GPX_STATUS_FAULT_UNUSED | 0xC0000000 |


#### DID_SYS_CMD.command

(eSystemCommand)  

| Field | Value |
|-------|------|
| SYS_CMD_NONE | 0 |
| SYS_CMD_SAVE_PERSISTENT_MESSAGES | 1 |
| SYS_CMD_ENABLE_BOOTLOADER_AND_RESET | 2 |
| SYS_CMD_ENABLE_SENSOR_STATS | 3 |
| SYS_CMD_ENABLE_RTOS_STATS | 4 |
| SYS_CMD_ZERO_MOTION | 5 |
| SYS_CMD_REF_POINT_STATIONARY | 6 |
| SYS_CMD_REF_POINT_MOVING | 7 |
| SYS_CMD_RESET_RTOS_STATS | 8 |
| SYS_CMD_ENABLE_GNSS_LOW_LEVEL_CONFIG | 10 |
| SYS_CMD_DISABLE_SERIAL_PORT_BRIDGE | 11 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_USB_TO_GNSS1 | 12 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_USB_TO_GNSS2 | 13 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_USB_TO_SER0 | 14 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_USB_TO_SER1 | 15 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_USB_TO_SER2 | 16 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_SER0_TO_GNSS1 | 17 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_CUR_PORT_TO_GNSS1 | 18 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_CUR_PORT_TO_GNSS2 | 19 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_CUR_PORT_TO_USB | 20 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_CUR_PORT_TO_SER0 | 21 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_CUR_PORT_TO_SER1 | 22 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_CUR_PORT_TO_SER2 | 23 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_USB_LOOPBACK | 24 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_SER0_LOOPBACK | 25 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_SER1_LOOPBACK | 26 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_SER2_LOOPBACK | 27 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_CUR_PORT_LOOPBACK | 28 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_CUR_PORT_LOOPBACK_TESTMODE | 29 |
| SYS_CMD_GPX_ENABLE_BOOTLOADER_MODE | 30 |
| SYS_CMD_GPX_ENABLE_GNSS1_CHIPSET_BOOTLOADER | 31 |
| SYS_CMD_GPX_ENABLE_GNSS2_CHIPSET_BOOTLOADER | 32 |
| SYS_CMD_GPX_ENABLE_GNSS1_PASS_THROUGH | 33 |
| SYS_CMD_GPX_ENABLE_GNSS2_PASS_THROUGH | 34 |
| SYS_CMD_GPX_HARD_RESET_GNSS1 | 36 |
| SYS_CMD_GPX_HARD_RESET_GNSS2 | 37 |
| SYS_CMD_GPX_SOFT_RESET_GPX | 38 |
| SYS_CMD_GPX_ENABLE_SERIAL_BRIDGE_CUR_PORT_LOOPBACK | 39 |
| SYS_CMD_GPX_ENABLE_SERIAL_BRIDGE_CUR_PORT_LOOPBACK_TESTMODE | 40 |
| SYS_CMD_GPX_ENABLE_RTOS_STATS | 41 |
| SYS_CMD_GNSS_RCVR_QUIET_MODE | 60 |
| SYS_CMD_GNSS_RCVR_SOFT_RESET | 61 |
| SYS_CMD_GNSS_RCVR_HARD_RESET | 62 |
| SYS_CMD_RESET_EKF_STATES | 70 |
| SYS_CMD_CLEAR_ERROR_STATUS | 71 |
| SYS_CMD_SAVE_FLASH | 97 |
| SYS_CMD_SAVE_GNSS_ASSIST_TO_FLASH_RESET | 98 |
| SYS_CMD_SOFTWARE_RESET | 99 |
| SYS_CMD_MANF_UNLOCK | 1122334455 |
| SYS_CMD_MANF_ERASE_CALIBRATION_MOTION | 1357924678 |
| SYS_CMD_MANF_ERASE_CALIBRATION | 1357924679 |
| SYS_CMD_MANF_FACTORY_RESET | 1357924680 |
| SYS_CMD_MANF_CHIP_ERASE | 1357924681 |
| SYS_CMD_MANF_DOWNGRADE_CALIBRATION | 1357924682 |
| SYS_CMD_MANF_ENABLE_ROM_BOOTLOADER | 1357924683 |
| SYS_CMD_MANF_LED_ON | 1357924684 |
| SYS_CMD_MANF_LED_OFF | 1357924685 |
| SYS_CMD_FAULT_TEST_TRIG_MALLOC | 57005 |
| SYS_CMD_FAULT_TEST_TRIG_HARD_FAULT | 57006 |
| SYS_CMD_FAULT_TEST_TRIG_WATCHDOG | 57007 |
| SYS_CMD_FAULT_TEST_TRIG_FLASH_TORN_WRITE | 57008 |


#### DID_SYS_PARAMS.genFaultCode

(eGenFaultCodes)  

| Field | Value |
|-------|------|
| GFC_INS_STATE_ORUN_UVW | 0x00000001 |
| GFC_INS_STATE_ORUN_LAT | 0x00000002 |
| GFC_INS_STATE_ORUN_ALT | 0x00000004 |
| GFC_UNHANDLED_INTERRUPT | 0x00000010 |
| GFC_GNSS_CRITICAL_FAULT | 0x00000020 |
| GFC_GNSS_TX_LIMITED | 0x00000040 |
| GFC_GNSS_RX_OVERRUN | 0x00000080 |
| GFC_INIT_SENSORS | 0x00000100 |
| GFC_INIT_SPI | 0x00000200 |
| GFC_CONFIG_SPI | 0x00000400 |
| GFC_GNSS1_INIT | 0x00000800 |
| GFC_GNSS2_INIT | 0x00001000 |
| GFC_FLASH_INVALID_VALUES | 0x00002000 |
| GFC_FLASH_CHECKSUM_FAILURE | 0x00004000 |
| GFC_FLASH_WRITE_FAILURE | 0x00008000 |
| GFC_SYS_FAULT_GENERAL | 0x00010000 |
| GFC_SYS_FAULT_CRITICAL | 0x00020000 |
| GFC_SENSOR_SATURATION | 0x00040000 |
| GFC_EKF_STATES_INVALID | 0x00080000 |
| GFC_INIT_IMU | 0x00100000 |
| GFC_INIT_BAROMETER | 0x00200000 |
| GFC_INIT_MAGNETOMETER | 0x00400000 |
| GFC_INIT_I2C | 0x00800000 |
| GFC_CHIP_ERASE_INVALID | 0x01000000 |
| GFC_EKF_GNSS_TIME_FAULT | 0x02000000 |
| GFC_GNSS_RECEIVER_TIME | 0x04000000 |
| GFC_GNSS_GENERAL_FAULT | 0x08000000 |
| GFC_EKF_INPUT_INVALID_IMU | 0x10000000 |
| GFC_GNSS_RTOS_ERROR | 0x20000000 |
| GFC_GPX_STATUS_COMMON_MASK | GFC_GNSS1_INIT\|GFC_GNSS2_INIT\|GFC_GNSS_TX_LIMITED\|GFC_GNSS_RX_OVERRUN\|GFC_GNSS_CRITICAL_FAULT\|GFC_GNSS_RECEIVER_TIME\|GFC_GNSS_GENERAL_FAULT |


#### GPS Navigation Fix Type

(eGnssNavFixStatus)  

| Field | Value |
|-------|------|
| GNSS_NAV_FIX_NONE | 0x00000000 |
| GNSS_NAV_FIX_POSITIONING_3D | 0x00000001 |
| GNSS_NAV_FIX_POSITIONING_RTK_FLOAT | 0x00000002 |
| GNSS_NAV_FIX_POSITIONING_RTK_FIX | 0x00000003 |


#### GPS Status

(eGnssStatus)  

| Field | Value |
|-------|------|
| GNSS_STATUS_NUM_SATS_USED_MASK | 0x000000FF |
| GNSS_STATUS_FIX_NONE | 0x00000000 |
| GNSS_STATUS_FIX_DEAD_RECKONING_ONLY | 0x00000100 |
| GNSS_STATUS_FIX_2D | 0x00000200 |
| GNSS_STATUS_FIX_3D | 0x00000300 |
| GNSS_STATUS_FIX_GNSS_PLUS_DEAD_RECK | 0x00000400 |
| GNSS_STATUS_FIX_TIME_ONLY | 0x00000500 |
| GNSS_STATUS_FIX_REF_LLA | 0x00000600 |
| GNSS_STATUS_FIX_UNUSED2 | 0x00000700 |
| GNSS_STATUS_FIX_DGPS | 0x00000800 |
| GNSS_STATUS_FIX_SBAS | 0x00000900 |
| GNSS_STATUS_FIX_RTK_SINGLE | 0x00000A00 |
| GNSS_STATUS_FIX_RTK_FLOAT | 0x00000B00 |
| GNSS_STATUS_FIX_RTK_FIX | 0x00000C00 |
| GNSS_STATUS_FIX_MASK | 0x00001F00 |
| GNSS_STATUS_FIX_BIT_OFFSET |  (int)8 |
| GNSS_STATUS_FLAGS_FIX_OK | 0x00010000 |
| GNSS_STATUS_FLAGS_DGPS_USED | 0x00020000 |
| GNSS_STATUS_FLAGS_RTK_FIX_AND_HOLD | 0x00040000 |
| GNSS_STATUS_FLAGS_UNUSED_1 | 0x00080000 |
| GNSS_STATUS_FLAGS_GNSS1_RTK_POSITION_ENABLED | 0x00100000 |
| GNSS_STATUS_FLAGS_STATIC_MODE | 0x00200000 |
| GNSS_STATUS_FLAGS_GNSS2_RTK_COMPASS_ENABLED | 0x00400000 |
| GNSS_STATUS_FLAGS_GNSS1_RTK_RAW_GNSS_DATA_ERROR | 0x00800000 |
| GNSS_STATUS_FLAGS_GNSS1_RTK_BASE_DATA_MISSING | 0x01000000 |
| GNSS_STATUS_FLAGS_GNSS1_RTK_BASE_POSITION_MOVING | 0x02000000 |
| GNSS_STATUS_FLAGS_GNSS1_RTK_BASE_POSITION_INVALID | 0x03000000 |
| GNSS_STATUS_FLAGS_GNSS1_RTK_BASE_POSITION_MASK | 0x03000000 |
| GNSS_STATUS_FLAGS_GNSS1_RTK_POSITION_VALID | 0x04000000 |
| GNSS_STATUS_FLAGS_GNSS2_RTK_COMPASS_VALID | 0x08000000 |
| GNSS_STATUS_FLAGS_GNSS2_RTK_COMPASS_BASELINE_BAD | 0x00002000 |
| GNSS_STATUS_FLAGS_GNSS2_RTK_COMPASS_BASELINE_UNSET | 0x00004000 |
| GNSS_STATUS_FLAGS_GNSS_NMEA_DATA | 0x00008000 |
| GNSS_STATUS_FLAGS_GNSS_PPS_TIMESYNC | 0x10000000 |
| GNSS_STATUS_FLAGS_MASK | 0x1FFFE000 |
| GNSS_STATUS_FLAGS_BIT_OFFSET |  (int)16 |
| GNSS_STATUS_FLAGS_UNUSED_2 | 0x20000000 |
| GNSS_STATUS_FLAGS_UNUSED_3 | 0x40000000 |
| GNSS_STATUS_FLAGS_UNUSED_4 | 0x80000000 |


#### Hardware Status Flags

(eHdwStatusFlags)  

| Field | Value |
|-------|------|
| HDW_STATUS_MOTION_GYR | 0x00000001 |
| HDW_STATUS_MOTION_ACC | 0x00000002 |
| HDW_STATUS_MOTION_MASK | 0x00000003 |
| HDW_STATUS_IMU_FAULT_REJECT_GYR | 0x00000004 |
| HDW_STATUS_IMU_FAULT_REJECT_ACC | 0x00000008 |
| HDW_STATUS_IMU_FAULT_REJECT_MASK | 0x0000000C |
| HDW_STATUS_GNSS_SATELLITE_RX_VALID | 0x00000010 |
| HDW_STATUS_STROBE_IN_EVENT | 0x00000020 |
| HDW_STATUS_GNSS_TIME_OF_WEEK_VALID | 0x00000040 |
| HDW_STATUS_REFERENCE_IMU_RX | 0x00000080 |
| HDW_STATUS_SATURATION_GYR | 0x00000100 |
| HDW_STATUS_SATURATION_ACC | 0x00000200 |
| HDW_STATUS_SATURATION_MAG | 0x00000400 |
| HDW_STATUS_SATURATION_BARO | 0x00000800 |
| HDW_STATUS_IMU_SATURATION_MASK | (int)(HDW_STATUS_SATURATION_GYR\|HDW_STATUS_SATURATION_ACC\) |
| HDW_STATUS_SATURATION_MASK | 0x00000F00 |
| HDW_STATUS_SATURATION_OFFSET | 8 |
| HDW_STATUS_SYSTEM_RESET_REQUIRED | 0x00001000 |
| HDW_STATUS_ERR_GNSS_PPS_NOISE | 0x00002000 |
| HDW_STATUS_MAG_RECAL_COMPLETE | 0x00004000 |
| HDW_STATUS_FLASH_WRITE_PENDING | 0x00008000 |
| HDW_STATUS_ERR_COM_TX_LIMITED | 0x00010000 |
| HDW_STATUS_ERR_COM_RX_OVERRUN | 0x00020000 |
| HDW_STATUS_ERR_NO_GNSS_PPS | 0x00040000 |
| HDW_STATUS_GNSS_PPS_TIMESYNC | 0x00080000 |
| HDW_STATUS_COM_PARSE_ERR_COUNT_MASK | 0x00F00000 |
| HDW_STATUS_COM_PARSE_ERR_COUNT_OFFSET | 20 |
| HDW_STATUS_BIT_RUNNING | 0x01000000 |
| HDW_STATUS_BIT_PASSED | 0x02000000 |
| HDW_STATUS_BIT_FAILED | 0x03000000 |
| HDW_STATUS_BIT_MASK | 0x03000000 |
| HDW_STATUS_ERR_TEMPERATURE | 0x04000000 |
| HDW_STATUS_SPI_INTERFACE_ENABLED | 0x08000000 |
| HDW_STATUS_RESET_CAUSE_MASK | 0x70000000 |
| HDW_STATUS_RESET_CAUSE_BACKUP_MODE | 0x10000000 |
| HDW_STATUS_RESET_CAUSE_WATCHDOG_FAULT | 0x20000000 |
| HDW_STATUS_RESET_CAUSE_SOFT | 0x30000000 |
| HDW_STATUS_RESET_CAUSE_HDW | 0x40000000 |
| HDW_STATUS_FAULT_SYS_CRITICAL | 0x80000000 |


#### IMU Shock Options

(eImuShockOptions)  

| Field | Value |
|-------|------|
| IMU_SHOCK_OPTIONS_ENABLE | 0x01 |
| IMU_SHOCK_OPTIONS_FAST_RECOVERY | 0x02 |


#### IMU Status

(eImuStatus)  

| Field | Value |
|-------|------|
| IMU_STATUS_GYR_X_OK | 0x00000001 |
| IMU_STATUS_GYR_Y_OK | 0x00000002 |
| IMU_STATUS_GYR_Z_OK | 0x00000004 |
| IMU_STATUS_ACC_X_OK | 0x00000008 |
| IMU_STATUS_ACC_Y_OK | 0x00000010 |
| IMU_STATUS_ACC_Z_OK | 0x00000020 |
| IMU_STATUS_IMU_OK_BITSIZE | 6 |
| IMU_STATUS_IMU_OK_MASK | IMU_STATUS_GYR_X_OK\|IMU_STATUS_GYR_Y_OK\|IMU_STATUS_GYR_Z_OK\|IMU_STATUS_ACC_X_OK\|IMU_STATUS_ACC_Y_OK\|IMU_STATUS_ACC_Z_OK |
| IMU_STATUS_GYR_OK_MASK | IMU_STATUS_GYR_X_OK\|IMU_STATUS_GYR_Y_OK\|IMU_STATUS_GYR_Z_OK |
| IMU_STATUS_ACC_OK_MASK | IMU_STATUS_ACC_X_OK\|IMU_STATUS_ACC_Y_OK\|IMU_STATUS_ACC_Z_OK |
| IMU_STATUS_SHOCK_PRESENT | 0x00000040 |
| IMU_STATUS_MAG_UPDATE | 0x00000100 |
| IMU_STATUS_REFERENCE_IMU_PRESENT | 0x00000200 |
| IMU_STATUS_RESERVED2 | 0x00000400 |
| IMU_STATUS_SATURATION_HISTORY | 0x00000100 |
| IMU_STATUS_SAMPLE_RATE_FAULT_HISTORY | 0x00000200 |
| IMU_STATUS_GYR_FAULT_REJECT | 0x01000000 |
| IMU_STATUS_ACC_FAULT_REJECT | 0x02000000 |
| IMU_STATUS_SATURATION_GYR | 0x40000000 |
| IMU_STATUS_SATURATION_ACC | 0x80000000 |
| IMU_STATUS_SATURATION_MASK | 0xC0000000 |


#### INS status Flags

(eInsStatusFlags)  

| Field | Value |
|-------|------|
| INS_STATUS_HDG_ALIGN_COARSE | 0x00000001 |
| INS_STATUS_VEL_ALIGN_COARSE | 0x00000002 |
| INS_STATUS_POS_ALIGN_COARSE | 0x00000004 |
| INS_STATUS_ALIGN_COARSE_MASK | 0x00000007 |
| INS_STATUS_WHEEL_AIDING_VEL | 0x00000008 |
| INS_STATUS_HDG_ALIGN_FINE | 0x00000010 |
| INS_STATUS_VEL_ALIGN_FINE | 0x00000020 |
| INS_STATUS_POS_ALIGN_FINE | 0x00000040 |
| INS_STATUS_ALIGN_FINE_MASK | 0x00000070 |
| INS_STATUS_GNSS_AIDING_HEADING | 0x00000080 |
| INS_STATUS_GNSS_AIDING_POS | 0x00000100 |
| INS_STATUS_GNSS_UPDATE_IN_SOLUTION | 0x00000200 |
| INS_STATUS_EKF_USING_REFERENCE_IMU | 0x00000400 |
| INS_STATUS_MAG_AIDING_HEADING | 0x00000800 |
| INS_STATUS_NAV_MODE | 0x00001000 |
| INS_STATUS_STATIONARY_MODE | 0x00002000 |
| INS_STATUS_GNSS_AIDING_VEL | 0x00004000 |
| INS_STATUS_KINEMATIC_CAL_GOOD | 0x00008000 |
| INS_STATUS_SOLUTION_MASK | 0x000F0000 |
| INS_STATUS_SOLUTION_OFFSET | 16 |
| INS_STATUS_SOLUTION_OFF | 0 |
| INS_STATUS_SOLUTION_ALIGNING | 1 |
| INS_STATUS_SOLUTION_NAV | 3 |
| INS_STATUS_SOLUTION_NAV_HIGH_VARIANCE | 4 |
| INS_STATUS_SOLUTION_AHRS | 5 |
| INS_STATUS_SOLUTION_AHRS_HIGH_VARIANCE | 6 |
| INS_STATUS_SOLUTION_VRS | 7 |
| INS_STATUS_SOLUTION_VRS_HIGH_VARIANCE | 8 |
| INS_STATUS_RTK_COMPASSING_BASELINE_UNSET | 0x00100000 |
| INS_STATUS_RTK_COMPASSING_BASELINE_BAD | 0x00200000 |
| INS_STATUS_RTK_COMPASSING_MASK | (INS_STATUS_RTK_COMPASSING_BASELINE_UNSET\|INS_STATUS_RTK_COMPASSING_BASELINE_BAD\) |
| INS_STATUS_MAG_RECALIBRATING | 0x00400000 |
| INS_STATUS_MAG_INTERFERENCE_OR_BAD_CAL_OR_NO_CAL | 0x00800000 |
| INS_STATUS_GNSS_NAV_FIX_MASK | 0x03000000 |
| INS_STATUS_GNSS_NAV_FIX_OFFSET | 24 |
| INS_STATUS_RTK_COMPASSING_VALID | 0x04000000 |
| INS_STATUS_RTK_RAW_GNSS_DATA_ERROR | 0x08000000 |
| INS_STATUS_RTK_ERR_BASE_DATA_MISSING | 0x10000000 |
| INS_STATUS_RTK_ERR_BASE_POSITION_MOVING | 0x20000000 |
| INS_STATUS_RTK_ERR_BASE_POSITION_INVALID | 0x30000000 |
| INS_STATUS_RTK_ERR_BASE_MASK | 0x30000000 |
| INS_STATUS_RTK_ERROR_MASK | (INS_STATUS_RTK_RAW_GNSS_DATA_ERROR\|INS_STATUS_RTK_ERR_BASE_MASK\) |
| INS_STATUS_RTOS_TASK_PERIOD_OVERRUN | 0x40000000 |
| INS_STATUS_GENERAL_FAULT | 0x80000000 |


#### Magnetometer Recalibration Mode

(eMagCalState)  

| Field | Value |
|-------|------|
| MAG_CAL_STATE_DO_NOTHING |  (int)0 |
| MAG_CAL_STATE_MULTI_AXIS |  (int)1 |
| MAG_CAL_STATE_SINGLE_AXIS |  (int)2 |
| MAG_CAL_STATE_ABORT |  (int)101 |
| MAG_CAL_STATE_RECAL_RUNNING |  (int)200 |
| MAG_CAL_STATE_RECAL_COMPLETE |  (int)201 |
| MAG_CAL_STATE_RECAL_MODE_NOT_SUPPORTED |  (int)202 |


#### RTK Configuration

(eRTKConfigBits)  

| Field | Value |
|-------|------|
| RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING_DEPRECATED | 0x00000001 |
| RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING | 0x00000002 |
| RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING | 0x00000004 |
| RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING_DEPRECATED | 0x00000008 |
| RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING_MASK | (RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING\|RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING_DEPRECATED\) |
| RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING_MASK | (RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING\|RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING_DEPRECATED\) |
| RTK_CFG_BITS_ROVER_MODE_MASK | 0x0000000F |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_UBLOX_SER0 | 0x00000010 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_UBLOX_SER1 | 0x00000020 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_UBLOX_SER2 | 0x00000040 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_UBLOX_USB | 0x00000080 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_SER0 | 0x00000100 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_SER1 | 0x00000200 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_SER2 | 0x00000400 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_USB | 0x00000800 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_UBLOX_SER0 | 0x00001000 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_UBLOX_SER1 | 0x00002000 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_UBLOX_SER2 | 0x00004000 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_UBLOX_USB | 0x00008000 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_SER0 | 0x00010000 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_SER1 | 0x00020000 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_SER2 | 0x00040000 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_USB | 0x00080000 |
| RTK_CFG_BITS_BASE_POS_MOVING | 0x00100000 |
| RTK_CFG_BITS_RESERVED1 | 0x00200000 |
| RTK_CFG_BITS_RTK_BASE_IS_IDENTICAL_TO_ROVER | 0x00400000 |
| RTK_CFG_BITS_GNSS_PORT_PASS_THROUGH | 0x00800000 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_CUR_PORT | 0x01000000 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_CUR_PORT | 0x02000000 |
| RTK_CFG_BITS_BASE_OUTPUT_RTCM3_CLEAR_CUR_PORT | 0x04000000 |
| RTK_CFG_BITS_BASE_OUTPUT_RTCM3_CUR_PORT_MASK | (RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_CUR_PORT\|RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_CUR_PORT\) |
| RTK_CFG_BITS_BASE_UBLOX_MASK | (RTK_CFG_BITS_BASE_GNSS1_UBLOX_MASK\|RTK_CFG_BITS_BASE_GNSS2_UBLOX_MASK\) |
| RTK_CFG_BITS_BASE_RTCM3_MASK | (RTK_CFG_BITS_BASE_GNSS1_RTCM3_MASK\|RTK_CFG_BITS_BASE_GNSS2_RTCM3_MASK\) |
| RTK_CFG_BITS_BASE_MODE | (RTK_CFG_BITS_BASE_UBLOX_MASK\|RTK_CFG_BITS_BASE_RTCM3_MASK\) |
| RTK_CFG_BITS_ROVER_MODE_ONBOARD_MASK | (RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING_DEPRECATED\|RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING_DEPRECATED\) |
| RTK_CFG_BITS_ALL_MODES_MASK | (RTK_CFG_BITS_ROVER_MODE_MASK\|RTK_CFG_BITS_BASE_MODE\) |


#### RTK Solution Status

(eRtkSolStatus)  

| Field | Value |
|-------|------|
| rtk_solution_status_none | 0 |
| rtk_solution_status_fix | 1 |
| rtk_solution_status_float | 2 |
| rtk_solution_status_sbas | 3 |
| rtk_solution_status_dgps | 4 |
| rtk_solution_status_single | 5 |


#### Raw GPS Data Type

(eRawDataType)  

| Field | Value |
|-------|------|
| raw_data_type_observation | 1 |
| raw_data_type_ephemeris | 2 |
| raw_data_type_glonass_ephemeris | 3 |
| raw_data_type_sbas | 4 |
| raw_data_type_base_station_antenna_position | 5 |
| raw_data_type_ionosphere_model_utc_alm | 6 |


#### System Configuration

(eSysConfigBits)  

| Field | Value |
|-------|------|
| UNUSED1 | 0x00000001 |
| SYS_CFG_BITS_ENABLE_MAG_CONTINUOUS_CAL | 0x00000002 |
| SYS_CFG_BITS_AUTO_MAG_RECAL | 0x00000004 |
| SYS_CFG_BITS_DISABLE_MAG_DECL_ESTIMATION | 0x00000008 |
| SYS_CFG_BITS_DISABLE_LEDS | 0x00000010 |
| SYS_CFG_BITS_MAG_RECAL_MODE_MASK | 0x00000700 |
| SYS_CFG_BITS_MAG_RECAL_MODE_OFFSET | 8 |
| SYS_CFG_BITS_MAG_ENABLE_WMM_DECLINATION | 0x00000800 |
| SYS_CFG_BITS_DISABLE_MAGNETOMETER_FUSION | 0x00001000 |
| SYS_CFG_BITS_DISABLE_BAROMETER_FUSION | 0x00002000 |
| SYS_CFG_BITS_DISABLE_GNSS1_FUSION | 0x00004000 |
| SYS_CFG_BITS_DISABLE_GNSS2_FUSION | 0x00008000 |
| SYS_CFG_BITS_DISABLE_AUTO_ZERO_VELOCITY_UPDATES | 0x00010000 |
| SYS_CFG_BITS_DISABLE_AUTO_ZERO_ANGULAR_RATE_UPDATES | 0x00020000 |
| SYS_CFG_BITS_DISABLE_INS_EKF | 0x00040000 |
| SYS_CFG_BITS_DISABLE_AUTO_BIT_ON_STARTUP | 0x00080000 |
| SYS_CFG_BITS_DISABLE_WHEEL_ENCODER_FUSION | 0x00100000 |
| SYS_CFG_BITS_ENABLE_GNSS_ANTENNA_OFFSET_ESTIMATION | 0x00200000 |
| SYS_CFG_BITS_BOR_LEVEL_0 | 0x0 |
| SYS_CFG_BITS_BOR_LEVEL_1 | 0x1 |
| SYS_CFG_BITS_BOR_LEVEL_2 | 0x2 |
| SYS_CFG_BITS_BOR_LEVEL_3 | 0x3 |
| SYS_CFG_BITS_BOR_THRESHOLD_MASK | 0x00C00000 |
| SYS_CFG_BITS_BOR_THRESHOLD_OFFSET | 22 |
| SYS_CFG_USE_REFERENCE_IMU_IN_EKF | 0x01000000 |
| SYS_CFG_EKF_REF_POINT_STATIONARY_ON_STROBE_INPUT | 0x02000000 |
