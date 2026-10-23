

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
| timeOfWeekMs | uint32_t | (ms) GPS time of week (since Sunday morning) |
| differentialAge | float | (s) Age of differential corrections |
| arRatio | float | Ambiguity resolution ratio factor for validation (unitless; higher indicates greater confidence the fixed integer ambiguity is correct) |
| baseToRoverVector | float[3] | (m) Vector from base to rover GNSS antennas {x,y,z} in ECEF.  DID_GNSS1_RTK_POS_REL: RTK base station (base) to GNSS1 (rover).  DID_GNSS2_RTK_CMP_REL (compassing): GNSS1 (base) to GNSS2 (rover) |
| baseToRoverDistance | float | (m) Distance from base to rover GNSS antennas (baseline length) |
| baseToRoverHeading | float | (rad) Heading of baseToRoverVector in the local tangent (NED) plane.  Compassing mode: GNSS1 (base) to GNSS2 (rover) |
| baseToRoverHeadingAcc | float | (rad) Accuracy (standard deviation) of baseToRoverHeading |
| status | uint32_t | GNSS status (see eGnssStatus): [0x000000xx] number of satellites used, [0x0000xx00] fix type, [0x00xx0000] status flags, NMEA input flag |


#### DID_GNSS1_SAT

`gnss_sat_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| numSats | uint32_t | Number of satellites in the sky (valid entries in the sat[] list below) |
| sat | gnss_sat_sv_t[80] | Per-satellite tracking information list |


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
| timeOfWeekMs | uint32_t | (ms) GPS time of week (since Sunday morning) |
| differentialAge | float | (s) Age of differential corrections |
| arRatio | float | Ambiguity resolution ratio factor for validation (unitless; higher indicates greater confidence the fixed integer ambiguity is correct) |
| baseToRoverVector | float[3] | (m) Vector from base to rover GNSS antennas {x,y,z} in ECEF.  DID_GNSS1_RTK_POS_REL: RTK base station (base) to GNSS1 (rover).  DID_GNSS2_RTK_CMP_REL (compassing): GNSS1 (base) to GNSS2 (rover) |
| baseToRoverDistance | float | (m) Distance from base to rover GNSS antennas (baseline length) |
| baseToRoverHeading | float | (rad) Heading of baseToRoverVector in the local tangent (NED) plane.  Compassing mode: GNSS1 (base) to GNSS2 (rover) |
| baseToRoverHeadingAcc | float | (rad) Accuracy (standard deviation) of baseToRoverHeading |
| status | uint32_t | GNSS status (see eGnssStatus): [0x000000xx] number of satellites used, [0x0000xx00] fix type, [0x00xx0000] status flags, NMEA input flag |


#### DID_GNSS2_SAT

GNSS 2 GNSS satellite information: sat identifiers, carrier to noise ratio, elevation and azimuth angles, pseudo range residual. 

`gnss_sat_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| numSats | uint32_t | Number of satellites in the sky (valid entries in the sat[] list below) |
| sat | gnss_sat_sv_t[80] | Per-satellite tracking information list |


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
| hardwareVer | uint8_t[3] | Hardware version: [0]=major, [1]=minor, [2]=pcb/a revision |
| hardwareVariant | uint8_t | Hardware variant; an arbitrary number independent of version that identifies some variation of the hardware; most commonly, IMU population type on IMX-6 (see eImx6ImuPopulationType) |
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
| startupImuOdr | uint32_t | IMU output data rate set on startup (see eImuOdr). Raised if its sample period would be larger than startupNavDtMs. IMU_ODR_DISABLED disables sensor/IMU sampling. |
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
| deadReckoningTimeout | uint8_t | (s) Time without any position, velocity, or wheel/kinematic aiding after which the INS drops from NAV to AHRS mode.  0 = never time out. |
| reserved1 | uint8_t | Reserved for future use |
| reserved2 | uint16_t | Reserved for future use |
| reserved3 | uint32_t | Reserved for future use |
| reserved4 | uint32_t | Reserved for future use |


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
| startupImuOdr | uint32_t | IMU output data rate set on startup (see eImuOdr). Raised if its sample period would be larger than startupNavDtMs. IMU_ODR_DISABLED disables sensor/IMU sampling. |
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
| deadReckoningTimeout | uint8_t | (s) Time without any position, velocity, or wheel/kinematic aiding after which the INS drops from NAV to AHRS mode.  0 = never time out. |
| reserved1 | uint8_t | Reserved for future use |
| reserved2 | uint16_t | Reserved for future use |
| reserved3 | uint32_t | Reserved for future use |
| reserved4 | uint32_t | Reserved for future use |


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


#### DID_CBOR

`cbor_msg_t`

| Field | Type | Description |
|-------|------|-------------|
| data | uint8_t[1] | CBOR map, ISB packet size bytes |


#### DID_DEV_INFO

`dev_info_t`

| Field | Type | Description |
|-------|------|-------------|
| reserved | uint8_t | Reserved bits |
| buildFlags | uint8_t | Build flags: 0x1=debug mode, 0x2=dirty (see eBuildFlags) |
| hardwareType | uint8_t | Hardware Type: 1=uINS, 2=EVB, 3=IMX, 4=GPX (see eIsHardwareType) |
| hdwRunState | uint8_t | Device Run State: Bootloader, App, etc (see eHdwRunStates) |
| serialNumber | uint32_t | Serial number |
| hardwareVer | uint8_t[3] | Hardware version: [0]=major, [1]=minor, [2]=pcb/a revision |
| hardwareVariant | uint8_t | Hardware variant; an arbitrary number independent of version that identifies some variation of the hardware; most commonly, IMU population type on IMX-6 (see eImx6ImuPopulationType) |
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
| hardwareVer | uint8_t[3] | Hardware version: [0]=major, [1]=minor, [2]=pcb/a revision |
| hardwareVariant | uint8_t | Hardware variant; an arbitrary number independent of version that identifies some variation of the hardware; most commonly, IMU population type on IMX-6 (see eImx6ImuPopulationType) |
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


#### DID_EXT_AIDING_ATTITUDE

`ext_aiding_attitude_t`

| Field | Type | Description |
|-------|------|-------------|
| timeMs | uint32_t | (ms) Time of measurement: GNSS time of week, or latency before reception, as selected by status (see eExtAidingStatus) |
| status | uint32_t | Attitude representation, 1=euler, 2=quaternion (see eExtAidingAttitudeType), plus time interpretation of timeMs (see eExtAidingStatus) |
| att | float[4] | attitude relative to NED, interpreted per `status`: euler {roll,pitch,yaw,-} or NED-to-body quaternion {w,x,y,z} |
| var | float[9] | 3x3 row-major attitude-error covariance (rad^2), about the body axes. Must have a non-zero diagonal or the observation is discarded. |


#### DID_EXT_AIDING_DIR_SPEED

`ext_aiding_dir_speed_t`

| Field | Type | Description |
|-------|------|-------------|
| timeMs | uint32_t | (ms) Time of measurement: GNSS time of week, or latency before reception, as selected by status (see eExtAidingStatus) |
| status | uint32_t | Time interpretation of timeMs (see eExtAidingStatus); other bits reserved, set to 0 |
| speed | float | speed along `direction` (m/s) |
| var | float | observation variance (m^2/s^2).  Must be non-zero or the observation is discarded. |
| offset | float[3] | point of measurement relative to IMU origin in IMU/body frame {x,y,z} (m) |
| direction | float[3] | unit vector, in IMU/body frame, along which `speed` is measured (e.g. [1,0,0] for forward-pointing airspeed) |


#### DID_EXT_AIDING_HEADING

`ext_aiding_heading_t`

| Field | Type | Description |
|-------|------|-------------|
| timeMs | uint32_t | (ms) Time of measurement: GNSS time of week, or latency before reception, as selected by status (see eExtAidingStatus) |
| status | uint32_t | Heading type, 1=true, 2=magnetic, 3=course over ground (see eExtAidingHeadingType), plus time interpretation of timeMs (see eExtAidingStatus) |
| heading | float | heading (rad), 0 = north, positive clockwise, range [-pi, pi] |
| var | float | observation variance (rad^2).  Must be non-zero or the observation is discarded. |


#### DID_EXT_AIDING_POS

`ext_aiding_pos_t`

| Field | Type | Description |
|-------|------|-------------|
| timeMs | uint32_t | (ms) Time of measurement: GNSS time of week, or latency before reception, as selected by status (see eExtAidingStatus) |
| status | uint32_t | Frame of measurement, 1=ECEF, 2=NED, plus time interpretation of timeMs (see eExtAidingStatus). Any other frame is discarded. |
| pos | double[3] | position {x,y,z} (m) |
| offset | float[3] | point of measurement relative to IMU origin in IMU/body frame {x,y,z} (m) |
| var | float[3] | observation variance, per axis, in NED (m^2).  Must be non-zero or the observation is discarded. |


#### DID_EXT_AIDING_SPEED

`ext_aiding_speed_t`

| Field | Type | Description |
|-------|------|-------------|
| timeMs | uint32_t | (ms) Time of measurement: GNSS time of week, or latency before reception, as selected by status (see eExtAidingStatus) |
| status | uint32_t | Speed type, 1=3D magnitude, 2=horizontal magnitude (see eExtAidingSpeedType), plus time interpretation of timeMs (see eExtAidingStatus) |
| speed | float | speed (m/s) |
| var | float | observation variance (m^2/s^2).  Must be non-zero or the observation is discarded. |
| offset | float[3] | point of measurement relative to IMU origin in IMU/body frame {x,y,z} (m) |


#### DID_EXT_AIDING_VEL

`ext_aiding_vel_t`

| Field | Type | Description |
|-------|------|-------------|
| timeMs | uint32_t | (ms) Time of measurement: GNSS time of week, or latency before reception, as selected by status (see eExtAidingStatus) |
| status | uint32_t | Frame of measurement, 1=ECEF, 2=NED, 3=Body, plus time interpretation of timeMs (see eExtAidingStatus). Any other frame is discarded. |
| vel | float[3] | velocity {vx,vy,vz} (m/s) |
| offset | float[3] | point of measurement relative to IMU origin in IMU/body frame {x,y,z} (m) |
| var | float[3] | observation variance, per axis, in NED (m^2/s^2).  Must be non-zero or the observation is discarded. |


#### DID_EXT_IMU

`imu_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds. Convert to GPS time of week by adding gps.towOffset |
| status | uint32_t | IMU status flags (eImuStatus) |
| I | imui_t | Combined Inertial Measurement Unit (IMU) sample: angular rate and acceleration |


#### DID_GNSS1_SIG

`gnss_sig_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| numSigs | uint32_t | Number of satellite signals in the following satellite signal list (valid entries in sig[] below) |
| sig | gnss_sig_sv_t[160] | Per-signal tracking information list |


#### DID_GNSS1_TIMESYNC

GNSS1 PPS time synchronization. 

`gnss_timesync_t`

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
| sig | gnss_sig_sv_t[160] | Per-signal tracking information list |


#### DID_GNSS2_TIMESYNC

GNSS2 PPS time synchronization. 

`gnss_timesync_t`

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
| reserved | int |  |
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
| platformType | int32_t | Platform / carrier board (ePlatformConfig::PLATFORM_CFG_TYPE_MASK). Only valid if greater than zero. Write: a negative value in a full-struct write keeps the current platform type. |
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
| sampleTaskPeriodMs | uint32_t | IMU sample task period, in milliseconds. Not the sensor sample period (see eImuOdr). Zero disables sampling. |
| navOutputPeriodMs | uint32_t | Preintegrated IMU (PIMU) integration period and navigation/AHRS filter output period, in milliseconds |
| sensorTruePeriod | double | Actual sample period relative to GNSS PPS, in seconds |
| flashCfgChecksum | uint32_t | Flash config checksum used with host SDK synchronization |
| navUpdatePeriodMs | uint32_t | Navigation/AHRS filter update period, in milliseconds |
| genFaultCode | uint32_t | General fault code descriptor (see eGenFaultCodes). Set to zero to reset fault code. |
| upTime | double | System up time, in seconds (double precision) |


#### DID_TIMEPULSE

`is_timepulse_t`

| Field | Type | Description |
|-------|------|-------------|
| week | uint32_t | GPS number of weeks since January 6th, 1980 |
| timeOfWeekMs | uint32_t | (ms) GPS time of week (since Sunday morning) of the timepulse event |
| status | uint32_t | Timepulse status flags |
| syncCnt | uint32_t | Count of timepulse sync events since power-on |
| reserved | uint32_t[4] | Reserved for future use |


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

