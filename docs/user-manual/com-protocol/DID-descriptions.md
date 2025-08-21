

## Data Sets (DIDs)

Data Sets in the form of C structures are available through binary protocol and provide access to system configuration and output data. The data sets are defined in SDK/src/data_sets.h of the InertialSense SDK.

### INS / AHRS Output

#### DID_INS_1

INS output: euler rotation w/ respect to NED, NED position from reference LLA. 

`ins_1_t`

| Field | Type | Description |
|-------|------|-------------|
| week | uint32_t | GPS number of weeks since January 6th, 1980 |
| timeOfWeek | double | GPS time of week (since Sunday morning) in seconds |
| insStatus | uint32_t | INS status flags (eInsStatusFlags). Copy of DID_SYS_PARAMS.insStatus |
| hdwStatus | uint32_t | Hardware status flags (eHdwStatusFlags). Copy of DID_SYS_PARAMS.hdwStatus |
| theta | float[3] | Euler angles: roll, pitch, yaw in radians with respect to NED |
| uvw | float[3] | Velocity U, V, W in meters per second.  Convert to NED velocity using "vectorBodyToReference(uvw, theta, vel_ned)". |
| lla | double[3] | WGS84 latitude, longitude, height above ellipsoid (degrees,degrees,meters) |
| ned | float[3] | North, east and down (meters) offset from reference latitude, longitude, and altitude to current latitude, longitude, and altitude |


#### DID_INS_2

INS output: quaternion rotation w/ respect to NED, ellipsoid altitude 

`ins_2_t`

| Field | Type | Description |
|-------|------|-------------|
| week | uint32_t | GPS number of weeks since January 6th, 1980 |
| timeOfWeek | double | GPS time of week (since Sunday morning) in seconds |
| insStatus | uint32_t | INS status flags (eInsStatusFlags). Copy of DID_SYS_PARAMS.insStatus |
| hdwStatus | uint32_t | Hardware status flags (eHdwStatusFlags). Copy of DID_SYS_PARAMS.hdwStatus |
| qn2b | float[4] | Quaternion body rotation with respect to NED: W, X, Y, Z |
| uvw | float[3] | Velocity U, V, W in meters per second.  Convert to NED velocity using "quatRot(vel_ned, qn2b, uvw)". |
| lla | double[3] | WGS84 latitude, longitude, height above ellipsoid in meters (not MSL) |


#### DID_INS_3

Inertial navigation data with quaternion NED to body rotation and ECEF position. 

`ins_3_t`

| Field | Type | Description |
|-------|------|-------------|
| week | uint32_t | GPS number of weeks since January 6th, 1980 |
| timeOfWeek | double | GPS time of week (since Sunday morning) in seconds |
| insStatus | uint32_t | INS status flags (eInsStatusFlags). Copy of DID_SYS_PARAMS.insStatus |
| hdwStatus | uint32_t | Hardware status flags (eHdwStatusFlags). Copy of DID_SYS_PARAMS.hdwStatus |
| qn2b | float[4] | Quaternion body rotation with respect to NED: W, X, Y, Z |
| uvw | float[3] | Velocity U, V, W in meters per second.  Convert to NED velocity using "quatRot(vel_ned, qn2b, uvw)". |
| lla | double[3] | WGS84 latitude, longitude, height above ellipsoid in meters (not MSL) |
| msl | float | height above mean sea level (MSL) in meters |


#### DID_INS_4

INS output: quaternion rotation w/ respect to ECEF, ECEF position. 

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

Inertial measurement unit data down-sampled from IMU rate (DID_FLASH_CONFIG.startupImuDtMs (1KHz)) to navigation update rate (DID_FLASH_CONFIG.startupNavDtMs) as an anti-aliasing filter to reduce noise and preserve accuracy.  Minimum data period is DID_FLASH_CONFIG.startupNavDtMs (1KHz max).  

`imu_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds.  Convert to GPS time of week by adding gps.towOffset |
| status | uint32_t | IMU Status (eImuStatus) |
| I | imus_t | Inertial Measurement Unit (IMU) |


#### DID_IMU_RAW

IMU data averaged from DID_IMU3_RAW.  Use this IMU data for output data rates faster than DID_FLASH_CONFIG.startupNavDtMs.  Otherwise we recommend use of DID_IMU or DID_PIMU as they are oversampled and contain less noise. 

`imu_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds.  Convert to GPS time of week by adding gps.towOffset |
| status | uint32_t | IMU Status (eImuStatus) |
| I | imus_t | Inertial Measurement Unit (IMU) |


#### DID_PIMU

Preintegrated IMU (a.k.a. Coning and Sculling integral) in body/IMU frame.  Updated at IMU rate. Also know as delta theta delta velocity, or preintegrated IMU (PIMU). For clarification, the name "Preintegrated IMU" or "PIMU" throughout our User Manual. This data is integrated from the IMU data at the IMU update rate (startupImuDtMs, default 1ms).  The PIMU integration period (dt) and INS NAV update data period are the same.  DID_FLASH_CONFIG.startupNavDtMs sets the NAV output period at startup.  The minimum NAV update and output periods are found here:  https://docs.inertialsense.com/user-manual/application-config/imu_ins_gnss_configuration/#navigation-update-and-output-periods.  If a faster output data rate for IMU is desired, DID_IMU_RAW can be used instead. PIMU data acts as a form of compression, adding the benefit of higher integration rates for slower output data rates, preserving the IMU data without adding filter delay and addresses antialiasing. It is most effective for systems that have higher dynamics and lower communications data rates.  The minimum data period is DID_FLASH_CONFIG.startupImuDtMs or 4, whichever is larger (250Hz max). The PIMU value can be converted to IMU by dividing PIMU by dt (i.e. IMU = PIMU / dt)  

`pimu_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds.  Convert to GPS time of week by adding gps.towOffset |
| dt | float | Integral period in seconds for delta theta and delta velocity.  This is configured using DID_FLASH_CONFIG.startupNavDtMs. |
| status | uint32_t | IMU Status (eImuStatus) |
| theta | float[3] | IMU delta theta (gyroscope {p,q,r} integral) in radians in sensor frame |
| vel | float[3] | IMU delta velocity (accelerometer {x,y,z} integral) in m/s in sensor frame |


### Sensor Output

#### DID_BAROMETER

Barometric pressure sensor data 

`barometer_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds.  Convert to GPS time of week by adding gps.towOffset |
| bar | float | Barometric pressure in kilopascals |
| mslBar | float | MSL altitude from barometric pressure sensor in meters |
| barTemp | float | Temperature of barometric pressure sensor in Celsius |
| humidity | float | Relative humidity as a percent (%rH). Range is 0% - 100% |


#### DID_MAGNETOMETER

Magnetometer sensor output 

`magnetometer_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds.  Convert to GPS time of week by adding gps.towOffset |
| mag | float[3] | Magnetometers |


#### DID_MAG_CAL

Magnetometer calibration 

`mag_cal_t`

| Field | Type | Description |
|-------|------|-------------|
| state | uint32_t | Mag recalibration state.  COMMANDS: 1=multi-axis, 2=single-axis, 101=abort, STATUS: 200=running, 201=done (see eMagCalState) |
| progress | float | Mag recalibration progress indicator: 0-100 % |
| declination | float | Magnetic declination estimate |


#### DID_SYS_SENSORS

System sensor information 

`sys_sensors_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds.  Convert to GPS time of week by adding gps.towOffset |
| temp | float | Temperature in Celsius |
| pqr | float[3] | Gyros in radians / second |
| acc | float[3] | Accelerometers in meters / second squared |
| mag | float[3] | Magnetometers |
| bar | float | Barometric pressure in kilopascals |
| barTemp | float | Temperature of barometric pressure sensor in Celsius |
| mslBar | float | MSL altitude from barometric pressure sensor in meters |
| humidity | float | Relative humidity as a percent (%rH). Range is 0% - 100% |
| vin | float | EVB system input voltage in volts. uINS pin 5 (G2/AN2).  Use 10K/1K resistor divider between Vin and GND.  |
| ana1 | float | ADC analog input in volts. uINS pin 4, (G1/AN1). |
| ana3 | float | ADC analog input in volts. uINS pin 19 (G3/AN3). |
| ana4 | float | ADC analog input in volts. uINS pin 20 (G4/AN4). |


### GPS / GNSS

#### DID_GPS1_POS

GPS 1 position data.  This comes from DID_GPS1_RCVR_POS or DID_GPS1_RTK_POS, depending on whichever is more accurate. 

`gps_pos_t`

| Field | Type | Description |
|-------|------|-------------|
| week | uint32_t | GPS number of weeks since January 6th, 1980 |
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| status | uint32_t | (see eGpsStatus) GPS status: [0x000000xx] number of satellites used, [0x0000xx00] fix type, [0x00xx0000] status flags, NMEA input flag |
| ecef | double[3] | Position in ECEF {x,y,z} (m) |
| lla | double[3] | Position - WGS84 latitude, longitude, height above ellipsoid (not MSL) (degrees, m) |
| hMSL | float | Height above mean sea level (MSL) in meters |
| hAcc | float | Horizontal accuracy in meters |
| vAcc | float | Vertical accuracy in meters |
| pDop | float | Position dilution of precision (unitless) |
| cnoMean | float | Average of all non-zero satellite carrier to noise ratios (signal strengths) in dBHz |
| towOffset | double | Time sync offset between local time since boot up to GPS time of week in seconds.  Add this to IMU and sensor time to get GPS time of week in seconds. |
| leapS | uint8_t | GPS leap second (GPS-UTC) offset. Receiver's best knowledge of the leap seconds offset from UTC to GPS time. Subtract from GPS time of week to get UTC time of week. (18 seconds as of December 31, 2016) |
| satsUsed | uint8_t | Number of satellites used |
| cnoMeanSigma | uint8_t | Standard deviation of cnoMean over past 5 seconds (dBHz x10) |
| reserved | uint8_t | Reserved for future use |


#### DID_GPS1_RCVR_POS

GPS 1 position data from GNSS receiver. 

`gps_pos_t`

| Field | Type | Description |
|-------|------|-------------|
| week | uint32_t | GPS number of weeks since January 6th, 1980 |
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| status | uint32_t | (see eGpsStatus) GPS status: [0x000000xx] number of satellites used, [0x0000xx00] fix type, [0x00xx0000] status flags, NMEA input flag |
| ecef | double[3] | Position in ECEF {x,y,z} (m) |
| lla | double[3] | Position - WGS84 latitude, longitude, height above ellipsoid (not MSL) (degrees, m) |
| hMSL | float | Height above mean sea level (MSL) in meters |
| hAcc | float | Horizontal accuracy in meters |
| vAcc | float | Vertical accuracy in meters |
| pDop | float | Position dilution of precision (unitless) |
| cnoMean | float | Average of all non-zero satellite carrier to noise ratios (signal strengths) in dBHz |
| towOffset | double | Time sync offset between local time since boot up to GPS time of week in seconds.  Add this to IMU and sensor time to get GPS time of week in seconds. |
| leapS | uint8_t | GPS leap second (GPS-UTC) offset. Receiver's best knowledge of the leap seconds offset from UTC to GPS time. Subtract from GPS time of week to get UTC time of week. (18 seconds as of December 31, 2016) |
| satsUsed | uint8_t | Number of satellites used |
| cnoMeanSigma | uint8_t | Standard deviation of cnoMean over past 5 seconds (dBHz x10) |
| reserved | uint8_t | Reserved for future use |


#### DID_GPS1_RTK_POS

GPS RTK position data 

`gps_pos_t`

| Field | Type | Description |
|-------|------|-------------|
| week | uint32_t | GPS number of weeks since January 6th, 1980 |
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| status | uint32_t | (see eGpsStatus) GPS status: [0x000000xx] number of satellites used, [0x0000xx00] fix type, [0x00xx0000] status flags, NMEA input flag |
| ecef | double[3] | Position in ECEF {x,y,z} (m) |
| lla | double[3] | Position - WGS84 latitude, longitude, height above ellipsoid (not MSL) (degrees, m) |
| hMSL | float | Height above mean sea level (MSL) in meters |
| hAcc | float | Horizontal accuracy in meters |
| vAcc | float | Vertical accuracy in meters |
| pDop | float | Position dilution of precision (unitless) |
| cnoMean | float | Average of all non-zero satellite carrier to noise ratios (signal strengths) in dBHz |
| towOffset | double | Time sync offset between local time since boot up to GPS time of week in seconds.  Add this to IMU and sensor time to get GPS time of week in seconds. |
| leapS | uint8_t | GPS leap second (GPS-UTC) offset. Receiver's best knowledge of the leap seconds offset from UTC to GPS time. Subtract from GPS time of week to get UTC time of week. (18 seconds as of December 31, 2016) |
| satsUsed | uint8_t | Number of satellites used |
| cnoMeanSigma | uint8_t | Standard deviation of cnoMean over past 5 seconds (dBHz x10) |
| reserved | uint8_t | Reserved for future use |


#### DID_GPS1_RTK_POS_MISC

RTK precision position related data. 

`gps_rtk_misc_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| accuracyPos | float[3] | Accuracy - estimated standard deviations of the solution assuming a priori error model and error parameters by the positioning options. []: standard deviations {ECEF - x,y,z} or {north, east, down} (meters) |
| accuracyCov | float[3] | Accuracy - estimated standard deviations of the solution assuming a priori error model and error parameters by the positioning options. []: Absolute value of means square root of estimated covariance NE, EU, UN |
| arThreshold | float | Ambiguity resolution threshold for validation |
| gDop | float | Geometric dilution of precision (meters) |
| hDop | float | Horizontal dilution of precision (meters) |
| vDop | float | Vertical dilution of precision (meters) |
| baseLla | double[3] | Base Position - latitude, longitude, height (degrees, meters) |
| cycleSlipCount | uint32_t | Cycle slip counter |
| roverGpsObservationCount | uint32_t | Rover gps observation element counter |
| baseGpsObservationCount | uint32_t | Base station gps observation element counter |
| roverGlonassObservationCount | uint32_t | Rover glonass observation element counter |
| baseGlonassObservationCount | uint32_t | Base station glonass observation element counter |
| roverGalileoObservationCount | uint32_t | Rover galileo observation element counter |
| baseGalileoObservationCount | uint32_t | Base station galileo observation element counter |
| roverBeidouObservationCount | uint32_t | Rover beidou observation element counter |
| baseBeidouObservationCount | uint32_t | Base station beidou observation element counter |
| roverQzsObservationCount | uint32_t | Rover qzs observation element counter |
| baseQzsObservationCount | uint32_t | Base station qzs observation element counter |
| roverGpsEphemerisCount | uint32_t | Rover gps ephemeris element counter |
| baseGpsEphemerisCount | uint32_t | Base station gps ephemeris element counter |
| roverGlonassEphemerisCount | uint32_t | Rover glonass ephemeris element counter |
| baseGlonassEphemerisCount | uint32_t | Base station glonass ephemeris element counter |
| roverGalileoEphemerisCount | uint32_t | Rover galileo ephemeris element counter |
| baseGalileoEphemerisCount | uint32_t | Base station galileo ephemeris element counter |
| roverBeidouEphemerisCount | uint32_t | Rover beidou ephemeris element counter |
| baseBeidouEphemerisCount | uint32_t | Base station beidou ephemeris element counter |
| roverQzsEphemerisCount | uint32_t | Rover qzs ephemeris element counter |
| baseQzsEphemerisCount | uint32_t | Base station qzs ephemeris element counter |
| roverSbasCount | uint32_t | Rover sbas element counter |
| baseSbasCount | uint32_t | Base station sbas element counter |
| baseAntennaCount | uint32_t | Base station antenna position element counter |
| ionUtcAlmCount | uint32_t | Ionosphere model, utc and almanac count |
| correctionChecksumFailures | uint32_t | Number of checksum failures from received corrections |
| timeToFirstFixMs | uint32_t | Time to first RTK fix. |


#### DID_GPS1_RTK_POS_REL

RTK precision position base to rover relative info. 

`gps_rtk_rel_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| differentialAge | float | Age of differential (seconds) |
| arRatio | float | Ambiguity resolution ratio factor for validation |
| baseToRoverVector | float[3] | Vector from base to rover (m) in ECEF - If Compassing enabled, this is the 3-vector from antenna 2 to antenna 1 |
| baseToRoverDistance | float | Distance from base to rover (m) |
| baseToRoverHeading | float | Angle from north to baseToRoverVector in local tangent plane. (rad) |
| baseToRoverHeadingAcc | float | Accuracy of baseToRoverHeading. (rad) |
| status | uint32_t | (see eGpsStatus) GPS status: [0x000000xx] number of satellites used, [0x0000xx00] fix type, [0x00xx0000] status flags, NMEA input flag |


#### DID_GPS1_SAT

GPS 1 GNSS satellite information: sat identifiers, carrier to noise ratio, elevation and azimuth angles, pseudo range residual. 

`gps_sat_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| numSats | uint32_t | Number of satellites in the sky |
| sat | gps_sat_sv_t[50] | Satellite information list |


#### DID_GPS1_VEL

GPS 1 velocity data 

`gps_vel_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| vel | float[3] | GPS Velocity.  Velocity is in ECEF {vx,vy,vz} (m/s) if status bit GNSS_STATUS_FLAGS_GNSS_NMEA_DATA (0x00008000) is NOT set.  Velocity is in local tangent plane with no vertical velocity {vNorth, vEast, 0} (m/s) if status bit GNSS_STATUS_FLAGS_GNSS_NMEA_DATA (0x00008000) is set. |
| sAcc | float | Speed accuracy in meters / second |
| status | uint32_t | (see eGpsStatus) GPS status: [0x000000xx] number of satellites used, [0x0000xx00] fix type, [0x00xx0000] status flags, NMEA input flag |


#### DID_GPS1_VERSION

GPS 1 version info 

`gps_version_t`

| Field | Type | Description |
|-------|------|-------------|
| swVersion | uint8_t[30] | Software version |
| hwVersion | uint8_t[10] | Hardware version |
| extension | gps_extension_ver_t[6] | Extension 30 bytes array description  |


#### DID_GPS2_POS

GPS 2 position data 

`gps_pos_t`

| Field | Type | Description |
|-------|------|-------------|
| week | uint32_t | GPS number of weeks since January 6th, 1980 |
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| status | uint32_t | (see eGpsStatus) GPS status: [0x000000xx] number of satellites used, [0x0000xx00] fix type, [0x00xx0000] status flags, NMEA input flag |
| ecef | double[3] | Position in ECEF {x,y,z} (m) |
| lla | double[3] | Position - WGS84 latitude, longitude, height above ellipsoid (not MSL) (degrees, m) |
| hMSL | float | Height above mean sea level (MSL) in meters |
| hAcc | float | Horizontal accuracy in meters |
| vAcc | float | Vertical accuracy in meters |
| pDop | float | Position dilution of precision (unitless) |
| cnoMean | float | Average of all non-zero satellite carrier to noise ratios (signal strengths) in dBHz |
| towOffset | double | Time sync offset between local time since boot up to GPS time of week in seconds.  Add this to IMU and sensor time to get GPS time of week in seconds. |
| leapS | uint8_t | GPS leap second (GPS-UTC) offset. Receiver's best knowledge of the leap seconds offset from UTC to GPS time. Subtract from GPS time of week to get UTC time of week. (18 seconds as of December 31, 2016) |
| satsUsed | uint8_t | Number of satellites used |
| cnoMeanSigma | uint8_t | Standard deviation of cnoMean over past 5 seconds (dBHz x10) |
| reserved | uint8_t | Reserved for future use |


#### DID_GPS2_RTK_CMP_MISC

RTK Dual GNSS RTK compassing related data. 

`gps_rtk_misc_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| accuracyPos | float[3] | Accuracy - estimated standard deviations of the solution assuming a priori error model and error parameters by the positioning options. []: standard deviations {ECEF - x,y,z} or {north, east, down} (meters) |
| accuracyCov | float[3] | Accuracy - estimated standard deviations of the solution assuming a priori error model and error parameters by the positioning options. []: Absolute value of means square root of estimated covariance NE, EU, UN |
| arThreshold | float | Ambiguity resolution threshold for validation |
| gDop | float | Geometric dilution of precision (meters) |
| hDop | float | Horizontal dilution of precision (meters) |
| vDop | float | Vertical dilution of precision (meters) |
| baseLla | double[3] | Base Position - latitude, longitude, height (degrees, meters) |
| cycleSlipCount | uint32_t | Cycle slip counter |
| roverGpsObservationCount | uint32_t | Rover gps observation element counter |
| baseGpsObservationCount | uint32_t | Base station gps observation element counter |
| roverGlonassObservationCount | uint32_t | Rover glonass observation element counter |
| baseGlonassObservationCount | uint32_t | Base station glonass observation element counter |
| roverGalileoObservationCount | uint32_t | Rover galileo observation element counter |
| baseGalileoObservationCount | uint32_t | Base station galileo observation element counter |
| roverBeidouObservationCount | uint32_t | Rover beidou observation element counter |
| baseBeidouObservationCount | uint32_t | Base station beidou observation element counter |
| roverQzsObservationCount | uint32_t | Rover qzs observation element counter |
| baseQzsObservationCount | uint32_t | Base station qzs observation element counter |
| roverGpsEphemerisCount | uint32_t | Rover gps ephemeris element counter |
| baseGpsEphemerisCount | uint32_t | Base station gps ephemeris element counter |
| roverGlonassEphemerisCount | uint32_t | Rover glonass ephemeris element counter |
| baseGlonassEphemerisCount | uint32_t | Base station glonass ephemeris element counter |
| roverGalileoEphemerisCount | uint32_t | Rover galileo ephemeris element counter |
| baseGalileoEphemerisCount | uint32_t | Base station galileo ephemeris element counter |
| roverBeidouEphemerisCount | uint32_t | Rover beidou ephemeris element counter |
| baseBeidouEphemerisCount | uint32_t | Base station beidou ephemeris element counter |
| roverQzsEphemerisCount | uint32_t | Rover qzs ephemeris element counter |
| baseQzsEphemerisCount | uint32_t | Base station qzs ephemeris element counter |
| roverSbasCount | uint32_t | Rover sbas element counter |
| baseSbasCount | uint32_t | Base station sbas element counter |
| baseAntennaCount | uint32_t | Base station antenna position element counter |
| ionUtcAlmCount | uint32_t | Ionosphere model, utc and almanac count |
| correctionChecksumFailures | uint32_t | Number of checksum failures from received corrections |
| timeToFirstFixMs | uint32_t | Time to first RTK fix. |


#### DID_GPS2_RTK_CMP_REL

Dual GNSS RTK compassing / moving base to rover (GPS 1 to GPS 2) relative info. 

`gps_rtk_rel_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| differentialAge | float | Age of differential (seconds) |
| arRatio | float | Ambiguity resolution ratio factor for validation |
| baseToRoverVector | float[3] | Vector from base to rover (m) in ECEF - If Compassing enabled, this is the 3-vector from antenna 2 to antenna 1 |
| baseToRoverDistance | float | Distance from base to rover (m) |
| baseToRoverHeading | float | Angle from north to baseToRoverVector in local tangent plane. (rad) |
| baseToRoverHeadingAcc | float | Accuracy of baseToRoverHeading. (rad) |
| status | uint32_t | (see eGpsStatus) GPS status: [0x000000xx] number of satellites used, [0x0000xx00] fix type, [0x00xx0000] status flags, NMEA input flag |


#### DID_GPS2_SAT

GPS 2 GNSS satellite information: sat identifiers, carrier to noise ratio, elevation and azimuth angles, pseudo range residual. 

`gps_sat_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| numSats | uint32_t | Number of satellites in the sky |
| sat | gps_sat_sv_t[50] | Satellite information list |


#### DID_GPS2_VEL

GPS 2 velocity data 

`gps_vel_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| vel | float[3] | GPS Velocity.  Velocity is in ECEF {vx,vy,vz} (m/s) if status bit GNSS_STATUS_FLAGS_GNSS_NMEA_DATA (0x00008000) is NOT set.  Velocity is in local tangent plane with no vertical velocity {vNorth, vEast, 0} (m/s) if status bit GNSS_STATUS_FLAGS_GNSS_NMEA_DATA (0x00008000) is set. |
| sAcc | float | Speed accuracy in meters / second |
| status | uint32_t | (see eGpsStatus) GPS status: [0x000000xx] number of satellites used, [0x0000xx00] fix type, [0x00xx0000] status flags, NMEA input flag |