(eGnssSatSigConst)  GNSS satellite system/signal constellation enable bits, used with nvm_flash_cfg_t.gnssSatSigConst (DID_FLASH_CONFIG). OR together the per-constellation bits (each already covers that constellation's tracked signal bands) to select which satellite systems the receiver tracks; GNSS_SAT_SIG_CONST_DEFAULT is the factory selection applied unless overridden.

| Field | Value | Description |
|-------|-------|-------------|
| GNSS_SAT_SIG_CONST_GPS | 0x0003 | GPS, all supported signals |
| GNSS_SAT_SIG_CONST_QZS | 0x000C | QZSS, all supported signals |
| GNSS_SAT_SIG_CONST_GAL | 0x0030 | Galileo, all supported signals |
| GNSS_SAT_SIG_CONST_BDS | 0x00C0 | BeiDou, all supported signals |
| GNSS_SAT_SIG_CONST_GLO | 0x0300 | GLONASS, all supported signals |
| GNSS_SAT_SIG_CONST_SBS | 0x1000 | SBAS, all supported signals |
| GNSS_SAT_SIG_CONST_IRN | 0x2000 | IRNSS / NavIC |
| GNSS_SAT_SIG_CONST_IME | 0x4000 | IMES |


#### DID_FLASH_CONFIG.sensorConfig

(eSensorConfig)  IMU/magnetometer sensor hardware configuration, used with nvm_flash_cfg_t.sensorConfig (DID_FLASH_CONFIG). Packs several small sub-fields (each with its own _MASK/_OFFSET pair) selecting gyro/accel full-scale range, gyro/accel DLPF bandwidth, IMU-to-sensor-frame mounting rotation, and disable/fault-detection flags for the magnetometer, barometer, and multi-IMU voting. Most fields require a system reset to take effect.

| Field | Value | Description |
|-------|-------|-------------|
| SENSOR_CFG_GYR_FS_250 | 0x00000000 | Gyro full-scale range: +-250 deg/s |
| SENSOR_CFG_GYR_FS_500 | 0x00000001 | Gyro full-scale range: +-500 deg/s |
| SENSOR_CFG_GYR_FS_1000 | 0x00000002 | Gyro full-scale range: +-1000 deg/s |
| SENSOR_CFG_GYR_FS_2000 | 0x00000003 | Gyro full-scale range: +-2000 deg/s |
| SENSOR_CFG_GYR_FS_4000 | 0x00000004 | Gyro full-scale range: +-4000 deg/s |
| SENSOR_CFG_GYR_FS_MAX | 0x00000007 | Gyro full-scale range: use individual sensor's max range |
| SENSOR_CFG_GYR_FS_MASK | 0x00000007 | Mask for gyro full-scale range field |
| SENSOR_CFG_GYR_FS_OFFSET |  (int)0 | Bit offset of SENSOR_CFG_GYR_FS_MASK within sensorConfig |
| SENSOR_CFG_ACC_FS_2G | 0x00000000 | Accelerometer full-scale range: +-2 g (m/s^2) |
| SENSOR_CFG_ACC_FS_4G | 0x00000001 | Accelerometer full-scale range: +-4 g (m/s^2) |
| SENSOR_CFG_ACC_FS_8G | 0x00000002 | Accelerometer full-scale range: +-8 g (m/s^2) |
| SENSOR_CFG_ACC_FS_16G | 0x00000003 | Accelerometer full-scale range: +-16 g (m/s^2) |
| SENSOR_CFG_ACC_FS_32G | 0x00000004 | Accelerometer full-scale range: +-32 g (m/s^2) |
| SENSOR_CFG_ACC_FS_MAX | 0x00000007 | Accelerometer full-scale range: use individual sensor's max range |
| SENSOR_CFG_ACC_FS_MASK | 0x00000070 | Mask for accelerometer full-scale range field |
| SENSOR_CFG_ACC_FS_OFFSET |  (int)4 | Bit offset of SENSOR_CFG_ACC_FS_MASK within sensorConfig |
| SENSOR_CFG_GYR_DLPF_250HZ | 0x00000000 | Gyro DLPF bandwidth override: 250 Hz |
| SENSOR_CFG_GYR_DLPF_184HZ | 0x00000001 | Gyro DLPF bandwidth override: 184 Hz |
| SENSOR_CFG_GYR_DLPF_92HZ | 0x00000002 | Gyro DLPF bandwidth override: 92 Hz |
| SENSOR_CFG_GYR_DLPF_41HZ | 0x00000003 | Gyro DLPF bandwidth override: 41 Hz |
| SENSOR_CFG_GYR_DLPF_20HZ | 0x00000004 | Gyro DLPF bandwidth override: 20 Hz |
| SENSOR_CFG_GYR_DLPF_10HZ | 0x00000005 | Gyro DLPF bandwidth override: 10 Hz |
| SENSOR_CFG_GYR_DLPF_5HZ | 0x00000006 | Gyro DLPF bandwidth override: 5 Hz |
| SENSOR_CFG_GYR_DLPF_MASK | 0x00000F00 | Mask for gyro DLPF bandwidth field |
| SENSOR_CFG_GYR_DLPF_OFFSET |  (int)8 | Bit offset of SENSOR_CFG_GYR_DLPF_MASK within sensorConfig |
| SENSOR_CFG_ACC_DLPF_218HZ | 0x00000000 | Accelerometer DLPF bandwidth override: 218 Hz |
| SENSOR_CFG_ACC_DLPF_218HZb | 0x00000001 | Accelerometer DLPF bandwidth override: 218 Hz (alternate register value) |
| SENSOR_CFG_ACC_DLPF_99HZ | 0x00000002 | Accelerometer DLPF bandwidth override: 99 Hz |
| SENSOR_CFG_ACC_DLPF_45HZ | 0x00000003 | Accelerometer DLPF bandwidth override: 45 Hz |
| SENSOR_CFG_ACC_DLPF_21HZ | 0x00000004 | Accelerometer DLPF bandwidth override: 21 Hz |
| SENSOR_CFG_ACC_DLPF_10HZ | 0x00000005 | Accelerometer DLPF bandwidth override: 10 Hz |
| SENSOR_CFG_ACC_DLPF_5HZ | 0x00000006 | Accelerometer DLPF bandwidth override: 5 Hz |
| SENSOR_CFG_ACC_DLPF_MASK | 0x0000F000 | Mask for accelerometer DLPF bandwidth field |
| SENSOR_CFG_ACC_DLPF_OFFSET |  (int)12 | Bit offset of SENSOR_CFG_ACC_DLPF_MASK within sensorConfig |
| SENSOR_CFG_SENSOR_ROTATION_MASK | 0x001F0000 | Mask for IMU/magnetometer mounting rotation field |
| SENSOR_CFG_SENSOR_ROTATION_OFFSET |  (int)16 | Bit offset of SENSOR_CFG_SENSOR_ROTATION_MASK within sensorConfig |
| SENSOR_CFG_SENSOR_ROTATION_0_0_0 |  (int)0 | Mounting rotation (roll, pitch, yaw deg): 0, 0, 0 |
| SENSOR_CFG_SENSOR_ROTATION_0_0_90 |  (int)1 | Mounting rotation (roll, pitch, yaw deg): 0, 0, 90 |
| SENSOR_CFG_SENSOR_ROTATION_0_0_180 |  (int)2 | Mounting rotation (roll, pitch, yaw deg): 0, 0, 180 |
| SENSOR_CFG_SENSOR_ROTATION_0_0_N90 |  (int)3 | Mounting rotation (roll, pitch, yaw deg): 0, 0, -90 |
| SENSOR_CFG_SENSOR_ROTATION_90_0_0 |  (int)4 | Mounting rotation (roll, pitch, yaw deg): 90, 0, 0 |
| SENSOR_CFG_SENSOR_ROTATION_90_0_90 |  (int)5 | Mounting rotation (roll, pitch, yaw deg): 90, 0, 90 |
| SENSOR_CFG_SENSOR_ROTATION_90_0_180 |  (int)6 | Mounting rotation (roll, pitch, yaw deg): 90, 0, 180 |
| SENSOR_CFG_SENSOR_ROTATION_90_0_N90 |  (int)7 | Mounting rotation (roll, pitch, yaw deg): 90, 0, -90 |
| SENSOR_CFG_SENSOR_ROTATION_180_0_0 |  (int)8 | Mounting rotation (roll, pitch, yaw deg): 180, 0, 0 |
| SENSOR_CFG_SENSOR_ROTATION_180_0_90 |  (int)9 | Mounting rotation (roll, pitch, yaw deg): 180, 0, 90 |
| SENSOR_CFG_SENSOR_ROTATION_180_0_180 |  (int)10 | Mounting rotation (roll, pitch, yaw deg): 180, 0, 180 |
| SENSOR_CFG_SENSOR_ROTATION_180_0_N90 |  (int)11 | Mounting rotation (roll, pitch, yaw deg): 180, 0, -90 |
| SENSOR_CFG_SENSOR_ROTATION_N90_0_0 |  (int)12 | Mounting rotation (roll, pitch, yaw deg): -90, 0, 0 |
| SENSOR_CFG_SENSOR_ROTATION_N90_0_90 |  (int)13 | Mounting rotation (roll, pitch, yaw deg): -90, 0, 90 |
| SENSOR_CFG_SENSOR_ROTATION_N90_0_180 |  (int)14 | Mounting rotation (roll, pitch, yaw deg): -90, 0, 180 |
| SENSOR_CFG_SENSOR_ROTATION_N90_0_N90 |  (int)15 | Mounting rotation (roll, pitch, yaw deg): -90, 0, -90 |
| SENSOR_CFG_SENSOR_ROTATION_0_90_0 |  (int)16 | Mounting rotation (roll, pitch, yaw deg): 0, 90, 0 |
| SENSOR_CFG_SENSOR_ROTATION_0_90_90 |  (int)17 | Mounting rotation (roll, pitch, yaw deg): 0, 90, 90 |
| SENSOR_CFG_SENSOR_ROTATION_0_90_180 |  (int)18 | Mounting rotation (roll, pitch, yaw deg): 0, 90, 180 |
| SENSOR_CFG_SENSOR_ROTATION_0_90_N90 |  (int)19 | Mounting rotation (roll, pitch, yaw deg): 0, 90, -90 |
| SENSOR_CFG_SENSOR_ROTATION_0_N90_0 |  (int)20 | Mounting rotation (roll, pitch, yaw deg): 0, -90, 0 |
| SENSOR_CFG_SENSOR_ROTATION_0_N90_90 |  (int)21 | Mounting rotation (roll, pitch, yaw deg): 0, -90, 90 |
| SENSOR_CFG_SENSOR_ROTATION_0_N90_180 |  (int)22 | Mounting rotation (roll, pitch, yaw deg): 0, -90, 180 |
| SENSOR_CFG_SENSOR_ROTATION_0_N90_N90 |  (int)23 | Mounting rotation (roll, pitch, yaw deg): 0, -90, -90 |
| SENSOR_CFG_DISABLE_MAGNETOMETER | 0x00400000 | Disable magnetometer sensor (sensorConfig[22]) |
| SENSOR_CFG_DISABLE_BAROMETER | 0x00800000 | Disable barometer sensor (sensorConfig[23]) |
| SENSOR_CFG_IMU_FAULT_DETECT_MASK | 0xFF000000 | Mask for multiple-IMU fault detection level field. Higher levels add new features to previous levels. |
| SENSOR_CFG_IMU_FAULT_DETECT_GYR | 0x01000000 | Enable multiple IMU gyro fault detection. Must be enabled for other gyro detection modes (offline, large bias, and noise). |
| SENSOR_CFG_IMU_FAULT_DETECT_ACC | 0x02000000 | Enable multiple IMU accelerometer fault detection. Must be enabled for other accel detection modes (offline, large bias, and noise). |
| SENSOR_CFG_IMU_FAULT_DETECT_OFFLINE | 0x04000000 | (Disabled/reserved, would be (int)0x04000000) One or more IMUs is offline or stuck |
| SENSOR_CFG_IMU_FAULT_DETECT_LARGE_BIAS | 0x08000000 | (Disabled/reserved, would be (int)0x08000000) IMU large-bias fault detection |
| SENSOR_CFG_IMU_FAULT_DETECT_SENSOR_NOISE | 0x10000000 | (Disabled/reserved, would be (int)0x10000000) IMU excessive-noise fault detection |


#### DID_FLASH_CONFIG.startupImuOdr

(eImuOdr)  IMU output data rate (ODR), used with nvm_flash_cfg_t.startupImuOdr (DID_FLASH_CONFIG). Each IMU runs at its supported ODR nearest the nominal rate (exactly the nominal rate on the LSM6DSV). Each value lists its sensor sample period, the time between IMU samples (1 / ODR). This differs from the firmware sample task period (DID_SYS_PARAMS.sampleTaskPeriodMs, see IMU_ODR_TASK_PERIOD_MS()), which is 1 ms for rates of 1 kHz and above, processing every IMU sample where the hardware supports it (IMX-6), and the sensor sample period below 1 kHz.

| Field | Value | Description |
|-------|-------|-------------|
| IMU_ODR_DISABLED | 0 | IMU sampling disabled |
| IMU_ODR_2000HZ | 1 | 2 kHz, 0.5 ms sample period (default) |
| IMU_ODR_1000HZ | 2 | 1 kHz, 1 ms sample period |
| IMU_ODR_500HZ | 3 | 500 Hz, 2 ms sample period |
| IMU_ODR_250HZ | 4 | 250 Hz, 4 ms sample period |
| IMU_ODR_125HZ | 5 | 125 Hz, 8 ms sample period |
| IMU_ODR_62_5HZ | 6 | 62.5 Hz, 16 ms sample period |
| IMU_ODR_31_25HZ | 7 | 31.25 Hz, 32 ms sample period |
| IMU_ODR_15_625HZ | 8 | 15.625 Hz, 64 ms sample period |
| IMU_ODR_4000HZ | 9 | 4 kHz, 0.25 ms sample period. Compared with 2 kHz, doubles the accelerometer bandwidth (ODR/4, 1 kHz) and moves the anti-aliasing margin well above the gyro's fixed bandwidth (about 500 Hz, the same at either rate), so vibration between 1 and 2 kHz is filtered instead of aliasing into the solution. Consider it for platforms with strong high-frequency vibration (engines, rotors, motors) or when accelerometer content above 500 Hz is needed. Costs about twice the sample processing of 2 kHz, and DID_IMUS_RAW output at this rate needs a high-bandwidth port. |
| IMU_ODR_8000HZ | 10 | 8 kHz, 0.125 ms sample period (requires high-bandwidth communication port to prevent data loss) |


#### DID_FLASH_CONFIG.sysCfgBits

(eSysConfigBits)  System configuration bitflags, used with nvm_flash_cfg_t.sysCfgBits (DID_FLASH_CONFIG). OR these bits together to disable/enable EKF sensor fusion sources, mag calibration behavior, automatic zero-velocity/zero-rate updates, BIT-on-startup, and brownout reset threshold. Written to flash and applied on the next reset.

| Field | Value | Description |
|-------|-------|-------------|
| UNUSED1 | 0x00000001 | Unused/reserved bit |
| SYS_CFG_BITS_ENABLE_MAG_CONTINUOUS_CAL | 0x00000002 | Enable mag continuous calibration. Allow slow background magnetometer calibration in the EKF. |
| SYS_CFG_BITS_AUTO_MAG_RECAL | 0x00000004 | Enable automatic mag recalibration |
| SYS_CFG_BITS_DISABLE_MAG_DECL_ESTIMATION | 0x00000008 | Disable mag declination estimation |
| SYS_CFG_BITS_DISABLE_LEDS | 0x00000010 | Disable LEDs |
| SYS_CFG_BITS_MAG_RECAL_MODE_MASK | 0x00000700 | Magnetometer recalibration mode mask. (see eMagCalState) 1 = multi-axis, 2 = single-axis |
| SYS_CFG_BITS_MAG_RECAL_MODE_OFFSET | 8 | Bit offset of SYS_CFG_BITS_MAG_RECAL_MODE_MASK within sysCfgBits |
| SYS_CFG_BITS_MAG_ENABLE_WMM_DECLINATION | 0x00000800 | When set, World Magnetic Model (WMM) will be used to set mag declination |
| SYS_CFG_BITS_DISABLE_MAGNETOMETER_FUSION | 0x00001000 | Disable magnetometer fusion |
| SYS_CFG_BITS_DISABLE_BAROMETER_FUSION | 0x00002000 | Disable barometer fusion |
| SYS_CFG_BITS_DISABLE_GNSS1_FUSION | 0x00004000 | Disable GNSS 1 fusion |
| SYS_CFG_BITS_DISABLE_GNSS2_FUSION | 0x00008000 | Disable GNSS 2 fusion |
| SYS_CFG_BITS_DISABLE_AUTO_ZERO_VELOCITY_UPDATES | 0x00010000 | Disable automatic Zero Velocity Updates (ZUPT). Useful for degraded GNSS environments or applications with very slow velocities. |
| SYS_CFG_BITS_DISABLE_AUTO_ZERO_ANGULAR_RATE_UPDATES | 0x00020000 | Disable automatic Zero Angular Rate Updates (ZARU). Useful for applications with small/slow angular rates. |
| SYS_CFG_BITS_DISABLE_INS_EKF | 0x00040000 | Disable INS EKF updates |
| SYS_CFG_BITS_DISABLE_AUTO_BIT_ON_STARTUP | 0x00080000 | Prevent built-in test (BIT) from running automatically on startup |
| SYS_CFG_BITS_DISABLE_WHEEL_ENCODER_FUSION | 0x00100000 | Disable wheel encoder fusion |
| SYS_CFG_BITS_ENABLE_GNSS_ANTENNA_OFFSET_ESTIMATION | 0x00200000 | Enable rover GNSS antenna offset estimation in RTK compassing mode |
| SYS_CFG_BITS_BOR_LEVEL_0 | 0x0 | Brownout reset threshold: 1.65 - 1.75 V (default) |
| SYS_CFG_BITS_BOR_LEVEL_1 | 0x1 | Brownout reset threshold: 2.0 - 2.1 V |
| SYS_CFG_BITS_BOR_LEVEL_2 | 0x2 | Brownout reset threshold: 2.25 - 2.35 V |
| SYS_CFG_BITS_BOR_LEVEL_3 | 0x3 | Brownout reset threshold: 2.5 - 2.6 V |
| SYS_CFG_BITS_BOR_THRESHOLD_MASK | 0x00C00000 | Mask for brownout reset threshold voltage level field |
| SYS_CFG_BITS_BOR_THRESHOLD_OFFSET | 22 | Bit offset of SYS_CFG_BITS_BOR_THRESHOLD_MASK within sysCfgBits |
| SYS_CFG_USE_REFERENCE_IMU_IN_EKF | 0x01000000 | Use reference IMU in EKF instead of onboard IMU |
| SYS_CFG_EKF_REF_POINT_STATIONARY_ON_STROBE_INPUT | 0x02000000 | Reference point stationary on strobe input |


#### DID_GPX_FLASH_CFG.sysCfgBits

(eGpxSysConfigBits)  GPX system configuration bits, used with DID_GPX_FLASH_CFG::sysCfgBits (gpx_flash_cfg_t.sysCfgBits). Controls VCC_RF power switching and the brownout reset threshold. GPX_SYS_CFG_BITS_BOR_LEVEL_x are raw 2-bit codes (0-3), not pre-shifted bit flags -- shift the desired code left by GPX_SYS_CFG_BITS_BOR_THRESHOLD_OFFSET and mask with GPX_SYS_CFG_BITS_BOR_THRESHOLD_MASK before ORing it into sysCfgBits.

| Field | Value | Description |
|-------|-------|-------------|
| GPX_SYS_CFG_BITS_DISABLE_VCC_RF | 0x00000001 | Disable (tri-state) VCC_RF (GPX pin 16) output supplied via VAUX (GPX pin 40) |
| GPX_SYS_CFG_BITS_EXT_AIDING_LATENCY | 0x00000002 |
| GPX_SYS_CFG_BITS_BOR_LEVEL_0 | 0x0 | Brownout reset threshold voltage level: 1.65 - 1.75 V (default) |
| GPX_SYS_CFG_BITS_BOR_LEVEL_1 | 0x1 | Brownout reset threshold voltage level: 2.0 - 2.1 V |
| GPX_SYS_CFG_BITS_BOR_LEVEL_2 | 0x2 | Brownout reset threshold voltage level: 2.25 - 2.35 V |
| GPX_SYS_CFG_BITS_BOR_LEVEL_3 | 0x3 | Brownout reset threshold voltage level: 2.5 - 2.6 V |
| GPX_SYS_CFG_BITS_BOR_THRESHOLD_MASK | 0x00C00000 | Mask for the brownout reset threshold field, once shifted into position within sysCfgBits |
| GPX_SYS_CFG_BITS_BOR_THRESHOLD_OFFSET | 22 | Bit offset of GPX_SYS_CFG_BITS_BOR_THRESHOLD_MASK within sysCfgBits |


#### DID_GPX_STATUS.hdwStatus

(eGPXHdwStatusFlags)  (DID_GPX_STATUS) GPX hardware status flags, reported in gpx_status_t.hdwStatus. Reports per-GNSS-receiver signal/time/reset/init health, communications and PPS timing errors, CNO (carrier-to-noise) signal quality errors, built-in self-test (BIT) progress, temperature, and the cause of the last system reset. GPX_HDW_STATUS_ERROR_MASK ORs together the sub-fields considered indicative of an error condition for quick fault checks.

| Field | Value | Description |
|-------|-------|-------------|
| GPX_HDW_STATUS_GNSS1_SATELLITE_RX | 0x00000001 | GNSS1 satellite signals are being received (antenna and cable are good) |
| GPX_HDW_STATUS_GNSS2_SATELLITE_RX | 0x00000002 | GNSS2 satellite signals are being received (antenna and cable are good) |
| GPX_HDW_STATUS_GNSS1_TIME_OF_WEEK_VALID | 0x00000004 | GPS time of week is valid and reported for GNSS1. Otherwise the timeOfWeek is local system time. |
| GPX_HDW_STATUS_GNSS2_TIME_OF_WEEK_VALID | 0x00000008 | GPS time of week is valid and reported for GNSS2. Otherwise the timeOfWeek is local system time. |
| GPX_HDW_STATUS_GNSS1_RESET_COUNT_MASK | 0x00000070 | Mask for the GNSS1 reset-required count field |
| GPX_HDW_STATUS_GNSS1_RESET_COUNT_OFFSET | 4 | Bit offset of GPX_HDW_STATUS_GNSS1_RESET_COUNT_MASK within hdwStatus |
| GPX_HDW_STATUS_FAULT_GNSS1_INIT | 0x00000080 | Failed to communicate or setup GNSS receiver 1 |
| GPX_HDW_STATUS_GNSS1_FAULT_FLAG_OFFSET | 7 | Bit offset of GPX_HDW_STATUS_FAULT_GNSS1_INIT within hdwStatus |
| GPX_HDW_STATUS_GNSS2_RESET_COUNT_MASK | 0x00000700 | Mask for the GNSS2 reset-required count field |
| GPX_HDW_STATUS_GNSS2_RESET_COUNT_OFFSET | 8 | Bit offset of GPX_HDW_STATUS_GNSS2_RESET_COUNT_MASK within hdwStatus |
| GPX_HDW_STATUS_FAULT_GNSS2_INIT | 0x00000800 | Failed to communicate or setup GNSS receiver 2 |
| GPX_HDW_STATUS_GNSS2_FAULT_FLAG_OFFSET | 11 | Bit offset of GPX_HDW_STATUS_FAULT_GNSS2_INIT within hdwStatus |
| GPX_HDW_STATUS_GNSS_FW_UPDATE_REQUIRED | 0x00001000 | GNSS is faulting; firmware update REQUIRED |
| GPX_HDW_STATUS_LED_ENABLED | 0x00002000 | Enables LED in Manufacturing TBed |
| GPX_HDW_STATUS_SYSTEM_RESET_REQUIRED | 0x00004000 | System reset is required for proper function |
| GPX_HDW_STATUS_FLASH_WRITE_PENDING | 0x00008000 | System flash write staging or occurring now. Processor will pause and not respond during a flash write, typically 150-250 ms. |
| GPX_HDW_STATUS_ERR_COM_TX_LIMITED | 0x00010000 | Communications Tx buffer limited |
| GPX_HDW_STATUS_ERR_COM_RX_OVERRUN | 0x00020000 | Communications Rx buffer overrun |
| GPX_HDW_STATUS_ERR_COM_MASK | 0x00030000 | Communications error mask |
| GPX_HDW_STATUS_ERR_NO_GNSS1_PPS | 0x00040000 | GNSS1 PPS timepulse signal has not been received or is in error |
| GPX_HDW_STATUS_ERR_NO_GNSS2_PPS | 0x00080000 | GNSS2 PPS timepulse signal has not been received or is in error |
| GPX_HDW_STATUS_ERR_PPS_MASK | 0x000C0000 | GNSS PPS error mask |
| GPX_HDW_STATUS_ERR_LOW_CNO_GNSS1 | 0x00100000 | GNSS1 signal strength low (<20) |
| GPX_HDW_STATUS_ERR_LOW_CNO_GNSS2 | 0x00200000 | GNSS2 signal strength low (<20) |
| GPX_HDW_STATUS_ERR_CNO_GNSS1_IR | 0x00400000 | GNSS1 signal irregular. High CNO standard deviation over 5 second period detected. 10x CNO mean sigma (i.e. >1.0 dBHz) |
| GPX_HDW_STATUS_ERR_CNO_GNSS2_IR | 0x00800000 | GNSS2 signal irregular. High CNO standard deviation over 5 second period detected. 10x CNO mean sigma (i.e. >1.0 dBHz) |
| GPX_HDW_STATUS_ERR_CNO_MASK | 0x00F00000 | GNSS signal error mask |
| GPX_HDW_STATUS_BIT_RUNNING | 0x01000000 | (BIT) Built-in self-test running |
| GPX_HDW_STATUS_BIT_PASSED | 0x02000000 | (BIT) Built-in self-test passed |
| GPX_HDW_STATUS_BIT_FAULT | 0x03000000 | (BIT) Built-in self-test failure |
| GPX_HDW_STATUS_BIT_MASK | 0x03000000 | (BIT) Built-in self-test mask |
| GPX_HDW_STATUS_BIT_OFFSET | 24 | (BIT) Built-in self-test offset |
| GPX_HDW_STATUS_ERR_TEMPERATURE | 0x04000000 | Temperature outside spec'd operating range |
| GPX_HDW_STATUS_GNSS_PPS_TIMESYNC | 0x08000000 | Time synchronized by GNSS PPS |
| GPX_HDW_STATUS_RESET_CAUSE_MASK | 0x70000000 | Mask for the cause-of-system-reset field |
| GPX_HDW_STATUS_RESET_CAUSE_BACKUP_MODE | 0x10000000 | Reset from Backup mode (low-power state w/ CPU off) |
| GPX_HDW_STATUS_RESET_CAUSE_SOFT | 0x20000000 | Reset from Software |
| GPX_HDW_STATUS_RESET_CAUSE_HDW | 0x40000000 | Reset from Hardware (NRST pin low) |
| GPX_HDW_STATUS_FAULT_SYS_CRITICAL | 0x80000000 | Critical System Fault, CPU error. (see DID_GPX_STATUS.status, eGpxStatus::GPX_STATUS_FATAL_MASK) |


#### DID_GPX_STATUS.rtkMode

(eRTKConfigBits)  RTK positioning, compassing, and base-station configuration bitflags, used with nvm_flash_cfg_t.RTKCfgBits (DID_FLASH_CONFIG). Selects rover mode (precision positioning vs. dual-GNSS compassing), and independently configures the device to act as an RTK base station broadcasting ublox/RTCM3 correction data from GNSS1 and/or GNSS2 out any combination of serial ports, USB, or the "current" port. OR the desired bits together; RTK_CFG_BITS_ROVER_MODE_MASK and RTK_CFG_BITS_BASE_MODE isolate the rover-mode and base-mode sub-fields respectively.

| Field | Value | Description |
|-------|-------|-------------|
| RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING_DEPRECATED | 0x00000001 | Enable onboard RTK GNSS precision positioning (GNSS1) DEPRECATED |
| RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING | 0x00000002 | Enable external RTK GNSS positioning (GNSS1) |
| RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING | 0x00000004 | Enable dual GNSS RTK compassing (GNSS2 to GNSS1) |
| RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING_DEPRECATED | 0x00000008 | Enable dual GNSS RTK compassing (GNSS2 to GNSS1) DEPRECATED |
| RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING_MASK | (RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING\|RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING_DEPRECATED\) | Mask of RTK GNSS positioning types |
| RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING_MASK | (RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING\|RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING_DEPRECATED\) | Mask of dual GNSS RTK compassing types |
| RTK_CFG_BITS_ROVER_MODE_MASK | 0x0000000F | Mask of RTK position, heading, and base modes |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_UBLOX_SER0 | 0x00000010 | Enable RTK base and output ublox data from GNSS 1 on serial port 0 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_UBLOX_SER1 | 0x00000020 | Enable RTK base and output ublox data from GNSS 1 on serial port 1 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_UBLOX_SER2 | 0x00000040 | Enable RTK base and output ublox data from GNSS 1 on serial port 2 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_UBLOX_USB | 0x00000080 | Enable RTK base and output ublox data from GNSS 1 on USB port |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_SER0 | 0x00000100 | Enable RTK base and output RTCM3 data from GNSS 1 on serial port 0 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_SER1 | 0x00000200 | Enable RTK base and output RTCM3 data from GNSS 1 on serial port 1 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_SER2 | 0x00000400 | Enable RTK base and output RTCM3 data from GNSS 1 on serial port 2 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_USB | 0x00000800 | Enable RTK base and output RTCM3 data from GNSS 1 on USB port |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_UBLOX_SER0 | 0x00001000 | Enable RTK base and output ublox data from GNSS 2 on serial port 0 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_UBLOX_SER1 | 0x00002000 | Enable RTK base and output ublox data from GNSS 2 on serial port 1 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_UBLOX_SER2 | 0x00004000 | Enable RTK base and output ublox data from GNSS 2 on serial port 2 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_UBLOX_USB | 0x00008000 | Enable RTK base and output ublox data from GNSS 2 on USB port |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_SER0 | 0x00010000 | Enable RTK base and output RTCM3 data from GNSS 2 on serial port 0 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_SER1 | 0x00020000 | Enable RTK base and output RTCM3 data from GNSS 2 on serial port 1 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_SER2 | 0x00040000 | Enable RTK base and output RTCM3 data from GNSS 2 on serial port 2 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_USB | 0x00080000 | Enable RTK base and output RTCM3 data from GNSS 2 on USB port |
| RTK_CFG_BITS_BASE_POS_MOVING | 0x00100000 | Enable base mode moving position. (For future use. Not implemented. This bit should always be 0 for now.) TODO: Implement moving base. |
| RTK_CFG_BITS_RESERVED1 | 0x00200000 | Reserved for future use |
| RTK_CFG_BITS_RTK_BASE_IS_IDENTICAL_TO_ROVER | 0x00400000 | When using RTK, specifies whether the base station is identical hardware to this rover. If so, optimizations are enabled to get fix faster. |
| RTK_CFG_BITS_GNSS_PORT_PASS_THROUGH | 0x00800000 | Forward all messages between the selected GNSS and serial port. Disable for RTK base use (to forward only GNSS raw messages and use the surveyed location refLLA instead of current GNSS position). |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_CUR_PORT | 0x01000000 | Enable RTK base and output RTCM3 data from GNSS 1 on the current serial port |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_CUR_PORT | 0x02000000 | Enable RTK base and output RTCM3 data from GNSS 2 on the current serial port |
| RTK_CFG_BITS_BASE_OUTPUT_RTCM3_CLEAR_CUR_PORT | 0x04000000 | If this bit is set in conjunction with setting the current port, this clears the current port |
| RTK_CFG_BITS_MULTIPATH_MITIGATION | 0x08000000 | Enable multipath detection and mitigation in RTK solutiion |
| RTK_CFG_BITS_BASE_OUTPUT_RTCM3_CUR_PORT_MASK | (RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_CUR_PORT\|RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_CUR_PORT\) | Mask of RTK base and output RTCM3 data on the current serial ports |
| RTK_CFG_BITS_BASE_UBLOX_MASK | (RTK_CFG_BITS_BASE_GNSS1_UBLOX_MASK\|RTK_CFG_BITS_BASE_GNSS2_UBLOX_MASK\) | Mask of all ublox base-output bits, both GNSS receivers |
| RTK_CFG_BITS_BASE_RTCM3_MASK | (RTK_CFG_BITS_BASE_GNSS1_RTCM3_MASK\|RTK_CFG_BITS_BASE_GNSS2_RTCM3_MASK\) | Mask of all RTCM3 base-output bits, both GNSS receivers |
| RTK_CFG_BITS_BASE_MODE | (RTK_CFG_BITS_BASE_UBLOX_MASK\|RTK_CFG_BITS_BASE_RTCM3_MASK\) | All base station bits |
| RTK_CFG_BITS_ROVER_MODE_ONBOARD_MASK | (RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING_DEPRECATED\|RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING_DEPRECATED\) | Mask selecting the deprecated onboard RTK engine rover modes |
| RTK_CFG_BITS_ALL_MODES_MASK | (RTK_CFG_BITS_ROVER_MODE_MASK\|RTK_CFG_BITS_BASE_MODE\) | Mask of Rover, Compassing, and Base modes |


#### DID_GPX_STATUS.status

(eGpxStatus)  (DID_GPX_STATUS) GPX status flags, reported in gpx_status_t.status. Packs a communications parse-error counter, per-port Rx-traffic-detected flags, an update-confirmed flag, and a general fault region (bits 16-31) covering RTK/GNSS/RTOS/DMA fault flags plus a fatal-fault sub-field (GPX_STATUS_FATAL_MASK) that reports the specific cause the last time a critical CPU reset occurred. GPX_STATUS_FATAL_RESET_LOW_POW..GPX_STATUS_FATAL_UNKNOWN are raw cause codes, not individual bit flags -- shift the code left by GPX_STATUS_FATAL_OFFSET and mask with GPX_STATUS_FATAL_MASK to read/write the sub-field.

| Field | Value | Description |
|-------|-------|-------------|
| GPX_STATUS_COM_PARSE_ERR_COUNT_MASK | 0x0000000F | Mask for the communications parse error count field |
| GPX_STATUS_COM_PARSE_ERR_COUNT_OFFSET | 0 | Bit offset of GPX_STATUS_COM_PARSE_ERR_COUNT_MASK within status |
| GPX_STATUS_COM0_RX_TRAFFIC_DETECTED | 0x00000010 | Rx communications detected on serial port 0 in the last 30 seconds |
| GPX_STATUS_COM1_RX_TRAFFIC_DETECTED | 0x00000020 | Rx communications detected on serial port 1 in the last 30 seconds |
| GPX_STATUS_COM2_RX_TRAFFIC_DETECTED | 0x00000040 | Rx communications detected on serial port 2 in the last 30 seconds |
| GPX_STATUS_USB_RX_TRAFFIC_DETECTED | 0x00000080 | Rx communications detected on USB in the last 30 seconds |
| GPX_STATUS_UPDATE_CONFIRMED | 0x00000100 | Update confirmed |
| GPX_STATUS_GENERAL_FAULT_MASK | 0xFFDF0000 | Mask covering all general fault bits (RTK/GNSS/RTOS/DMA faults and the fatal sub-field)        // GPX_STATUS_FAULT_RTOS_TASK_PERIOD_OVERRUN excluded to prevent RTOS task period overrun false positives. WHJ |
| GPX_STATUS_FAULT_RTK_QUEUE_LIMITED | 0x00010000 | RTK buffer filled causing data loss |
| GPX_STATUS_FAULT_GNSS_RCVR_TIME | 0x00100000 | GNSS receiver time fault |
| GPX_STATUS_FAULT_RTOS_TASK_PERIOD_OVERRUN | 0x00200000 | RTOS task period overrun |
| GPX_STATUS_FAULT_DMA | 0x00800000 | DMA fault detected |
| GPX_STATUS_FATAL_MASK | 0x1F000000 | Mask for the fatal-fault cause sub-field (critical failure resulting in CPU reset), once shifted into position within status |
| GPX_STATUS_FATAL_OFFSET | 24 | Bit offset of GPX_STATUS_FATAL_MASK within status |
| GPX_STATUS_FATAL_RESET_LOW_POW |  (int)1 | Fatal cause: reset from low power |
| GPX_STATUS_FATAL_RESET_BROWN |  (int)2 | Fatal cause: reset from brown out |
| GPX_STATUS_FATAL_RESET_WATCHDOG |  (int)3 | Fatal cause: reset from watchdog |
| GPX_STATUS_FATAL_CPU_EXCEPTION |  (int)4 | Fatal cause: CPU exception |
| GPX_STATUS_FATAL_UNHANDLED_INTERRUPT |  (int)5 | Fatal cause: unhandled interrupt |
| GPX_STATUS_FATAL_STACK_OVERFLOW |  (int)6 | Fatal cause: stack overflow |
| GPX_STATUS_FATAL_KERNEL_OOPS |  (int)7 | Fatal cause: kernel oops |
| GPX_STATUS_FATAL_KERNEL_PANIC |  (int)8 | Fatal cause: kernel panic |
| GPX_STATUS_FATAL_UNALIGNED_ACCESS |  (int)9 | Fatal cause: unaligned memory access |
| GPX_STATUS_FATAL_MEMORY_ERROR |  (int)10 | Fatal cause: memory error |
| GPX_STATUS_FATAL_BUS_ERROR |  (int)11 | Fatal cause: bus error (bad pointer or malloc) |
| GPX_STATUS_FATAL_USAGE_ERROR |  (int)12 | Fatal cause: usage error |
| GPX_STATUS_FATAL_DIV_ZERO |  (int)13 | Fatal cause: divide by zero |
| GPX_STATUS_FATAL_SER0_REINIT |  (int)14 | Fatal cause: serial port 0 re-initialization |
| GPX_STATUS_FATAL_UNKNOWN | 0x1F | Fatal cause: unknown. TODO: Temporarily set to (5 bits). Reset to 0xFF when gpx_flash_cfg.debug is no longer used with fault reporting. (WHJ) |
| GPX_STATUS_FAULT_RP | 0x20000000 | Internal use |
| GPX_STATUS_FAULT_UNUSED | 0xC0000000 | Reserved for future fault status |


#### DID_SYS_CMD.command

(eSystemCommand)  Command codes for system_command_t.command (DID_SYS_CMD). The paired invCommand value (shown in parens as "inv") is the bitwise inverse of command and must be sent in the same write for the command to be processed.

| Field | Value | Description |
|-------|-------|-------------|
| SYS_CMD_NONE | 0 | No command (uint32 inv: 4294967295) |
| SYS_CMD_SAVE_PERSISTENT_MESSAGES | 1 | Save current persistent messages (uint32 inv: 4294967294) |
| SYS_CMD_ENABLE_BOOTLOADER_AND_RESET | 2 | Enable bootloader and reset (uint32 inv: 4294967293) |
| SYS_CMD_ENABLE_SENSOR_STATS | 3 | Enable sensor stats collection (uint32 inv: 4294967292) |
| SYS_CMD_ENABLE_RTOS_STATS | 4 | Enable RTOS task stats collection (uint32 inv: 4294967291) |
| SYS_CMD_ZERO_MOTION | 5 | Zero motion (stationary) command, used to aid the EKF (uint32 inv: 4294967290) |
| SYS_CMD_REF_POINT_STATIONARY | 6 | Mark reference/truth input as stationary, for calibration (uint32 inv: 4294967289) |
| SYS_CMD_REF_POINT_MOVING | 7 | Mark reference/truth input as moving, for calibration (uint32 inv: 4294967288) |
| SYS_CMD_RESET_RTOS_STATS | 8 | Reset RTOS task stats (uint32 inv: 4294967287) |
| SYS_CMD_ENABLE_GNSS_LOW_LEVEL_CONFIG | 10 | Enable GNSS low level (chipset-specific) configuration (uint32 inv: 4294967285) |
| SYS_CMD_DISABLE_SERIAL_PORT_BRIDGE | 11 | Disable serial port bridge (uint32 inv: 4294967284) |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_USB_TO_GNSS1 | 12 | Enable serial port bridge: USB to GNSS1 (uint32 inv: 4294967283) |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_USB_TO_GNSS2 | 13 | Enable serial port bridge: USB to GNSS2 (uint32 inv: 4294967282) |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_USB_TO_SER0 | 14 | Enable serial port bridge: USB to SER0 (uint32 inv: 4294967281) |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_USB_TO_SER1 | 15 | Enable serial port bridge: USB to SER1 (uint32 inv: 4294967280) |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_USB_TO_SER2 | 16 | Enable serial port bridge: USB to SER2 (uint32 inv: 4294967279) |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_SER0_TO_GNSS1 | 17 | Enable serial port bridge: SER0 to GNSS1 (uint32 inv: 4294967278) |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_CUR_PORT_TO_GNSS1 | 18 | Enable serial port bridge: current port to GNSS1 (uint32 inv: 4294967277) |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_CUR_PORT_TO_GNSS2 | 19 | Enable serial port bridge: current port to GNSS2 (uint32 inv: 4294967276) |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_CUR_PORT_TO_USB | 20 | Enable serial port bridge: current port to USB (uint32 inv: 4294967275) |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_CUR_PORT_TO_SER0 | 21 | Enable serial port bridge: current port to SER0 (uint32 inv: 4294967274) |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_CUR_PORT_TO_SER1 | 22 | Enable serial port bridge: current port to SER1 (uint32 inv: 4294967273) |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_CUR_PORT_TO_SER2 | 23 | Enable serial port bridge: current port to SER2 (uint32 inv: 4294967272) |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_USB_LOOPBACK | 24 | Enable serial port bridge: USB loopback (uint32 inv: 4294967271) |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_SER0_LOOPBACK | 25 | Enable serial port bridge: SER0 loopback (uint32 inv: 4294967270) |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_SER1_LOOPBACK | 26 | Enable serial port bridge: SER1 loopback (uint32 inv: 4294967269) |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_SER2_LOOPBACK | 27 | Enable serial port bridge: SER2 loopback (uint32 inv: 4294967268) |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_CUR_PORT_LOOPBACK | 28 | Enable serial port bridge: current port loopback (uint32 inv: 4294967267) |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_CUR_PORT_LOOPBACK_TESTMODE | 29 | Enable serial port bridge: current port loopback, driver test mode (uint32 inv: 4294967266) |
| SYS_CMD_GPX_ENABLE_BOOTLOADER_MODE | 30 | GPX: enable bootloader mode (uint32 inv: 4294967265) |
| SYS_CMD_GPX_ENABLE_GNSS1_CHIPSET_BOOTLOADER | 31 | GPX: enable GNSS1 chipset bootloader (uint32 inv: 4294967264) |
| SYS_CMD_GPX_ENABLE_GNSS2_CHIPSET_BOOTLOADER | 32 | GPX: enable GNSS2 chipset bootloader (uint32 inv: 4294967263) |
| SYS_CMD_GPX_ENABLE_GNSS1_PASS_THROUGH | 33 | GPX: enable GNSS1 pass-through (uint32 inv: 4294967262) |
| SYS_CMD_GPX_ENABLE_GNSS2_PASS_THROUGH | 34 | GPX: enable GNSS2 pass-through (uint32 inv: 4294967261) |
| SYS_CMD_GPX_HARD_RESET_GNSS1 | 36 | GPX: hard reset GNSS1 receiver (uint32 inv: 4294967259) |
| SYS_CMD_GPX_HARD_RESET_GNSS2 | 37 | GPX: hard reset GNSS2 receiver (uint32 inv: 4294967258) |
| SYS_CMD_GPX_SOFT_RESET_GPX | 38 | GPX: soft reset GPX (uint32 inv: 4294967257) |
| SYS_CMD_GPX_ENABLE_SERIAL_BRIDGE_CUR_PORT_LOOPBACK | 39 | GPX: enable serial bridge on IMX to GPX and loopback on GPX (uint32 inv: 4294967256) |
| SYS_CMD_GPX_ENABLE_SERIAL_BRIDGE_CUR_PORT_LOOPBACK_TESTMODE | 40 | GPX: enable serial bridge on IMX to GPX and loopback on GPX, driver test mode (uint32 inv: 4294967255) |
| SYS_CMD_GPX_ENABLE_RTOS_STATS | 41 | GPX: enable RTOS task stats collection (uint32 inv: 4294967254) |
| SYS_CMD_GPX_SAVE_PERSISTENT_MESSAGES | 42 | GPX: save current persistent messages (uint32 inv: 4294967253) |
| SYS_CMD_GNSS_RCVR_QUIET_MODE | 60 | Put GNSS receiver into quiet mode (uint32 inv: 4294967235) |
| SYS_CMD_GNSS_RCVR_SOFT_RESET | 61 | Soft reset GNSS receiver (uint32 inv: 4294967234) |
| SYS_CMD_GNSS_RCVR_HARD_RESET | 62 | Hard reset GNSS receiver (uint32 inv: 4294967233) |
| SYS_CMD_GNSS_RCVR_PWR_CYCLE | 63 | Power cycle GNSS receiver (uint32 inv: 4294967232) |
| SYS_CMD_RESET_EKF_STATES | 70 | Resets the Extended Kalman Filter (EKF) states in the INS solution. Use to reinitialize navigation filter without a full system reset. (uint32 inv: 4294967226) |
| SYS_CMD_CLEAR_ERROR_STATUS | 71 | Resets debug information such as CPU reset cause and fault states. (uint32 inv: 4294967225) |
| SYS_CMD_SAVE_FLASH | 97 | Save current flash config to persistent flash memory (uint32 inv: 4294967198) |
| SYS_CMD_SAVE_GNSS_ASSIST_TO_FLASH_RESET | 98 | Save GNSS assist data (ephemeris/almanac) to flash then reset (uint32 inv: 4294967197) |
| SYS_CMD_SOFTWARE_RESET | 99 | Software reset (uint32 inv: 4294967196) |
| SYS_CMD_MANF_UNLOCK | 1122334455 | Manufacturing unlock, required before any SYS_CMD_MANF_* command below is accepted (uint32 inv: 3172632840) |
| SYS_CMD_MANF_ERASE_CALIBRATION_MOTION | 1357924678 | Manufacturing: erase motion calibration. SYS_CMD_MANF_UNLOCK must be sent prior to this command. (uint32 inv: 2937042617) |
| SYS_CMD_MANF_ERASE_CALIBRATION | 1357924679 | Manufacturing: erase calibration. SYS_CMD_MANF_UNLOCK must be sent prior to this command. (uint32 inv: 2937042616) |
| SYS_CMD_MANF_FACTORY_RESET | 1357924680 | Manufacturing: factory reset. SYS_CMD_MANF_UNLOCK must be sent prior to this command. (uint32 inv: 2937042615) |
| SYS_CMD_MANF_CHIP_ERASE | 1357924681 | Manufacturing: chip erase. SYS_CMD_MANF_UNLOCK must be sent prior to this command.  A device power cycle may be necessary to complete this command. (uint32 inv: 2937042614) |
| SYS_CMD_MANF_DOWNGRADE_CALIBRATION | 1357924682 | Manufacturing: downgrade calibration. SYS_CMD_MANF_UNLOCK must be sent prior to this command. (uint32 inv: 2937042613) |
| SYS_CMD_MANF_ENABLE_ROM_BOOTLOADER | 1357924683 | Manufacturing: enable ROM bootloader. SYS_CMD_MANF_UNLOCK must be sent prior to this command.  A device power cycle may be necessary to complete this command. (uint32 inv: 2937042612) |
| SYS_CMD_MANF_LED_ON | 1357924684 | Enable testbed LED on IMX (sysStatus) and GPX (hdwStatus). (uint32 inv: 2937042611) |
| SYS_CMD_MANF_LED_OFF | 1357924685 | Disable testbed LED on IMX (sysStatus) and GPX (hdwStatus). (uint32 inv: 2937042610) |
| SYS_CMD_FAULT_TEST_TRIG_MALLOC | 57005 | Fault injection test: trigger a malloc-related fault |
| SYS_CMD_FAULT_TEST_TRIG_HARD_FAULT | 57006 | Fault injection test: trigger a hard fault |
| SYS_CMD_FAULT_TEST_TRIG_WATCHDOG | 57007 | Fault injection test: trigger a watchdog timeout |
| SYS_CMD_FAULT_TEST_TRIG_FLASH_TORN_WRITE | 57008 | Fault injection test (SN-7873): erase test page, start dword program, NVIC_SystemReset mid-flight to leave a torn dword with bad ECC; auto-fires NMI on next boot to exercise the full classify+recover cycle |


#### DID_SYS_PARAMS.genFaultCode

(eGenFaultCodes)  General fault code bitflags, carried in sys_params_t.genFaultCode (DID_SYS_PARAMS). Multiple bits may be set simultaneously; a value of zero indicates no fault is latched.

| Field | Value | Description |
|-------|-------|-------------|
| GFC_INS_STATE_ORUN_UVW | 0x00000001 | INS state limit overrun - UVW (body frame velocity) |
| GFC_INS_STATE_ORUN_LAT | 0x00000002 | INS state limit overrun - Latitude |
| GFC_INS_STATE_ORUN_ALT | 0x00000004 | INS state limit overrun - Altitude |
| GFC_UNHANDLED_INTERRUPT | 0x00000010 | Unhandled interrupt |
| GFC_GNSS_CRITICAL_FAULT | 0x00000020 | GNSS receiver critical fault. See the corresponding GNSS status fault flags (i.e. GPX_STATUS_FATAL_MASK) |
| GFC_GNSS_TX_LIMITED | 0x00000040 | GNSS Tx limited |
| GFC_GNSS_RX_OVERRUN | 0x00000080 | GNSS Rx overrun |
| GFC_INIT_SENSORS | 0x00000100 | Fault: sensor initialization |
| GFC_INIT_SPI | 0x00000200 | Fault: SPI bus initialization |
| GFC_CONFIG_SPI | 0x00000400 | Fault: SPI configuration |
| GFC_GNSS1_INIT | 0x00000800 | Fault: GNSS1 init |
| GFC_GNSS2_INIT | 0x00001000 | Fault: GNSS2 init |
| GFC_FLASH_INVALID_VALUES | 0x00002000 | Flash failed to load valid values |
| GFC_FLASH_CHECKSUM_FAILURE | 0x00004000 | Flash checksum failure |
| GFC_FLASH_WRITE_FAILURE | 0x00008000 | Flash write failure |
| GFC_SYS_FAULT_GENERAL | 0x00010000 | System Fault: general |
| GFC_SYS_FAULT_CRITICAL | 0x00020000 | System Fault: CRITICAL system fault (see DID_SYS_FAULT) |
| GFC_SENSOR_SATURATION | 0x00040000 | Sensor(s) saturated |
| GFC_EKF_STATES_INVALID | 0x00080000 | INS extended kalman filter states invalid and the EKF was reset |
| GFC_INIT_IMU | 0x00100000 | Fault: IMU initialization |
| GFC_INIT_BAROMETER | 0x00200000 | Fault: Barometer initialization |
| GFC_INIT_MAGNETOMETER | 0x00400000 | Fault: Magnetometer initialization |
| GFC_INIT_I2C | 0x00800000 | Fault: I2C initialization |
| GFC_CHIP_ERASE_INVALID | 0x01000000 | Fault: Chip erase line toggled but did not meet required hold time.  This is caused by noise/transient on chip erase pin. |
| GFC_EKF_GNSS_TIME_FAULT | 0x02000000 | Fault: EKF GNSS time fault |
| GFC_GNSS_RECEIVER_TIME | 0x04000000 | Fault: GNSS receiver time fault |
| GFC_GNSS_GENERAL_FAULT | 0x08000000 | Fault: GNSS receiver general fault. See the corresponding GNSS status fault flags (i.e. GPX_STATUS_GENERAL_FAULT_MASK) |
| GFC_EKF_INPUT_INVALID_IMU | 0x10000000 | Fault: Invalid IMU input rejected by EKF |
| GFC_GNSS_RTOS_ERROR | 0x20000000 | Fault: GNSS RTOS error |
| GFC_EKF_BIAS_SATURATED | 0x40000000 | Fault: EKF bias saturated |
| GFC_EKF_BIAS_SATURATED | 0x40000000 |
| GFC_GPX_STATUS_COMMON_MASK | GFC_GNSS1_INIT\|GFC_GNSS2_INIT\|GFC_GNSS_TX_LIMITED\|GFC_GNSS_RX_OVERRUN\|GFC_GNSS_CRITICAL_FAULT\|GFC_GNSS_RECEIVER_TIME\|GFC_GNSS_GENERAL_FAULT | IMX GFC flags that relate to GPX status flags |


#### GPS Navigation Fix Type

(eGnssNavFixStatus)  GNSS navigation fix type, packed into eInsStatusFlags::INS_STATUS_GNSS_NAV_FIX_MASK and extracted via INS_STATUS_NAV_FIX_STATUS(). Higher values indicate a more accurate fix. / /* NOTE: If you modify this enum, please also modify the eGnssNavFixStatus enum in IS-src/python/src/ci_hdw/data_sets.py

| Field | Value | Description |
|-------|-------|-------------|
| GNSS_NAV_FIX_NONE | 0x00000000 | No GNSS fix |
| GNSS_NAV_FIX_POSITIONING_3D | 0x00000001 | Standard 3D GNSS position fix (no RTK corrections) |
| GNSS_NAV_FIX_POSITIONING_RTK_FLOAT | 0x00000002 | RTK fix with floating (unresolved) integer ambiguities |
| GNSS_NAV_FIX_POSITIONING_RTK_FIX | 0x00000003 | RTK fix with resolved integer ambiguities. Includes fix & hold |


#### GPS Status

(eGnssStatus)  GNSS receiver status bitflags, carried in gnss_pos_t.status (DID_GNSS1_POS, DID_GNSS2_POS, DID_GNSS1_RCVR_POS, DID_GNSS1_RTK_POS, etc). Packs [0x000000xx] a legacy satellite-used count, [0x0000xx00] the fix type, and [0x xxxx0000] status/quality flags into a single 32-bit word.

| Field | Value | Description |
|-------|-------|-------------|
| GNSS_STATUS_NUM_SATS_USED_MASK | 0x000000FF | (deprecated) Number of satellites used in solution; use gnss_pos_t.satsUsed instead |
| GNSS_STATUS_FIX_NONE | 0x00000000 | No fix |
| GNSS_STATUS_FIX_DEAD_RECKONING_ONLY | 0x00000100 | Dead reckoning only, no GNSS fix |
| GNSS_STATUS_FIX_2D | 0x00000200 | 2D fix (no reliable altitude) |
| GNSS_STATUS_FIX_3D | 0x00000300 | 3D fix |
| GNSS_STATUS_FIX_GNSS_PLUS_DEAD_RECK | 0x00000400 | GNSS fix combined with dead reckoning |
| GNSS_STATUS_FIX_TIME_ONLY | 0x00000500 | Time-only fix (no position) |
| GNSS_STATUS_FIX_REF_LLA | 0x00000600 | Fixed at a reference LLA position (e.g. surveyed base station) |
| GNSS_STATUS_FIX_UNUSED2 | 0x00000700 | Unused |
| GNSS_STATUS_FIX_DGPS | 0x00000800 | Differential GPS (DGPS) fix |
| GNSS_STATUS_FIX_SBAS | 0x00000900 | SBAS (satellite-based augmentation) fix |
| GNSS_STATUS_FIX_RTK_SINGLE | 0x00000A00 | RTK single (no differential corrections applied) |
| GNSS_STATUS_FIX_RTK_FLOAT | 0x00000B00 | RTK fix with floating (unresolved) integer ambiguities |
| GNSS_STATUS_FIX_RTK_FIX | 0x00000C00 | RTK fix with resolved integer ambiguities |
| GNSS_STATUS_FIX_MASK | 0x00001F00 | Mask isolating the fix-type field |
| GNSS_STATUS_FIX_BIT_OFFSET |  (int)8 | Bit offset of the fix-type field within status |
| GNSS_STATUS_FLAGS_FIX_OK | 0x00010000 | Fix is within limits (e.g. DOP & accuracy) |
| GNSS_STATUS_FLAGS_DGPS_USED | 0x00020000 | Differential GPS (DGPS) used. |
| GNSS_STATUS_FLAGS_RTK_FIX_AND_HOLD | 0x00040000 | RTK feedback on the integer solutions to drive the float biases towards the resolved integers |
| GNSS_STATUS_FLAGS_UNUSED_1 | 0x00080000 | Unused |
| GNSS_STATUS_FLAGS_GNSS1_RTK_POSITION_ENABLED | 0x00100000 | GNSS1 RTK precision positioning mode enabled |
| GNSS_STATUS_FLAGS_STATIC_MODE | 0x00200000 | Static mode |
| GNSS_STATUS_FLAGS_GNSS2_RTK_COMPASS_ENABLED | 0x00400000 | GNSS2 RTK moving base mode enabled |
| GNSS_STATUS_FLAGS_GNSS1_RTK_RAW_GNSS_DATA_ERROR | 0x00800000 | GNSS1 RTK error: observations or ephemeris are invalid or not received (i.e. RTK differential corrections) |
| GNSS_STATUS_FLAGS_GNSS1_RTK_BASE_DATA_MISSING | 0x01000000 | GNSS1 RTK error: Either base observations or antenna position have not been received. |
| GNSS_STATUS_FLAGS_GNSS1_RTK_BASE_POSITION_MOVING | 0x02000000 | GNSS1 RTK error: base position moved when it should be stationary |
| GNSS_STATUS_FLAGS_GNSS1_RTK_BASE_POSITION_INVALID | 0x03000000 | GNSS1 RTK error: base position is invalid or not surveyed well |
| GNSS_STATUS_FLAGS_GNSS1_RTK_BASE_POSITION_MASK | 0x03000000 | GNSS1 RTK error: base position error bitmask |
| GNSS_STATUS_FLAGS_GNSS1_RTK_POSITION_VALID | 0x04000000 | GNSS1 RTK precision position and carrier phase range solution with fixed ambiguities (i.e. < 6cm horizontal accuracy). The carrier phase range solution with floating ambiguities occurs if GNSS_STATUS_FIX_RTK_FIX is set and GNSS_STATUS_FLAGS_GNSS1_RTK_POSITION_VALID is not set (i.e. > 6cm horizontal accuracy). |
| GNSS_STATUS_FLAGS_GNSS2_RTK_COMPASS_VALID | 0x08000000 | GNSS2 RTK moving base heading. Indicates RTK compassing heading valid and available in DID_GNSS2_RTK_CMP_REL. |
| GNSS_STATUS_FLAGS_GNSS2_RTK_COMPASS_BASELINE_BAD | 0x00002000 | GNSS2 RTK compassing antenna baseline specified in flashCfg and measured by GNSS do not match |
| GNSS_STATUS_FLAGS_GNSS2_RTK_COMPASS_BASELINE_UNSET | 0x00004000 | GNSS2 RTK compassing antenna baseline offsets are not set in flashCfg |
| GNSS_STATUS_FLAGS_GNSS_NMEA_DATA | 0x00008000 | 1 = Data from NMEA message. GNSS velocity is NED (not ECEF). |
| GNSS_STATUS_FLAGS_GNSS_PPS_TIMESYNC | 0x10000000 | Time is synchronized by GNSS PPS. |
| GNSS_STATUS_FLAGS_MASK | 0x1FFFE000 | Mask isolating all status/quality flag bits |
| GNSS_STATUS_FLAGS_BIT_OFFSET |  (int)16 | Bit offset of the status/quality flags field within status |
| GNSS_STATUS_FLAGS_RTK_COV_ECEF_PACKED_VALID | 0x20000000 | RTK ECEF covariance matrix is valid and packed in rel->covEcefPacked |
| GNSS_STATUS_FLAGS_UNUSED_3 | 0x40000000 | Unused |
| GNSS_STATUS_FLAGS_UNUSED_4 | 0x80000000 | Unused |


#### Hardware Status Flags

(eHdwStatusFlags)  Hardware status bitflags, carried in DID_SYS_PARAMS.hdwStatus and copied into every INS output message (DID_INS_1, DID_INS_2, DID_INS_3, DID_INS_4). Reports motion state, sensor saturation/fault conditions, GNSS timing/PPS health, communications errors, built-in self-test (BIT) state, and the cause of the last system reset. HDW_STATUS_ERROR_MASK aggregates the bits that indicate a hardware fault requiring attention.

| Field | Value | Description |
|-------|-------|-------------|
| HDW_STATUS_MOTION_GYR | 0x00000001 | Gyro motion detected |
| HDW_STATUS_MOTION_ACC | 0x00000002 | Accelerometer motion detected |
| HDW_STATUS_MOTION_MASK | 0x00000003 | Unit is moving and NOT stationary |
| HDW_STATUS_IMU_FAULT_REJECT_GYR | 0x00000004 | IMU gyro fault rejection. One of the redundant gyro sensors is divergent and being excluded. |
| HDW_STATUS_IMU_FAULT_REJECT_ACC | 0x00000008 | IMU accelerometer fault rejection. One of the redundant accelerometer sensors is divergent and being excluded. |
| HDW_STATUS_IMU_FAULT_REJECT_MASK | 0x0000000C | IMU fault rejection mask. One of the redundant IMU sensors is divergent and being excluded. |
| HDW_STATUS_GNSS_SATELLITE_RX_VALID | 0x00000010 | GNSS satellite signals are being received (antenna and cable are good). Unset indicates weak signal or no output from GNSS receiver. |
| HDW_STATUS_STROBE_IN_EVENT | 0x00000020 | Event occurred on strobe input pin |
| HDW_STATUS_GNSS_TIME_OF_WEEK_VALID | 0x00000040 | GPS time of week is valid and reported. Otherwise the timeOfWeek is local system time. |
| HDW_STATUS_REFERENCE_IMU_RX | 0x00000080 | Reference IMU data being received |
| HDW_STATUS_SATURATION_GYR | 0x00000100 | Sensor saturation on gyro |
| HDW_STATUS_SATURATION_ACC | 0x00000200 | Sensor saturation on accelerometer |
| HDW_STATUS_SATURATION_MAG | 0x00000400 | Sensor saturation on magnetometer |
| HDW_STATUS_SATURATION_BARO | 0x00000800 | Sensor saturation on barometric pressure |
| HDW_STATUS_IMU_SATURATION_MASK | (int)(HDW_STATUS_SATURATION_GYR\|HDW_STATUS_SATURATION_ACC\) | Sensor saturation mask (IMU only: gyro + accelerometer) |
| HDW_STATUS_SATURATION_MASK | 0x00000F00 | Sensor saturation mask (all sensors: gyro, accelerometer, magnetometer, barometer) |
| HDW_STATUS_SATURATION_OFFSET | 8 | Bit offset of the sensor saturation field within hdwStatus |
| HDW_STATUS_SYSTEM_RESET_REQUIRED | 0x00001000 | System Reset is required for proper function |
| HDW_STATUS_ERR_GNSS_PPS_NOISE | 0x00002000 | GNSS PPS timepulse signal has noise and occurred too frequently |
| HDW_STATUS_MAG_RECAL_COMPLETE | 0x00004000 | Magnetometer recalibration has finished (when INS_STATUS_MAG_RECALIBRATING is unset). |
| HDW_STATUS_FLASH_WRITE_PENDING | 0x00008000 | System flash write staging or occurring now. Processor will pause and not respond during a flash write, typically 150-250 ms. |
| HDW_STATUS_ERR_COM_TX_LIMITED | 0x00010000 | Communications Tx buffer limited |
| HDW_STATUS_ERR_COM_RX_OVERRUN | 0x00020000 | Communications Rx buffer overrun |
| HDW_STATUS_ERR_NO_GNSS_PPS | 0x00040000 | GNSS PPS timepulse signal has not been received or is in error |
| HDW_STATUS_GNSS_PPS_TIMESYNC | 0x00080000 | Time synchronized by GNSS PPS |
| HDW_STATUS_COM_PARSE_ERR_COUNT_MASK | 0x00F00000 | Communications parse error count mask; extract with HDW_STATUS_COM_PARSE_ERROR_COUNT() |
| HDW_STATUS_COM_PARSE_ERR_COUNT_OFFSET | 20 | Bit offset of the communications parse error count field within hdwStatus |
| HDW_STATUS_BIT_RUNNING | 0x01000000 | (BIT) Built-in self-test running |
| HDW_STATUS_BIT_PASSED | 0x02000000 | (BIT) Built-in self-test passed |
| HDW_STATUS_BIT_FAILED | 0x03000000 | (BIT) Built-in self-test failure |
| HDW_STATUS_BIT_MASK | 0x03000000 | (BIT) Built-in self-test mask |
| HDW_STATUS_ERR_TEMPERATURE | 0x04000000 | Temperature outside spec'd operating range |
| HDW_STATUS_SPI_INTERFACE_ENABLED | 0x08000000 | IMX pins G5-G8 are configure for SPI use |
| HDW_STATUS_RESET_CAUSE_MASK | 0x70000000 | Cause of system reset mask |
| HDW_STATUS_RESET_CAUSE_BACKUP_MODE | 0x10000000 | Reset from backup mode (low-power state w/ CPU off) |
| HDW_STATUS_RESET_CAUSE_WATCHDOG_FAULT | 0x20000000 | Reset from watchdog fault |
| HDW_STATUS_RESET_CAUSE_SOFT | 0x30000000 | Reset from software |
| HDW_STATUS_RESET_CAUSE_HDW | 0x40000000 | Reset from hardware (NRST pin low) |
| HDW_STATUS_FAULT_SYS_CRITICAL | 0x80000000 | Critical System Fault, CPU error. (see DID_SYS_FAULT.status, eSysFaultStatus) |


#### IMU Shock Options

(eImuShockOptions)  IMU shock-rejection configuration bitflags, used with nvm_flash_cfg_t.imuShockOptions (DID_FLASH_CONFIG). Controls whether the EKF detects and rejects IMU shock/impact events during attitude estimation.

| Field | Value | Description |
|-------|-------|-------------|
| IMU_SHOCK_OPTIONS_ENABLE | 0x01 | Enable IMU shock detection and rejection |
| IMU_SHOCK_OPTIONS_FAST_RECOVERY | 0x02 | Useful when shocks occur during rotation, as it minimizes post-shock error and reduces the time required for attitude convergence. However, this option increases the amount of attitude error induced by shock events and is therefore discouraged when the platform is stationary and not rotating during shocks. |


#### IMU Status

(eImuStatus)  Combined-IMU status bitflags for imu_t.status and pimu_t.status (DID_IMU, DID_IMU_RAW, DID_PIMU, etc).

| Field | Value | Description |
|-------|-------|-------------|
| IMU_STATUS_GYR_X_OK | 0x00000001 | IMU X gyro is valid |
| IMU_STATUS_GYR_Y_OK | 0x00000002 | IMU Y gyro is valid |
| IMU_STATUS_GYR_Z_OK | 0x00000004 | IMU Z gyro is valid |
| IMU_STATUS_ACC_X_OK | 0x00000008 | IMU X accelerometer is valid |
| IMU_STATUS_ACC_Y_OK | 0x00000010 | IMU Y accelerometer is valid |
| IMU_STATUS_ACC_Z_OK | 0x00000020 | IMU Z accelerometer is valid |
| IMU_STATUS_IMU_OK_BITSIZE | 6 | Number of IMU OK bits |
| IMU_STATUS_IMU_OK_MASK | IMU_STATUS_GYR_X_OK\|IMU_STATUS_GYR_Y_OK\|IMU_STATUS_GYR_Z_OK\|IMU_STATUS_ACC_X_OK\|IMU_STATUS_ACC_Y_OK\|IMU_STATUS_ACC_Z_OK | IMU valid mask |
| IMU_STATUS_GYR_OK_MASK | IMU_STATUS_GYR_X_OK\|IMU_STATUS_GYR_Y_OK\|IMU_STATUS_GYR_Z_OK | Gyro valid mask |
| IMU_STATUS_ACC_OK_MASK | IMU_STATUS_ACC_X_OK\|IMU_STATUS_ACC_Y_OK\|IMU_STATUS_ACC_Z_OK | Accelerometer valid mask |
| IMU_STATUS_SHOCK_PRESENT | 0x00000040 | Sensor shock detected |
| IMU_STATUS_MAG_UPDATE | 0x00000100 | Magnetometer sample occurred |
| IMU_STATUS_REFERENCE_IMU_PRESENT | 0x00000200 | Data was received at least once from Reference IMU |
| IMU_STATUS_GYR_FAULT_REJECT | 0x01000000 | IMU fault rejection is excluding one of the gyros from the combined IMU output |
| IMU_STATUS_ACC_FAULT_REJECT | 0x02000000 | IMU fault rejection is excluding one of the accelerometers from the combined IMU output |
| IMU_STATUS_SATURATION_GYR | 0x40000000 | Sensor saturation |
| IMU_STATUS_SATURATION_ACC | 0x80000000 |  |
| IMU_STATUS_SATURATION_MASK | 0xC0000000 |  |


#### INS status Flags

(eInsStatusFlags)  INS/AHRS solution status bitflags, carried in DID_SYS_PARAMS.insStatus and copied into every INS output message (DID_INS_1, DID_INS_2, DID_INS_3, DID_INS_4). Bits [0:2] and [4:6] report alignment quality (COARSE = usable but outside spec, FINE = within spec) for heading, velocity, and position independently. Bits [16:19] (INS_STATUS_SOLUTION_MASK) report the overall solution mode via INS_STATUS_SOLUTION(). Bits [24:25] report the GNSS navigation fix type via INS_STATUS_NAV_FIX_STATUS() (see eGnssNavFixStatus). The remaining bits report aiding sources in use and fault/error conditions; INS_STATUS_ERROR_MASK aggregates the bits that indicate a solution problem requiring attention.

| Field | Value | Description |
|-------|-------|-------------|
| INS_STATUS_HDG_ALIGN_COARSE | 0x00000001 | Heading estimate is usable but outside spec (COARSE) |
| INS_STATUS_VEL_ALIGN_COARSE | 0x00000002 | Velocity estimate is usable but outside spec (COARSE) |
| INS_STATUS_POS_ALIGN_COARSE | 0x00000004 | Position estimate is usable but outside spec (COARSE) |
| INS_STATUS_ALIGN_COARSE_MASK | 0x00000007 | Mask of all COARSE (usable but outside spec) alignment bits |
| INS_STATUS_WHEEL_AIDING_VEL | 0x00000008 | Velocity aided by wheel sensor |
| INS_STATUS_HDG_ALIGN_FINE | 0x00000010 | Heading estimate is within spec (FINE); see detailed note above |
| INS_STATUS_VEL_ALIGN_FINE | 0x00000020 | Velocity estimate is within spec (FINE) |
| INS_STATUS_POS_ALIGN_FINE | 0x00000040 | Position estimate is within spec (FINE) |
| INS_STATUS_ALIGN_FINE_MASK | 0x00000070 | Mask of all FINE (within spec) alignment bits |
| INS_STATUS_GNSS_AIDING_HEADING | 0x00000080 | Heading aided by GNSS |
| INS_STATUS_GNSS_AIDING_POS | 0x00000100 | Position aided by GNSS position |
| INS_STATUS_GNSS_UPDATE_IN_SOLUTION | 0x00000200 | GNSS update event occurred in solution, potentially causing discontinuity in position path |
| INS_STATUS_EKF_USING_REFERENCE_IMU | 0x00000400 | Reference IMU used in EKF |
| INS_STATUS_MAG_AIDING_HEADING | 0x00000800 | Heading aided by magnetic heading |
| INS_STATUS_NAV_MODE | 0x00001000 | Nav mode (set) = estimating velocity and position. AHRS mode (cleared) = NOT estimating velocity and position |
| INS_STATUS_STATIONARY_MODE | 0x00002000 | INS in stationary mode. If initiated by zero velocity command, user should not move (keep system motionless) to assist on-board processing. |
| INS_STATUS_GNSS_AIDING_VEL | 0x00004000 | Velocity aided by GNSS velocity |
| INS_STATUS_KINEMATIC_CAL_GOOD | 0x00008000 | Vehicle kinematic calibration is good |
| INS_STATUS_SOLUTION_MASK | 0x000F0000 | INS/AHRS solution status mask; extract with INS_STATUS_SOLUTION() |
| INS_STATUS_SOLUTION_OFFSET | 16 | Bit offset of the solution status field within insStatus |
| INS_STATUS_SOLUTION_OFF | 0 | System is off |
| INS_STATUS_SOLUTION_ALIGNING | 1 | System is in alignment mode |
| INS_STATUS_SOLUTION_NAV | 3 | System is in navigation mode and solution is good. |
| INS_STATUS_SOLUTION_NAV_HIGH_VARIANCE | 4 | System is in navigation mode but the attitude uncertainty has exceeded the threshold. |
| INS_STATUS_SOLUTION_AHRS | 5 | System is in AHRS mode and solution is good. |
| INS_STATUS_SOLUTION_AHRS_HIGH_VARIANCE | 6 | System is in AHRS mode but the attitude uncertainty has exceeded the threshold. |
| INS_STATUS_SOLUTION_VRS | 7 | System is in VRS mode (no earth relative heading) and roll and pitch are good. |
| INS_STATUS_SOLUTION_VRS_HIGH_VARIANCE | 8 | System is in VRS mode (no earth relative heading) but roll and pitch uncertainty has exceeded the threshold. |
| INS_STATUS_RTK_COMPASSING_BASELINE_UNSET | 0x00100000 | GNSS compassing antenna offsets are not set in flashCfg. |
| INS_STATUS_RTK_COMPASSING_BASELINE_BAD | 0x00200000 | GNSS antenna baseline specified in flashCfg and measured by GNSS do not match. |
| INS_STATUS_RTK_COMPASSING_MASK | (INS_STATUS_RTK_COMPASSING_BASELINE_UNSET\|INS_STATUS_RTK_COMPASSING_BASELINE_BAD\) | Mask of RTK compassing baseline error bits |
| INS_STATUS_MAG_RECALIBRATING | 0x00400000 | Magnetometer is being recalibrated. Device requires rotation to complete the calibration process. HDW_STATUS_MAG_RECAL_COMPLETE is set when complete. |
| INS_STATUS_MAG_INTERFERENCE_OR_BAD_CAL_OR_NO_CAL | 0x00800000 | Magnetometer is experiencing interference or calibration is bad. Attention may be required to remove interference (move the device) or recalibrate the magnetometer. |
| INS_STATUS_GNSS_NAV_FIX_MASK | 0x03000000 | GNSS navigation fix type mask (see eGnssNavFixStatus); extract with INS_STATUS_NAV_FIX_STATUS() |
| INS_STATUS_GNSS_NAV_FIX_OFFSET | 24 | Bit offset of the GNSS navigation fix type field within insStatus |
| INS_STATUS_RTK_COMPASSING_VALID | 0x04000000 | RTK compassing heading is accurate and aiding INS heading. (RTK fix and hold status) |
| INS_STATUS_RTK_RAW_GNSS_DATA_ERROR | 0x08000000 | RTK error: Observations invalid or not received (i.e. RTK differential corrections) |
| INS_STATUS_RTK_ERR_BASE_DATA_MISSING | 0x10000000 | RTK error: Either base observations or antenna position have not been received |
| INS_STATUS_RTK_ERR_BASE_POSITION_MOVING | 0x20000000 | RTK error: base position moved when it should be stationary |
| INS_STATUS_RTK_ERR_BASE_POSITION_INVALID | 0x30000000 | RTK error: base position invalid or not surveyed |
| INS_STATUS_RTK_ERR_BASE_MASK | 0x30000000 | RTK error: NO base position received (mask of base position error codes) |
| INS_STATUS_RTK_ERROR_MASK | (INS_STATUS_RTK_RAW_GNSS_DATA_ERROR\|INS_STATUS_RTK_ERR_BASE_MASK\) | GNSS base mask: combined RTK observation/base error bits |
| INS_STATUS_RTOS_TASK_PERIOD_OVERRUN | 0x40000000 | RTOS task ran longer than allotted period |
| INS_STATUS_GENERAL_FAULT | 0x80000000 | General fault (see sys_params_t.genFaultCode) |


#### Magnetometer Recalibration Mode

(eMagCalState)  Magnetometer calibration command/status codes, used for mag_cal_t.state (DID_MAG_CAL). Values below 100 are commands written by the host to start/stop a calibration; values 100+ are abort/status codes reported back by the device.

| Field | Value | Description |
|-------|-------|-------------|
| MAG_CAL_STATE_DO_NOTHING |  (int)0 | No command / idle, no calibration in progress |
| MAG_CAL_STATE_MULTI_AXIS |  (int)1 | COMMAND: Recalibrate magnetometers using multiple axis |
| MAG_CAL_STATE_SINGLE_AXIS |  (int)2 | COMMAND: Recalibrate magnetometers using only one axis |
| MAG_CAL_STATE_ABORT |  (int)101 | COMMAND: Stop mag recalibration and do not save results |
| MAG_CAL_STATE_RECAL_RUNNING |  (int)200 | STATUS: Mag recalibration is in progress |
| MAG_CAL_STATE_RECAL_COMPLETE |  (int)201 | STATUS: Mag recalibration has completed |
| MAG_CAL_STATE_RECAL_MODE_NOT_SUPPORTED |  (int)202 | STATUS: Mag recalibration mode not supported |


#### RTK Configuration

(eRTKConfigBits)  RTK positioning, compassing, and base-station configuration bitflags, used with nvm_flash_cfg_t.RTKCfgBits (DID_FLASH_CONFIG). Selects rover mode (precision positioning vs. dual-GNSS compassing), and independently configures the device to act as an RTK base station broadcasting ublox/RTCM3 correction data from GNSS1 and/or GNSS2 out any combination of serial ports, USB, or the "current" port. OR the desired bits together; RTK_CFG_BITS_ROVER_MODE_MASK and RTK_CFG_BITS_BASE_MODE isolate the rover-mode and base-mode sub-fields respectively.

| Field | Value | Description |
|-------|-------|-------------|
| RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING_DEPRECATED | 0x00000001 | Enable onboard RTK GNSS precision positioning (GNSS1) DEPRECATED |
| RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING | 0x00000002 | Enable external RTK GNSS positioning (GNSS1) |
| RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING | 0x00000004 | Enable dual GNSS RTK compassing (GNSS2 to GNSS1) |
| RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING_DEPRECATED | 0x00000008 | Enable dual GNSS RTK compassing (GNSS2 to GNSS1) DEPRECATED |
| RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING_MASK | (RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING\|RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING_DEPRECATED\) | Mask of RTK GNSS positioning types |
| RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING_MASK | (RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING\|RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING_DEPRECATED\) | Mask of dual GNSS RTK compassing types |
| RTK_CFG_BITS_ROVER_MODE_MASK | 0x0000000F | Mask of RTK position, heading, and base modes |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_UBLOX_SER0 | 0x00000010 | Enable RTK base and output ublox data from GNSS 1 on serial port 0 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_UBLOX_SER1 | 0x00000020 | Enable RTK base and output ublox data from GNSS 1 on serial port 1 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_UBLOX_SER2 | 0x00000040 | Enable RTK base and output ublox data from GNSS 1 on serial port 2 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_UBLOX_USB | 0x00000080 | Enable RTK base and output ublox data from GNSS 1 on USB port |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_SER0 | 0x00000100 | Enable RTK base and output RTCM3 data from GNSS 1 on serial port 0 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_SER1 | 0x00000200 | Enable RTK base and output RTCM3 data from GNSS 1 on serial port 1 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_SER2 | 0x00000400 | Enable RTK base and output RTCM3 data from GNSS 1 on serial port 2 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_USB | 0x00000800 | Enable RTK base and output RTCM3 data from GNSS 1 on USB port |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_UBLOX_SER0 | 0x00001000 | Enable RTK base and output ublox data from GNSS 2 on serial port 0 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_UBLOX_SER1 | 0x00002000 | Enable RTK base and output ublox data from GNSS 2 on serial port 1 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_UBLOX_SER2 | 0x00004000 | Enable RTK base and output ublox data from GNSS 2 on serial port 2 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_UBLOX_USB | 0x00008000 | Enable RTK base and output ublox data from GNSS 2 on USB port |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_SER0 | 0x00010000 | Enable RTK base and output RTCM3 data from GNSS 2 on serial port 0 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_SER1 | 0x00020000 | Enable RTK base and output RTCM3 data from GNSS 2 on serial port 1 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_SER2 | 0x00040000 | Enable RTK base and output RTCM3 data from GNSS 2 on serial port 2 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_USB | 0x00080000 | Enable RTK base and output RTCM3 data from GNSS 2 on USB port |
| RTK_CFG_BITS_BASE_POS_MOVING | 0x00100000 | Enable base mode moving position. (For future use. Not implemented. This bit should always be 0 for now.) TODO: Implement moving base. |
| RTK_CFG_BITS_RESERVED1 | 0x00200000 | Reserved for future use |
| RTK_CFG_BITS_RTK_BASE_IS_IDENTICAL_TO_ROVER | 0x00400000 | When using RTK, specifies whether the base station is identical hardware to this rover. If so, optimizations are enabled to get fix faster. |
| RTK_CFG_BITS_GNSS_PORT_PASS_THROUGH | 0x00800000 | Forward all messages between the selected GNSS and serial port. Disable for RTK base use (to forward only GNSS raw messages and use the surveyed location refLLA instead of current GNSS position). |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_CUR_PORT | 0x01000000 | Enable RTK base and output RTCM3 data from GNSS 1 on the current serial port |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_CUR_PORT | 0x02000000 | Enable RTK base and output RTCM3 data from GNSS 2 on the current serial port |
| RTK_CFG_BITS_BASE_OUTPUT_RTCM3_CLEAR_CUR_PORT | 0x04000000 | If this bit is set in conjunction with setting the current port, this clears the current port |
| RTK_CFG_BITS_MULTIPATH_MITIGATION | 0x08000000 | Enable multipath detection and mitigation in RTK solutiion |
| RTK_CFG_BITS_BASE_OUTPUT_RTCM3_CUR_PORT_MASK | (RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_CUR_PORT\|RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_CUR_PORT\) | Mask of RTK base and output RTCM3 data on the current serial ports |
| RTK_CFG_BITS_BASE_UBLOX_MASK | (RTK_CFG_BITS_BASE_GNSS1_UBLOX_MASK\|RTK_CFG_BITS_BASE_GNSS2_UBLOX_MASK\) | Mask of all ublox base-output bits, both GNSS receivers |
| RTK_CFG_BITS_BASE_RTCM3_MASK | (RTK_CFG_BITS_BASE_GNSS1_RTCM3_MASK\|RTK_CFG_BITS_BASE_GNSS2_RTCM3_MASK\) | Mask of all RTCM3 base-output bits, both GNSS receivers |
| RTK_CFG_BITS_BASE_MODE | (RTK_CFG_BITS_BASE_UBLOX_MASK\|RTK_CFG_BITS_BASE_RTCM3_MASK\) | All base station bits |
| RTK_CFG_BITS_ROVER_MODE_ONBOARD_MASK | (RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING_DEPRECATED\|RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING_DEPRECATED\) | Mask selecting the deprecated onboard RTK engine rover modes |
| RTK_CFG_BITS_ALL_MODES_MASK | (RTK_CFG_BITS_ROVER_MODE_MASK\|RTK_CFG_BITS_BASE_MODE\) | Mask of Rover, Compassing, and Base modes |


#### RTK Solution Status

(eRtkSolStatus)  RTK solution status, reported as the value decoded from the fix-type field of an eGnssStatus status word (e.g. gnss_pos_t.status, gnss_rtk_rel_t.status). Ordered roughly from lowest to highest accuracy: single is a standalone (non-differential) solution, dgps/sbas are code-based differential corrections, float is a carrier-phase RTK solution with unresolved (floating) integer ambiguities, and fix is a carrier-phase RTK solution with resolved integer ambiguities (highest accuracy).

| Field | Value | Description |
|-------|-------|-------------|
| rtk_solution_status_none | 0 | No RTK solution status available |
| rtk_solution_status_fix | 1 | RTK fix: carrier-phase solution with resolved (fixed) integer ambiguities (highest accuracy, typically < 6cm horizontal) |
| rtk_solution_status_float | 2 | RTK float: carrier-phase solution with unresolved (floating) integer ambiguities |
| rtk_solution_status_sbas | 3 | SBAS (satellite-based augmentation system) corrected solution |
| rtk_solution_status_dgps | 4 | DGPS (code-based differential GPS) corrected solution |
| rtk_solution_status_single | 5 | Single point (standalone, non-differential) solution |


#### Raw GPS Data Type

(eRawDataType)  Identifies which member of the uGnssRawData union in gnss_raw_t is populated, mapping onto the RTKLIB-derived structures documented above (obsd_t, eph_t, geph_t, sbsmsg_t, sta_t, ion_model_utc_alm_t). Used for DID_GNSS_BASE_RAW, DID_GNSS1_RAW, and DID_GNSS2_RAW.

| Field | Value | Description |
|-------|-------|-------------|
| raw_data_type_observation | 1 | Satellite pseudorange/carrier-phase observation data (obsd_t[]; see uGnssRawData.obs) |
| raw_data_type_ephemeris | 2 | Broadcast ephemeris for non-GLONASS constellations - GPS, Galileo, BeiDou, QZSS (eph_t; see uGnssRawData.eph) |
| raw_data_type_glonass_ephemeris | 3 | Broadcast GLONASS ephemeris (geph_t; see uGnssRawData.gloEph) |
| raw_data_type_sbas | 4 | SBAS (satellite-based augmentation system) message (sbsmsg_t; see uGnssRawData.sbas) |
| raw_data_type_base_station_antenna_position | 5 | Base station position / antenna information (sta_t; see uGnssRawData.sta) |
| raw_data_type_ionosphere_model_utc_alm | 6 | Ionosphere model, UTC, and almanac data (ion_model_utc_alm_t; see uGnssRawData.ion) |


#### System Configuration

(eSysConfigBits)  System configuration bitflags, used with nvm_flash_cfg_t.sysCfgBits (DID_FLASH_CONFIG). OR these bits together to disable/enable EKF sensor fusion sources, mag calibration behavior, automatic zero-velocity/zero-rate updates, BIT-on-startup, and brownout reset threshold. Written to flash and applied on the next reset.

| Field | Value | Description |
|-------|-------|-------------|
| UNUSED1 | 0x00000001 | Unused/reserved bit |
| SYS_CFG_BITS_ENABLE_MAG_CONTINUOUS_CAL | 0x00000002 | Enable mag continuous calibration. Allow slow background magnetometer calibration in the EKF. |
| SYS_CFG_BITS_AUTO_MAG_RECAL | 0x00000004 | Enable automatic mag recalibration |
| SYS_CFG_BITS_DISABLE_MAG_DECL_ESTIMATION | 0x00000008 | Disable mag declination estimation |
| SYS_CFG_BITS_DISABLE_LEDS | 0x00000010 | Disable LEDs |
| SYS_CFG_BITS_MAG_RECAL_MODE_MASK | 0x00000700 | Magnetometer recalibration mode mask. (see eMagCalState) 1 = multi-axis, 2 = single-axis |
| SYS_CFG_BITS_MAG_RECAL_MODE_OFFSET | 8 | Bit offset of SYS_CFG_BITS_MAG_RECAL_MODE_MASK within sysCfgBits |
| SYS_CFG_BITS_MAG_ENABLE_WMM_DECLINATION | 0x00000800 | When set, World Magnetic Model (WMM) will be used to set mag declination |
| SYS_CFG_BITS_DISABLE_MAGNETOMETER_FUSION | 0x00001000 | Disable magnetometer fusion |
| SYS_CFG_BITS_DISABLE_BAROMETER_FUSION | 0x00002000 | Disable barometer fusion |
| SYS_CFG_BITS_DISABLE_GNSS1_FUSION | 0x00004000 | Disable GNSS 1 fusion |
| SYS_CFG_BITS_DISABLE_GNSS2_FUSION | 0x00008000 | Disable GNSS 2 fusion |
| SYS_CFG_BITS_DISABLE_AUTO_ZERO_VELOCITY_UPDATES | 0x00010000 | Disable automatic Zero Velocity Updates (ZUPT). Useful for degraded GNSS environments or applications with very slow velocities. |
| SYS_CFG_BITS_DISABLE_AUTO_ZERO_ANGULAR_RATE_UPDATES | 0x00020000 | Disable automatic Zero Angular Rate Updates (ZARU). Useful for applications with small/slow angular rates. |
| SYS_CFG_BITS_DISABLE_INS_EKF | 0x00040000 | Disable INS EKF updates |
| SYS_CFG_BITS_DISABLE_AUTO_BIT_ON_STARTUP | 0x00080000 | Prevent built-in test (BIT) from running automatically on startup |
| SYS_CFG_BITS_DISABLE_WHEEL_ENCODER_FUSION | 0x00100000 | Disable wheel encoder fusion |
| SYS_CFG_BITS_ENABLE_GNSS_ANTENNA_OFFSET_ESTIMATION | 0x00200000 | Enable rover GNSS antenna offset estimation in RTK compassing mode |
| SYS_CFG_BITS_BOR_LEVEL_0 | 0x0 | Brownout reset threshold: 1.65 - 1.75 V (default) |
| SYS_CFG_BITS_BOR_LEVEL_1 | 0x1 | Brownout reset threshold: 2.0 - 2.1 V |
| SYS_CFG_BITS_BOR_LEVEL_2 | 0x2 | Brownout reset threshold: 2.25 - 2.35 V |
| SYS_CFG_BITS_BOR_LEVEL_3 | 0x3 | Brownout reset threshold: 2.5 - 2.6 V |
| SYS_CFG_BITS_BOR_THRESHOLD_MASK | 0x00C00000 | Mask for brownout reset threshold voltage level field |
| SYS_CFG_BITS_BOR_THRESHOLD_OFFSET | 22 | Bit offset of SYS_CFG_BITS_BOR_THRESHOLD_MASK within sysCfgBits |
| SYS_CFG_USE_REFERENCE_IMU_IN_EKF | 0x01000000 | Use reference IMU in EKF instead of onboard IMU |
| SYS_CFG_EKF_REF_POINT_STATIONARY_ON_STROBE_INPUT | 0x02000000 | Reference point stationary on strobe input |