#### DID_GPS2_VERSION

GPS 2 version info 

`gps_version_t`

| Field | Type | Description |
|-------|------|-------------|
| swVersion | uint8_t[30] | Software version |
| hwVersion | uint8_t[10] | Hardware version |
| extension | gps_extension_ver_t[6] | Extension 30 bytes array description  |


#### DID_GPS_RTK_OPT

RTK options - requires little endian CPU. 

`gps_rtk_opt_t`

| Field | Type | Description |
|-------|------|-------------|
| mode | int32_t | positioning mode (PMODE_???) |
| soltype | int32_t | solution type (0:forward,1:backward,2:combined) |
| nf | int32_t | number of frequencies (1:L1,2:L1+L2,3:L1+L2+L5) |
| navsys | int32_t | navigation systems |
| elmin | double | elevation mask angle (rad) |
| snrmin | int32_t | Min snr to consider satellite for rtk |
| snrrange | int32_t | AR mode (0:off,1:continuous,2:instantaneous,3:fix and hold,4:ppp-ar) |
| modear | int32_t | GLONASS AR mode (0:off,1:on,2:auto cal,3:ext cal) |
| glomodear | int32_t | GPS AR mode (0:off,1:on) |
| gpsmodear | int32_t | SBAS AR mode (0:off,1:on) |
| sbsmodear | int32_t | BeiDou AR mode (0:off,1:on) |
| bdsmodear | int32_t | AR filtering to reject bad sats (0:off,1:on) |
| arfilter | int32_t | obs outage count to reset bias |
| maxout | int32_t | reject count to reset bias |
| maxrej | int32_t | min lock count to fix ambiguity |
| minlock | int32_t | min sats to fix integer ambiguities |
| minfixsats | int32_t | min sats to hold integer ambiguities |
| minholdsats | int32_t | min sats to drop sats in AR |
| mindropsats | int32_t | use stdev estimates from receiver to adjust measurement variances |
| rcvstds | int32_t | min fix count to hold ambiguity |
| minfix | int32_t | max iteration to resolve ambiguity |
| armaxiter | int32_t | dynamics model (0:none,1:velociy,2:accel) |
| dynamics | int32_t | number of filter iteration |
| niter | int32_t | interpolate reference obs (for post mission) |
| intpref | int32_t | rover position for fixed mode |
| rovpos | int32_t | base position for relative mode |
| refpos | int32_t | code/phase error ratio |
| eratio | double[] | measurement error factor |
| err | double[7] | initial-state std [0]bias,[1]iono [2]trop |
| std | double[3] | process-noise std [0]bias,[1]iono [2]trop [3]acch [4]accv [5] pos |
| prn | double[6] | satellite clock stability (sec/sec) |
| sclkstab | double | AR validation threshold |
| thresar | double[8] | elevation mask of AR for rising satellite (rad) |
| elmaskar | double | elevation mask to hold ambiguity (rad) |
| elmaskhold | double | slip threshold of geometry-free phase (m) |
| thresslip | double | variance for fix-and-hold pseudo measurements (cycle^2) |
| thresdop | double | gain used for GLO and SBAS sats to adjust ambiguity |
| varholdamb | double | max difference of time (sec) |
| gainholdamb | double | reset sat biases after this long trying to get fix if not acquired |
| maxtdiff | double | reject threshold of innovation for phase [0] and code [1] (m) |
| fix_reset_base_msgs | int | reject thresholds of NIS for phase [0] and code [1] |
| maxinno | double[2] | reject threshold of gdop |
| maxnis_lo | double[2] | baseline length constraint {const,sigma before fix, sigma after fix} (m) |
| maxnis_hi | double[2] | maximum error wrt ubx position (triggers reset if more than this far) (m) |
| maxgdop | double | rover position for fixed mode {x,y,z} (ecef) (m) |
| baseline | double[3] | base position for relative mode {x,y,z} (ecef) (m) |
| max_baseline_error | double | max averaging epochs |
| reset_baseline_error | double | output single by dgps/float/fix/ppp outage |
| max_ubx_error | float | velocity constraint in compassing mode {var before fix, var after fix} (m^2/s^2)  |


### GPX

#### DID_GPX_DEV_INFO

GPX device information 

`dev_info_t`

| Field | Type | Description |
|-------|------|-------------|
| reserved | uint16_t | Reserved bits |
| hardwareType | uint8_t | Hardware Type: 1=uINS, 2=EVB, 3=IMX, 4=GPX (see eIsHardwareType) |
| reserved2 | uint8_t | Unused |
| serialNumber | uint32_t | Serial number |
| hardwareVer | uint8_t[4] | Hardware version |
| firmwareVer | uint8_t[4] | Firmware (software) version |
| buildNumber | uint32_t | Build number |
| protocolVer | uint8_t[4] | Communications protocol version |
| repoRevision | uint32_t | Repository revision number |
| manufacturer | char[24] | Manufacturer name |
| buildType | uint8_t | Build type (Release: 'a'=ALPHA, 'b'=BETA, 'c'=RELEASE CANDIDATE, 'r'=PRODUCTION RELEASE, 'd'=developer/debug) |
| buildYear | uint8_t | Build date year - 2000 |
| buildMonth | uint8_t | Build date month |
| buildDay | uint8_t | Build date day |
| buildHour | uint8_t | Build time hour |
| buildMinute | uint8_t | Build time minute |
| buildSecond | uint8_t | Build time second |
| buildMillisecond | uint8_t | Build time millisecond |
| addInfo | char[24] | Additional info |
| firmwareMD5Hash | uint32_t[4] | Firmware MD5 hash |


#### DID_GPX_FLASH_CFG

GPX flash configuration 

`gpx_flash_cfg_t`

| Field | Type | Description |
|-------|------|-------------|
| size | uint32_t | Size of this struct |
| checksum | uint32_t | Checksum, excluding size and checksum |
| key | uint32_t | Manufacturer method for restoring flash defaults |
| ser0BaudRate | uint32_t | Serial port 0 baud rate in bits per second |
| ser1BaudRate | uint32_t | Serial port 1 baud rate in bits per second |
| ser2BaudRate | uint32_t | Serial port 2 baud rate in bits per second |
| startupGNSSDtMs | uint32_t | GPS measurement (system input data) update period in milliseconds set on startup. 200ms minimum (5Hz max). |
| gps1AntOffset | float[3] | X,Y,Z offset in meters in Sensor Frame to GPS 1 antenna. |
| gps2AntOffset | float[3] | X,Y,Z offset in meters in Sensor Frame to GPS 2 antenna. |
| gnssSatSigConst | uint16_t | Satellite system constellation used in GNSS solution.  (see eGnssSatSigConst) 0x0003=GPS, 0x000C=QZSS, 0x0030=Galileo, 0x00C0=Beidou, 0x0300=GLONASS, 0x1000=SBAS |
| dynamicModel | uint8_t | Dynamic platform model (see eDynamicModel).  Options are: 0=PORTABLE, 2=STATIONARY, 3=PEDESTRIAN, 4=GROUND VEHICLE, 5=SEA, 6=AIRBORNE_1G, 7=AIRBORNE_2G, 8=AIRBORNE_4G, 9=WRIST.  Used to balance noise and performance characteristics of the system.  The dynamics selected here must be at least as fast as your system or you experience accuracy error.  This is tied to the GPS position estimation model and intend in the future to be incorporated into the INS position model. |
| debug | uint8_t | Debug |
| gpsTimeSyncPeriodMs | uint32_t | Time between GPS time synchronization pulses in milliseconds.  Requires reboot to take effect. |
| gpsTimeUserDelay | float | (sec) User defined delay for GPS time.  This parameter can be used to account for GPS antenna cable delay.  |
| gpsMinimumElevation | float | Minimum elevation of a satellite above the horizon to be used in the solution (radians). Low elevation satellites may provide degraded accuracy, due to the long signal path through the atmosphere. |
| RTKCfgBits | uint32_t | RTK configuration bits (see eRTKConfigBits). |
| gnssCn0Minimum | uint8_t | (dBHz) GNSS CN0 absolute minimum threshold for signals.  Used to filter signals in RTK solution. |
| gnssCn0DynMinOffset | uint8_t | (dBHz) GNSS CN0 dynamic minimum threshold offset below max CN0 across all satellites. Used to filter signals used in RTK solution. To disable, set gnssCn0DynMinOffset to zero and increase gnssCn0Minimum. |
| reserved1 | uint8_t[2] | Reserved |
| sysCfgBits | uint32_t | System configuration bits (see eGpxSysConfigBits). |
| reserved2 | uint32_t | Reserved |


#### DID_GPX_RMC

GPX rmc  

`rmc_t`

| Field | Type | Description |
|-------|------|-------------|
| bits | uint64_t | Data stream enable bits for the specified ports.  (see RMC_BITS_...) |
| options | uint32_t | Options to select alternate ports to output data, etc.  (see RMC_OPTIONS_...) |


#### DID_GPX_STATUS

GPX status 

`gpx_status_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| status | uint32_t | Status (eGpxStatus) |
| grmcBitsSer0 | uint64_t | GRMC BITS (see GRMC_BITS_...)  |
| grmcBitsSer1 | uint64_t | (see NMEA_MSG_ID...) |
| grmcBitsSer2 | uint64_t | Hardware status flags (eGPXHdwStatusFlags) |
| grmcBitsUSB | uint64_t | MCU temperature (GPX_INVALID_MCU_TEMP if not availible) |
| grmcNMEABitsSer0 | uint64_t | Nav output period (ms). |
| grmcNMEABitsSer1 | uint64_t | Flash config checksum used with host SDK synchronization |
| grmcNMEABitsSer2 | uint64_t | RTK Mode bits (see eRTKConfigBits)  |
| grmcNMEABitsUSB | uint64_t | port |


### Raw GPS Data

Raw GPS data is contained in the `DID_GPS1_RAW`, `DID_GPS2_RAW`, and `DID_GPS_BASE_RAW` messages of type `gps_raw_t`.  The actual raw data is contained in the union member `gps_raw_t.data` and should be interpreted based on the value of `gps_raw_t.dataType` (i.e. as observation, ephemeris, SBAS, or base station position).

#### DID_GPS1_RAW

GPS raw data for rover (observation, ephemeris, etc.) - requires little endian CPU. The contents of data can vary for this message and are determined by dataType field. RTK positioning or RTK compassing must be enabled to stream this message. 

`gps_raw_t`

| Field | Type | Description |
|-------|------|-------------|
| receiverIndex | uint8_t | Receiver index (1=RECEIVER_INDEX_GPS1, 2=RECEIVER_INDEX_EXTERNAL_BASE, or 3=RECEIVER_INDEX_GPS2) |
| dataType | uint8_t | Type of data (eRawDataType: 1=observations, 2=ephemeris, 3=glonassEphemeris, 4=SBAS, 5=baseAntenna, 6=IonosphereModel) |
| obsCount | uint8_t | Number of observations in data (obsd_t) when dataType==1 (raw_data_type_observation). |
| reserved | uint8_t | Reserved |
| data | uGpsRawData | Interpret based on dataType (see eRawDataType) |


#### DID_GPS2_RAW

GPS raw data for rover (observation, ephemeris, etc.) - requires little endian CPU. The contents of data can vary for this message and are determined by dataType field. RTK positioning or RTK compassing must be enabled to stream this message. 

`gps_raw_t`

| Field | Type | Description |
|-------|------|-------------|
| receiverIndex | uint8_t | Receiver index (1=RECEIVER_INDEX_GPS1, 2=RECEIVER_INDEX_EXTERNAL_BASE, or 3=RECEIVER_INDEX_GPS2) |
| dataType | uint8_t | Type of data (eRawDataType: 1=observations, 2=ephemeris, 3=glonassEphemeris, 4=SBAS, 5=baseAntenna, 6=IonosphereModel) |
| obsCount | uint8_t | Number of observations in data (obsd_t) when dataType==1 (raw_data_type_observation). |
| reserved | uint8_t | Reserved |
| data | uGpsRawData | Interpret based on dataType (see eRawDataType) |


#### DID_GPS_BASE_RAW

GPS raw data for base station (observation, ephemeris, etc.) - requires little endian CPU. The contents of data can vary for this message and are determined by dataType field. RTK positioning or RTK compassing must be enabled to stream this message. 

`gps_raw_t`

| Field | Type | Description |
|-------|------|-------------|
| receiverIndex | uint8_t | Receiver index (1=RECEIVER_INDEX_GPS1, 2=RECEIVER_INDEX_EXTERNAL_BASE, or 3=RECEIVER_INDEX_GPS2) |
| dataType | uint8_t | Type of data (eRawDataType: 1=observations, 2=ephemeris, 3=glonassEphemeris, 4=SBAS, 5=baseAntenna, 6=IonosphereModel) |
| obsCount | uint8_t | Number of observations in data (obsd_t) when dataType==1 (raw_data_type_observation). |
| reserved | uint8_t | Reserved |
| data | uGpsRawData | Interpret based on dataType (see eRawDataType) |


#### Raw GPS Data Buffer Union

`uGpsRawData`

| Field | Type | Description |
|-------|------|-------------|
| obs | obsd_t[] | Satellite observation data |
| eph | eph_t | Satellite non-GLONASS ephemeris data (GPS, Galileo, Beidou, QZSS) |
| gloEph | geph_t | Satellite GLONASS ephemeris data |
| sbas | sbsmsg_t | Satellite-Based Augmentation Systems (SBAS) data |
| sta | sta_t | Base station information (base position, antenna position, antenna height, etc.) |
| ion | ion_model_utc_alm_t | Ionosphere model and UTC parameters |
| buf | uint8_t[1000] | Byte buffer |


#### GPS Galileo QZSS Ephemeris

`eph_t`

| Field | Type | Description |
|-------|------|-------------|
| sat | int32_t | Satellite number in RTKlib notation.  GPS: 1-32, GLONASS: 33-59, Galilleo: 60-89, SBAS: 90-95 |
| iode | int32_t | IODE Issue of Data, Ephemeris (ephemeris version) |
| iodc | int32_t | IODC Issue of Data, Clock (clock version) |
| sva | int32_t | SV accuracy (URA index) IRN-IS-200H p.97 |
| svh | int32_t | SV health GPS/QZS (0:ok) |
| week | int32_t | GPS/QZS: gps week, GAL: galileo week |
| code | int32_t | GPS/QZS: code on L2. (00 = Invalid, 01 = P Code ON, 11 = C/A code ON, 11 = Invalid).  GAL/CMP: data sources |
| flag | int32_t | GPS/QZS: L2 P data flag (indicates that the NAV data stream was commanded OFF on the P-code of the in-phase component of the L2 channel). CMP: nav type |
| toe | gtime_t | Time Of Ephemeris, ephemeris reference epoch in seconds within the week (s) |
| toc | gtime_t | clock data reference time (s) (20.3.4.5) |
| ttr | gtime_t | T_trans (s) |
| A | double | Orbit semi-major axis (m) |
| e | double | Orbit eccentricity (non-dimensional)  |
| i0 | double | Orbit inclination angle at reference time (rad) |
| OMG0 | double | Longitude of ascending node of orbit plane at weekly epoch (rad) |
| omg | double | Argument of perigee (rad) |
| M0 | double | Mean anomaly at reference time (rad) |
| deln | double | Mean Motion Difference From Computed Value (rad) |
| OMGd | double | Rate of Right Ascension (rad/s) |
| idot | double | Rate of Inclination Angle (rad/s) |
| crc | double | Amplitude of the Cosine Harmonic Correction Term to the Orbit Radius (m) |
| crs | double | Amplitude of the Sine Harmonic Correction Term to the Orbit Radius (m) |
| cuc | double | Amplitude of the Cosine Harmonic Correction Term to the Argument of Latitude (rad)  |
| cus | double | Amplitude of the Sine Harmonic Correction Term to the Argument of Latitude (rad) |
| cic | double | Amplitude of the Cosine Harmonic Correction Term to the Angle of Inclination (rad) |
| cis | double | Amplitude of the Sine Harmonic Correction Term to the Angle of Inclination (rad) |
| toes | double | Time Of Ephemeris, ephemeris reference epoch in seconds within the week (s), same as <toe> above but represented as double type. Note that toe is computed as eph->toe = gst2time(week, eph->toes). This is the expiration time and is generally ~2 hours ahead of current time. |
| fit | double | Fit interval (h) (0: 4 hours, 1: greater than 4 hours) |
| f0 | double | SV clock offset, af0 (s) |
| f1 | double | SV clock drift, af1 (s/s, non-dimensional) |
| f2 | double | SV clock drift rate, af2 (1/s) |
| tgd | double[4] | Group delay parameters GPS/QZS: tgd[0] = TGD (IRN-IS-200H p.103). Galilleo: tgd[0] = BGD E5a/E1, tgd[1] = BGD E5b/E1. Beidou: tgd[0] = BGD1, tgd[1] = BGD2 |
| Adot | double | Adot for CNAV, not used |
| ndot | double | First derivative of mean motion n (second derivative of mean anomaly M), ndot for CNAV (rad/s/s). Not used. |


#### GLONASS Ephemeris

`geph_t`

| Field | Type | Description |
|-------|------|-------------|
| sat | int32_t | Satellite number in RTKlib notation.  GPS: 1-32, GLONASS: 33-59, Galilleo: 60-89, SBAS: 90-95 |
| iode | int32_t | IODE (0-6 bit of tb field) |
| frq | int32_t | satellite frequency number |
| svh | int32_t | satellite health |
| sva | int32_t | satellite accuracy |
| age | int32_t | satellite age of operation |
| toe | gtime_t | Ephemeris reference epoch in seconds within the week in GPS time gpst (s) |
| tof | gtime_t | message frame time in gpst (s) |
| pos | double[3] | satellite position (ecef) (m) |
| vel | double[3] | satellite velocity (ecef) (m/s) |
| acc | double[3] | satellite acceleration (ecef) (m/s^2) |
| taun | double | SV clock bias (s) |
| gamn | double | relative frequency bias |
| dtaun | double | delay between L1 and L2 (s) |


#### SBAS

`sbsmsg_t`

| Field | Type | Description |
|-------|------|-------------|
| week | int32_t | receiption time - week |
| tow | int32_t | reception time - tow |
| prn | int32_t | SBAS satellite PRN number |
| msg | uint8_t[29] | SBAS message (226bit) padded by 0 |
| reserved | uint8_t[3] | reserved for alighment |


#### Station Parameters

`sta_t`

| Field | Type | Description |
|-------|------|-------------|
| deltype | int32_t | antenna delta type (0:enu,1:xyz) |
| pos | double[3] | station position (ecef) (m) |
| del | double[3] | antenna position delta (e/n/u or x/y/z) (m) |
| hgt | double | antenna height (m) |
| stationId | int32_t | station id |


#### Satellite Observation

`obs_t`

| Field | Type | Description |
|-------|------|-------------|
| n | uint32_t | number of observation slots used |
| nmax | uint32_t | number of observation slots allocated |
| data | obsd_t | observation data buffer |


#### Satellite information

`gps_sat_sv_t`

| Field | Type | Description |
|-------|------|-------------|
| gnssId | uint8_t | GNSS identifier (see eSatSvGnssId) |
| svId | uint8_t | Satellite identifier |
| elev | int8_t | (deg) Elevation (range: +/-90) |
| azim | int16_t | (deg) Azimuth (range: +/-180) |
| cno | uint8_t | (dBHz) Carrier to noise ratio (signal strength) |
| status | uint16_t | (see eSatSvStatus) |


#### Inertial Measurement Unit (IMU)

`imus_t`

| Field | Type | Description |
|-------|------|-------------|
| pqr | float[3] | Gyroscope P, Q, R in radians / second |
| acc | float[3] | Acceleration X, Y, Z in meters / second squared |


### Configuration

#### DID_FLASH_CONFIG

Flash memory configuration 

`nvm_flash_cfg_t`

| Field | Type | Description |
|-------|------|-------------|
| size | uint32_t | Size of group or union, which is nvm_group_x_t + padding |
| checksum | uint32_t | Checksum, excluding size and checksum |
| key | uint32_t | Manufacturer method for restoring flash defaults |
| startupImuDtMs | uint32_t | IMU sample (system input) period in milliseconds set on startup. Cannot be larger than startupNavDtMs. Zero disables sensor/IMU sampling. |
| startupNavDtMs | uint32_t | Navigation filter (system output) output period in milliseconds set on startup.  Used to initialize sysParams.navOutputPeriodMs. |
| ser0BaudRate | uint32_t | Serial port 0 baud rate in bits per second |
| ser1BaudRate | uint32_t | Serial port 1 baud rate in bits per second |
| insRotation | float[3] | Rotation in radians about the X,Y,Z axes from Sensor Frame to Intermediate Output Frame.  Order applied: Z,Y,X. |
| insOffset | float[3] | X,Y,Z offset in meters from Intermediate Output Frame to INS Output Frame. |
| gps1AntOffset | float[3] | X,Y,Z offset in meters in Sensor Frame to GPS 1 antenna. |
| dynamicModel | uint8_t | INS dynamic platform model (see eDynamicModel).  Options are: 0=PORTABLE, 2=STATIONARY, 3=PEDESTRIAN, 4=GROUND VEHICLE, 5=SEA, 6=AIRBORNE_1G, 7=AIRBORNE_2G, 8=AIRBORNE_4G, 9=WRIST.  Used to balance noise and performance characteristics of the system.  The dynamics selected here must be at least as fast as your system or you experience accuracy error.  This is tied to the GPS position estimation model and intend in the future to be incorporated into the INS position model. |
| debug | uint8_t | Debug |
| gnssSatSigConst | uint16_t | Satellite system constellation used in GNSS solution.  (see eGnssSatSigConst) 0x0003=GPS, 0x000C=QZSS, 0x0030=Galileo, 0x00C0=Beidou, 0x0300=GLONASS, 0x1000=SBAS |
| sysCfgBits | uint32_t | System configuration bits (see eSysConfigBits). |
| refLla | double[3] | Reference latitude, longitude and height above ellipsoid for north east down (NED) calculations (deg, deg, m) |
| lastLla | double[3] | Last latitude, longitude, HAE (height above ellipsoid) used to aid GPS startup (deg, deg, m).  Updated when the distance between current LLA and lastLla exceeds lastLlaUpdateDistance. |
| lastLlaTimeOfWeekMs | uint32_t | Last LLA GPS time since week start (Sunday morning) in milliseconds |
| lastLlaWeek | uint32_t | Last LLA GPS number of weeks since January 6th, 1980 |
| lastLlaUpdateDistance | float | Distance between current and last LLA that triggers an update of lastLla  |
| ioConfig | uint32_t | Hardware interface configuration bits (see eIoConfig). |
| platformConfig | uint32_t | Hardware platform specifying the IMX carrier board type (i.e. RUG, EVB, IG) and configuration bits (see ePlatformConfig).  The platform type is used to simplify the GPS and I/O configuration process.  Bit PLATFORM_CFG_UPDATE_IO_CONFIG is excluded from the flashConfig checksum and from determining whether to upload. |
| gps2AntOffset | float[3] | X,Y,Z offset in meters in Sensor Frame origin to GPS 2 antenna. |
| zeroVelRotation | float[3] | Euler (roll, pitch, yaw) rotation in radians from INS Sensor Frame to Intermediate ZeroVelocity Frame.  Order applied: heading, pitch, roll. |
| zeroVelOffset | float[3] | X,Y,Z offset in meters from Intermediate ZeroVelocity Frame to Zero Velocity Frame. |
| gpsTimeUserDelay | float | (sec) User defined delay for GPS time.  This parameter can be used to account for GPS antenna cable delay.  |
| magDeclination | float | Earth magnetic field (magnetic north) declination (heading offset from true north) in radians |
| gpsTimeSyncPeriodMs | uint32_t | Time between GPS time synchronization pulses in milliseconds.  Requires reboot to take effect. |
| startupGNSSDtMs | uint32_t | GPS measurement (system input) update period in milliseconds set on startup. 200ms minimum (5Hz max). |
| RTKCfgBits | uint32_t | RTK configuration bits (see eRTKConfigBits). |
| sensorConfig | uint32_t | Sensor config to specify the full-scale sensing ranges and output rotation for the IMU and magnetometer (see eSensorConfig) |
| gpsMinimumElevation | float | Minimum elevation of a satellite above the horizon to be used in the solution (radians). Low elevation satellites may provide degraded accuracy, due to the long signal path through the atmosphere. |
| ser2BaudRate | uint32_t | Serial port 2 baud rate in bits per second |
| wheelConfig | wheel_config_t | Wheel encoder: euler angles describing the rotation from imu to left wheel |
| magInterferenceThreshold | float | Magnetometer interference sensitivity threshold. Typical range is 2-10 (3 default) and 1000 to disable mag interference detection. |
| magCalibrationQualityThreshold | float | Magnetometer calibration quality sensitivity threshold. Typical range is 10-20 (10 default) and 1000 to disable mag calibration quality check, forcing it to be always good. |
| gnssCn0Minimum | uint8_t | (dBHz) GNSS CN0 absolute minimum threshold for signals.  Used to filter signals in RTK solution. |
| gnssCn0DynMinOffset | uint8_t | (dBHz) GNSS CN0 dynamic minimum threshold offset below max CN0 across all satellites. Used to filter signals used in RTK solution. To disable, set gnssCn0DynMinOffset to zero and increase gnssCn0Minimum. |
| imuRejectThreshGyroLow | uint8_t | IMU gyro fault rejection threshold low |
| imuRejectThreshGyroHigh | uint8_t | IMU gyro fault rejection threshold high |
| reserved2 | uint32_t[2] | Reserved |


#### DID_NMEA_BCAST_PERIOD

Set broadcast periods for NMEA messages 

`nmea_msgs_t`

| Field | Type | Description |
|-------|------|-------------|
| options | uint32_t | Options: Port selection[0x0=current, 0x1=ser0, 0x2=ser1, 0x4=ser2, 0x8=USB, 0x100=preserve, 0x200=Persistent] (see RMC_OPTIONS_...) |
| nmeaBroadcastMsgs | nmeaBroadcastMsgPair_t[20] | NMEA message to be set.  Up to 20 message ID/period pairs.  Message ID of zero indicates the remaining pairs are not used. (see eNmeaMsgId) |


#### DID_RMC

Realtime Message Controller (RMC). The data sets available through RMC are driven by the availability of the data. The RMC provides updates from various data sources (i.e. sensors) as soon as possible with minimal latency. Several of the data sources (sensors) output data at different data rates that do not all correspond. The RMC is provided so that broadcast of sensor data is done as soon as it becomes available. All RMC messages can be enabled using the standard Get Data packet format. 

`rmc_t`

| Field | Type | Description |
|-------|------|-------------|
| bits | uint64_t | Data stream enable bits for the specified ports.  (see RMC_BITS_...) |
| options | uint32_t | Options to select alternate ports to output data, etc.  (see RMC_OPTIONS_...) |


### Command

#### DID_SYS_CMD

System commands. Both the command and invCommand fields must be set at the same time for a command to take effect. 

`system_command_t`

| Field | Type | Description |
|-------|------|-------------|
| command | uint32_t | System commands (see eSystemCommand) 1=save current persistent messages, 5=zero motion, 97=save flash, 99=software reset.  "invCommand" (following variable) must be set to bitwise inverse of this value for this command to be processed.  |
| invCommand | uint32_t | Error checking field that must be set to bitwise inverse of command field for the command to take effect.  |


### EVB-2

#### DID_EVB_FLASH_CFG

EVB configuration. 

`evb_flash_cfg_t`

| Field | Type | Description |
|-------|------|-------------|
| size | uint32_t | Size of this struct |
| checksum | uint32_t | Checksum, excluding size and checksum |
| key | uint32_t | Manufacturer method for restoring flash defaults |
| cbPreset | uint8_t | Communications bridge preset. (see eEvb2ComBridgePreset) |
| reserved1 | uint8_t[3] | Communications bridge forwarding |
| cbf | uint32_t[EVB2_PORT_COUNT] | Communications bridge options (see eEvb2ComBridgeOptions) |
| cbOptions | uint32_t | Config bits (see eEvbFlashCfgBits) |
| bits | uint32_t | Radio preamble ID (PID) - 0x0 to 0x9. Only radios with matching PIDs can communicate together. Different PIDs minimize interference between multiple sets of networks. Checked before the network ID. |
| radioPID | uint32_t | Radio network ID (NID) - 0x0 to 0x7FFF. Only radios with matching NID can communicate together. Checked after the preamble ID. |
| radioNID | uint32_t | Radio power level - Transmitter output power level. (XBee PRO SX 0=20dBm, 1=27dBm, 2=30dBm)  |
| radioPowerLevel | uint32_t | WiFi SSID and PSK |
| wifi | evb_wifi_t[3] | Server IP and port |
| server | evb_server_t[3] | Encoder tick to wheel rotation conversion factor (in radians).  Encoder tick count per revolution on 1 channel x gear ratio x 2pi. |
| encoderTickToWheelRad | float | CAN baudrate |
| CANbaud_kbps | uint32_t | CAN receive address |
| can_receive_address | uint32_t | EVB port for uINS communications and SD card logging. 0=uINS-Ser0 (default), 1=uINS-Ser1, SP330=5, 6=GPIO_H8 (use eEvb2CommPorts) |
| uinsComPort | uint8_t | EVB port for uINS aux com and RTK corrections. 0=uINS-Ser0, 1=uINS-Ser1 (default), 5=SP330, 6=GPIO_H8 (use eEvb2CommPorts) |
| uinsAuxPort | uint8_t | Enable radio RTK filtering, etc. (see eEvb2PortOptions) |
| reserved2 | uint8_t[2] | Baud rate for EVB serial port H3 (SP330 RS233 and RS485/422). |
| portOptions | uint32_t | Baud rate for EVB serial port H4 (TLL to external radio). |
| h3sp330BaudRate | uint32_t | Baud rate for EVB serial port H8 (TLL). |
| h4xRadioBaudRate | uint32_t | Wheel encoder configuration (see eWheelCfgBits) |
| h8gpioBaudRate | uint32_t | Wheel update period.  Sets the wheel encoder and control update period. (ms) |


#### DID_EVB_STATUS

EVB monitor and log control interface. 

`evb_status_t`

| Field | Type | Description |
|-------|------|-------------|
| week | uint32_t | GPS number of weeks since January 6th, 1980 |
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| firmwareVer | uint8_t[4] | Firmware (software) version |
| evbStatus | uint32_t | Status (eEvbStatus) |
| loggerMode | uint32_t | Data logger control state. (see eEvb2LoggerMode) |
| loggerElapsedTimeMs | uint32_t | logger |
| wifiIpAddr | uint32_t | WiFi IP address |
| sysCommand | uint32_t | System command (see eSystemCommand).  99 = software reset |
| towOffset | double | Time sync offset between local time since boot up to GPS time of week in seconds.  Add this to IMU and sensor time to get GPS time of week in seconds. |


### General

#### DID_BIT

System built-in self-test 

`bit_t`

| Field | Type | Description |
|-------|------|-------------|
| command | uint8_t | BIT input command (see eBitCommand).  Ignored when zero.  |
| lastCommand | uint8_t | BIT last input command (see eBitCommand) |
| state | uint8_t | BIT current state (see eBitState) |
| reserved | uint8_t | Unused |
| hdwBitStatus | uint32_t | Hardware BIT status (see eHdwBitStatusFlags) |
| calBitStatus | uint32_t | Calibration BIT status (see eCalBitStatusFlags) |
| tcPqrBias | float | Temperature calibration bias |
| tcAccBias | float | Temperature calibration slope |
| tcPqrSlope | float | Temperature calibration linearity |
| tcAccSlope | float | Gyro error (rad/s) |
| tcPqrLinearity | float | Accelerometer error (m/s^2) |
| tcAccLinearity | float | Angular rate standard deviation |
| pqr | float | Acceleration standard deviation |
| acc | float | Self-test mode (see eBitTestMode) |
| pqrSigma | float | Self-test mode bi-directional variable used with testMode |
| accSigma | float | The hardware type detected (see "Product Hardware ID").  This is used to ensure correct firmware is used. |


#### DID_CAN_CONFIG

Addresses for CAN messages

`can_config_t`

| Field | Type | Description |
|-------|------|-------------|
| can_period_mult | uint16_t[] | Broadcast period multiple - CAN time message. 0 to disable. |
| can_transmit_address | uint32_t[] | Transmit address. |
| can_baudrate_kbps | uint16_t | Baud rate (kbps)  (See can_baudrate_t for valid baud rates)  |
| can_receive_address | uint32_t | Receive address. |


#### DID_DEV_INFO

Device information 

`dev_info_t`

| Field | Type | Description |
|-------|------|-------------|
| reserved | uint16_t | Reserved bits |
| hardwareType | uint8_t | Hardware Type: 1=uINS, 2=EVB, 3=IMX, 4=GPX (see eIsHardwareType) |
| reserved2 | uint8_t | Unused |
| serialNumber | uint32_t | Serial number |
| hardwareVer | uint8_t[4] | Hardware version |
| firmwareVer | uint8_t[4] | Firmware (software) version |
| buildNumber | uint32_t | Build number |
| protocolVer | uint8_t[4] | Communications protocol version |
| repoRevision | uint32_t | Repository revision number |
| manufacturer | char[24] | Manufacturer name |
| buildType | uint8_t | Build type (Release: 'a'=ALPHA, 'b'=BETA, 'c'=RELEASE CANDIDATE, 'r'=PRODUCTION RELEASE, 'd'=developer/debug) |
| buildYear | uint8_t | Build date year - 2000 |
| buildMonth | uint8_t | Build date month |
| buildDay | uint8_t | Build date day |
| buildHour | uint8_t | Build time hour |
| buildMinute | uint8_t | Build time minute |
| buildSecond | uint8_t | Build time second |
| buildMillisecond | uint8_t | Build time millisecond |
| addInfo | char[24] | Additional info |
| firmwareMD5Hash | uint32_t[4] | Firmware MD5 hash |


#### DID_DIAGNOSTIC_MESSAGE

Diagnostic message 

`diag_msg_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| messageLength | uint32_t | Message length, including null terminator |
| message | char[256] | Message data, max size of message is 256 |


#### DID_EVB_DEBUG_ARRAY



`debug_array_t`

| Field | Type | Description |
|-------|------|-------------|


#### DID_EVB_DEV_INFO

EVB device information 

`dev_info_t`

| Field | Type | Description |
|-------|------|-------------|
| reserved | uint16_t | Reserved bits |
| hardwareType | uint8_t | Hardware Type: 1=uINS, 2=EVB, 3=IMX, 4=GPX (see eIsHardwareType) |
| reserved2 | uint8_t | Unused |
| serialNumber | uint32_t | Serial number |
| hardwareVer | uint8_t[4] | Hardware version |
| firmwareVer | uint8_t[4] | Firmware (software) version |
| buildNumber | uint32_t | Build number |
| protocolVer | uint8_t[4] | Communications protocol version |
| repoRevision | uint32_t | Repository revision number |
| manufacturer | char[24] | Manufacturer name |
| buildType | uint8_t | Build type (Release: 'a'=ALPHA, 'b'=BETA, 'c'=RELEASE CANDIDATE, 'r'=PRODUCTION RELEASE, 'd'=developer/debug) |
| buildYear | uint8_t | Build date year - 2000 |
| buildMonth | uint8_t | Build date month |
| buildDay | uint8_t | Build date day |
| buildHour | uint8_t | Build time hour |
| buildMinute | uint8_t | Build time minute |
| buildSecond | uint8_t | Build time second |
| buildMillisecond | uint8_t | Build time millisecond |
| addInfo | char[24] | Additional info |
| firmwareMD5Hash | uint32_t[4] | Firmware MD5 hash |


#### DID_EVB_RTOS_INFO

EVB-2 RTOS information. 

`evb_rtos_info_t`

| Field | Type | Description |
|-------|------|-------------|
| freeHeapSize | uint32_t | Heap high water mark bytes |
| mallocSize | uint32_t | Total memory allocated using RTOS pvPortMalloc() |
| freeSize | uint32_t | Total memory freed using RTOS vPortFree() |
| task | rtos_task_t[] | Tasks |


#### DID_EVENT

`did_event_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time (uptime in seconds) |
| senderSN | uint32_t | Serial number |
| senderHdwId | uint16_t | Hardware: 0=Host, 1=uINS, 2=EVB, 3=IMX, 4=GPX (see "Product Hardware ID") |
| priority | int8_t | see eEventPriority |
| res8 | uint8_t | see eEventMsgTypeID |


#### DID_EVENT_HEADER_SIZE

`did_event_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time (uptime in seconds) |
| senderSN | uint32_t | Serial number |
| senderHdwId | uint16_t | Hardware: 0=Host, 1=uINS, 2=EVB, 3=IMX, 4=GPX (see "Product Hardware ID") |
| priority | int8_t | see eEventPriority |
| res8 | uint8_t | see eEventMsgTypeID |


#### DID_GPS1_SIG

GPS 1 GNSS signal information. 

`gps_sig_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| numSigs | uint32_t | Number of satellite signals in the following satelliate signal list |
| sig | gps_sig_sv_t[100] | Satellite signal list |


#### DID_GPS1_TIMEPULSE

GPS1 PPS time synchronization. 

`gps_timepulse_t`

| Field | Type | Description |
|-------|------|-------------|


#### DID_GPS2_SIG

GPS 2 GNSS signal information. 

`gps_sig_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| numSigs | uint32_t | Number of satellite signals in the following satelliate signal list |
| sig | gps_sig_sv_t[100] | Satellite signal list |


#### DID_GPX_BIT

GPX BIT test 

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

GPX debug 

`debug_array_t`

| Field | Type | Description |
|-------|------|-------------|


#### DID_GPX_PORT_MONITOR

Data rate and status monitoring for each communications port. 

`port_monitor_t`

| Field | Type | Description |
|-------|------|-------------|
| port | port_monitor_set_t[4] | Port monitor set |


#### DID_GPX_RTOS_INFO

GPX RTOs info 

`gpx_rtos_info_t`

| Field | Type | Description |
|-------|------|-------------|
| freeHeapSize | uint32_t | Heap high water mark bytes |
| mallocSize | uint32_t | Total memory allocated using RTOS pvPortMalloc() |
| freeSize | uint32_t | Total memory freed using RTOS vPortFree() |
| task | rtos_task_t[] | Tasks |


#### DID_GROUND_VEHICLE

Static configuration for wheel transform measurements. 

`ground_vehicle_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| status | uint32_t | Ground vehicle status flags (eGroundVehicleStatus) |
| mode | uint32_t | Current mode of the ground vehicle.  Use this field to apply commands. (see eGroundVehicleMode) |
| wheelConfig | wheel_config_t | Wheel transform, track width, and wheel radius. |


#### DID_IMU3_RAW

Triple IMU data calibrated from DID_IMU3_UNCAL.  We recommend use of DID_IMU or DID_PIMU as they are oversampled and contain less noise. 

`imu3_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds.  Convert to GPS time of week by adding gps.towOffset |
| status | uint32_t | IMU Status (eImuStatus) |
| I | imus_t[3] | Inertial Measurement Units (IMUs) |


#### DID_IMU3_UNCAL

Uncalibrated triple IMU data.  We recommend use of DID_IMU or DID_PIMU as they are calibrated and oversampled and contain less noise.  Minimum data period is DID_FLASH_CONFIG.startupImuDtMs or 4, whichever is larger (250Hz max). 

`imu3_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds.  Convert to GPS time of week by adding gps.towOffset |
| status | uint32_t | IMU Status (eImuStatus) |
| I | imus_t[3] | Inertial Measurement Units (IMUs) |


#### DID_IMU_MAG

DID_IMU + DID_MAGNETOMETER. Only one of DID_IMU_MAG or DID_PIMU_MAG should be streamed simultaneously. 

`imu_mag_t`

| Field | Type | Description |
|-------|------|-------------|
| imu | imu_t | imu - raw or pre-integrated depending on data id |
| mag | magnetometer_t | mag |


#### DID_INFIELD_CAL

Measure and correct IMU calibration error.  Estimate INS rotation to align INS with vehicle. 

`infield_cal_t`

| Field | Type | Description |
|-------|------|-------------|
| state | uint32_t | Used to set and monitor the state of the infield calibration system. (see eInfieldCalState) |
| status | uint32_t | Infield calibration status. (see eInfieldCalStatus) |
| sampleTimeMs | uint32_t | Number of samples used in IMU average. sampleTimeMs = 0 means "imu" member contains the IMU bias from flash.  |
| imu | imus_t[3] | Dual purpose variable.  1.) This is the averaged IMU sample when sampleTimeMs != 0.  2.) This is a mirror of the motion calibration IMU bias from flash when sampleTimeMs = 0. |
| calData | infield_cal_vaxis_t[3] | Collected data used to solve for the bias error and INS rotation.  Vertical axis: 0 = X, 1 = Y, 2 = Z  |


#### DID_INL2_MAG_OBS_INFO

INL2 magnetometer calibration information. 

`inl2_mag_obs_info_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | Timestamp in milliseconds |
| Ncal_samples | uint32_t | Number of calibration samples |
| ready | uint32_t | Data ready to be processed |
| calibrated | uint32_t | Calibration data present.  Set to -1 to force mag recalibration. |
| auto_recal | uint32_t | Allow mag to auto-recalibrate |
| outlier | uint32_t | Bad sample data |
| magHdg | float | Heading from magnetometer |
| insHdg | float | Heading from INS |
| magInsHdgDelta | float | Difference between mag heading and (INS heading plus mag declination) |
| nis | float | Normalized innovation squared (likelihood metric) |
| nis_threshold | float | Threshold for maximum NIS |
| Wcal | float[9] | Magnetometer calibration matrix. Must be initialized with a unit matrix, not zeros! |
| activeCalSet | uint32_t | Active calibration set (0 or 1) |
| magHdgOffset | float | Offset between magnetometer heading and estimate heading |
| Tcal | float | Scaled computed variance between calibrated magnetometer samples.  |
| bias_cal | float[3] | Calibrated magnetometer output can be produced using: Bcal = Wcal * (Braw - bias_cal) |


#### DID_INL2_NED_SIGMA

Standard deviation of INL2 EKF estimates in the NED frame. 

`inl2_ned_sigma_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | unsigned | Timestamp in milliseconds |
| StdPosNed | float[3] | NED position error sigma |
| StdVelNed | float[3] | NED velocity error sigma |
| StdAttNed | float[3] | NED attitude error sigma |
| StdAccBias | float[3] | Acceleration bias error sigma |
| StdGyrBias | float[3] | Angular rate bias error sigma |
| StdBarBias | float | Barometric altitude bias error sigma |
| StdMagDeclination | float | Mag declination error sigma |


#### DID_INL2_STATES

INS Extended Kalman Filter (EKF) states 

`inl2_states_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeek | double | GPS time of week (since Sunday morning) in seconds |
| qe2b | float[4] | Quaternion body rotation with respect to ECEF |
| ve | float[3] | (m/s) Velocity in ECEF frame |
| ecef | double[3] | (m)     Position in ECEF frame |
| biasPqr | float[3] | (rad/s) Gyro bias |
| biasAcc | float[3] | (m/s^2) Accelerometer bias |
| biasBaro | float | (m)     Barometer bias |
| magDec | float | (rad)   Magnetic declination |
| magInc | float | (rad)   Magnetic inclination |


#### DID_INL2_STATUS



`inl2_status_t`

| Field | Type | Description |
|-------|------|-------------|


#### DID_IO

I/O 

`io_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| gpioStatus | uint32_t | General purpose I/O status |


#### DID_MANUFACTURING_INFO

Manufacturing info 

`manufacturing_info_t`

| Field | Type | Description |
|-------|------|-------------|
| serialNumber | uint32_t | Inertial Sense serial number |
| hardwareId | uint16_t | Hardware ID: This is a packed identifier, which includes the Hardware Type, hardwareVer Major, and hardwareVer Minor |
| lotNumber | uint16_t | Inertial Sense lot number |
| date | char[16] | Inertial Sense manufacturing date (YYYYMMDDHHMMSS) |
| key | uint32_t | Key - write: unlock manufacturing info, read: number of times OTP has been set, 15 max |
| platformType | int32_t | Platform / carrier board (ePlatformConfig::PLATFORM_CFG_TYPE_MASK).  Only valid if greater than zero. |
| reserved | int32_t | Microcontroller unique identifier, 128 bits for SAM / 96 for STM32 |


#### DID_PIMU_MAG

DID_PIMU + DID_MAGNETOMETER. Only one of DID_IMU_MAG or DID_PIMU_MAG should be streamed simultaneously. 

`pimu_mag_t`

| Field | Type | Description |
|-------|------|-------------|
| pimu | pimu_t | Preintegrated IMU |
| mag | magnetometer_t | Magnetometer |


#### DID_PORT_MONITOR

Data rate and status monitoring for each communications port. 

`port_monitor_t`

| Field | Type | Description |
|-------|------|-------------|
| port | port_monitor_set_t[4] | Port monitor set |


#### DID_POSITION_MEASUREMENT

External position estimate 

`pos_measurement_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeek | double | GPS time of week (since Sunday morning) in seconds |
| ecef | double[3] | Position in ECEF (earth-centered earth-fixed) frame in meters |
| psi | float | Heading with respect to NED frame (rad |


#### DID_REFERENCE_IMU

Raw reference or truth IMU used for manufacturing calibration and testing. Input from testbed. 

`imu_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds.  Convert to GPS time of week by adding gps.towOffset |
| status | uint32_t | IMU Status (eImuStatus) |
| I | imus_t | Inertial Measurement Unit (IMU) |


#### DID_REFERENCE_MAGNETOMETER

Reference or truth magnetometer used for manufacturing calibration and testing 

`magnetometer_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds.  Convert to GPS time of week by adding gps.towOffset |
| mag | float[3] | Magnetometers |


#### DID_REFERENCE_PIMU

Reference or truth IMU used for manufacturing calibration and testing 

`pimu_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds.  Convert to GPS time of week by adding gps.towOffset |
| dt | float | Integral period in seconds for delta theta and delta velocity.  This is configured using DID_FLASH_CONFIG.startupNavDtMs. |
| status | uint32_t | IMU Status (eImuStatus) |
| theta | float[3] | IMU delta theta (gyroscope {p,q,r} integral) in radians in sensor frame |
| vel | float[3] | IMU delta velocity (accelerometer {x,y,z} integral) in m/s in sensor frame |


#### DID_ROS_COVARIANCE_POSE_TWIST

INL2 EKF covariances matrix lower diagonals 

`ros_covariance_pose_twist_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeek | double | GPS time of week (since Sunday morning) in seconds |
| covPoseLD | float[21] | (rad^2, m^2)  EKF attitude and position error covariance matrix lower diagonal in body (attitude) and ECEF (position) frames |
| covTwistLD | float[21] | ((m/s)^2, (rad/s)^2)   EKF velocity and angular rate error covariance matrix lower diagonal in ECEF (velocity) and body (attitude) frames |


#### DID_RTOS_INFO

RTOS information. 

`rtos_info_t`

| Field | Type | Description |
|-------|------|-------------|
| freeHeapSize | uint32_t | Heap high water mark bytes |
| mallocSize | uint32_t | Total memory allocated using RTOS pvPortMalloc() |
| freeSize | uint32_t | Total memory freed using RTOS vPortFree() |
| task | rtos_task_t[] | Tasks |


#### DID_RUNTIME_PROFILER

System runtime profiler 

`runtime_profiler_t`

| Field | Type | Description |
|-------|------|-------------|


#### DID_SCOMP



`sensor_compensation_t`

| Field | Type | Description |
|-------|------|-------------|


#### DID_SENSORS_ADC



`sys_sensors_adc_t`

| Field | Type | Description |
|-------|------|-------------|


#### DID_SENSORS_ADC_SIGMA



`sys_sensors_adc_t`

| Field | Type | Description |
|-------|------|-------------|


#### DID_SENSORS_MCAL

Temperature compensated and motion calibrated IMU output. 

`sensors_w_temp_t`

| Field | Type | Description |
|-------|------|-------------|
| imu3 | imu3_t | (°C) Temperature of IMU.  Units only apply for calibrated data. |
| temp | float[3] | (uT) Magnetometers.  Units only apply for calibrated data. |


#### DID_SENSORS_TCAL

Temperature compensated IMU output. 

`sensors_w_temp_t`

| Field | Type | Description |
|-------|------|-------------|
| imu3 | imu3_t | (°C) Temperature of IMU.  Units only apply for calibrated data. |
| temp | float[3] | (uT) Magnetometers.  Units only apply for calibrated data. |


#### DID_SENSORS_TC_BIAS



`sensors_t`

| Field | Type | Description |
|-------|------|-------------|
| time | double | Time since boot up in seconds.  Convert to GPS time of week by adding gps.towOffset |
| temp | float | Temperature in Celsius |
| pqr | float[3] | Gyros in radians / second |
| acc | float[3] | Accelerometers in meters / second squared |
| mag | float[3] | Magnetometers |
| bar | float | Barometric pressure in kilopascals |
| barTemp | float | Temperature of barometric pressure sensor in Celsius |
| mslBar | float | MSL altitude from barometric pressure sensor in meters |
| humidity | float | Relative humidity as a percent (%rH). Range is 0% - 100% |
| vin | float | EVB system input voltage in volts. uINS pin 5 (G2/AN2).  Use 10K/1K resistor divider between Vin and GND.  |
| ana1 | float | ADC analog input in volts. uINS pin 4, (G1/AN1). |
| ana3 | float | ADC analog input in volts. uINS pin 19 (G3/AN3). |
| ana4 | float | ADC analog input in volts. uINS pin 20 (G4/AN4). |


#### DID_SENSORS_UCAL

Uncalibrated IMU output. 

`sensors_w_temp_t`

| Field | Type | Description |
|-------|------|-------------|
| imu3 | imu3_t | (°C) Temperature of IMU.  Units only apply for calibrated data. |
| temp | float[3] | (uT) Magnetometers.  Units only apply for calibrated data. |


#### DID_STROBE_IN_TIME

Timestamp for input strobe. 

`strobe_in_time_t`

| Field | Type | Description |
|-------|------|-------------|
| week | uint32_t | GPS number of weeks since January 6th, 1980 |
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| pin | uint16_t | Strobe input pin (i.e. G1, G2, G5, or G9) |
| count | uint16_t | Strobe serial index number |


#### DID_SURVEY_IN

Survey in, used to determine position for RTK base station. Base correction output cannot run during a survey and will be automatically disabled if a survey is started. 

`survey_in_t`

| Field | Type | Description |
|-------|------|-------------|
| state | uint32_t | State of current survey, eSurveyInStatus |
| maxDurationSec | uint32_t | Maximum time (milliseconds) survey will run if minAccuracy is not first achieved. (ignored if 0). |
| minAccuracy | float | Required horizontal accuracy (m) for survey to complete before maxDuration. (ignored if 0) |
| elapsedTimeSec | uint32_t | Elapsed time (seconds) of the survey. |
| hAccuracy | float | Approximate horizontal accuracy of the survey (m). |
| lla | double[3] | The current surveyed latitude, longitude, altitude (deg, deg, m) |


#### DID_SYS_FAULT

System fault information. This is broadcast automatically every 10s if a critical fault is detected. 

`system_fault_t`

| Field | Type | Description |
|-------|------|-------------|
| status | uint32_t | System fault status (see eSysFaultStatus) |
| g1Task | uint32_t | Fault Type at HardFault |
| g2FileNum | uint32_t | Multipurpose register - Line number of fault |
| g3LineNum | uint32_t | Multipurpose register - File number at fault |
| g4 | uint32_t | Multipurpose register - at time of fault.  |
| g5Lr | uint32_t | Multipurpose register - link register value at time of fault.  |
| pc | uint32_t | Program Counter value at time of fault |
| psr | uint32_t | Program Status Register value at time of fault |


#### DID_SYS_PARAMS

System parameters / info 

`sys_params_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeekMs | uint32_t | GPS time of week (since Sunday morning) in milliseconds |
| insStatus | uint32_t | INS status flags (eInsStatusFlags) |
| hdwStatus | uint32_t | Hardware status flags (eHdwStatusFlags) |
| imuTemp | float | IMU temperature |
| baroTemp | float | Baro temperature |
| mcuTemp | float | MCU temperature (not available yet) |
| sysStatus | uint32_t | System status flags (eSysStatusFlags) |
| imuSamplePeriodMs | uint32_t | IMU sample period (ms). Zero disables sampling. |
| navOutputPeriodMs | uint32_t | Preintegrated IMU (PIMU) integration period and navigation/AHRS filter output period (ms). |
| sensorTruePeriod | double | Actual sample period relative to GPS PPS (sec) |
| flashCfgChecksum | uint32_t | Flash config checksum used with host SDK synchronization |
| navUpdatePeriodMs | uint32_t | Navigation/AHRS filter update period (ms) |
| genFaultCode | uint32_t | General fault code descriptor (eGenFaultCodes).  Set to zero to reset fault code. |
| upTime | double | System up time in seconds (with double precision) |


#### DID_WHEEL_ENCODER

Wheel encoder data to be fused with GPS-INS measurements, set DID_GROUND_VEHICLE for configuration before sending this message 

`wheel_encoder_t`

| Field | Type | Description |
|-------|------|-------------|
| timeOfWeek | double | (Do not use, internal development only) Time of measurement in current GPS week |
| status | uint32_t | Status |
| theta_l | float | (Do not use, internal development only) Left wheel angle (rad) |
| theta_r | float | (Do not use, internal development only) Right wheel angle (rad) |
| omega_l | float | Left wheel angular rate (rad/s). Positive when wheel is turning toward the forward direction of the vehicle. Use WHEEL_CFG_BITS_DIRECTION_REVERSE_LEFT in DID_FLASH_CONFIG::wheelConfig to reverse this. |
| omega_r | float | Right wheel angular rate (rad/s). Positive when wheel is turning toward the forward direction of the vehicle. Use WHEEL_CFG_BITS_DIRECTION_REVERSE_RIGHT in DID_FLASH_CONFIG::wheelConfig to reverse this. |
| wrap_count_l | uint32_t | (Do not use, internal development only) Left wheel revolution count |
| wrap_count_r | uint32_t | (Do not use, internal development only) Right wheel revolution count |


## Enumerations and Defines

System status and configuration is made available through various enumeration and #defines.

### General

#### DID_EVB_FLASH_CFG.cbPreset

(eEvb2ComBridgePreset)  

| Field | Value |
|-------|------|
| EVB2_CB_PRESET_NA | 0 |
| EVB2_CB_PRESET_ALL_OFF | 1 |
| EVB2_CB_PRESET_RS232 | 2 |
| EVB2_CB_PRESET_RS232_XBEE | 3 |
| EVB2_CB_PRESET_RS422_WIFI | 4 |
| EVB2_CB_PRESET_SPI_RS232 | 5 |
| EVB2_CB_PRESET_USB_HUB_RS232 | 6 |
| EVB2_CB_PRESET_USB_HUB_RS422 | 7 |
| EVB2_CB_PRESET_COUNT | 8 |


#### DID_EVB_FLASH_CFG.portOptions

(eEvb2PortOptions)  

| Field | Value |
|-------|------|
| EVB2_PORT_OPTIONS_RADIO_RTK_FILTER | 0x00000001 |
| EVB2_PORT_OPTIONS_DEFAULT |  EVB2_PORT_OPTIONS_RADIO_RTK_FILTER |


#### DID_EVB_STATUS.loggerMode

(eEvb2LoggerMode)  

| Field | Value |
|-------|------|
| EVB2_LOG_NA | 0 |
| EVB2_LOG_CMD_START | 2 |
| EVB2_LOG_CMD_STOP | 4 |
| EVB2_LOG_CMD_PURGE | 1002 |


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
| SENSOR_CFG_GYR_FS_MASK | 0x00000007 |
| SENSOR_CFG_GYR_FS_OFFSET |  (int)0 |
| SENSOR_CFG_ACC_FS_2G | 0x00000000 |
| SENSOR_CFG_ACC_FS_4G | 0x00000001 |
| SENSOR_CFG_ACC_FS_8G | 0x00000002 |
| SENSOR_CFG_ACC_FS_16G | 0x00000003 |
| SENSOR_CFG_ACC_FS_MASK | 0x00000030 |
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
| Magnetometer |  multi-axis |
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
| SYS_CFG_BITS_UNUSED3 | 0x00200000 |
| SYS_CFG_BITS_BOR_LEVEL_0 | 0x0 |
| SYS_CFG_BITS_BOR_LEVEL_1 | 0x1 |
| SYS_CFG_BITS_BOR_LEVEL_2 | 0x2 |
| SYS_CFG_BITS_BOR_LEVEL_3 | 0x3 |
| SYS_CFG_BITS_BOR_THREHOLD_MASK | 0x00C00000 |
| SYS_CFG_BITS_BOR_THREHOLD_OFFSET | 22 |
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
| GPX_SYS_CFG_BITS_BOR_THREHOLD_MASK | 0x00C00000 |
| GPX_SYS_CFG_BITS_BOR_THREHOLD_OFFSET | 22 |


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
| GPX_HDW_STATUS_UNUSED | 0x00002000 |
| GPX_HDW_STATUS_SYSTEM_RESET_REQUIRED | 0x00004000 |
| GPX_HDW_STATUS_FLASH_WRITE_PENDING | 0x00008000 |
| GPX_HDW_STATUS_ERR_COM_TX_LIMITED | 0x00010000 |
| GPX_HDW_STATUS_ERR_COM_RX_OVERRUN | 0x00020000 |
| GPX_HDW_STATUS_ERR_NO_GPS1_PPS | 0x00040000 |
| GPX_HDW_STATUS_ERR_NO_GPS2_PPS | 0x00080000 |
| GPX_HDW_STATUS_ERR_PPS_MASK | 0x000C0000 |
| GPX_HDW_STATUS_ERR_LOW_CNO_GPS1 | 0x00100000 |
| GPX_HDW_STATUS_ERR_LOW_CNO_GPS2 | 0x00200000 |
| GPX_HDW_STATUS_ERR_CNO_GPS1_IR | 0x00400000 |
| GPX_HDW_STATUS_ERR_CNO_GPS2_IR | 0x00800000 |
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
| RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING_MASK | (RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING_DEPRECATED\|RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING\) |
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
| RTK_CFG_BITS_GPS_PORT_PASS_THROUGH | 0x00800000 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_CUR_PORT | 0x01000000 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_CUR_PORT | 0x02000000 |
| RTK_CFG_BITS_BASE_OUTPUT_RTCM3_CUR_PORT_MASK | (RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_CUR_PORT\|RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_CUR_PORT\) |
| RTK_CFG_BITS_ROVER_MODE_ONBOARD_MASK | (RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING_DEPRECATED\|RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING_DEPRECATED\) |
| RTK_CFG_BITS_ALL_MODES_MASK | (RTK_CFG_BITS_ROVER_MODE_MASK\|RTK_CFG_BITS_BASE_MODE\) |


#### DID_GPX_STATUS.status

(eGpxStatus)  

| Field | Value |
|-------|------|
| GPX_STATUS_COM_PARSE_ERR_COUNT_MASK | 0x0000000F |
| GPX_STATUS_COM_PARSE_ERR_COUNT_OFFSET | 0 |
| GPX_STATUS_COM0_RX_TRAFFIC_NOT_DECTECTED | 0x00000010 |
| GPX_STATUS_COM1_RX_TRAFFIC_NOT_DECTECTED | 0x00000020 |
| GPX_STATUS_COM2_RX_TRAFFIC_NOT_DECTECTED | 0x00000040 |
| GPX_STATUS_USB_RX_TRAFFIC_NOT_DECTECTED | 0x00000080 |
| GPX_STATUS_GENERAL_FAULT_MASK | 0xFFFF0000 |
| GPX_STATUS_FAULT_RTK_QUEUE_LIMITED | 0x00010000 |
| GPX_STATUS_FAULT_GNSS_RCVR_TIME | 0x00100000 |
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
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_USB_TO_GPS1 | 12 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_USB_TO_GPS2 | 13 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_USB_TO_SER0 | 14 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_USB_TO_SER1 | 15 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_USB_TO_SER2 | 16 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_SER0_TO_GNSS1 | 17 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_CUR_PORT_TO_GPS1 | 18 |
| SYS_CMD_ENABLE_SERIAL_PORT_BRIDGE_CUR_PORT_TO_GPS2 | 19 |
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
| SYS_CMD_TEST_SER0_TX_PIN_LOW | 70 |
| SYS_CMD_TEST_SER0_TX_PIN_HIGH | 71 |
| SYS_CMD_TEST_SER0_TX_INPUT | 72 |
| SYS_CMD_TEST_SER0_TX_PP_NONE | 80 |
| SYS_CMD_TEST_SER0_TX_PP_U | 81 |
| SYS_CMD_TEST_SER0_TX_PP_D | 82 |
| SYS_CMD_OUTPUT_IDLE | 95 |
| SYS_CMD_EXIT_OUTPUT_IDLE | 96 |
| SYS_CMD_SAVE_FLASH | 97 |
| SYS_CMD_SAVE_GPS_ASSIST_TO_FLASH_RESET | 98 |
| SYS_CMD_SOFTWARE_RESET | 99 |
| SYS_CMD_MANF_UNLOCK | 1122334455 |
| SYS_CMD_MANF_FACTORY_RESET | 1357924680 |
| SYS_CMD_MANF_CHIP_ERASE | 1357924681 |
| SYS_CMD_MANF_DOWNGRADE_CALIBRATION | 1357924682 |
| SYS_CMD_MANF_ENABLE_ROM_BOOTLOADER | 1357924683 |
| SYS_CMD_FAULT_TEST_TRIG_MALLOC | 57005 |
| SYS_CMD_FAULT_TEST_TRIG_HARD_FAULT | 57006 |
| SYS_CMD_FAULT_TEST_TRIG_WATCHDOG | 57007 |


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
| GFC_INIT_IMU | 0x00100000 |
| GFC_INIT_BAROMETER | 0x00200000 |
| GFC_INIT_MAGNETOMETER | 0x00400000 |
| GFC_INIT_I2C | 0x00800000 |
| GFC_CHIP_ERASE_INVALID | 0x01000000 |
| GFC_EKF_GNSS_TIME_FAULT | 0x02000000 |
| GFC_GNSS_RECEIVER_TIME | 0x04000000 |
| GFC_GNSS_GENERAL_FAULT | 0x08000000 |
| GFC_GPX_STATUS_COMMON_MASK | GFC_GNSS1_INIT\|GFC_GNSS2_INIT\|GFC_GNSS_TX_LIMITED\|GFC_GNSS_RX_OVERRUN\|GFC_GNSS_CRITICAL_FAULT\|GFC_GNSS_RECEIVER_TIME\|GFC_GNSS_GENERAL_FAULT |


#### GPS Navigation Fix Type

(eGpsNavFixStatus)  

| Field | Value |
|-------|------|
| GPS_NAV_FIX_NONE | 0x00000000 |
| GPS_NAV_FIX_POSITIONING_3D | 0x00000001 |
| GPS_NAV_FIX_POSITIONING_RTK_FLOAT | 0x00000002 |
| GNSS_NAV_FIX_POSITIONING_RTK_FIX | 0x00000003 |


#### GPS Status

(eGpsStatus)  

| Field | Value |
|-------|------|
| GPS_STATUS_NUM_SATS_USED_MASK | 0x000000FF |
| GPS_STATUS_FIX_NONE | 0x00000000 |
| GNSS_STATUS_FIX_DEAD_RECKONING_ONLY | 0x00000100 |
| GNSS_STATUS_FIX_2D | 0x00000200 |
| GPS_STATUS_FIX_3D | 0x00000300 |
| GNSS_STATUS_FIX_GNSS_PLUS_DEAD_RECK | 0x00000400 |
| GNSS_STATUS_FIX_TIME_ONLY | 0x00000500 |
| GNSS_STATUS_FIX_UNUSED1 | 0x00000600 |
| GNSS_STATUS_FIX_UNUSED2 | 0x00000700 |
| GNSS_STATUS_FIX_DGPS | 0x00000800 |
| GNSS_STATUS_FIX_SBAS | 0x00000900 |
| GNSS_STATUS_FIX_RTK_SINGLE | 0x00000A00 |
| GNSS_STATUS_FIX_RTK_FLOAT | 0x00000B00 |
| GNSS_STATUS_FIX_RTK_FIX | 0x00000C00 |
| GPS_STATUS_FIX_MASK | 0x00001F00 |
| GNSS_STATUS_FIX_BIT_OFFSET |  (int)8 |
| GNSS_STATUS_FLAGS_FIX_OK | 0x00010000 |
| GNSS_STATUS_FLAGS_DGPS_USED | 0x00020000 |
| GNSS_STATUS_FLAGS_RTK_FIX_AND_HOLD | 0x00040000 |
| GNSS_STATUS_FLAGS_WEEK_VALID | 0x00040000 |
| GNSS_STATUS_FLAGS_TOW_VALID | 0x00080000 |
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
| GNSS_STATUS_FLAGS_GNSS_NMEA_DATA | 0x00008000 |
| GNSS_STATUS_FLAGS_GNSS_PPS_TIMESYNC | 0x10000000 |
| GNSS_STATUS_FLAGS_MASK | 0xFFFFE000 |
| GNSS_STATUS_FLAGS_BIT_OFFSET |  (int)16 |


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


#### IMU Status

(eImuStatus)  

| Field | Value |
|-------|------|
| IMU_STATUS_SATURATION_IMU1_GYR | 0x00000001 |
| IMU_STATUS_SATURATION_IMU2_GYR | 0x00000002 |
| IMU_STATUS_SATURATION_IMU3_GYR | 0x00000004 |
| IMU_STATUS_SATURATION_IMU1_ACC | 0x00000008 |
| IMU_STATUS_SATURATION_IMU2_ACC | 0x00000010 |
| IMU_STATUS_SATURATION_IMU3_ACC | 0x00000020 |
| IMU_STATUS_SATURATION_MASK | 0x0000003F |
| IMU_STATUS_MAG_UPDATE | 0x00000100 |
| IMU_STATUS_REFERENCE_IMU_PRESENT | 0x00000200 |
| IMU_STATUS_RESERVED2 | 0x00000400 |
| IMU_STATUS_SATURATION_HISTORY | 0x00000100 |
| IMU_STATUS_SAMPLE_RATE_FAULT_HISTORY | 0x00000200 |
| IMU_STATUS_GYR1_OK | 0x00010000 |
| IMU_STATUS_GYR2_OK | 0x00020000 |
| IMU_STATUS_GYR3_OK | 0x00040000 |
| IMU_STATUS_ACC1_OK | 0x00080000 |
| IMU_STATUS_ACC2_OK | 0x00100000 |
| IMU_STATUS_ACC3_OK | 0x00200000 |
| IMU_STATUS_IMU1_OK | (int)(IMU_STATUS_GYR1_OK\|IMU_STATUS_ACC1_OK\) |
| IMU_STATUS_IMU2_OK | (int)(IMU_STATUS_GYR2_OK\|IMU_STATUS_ACC2_OK\) |
| IMU_STATUS_IMU3_OK | (int)(IMU_STATUS_GYR3_OK\|IMU_STATUS_ACC3_OK\) |
| IMU_STATUS_IMU_OK_MASK | 0x003F0000 |
| IMU_STATUS_GYR_FAULT_REJECT | 0x01000000 |
| IMU_STATUS_ACC_FAULT_REJECT | 0x02000000 |


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
| INS_STATUS_GPS_AIDING_HEADING | 0x00000080 |
| INS_STATUS_GPS_AIDING_POS | 0x00000100 |
| INS_STATUS_GPS_UPDATE_IN_SOLUTION | 0x00000200 |
| INS_STATUS_EKF_USING_REFERENCE_IMU | 0x00000400 |
| INS_STATUS_MAG_AIDING_HEADING | 0x00000800 |
| INS_STATUS_NAV_MODE | 0x00001000 |
| INS_STATUS_STATIONARY_MODE | 0x00002000 |
| INS_STATUS_GPS_AIDING_VEL | 0x00004000 |
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
| INS_STATUS_MAG_INTERFERENCE_OR_BAD_CAL | 0x00800000 |
| INS_STATUS_GPS_NAV_FIX_MASK | 0x03000000 |
| INS_STATUS_GPS_NAV_FIX_OFFSET | 24 |
| INS_STATUS_RTK_COMPASSING_VALID | 0x04000000 |
| INS_STATUS_RTK_RAW_GPS_DATA_ERROR | 0x08000000 |
| INS_STATUS_RTK_ERR_BASE_DATA_MISSING | 0x10000000 |
| INS_STATUS_RTK_ERR_BASE_POSITION_MOVING | 0x20000000 |
| INS_STATUS_RTK_ERR_BASE_POSITION_INVALID | 0x30000000 |
| INS_STATUS_RTK_ERR_BASE_MASK | 0x30000000 |
| INS_STATUS_RTK_ERROR_MASK | (INS_STATUS_RTK_RAW_GPS_DATA_ERROR\|INS_STATUS_RTK_ERR_BASE_MASK\) |
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


#### RTK Configuration

(eRTKConfigBits)  

| Field | Value |
|-------|------|
| RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING_DEPRECATED | 0x00000001 |
| RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING | 0x00000002 |
| RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING | 0x00000004 |
| RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING_DEPRECATED | 0x00000008 |
| RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING_MASK | (RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING_DEPRECATED\|RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING\) |
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
| RTK_CFG_BITS_GPS_PORT_PASS_THROUGH | 0x00800000 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_CUR_PORT | 0x01000000 |
| RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_CUR_PORT | 0x02000000 |
| RTK_CFG_BITS_BASE_OUTPUT_RTCM3_CUR_PORT_MASK | (RTK_CFG_BITS_BASE_OUTPUT_GNSS1_RTCM3_CUR_PORT\|RTK_CFG_BITS_BASE_OUTPUT_GNSS2_RTCM3_CUR_PORT\) |
| RTK_CFG_BITS_ROVER_MODE_ONBOARD_MASK | (RTK_CFG_BITS_ROVER_MODE_RTK_POSITIONING_DEPRECATED\|RTK_CFG_BITS_ROVER_MODE_RTK_COMPASSING_DEPRECATED\) |
| RTK_CFG_BITS_ALL_MODES_MASK | (RTK_CFG_BITS_ROVER_MODE_MASK\|RTK_CFG_BITS_BASE_MODE\) |


#### System Configuration

(eSysConfigBits)  

| Field | Value |
|-------|------|
| UNUSED1 | 0x00000001 |
| SYS_CFG_BITS_ENABLE_MAG_CONTINUOUS_CAL | 0x00000002 |
| SYS_CFG_BITS_AUTO_MAG_RECAL | 0x00000004 |
| SYS_CFG_BITS_DISABLE_MAG_DECL_ESTIMATION | 0x00000008 |
| SYS_CFG_BITS_DISABLE_LEDS | 0x00000010 |
| Magnetometer |  multi-axis |
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
| SYS_CFG_BITS_UNUSED3 | 0x00200000 |
| SYS_CFG_BITS_BOR_LEVEL_0 | 0x0 |
| SYS_CFG_BITS_BOR_LEVEL_1 | 0x1 |
| SYS_CFG_BITS_BOR_LEVEL_2 | 0x2 |
| SYS_CFG_BITS_BOR_LEVEL_3 | 0x3 |
| SYS_CFG_BITS_BOR_THREHOLD_MASK | 0x00C00000 |
| SYS_CFG_BITS_BOR_THREHOLD_OFFSET | 22 |
| SYS_CFG_USE_REFERENCE_IMU_IN_EKF | 0x01000000 |
| SYS_CFG_EKF_REF_POINT_STATIONARY_ON_STROBE_INPUT | 0x02000000 |
