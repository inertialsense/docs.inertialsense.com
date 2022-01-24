# INS & GNSS Configuration

## Translation

Although the uINS can be mounted and operated in any arbitrary orientation, it is often desirable and conventional to translate the uINS output so that it is rotated into the vehicle frame and located at certain location for control and navigation of the vehicle. This is done using the ***IMU Rotation***, ***INS Rotation***, and ***INS Offset*** parameters.  

In most common applications, output is translated to the vehicle frame (X to the front, Y to the right, and Z down): 

- *IMU Rotation* provides gross rotation of the IMU output.
- *INS Rotation* provides small angle alignment of the INS output.   
- *INS Offset* moves the location from the INS output.

### Senor Rotation (From Hardware Native Frame to IMU Body Frame)

The *IMU rotation* is used rotation the IMU and magnetometer output (sensor frame) in **multiples of 90 degrees** using the `SENSOR_CFG_SENSOR_ROTATION_MASK` bits of the `DID_FLASH_CONFIG.sensorConfig` as defined in `enum eSensorConfig`.  These X,Y,Z rotations occur about the corresponding axes and applied in the order of Z,Y,X.  This rotation is recommended for gross rotations.   

### INS Rotation

The *INS rotation* is used to convert the INS output from the INS [sensor frame](../../reference/coordinate_frames/#sensor-frame) to the vehicle frame.  This is useful if the sensor frame and vehicle frame are not aligned.  The actual INS rotation parameters are `DID_FLASH_CONFIG.insRotation[3]` (X, Y, Z) in radians.  The *INS rotation* values describes the rotation from the INS sensor frame to the intermediate frame in order of Z, Y, X.  This rotation is   

### INS Offset

The *INS offset* is used to shift the location of the INS output and is applied following the INS Rotation.  This offset can be used to move the uINS location from the origin of the sensor frame to any arbitrary location, often a control navigation point on the vehicle.   



### Aligning INS with Vehicle Frame

To identify the angle error between the INS output frame and the vehicle frame, the vehicle must 

If surface is level, measure the axis rotation error by identify the corresponding axis with roll or pitch.

If save is NOT level, two measurements with a 180 degree rotation about the gravity vector should be made. 

The difference between IMU frame and the vehicle frame can be identified through the attitude euler angles when a given axis is perpendicular to gravity. 

When gravity is orthogonal to the IMU X and Y plane: 

X - Roll

Y - Pitch

When gravity is orthogonal to the IMU X and Z plane (roll is +-90 degrees): 

Z - Pitch  



### Identifying INS Rotation

The INS rotation can be identified using the following method:  

1. Start by orientating the INS (or picturing the INS orientation) aligned with the vehicle frame.  It can help to have the vehicle frame upright and level with the ground.
2. Rotate the INS in heading (about Z axis) until the heading matches the sensor frame heading.
3. Rotate the INS in pitch (about Y axis) until the pitch matches the sensor frame pitch.
4. Rotate the INS in roll (about Z axis) until the roll matches the sensor frame roll.

### Aligning the INS After Mounting  

The following process uses the uINS to measure and correct for the uINS mounting angle. 

1. Set `DID_FLASH_CONFIG.insRotation` to zero. 

2. Set the sensor on the ground at various known orientations and record the INS quaternion output (DID_INS_2).  Using the euler output (DID_INS_1) is not recommended as euler angles can have significant error when the pitch is near +-90 degrees.

3. Find the difference between the known orientations and the measured INS quaternion orientations and average these differences together. 

4. Negate this average difference and enter that into the `DID_FLASH_CONFIG.insRotation`. This value is in euler, however it is OK for this step as this rotation should have just been converted from quaternion to euler and will be converted back to quaternion on-board for the runtime rotation.

If using software release 1.8.4 or newer, we recommend using the `DID_FLASH_CONFIG.sensorConfig` to rotate the sensor frame by 90 degrees to near level before following the steps above. 

## GNSS Antenna Offset

If the setup includes a significant distance (40cm or more) between the GPS antenna and the uINS central unit, enter a non-zero value for the GPS lever arm, `DID_FLASH_CONFIG.gps1AntOffset` (or  `DID_FLASH_CONFIG.gpsAnt2Offset`) X,Y,Z offset in meters from Sensor Frame origin to GPS antenna.  The sensor frame is labeled on the uINS EVB case.

## IMU Sample and Navigation Periods

The IMU sample period is configured by setting `DID_FLASH_CONFIG.startupImuDtMs`  in milliseconds.  This parameter determines how frequently the IMU is measured and data integrated into the `DID_PREINTEGRATED_IMU` data.  `DID_FLASH_CONFIG.startupImuDtMs` also automatically sets the bandwidth of the IMU anti-aliasing filter to less than one half the Nyquist frequency (i.e. < 250 / startupImuDtMs).  The IMU anti-aliasing filter bandwidth can also be overridden to another frequency by setting bits `SENSOR_CFG_GYR_DLPF` and `SENSOR_CFG_ACC_DLPF` in `DID_FLASH_CONFIG.sensorConfig`. ![](../images/imu_chain.svg)

The INS and AHRS kalman filter update period is configured using `DID_FLASH_CONFIG.startupNavDtMs`.  This parameter also sets the integration period for the Preintegrated IMU or conning and sculling (delta theta, delta velocity) integrals.  The `DID_DUAL_IMU`  is the derivative of the `DID_PREINTEGRATED_IMU` value over a single integration period and serves as an anti-aliased moving average of the IMU value.

## INS-GNSS Dynamic Model
The `DID_FLASH_CONFIG.insDynModel` setting allows the user to adjust how the EKF behaves in different dynamic environments. All values except for 2 (STATIONARY) and 8 (AIR <4g) are experimental. The user is encouraged to attempt to use different settings to improve performance, however in most applications
the default setting, 8: airborne <4g, will yield best performance.

The STATIONARY configuration (insDynModel = 2) can be used to configure the EKF for static applications. It is a permanent implementation of the [Zero Motion Command](../application-config/zero_motion_command.md) which will reduce EKF drift under stationary conditions.

## Disable Magnetometer and Barometer Updates

Magnetometer and barometer updates (fusion) into the INS and AHRS filter (Kalman filter) can be disabled by setting the following bits in `DID_FLASH_CONFIG.sysCfgBits`.

| Bit Name                                 | Bit Value  | Description                          |
| ---------------------------------------- | ---------- | ------------------------------------ |
| SYS_CFG_BITS_DISABLE_MAGNETOMETER_FUSION | 0x00001000 | Disable magnetometer fusion into EKF |
| SYS_CFG_BITS_DISABLE_BAROMETER_FUSION    | 0x00002000 | Disable barometer fusion into EKF    |

These settings can be disabled using the General Settings tab of the EvalTool.

<center>

![evaltool_general_settings](../images/evaltool_general_settings2.png)

</center>

## Disable Zero Velocity Updates

Zero velocity updates (ZUPT) rely on GPS and/or wheel encoder data. In some cases there can be a slight lag/deviation when starting motion while simultaneously rotating. This is because GPS data is updated at 5 Hz and it takes a few samples to detect motion after a period of no motion. When ZUPT is enabled, it acts as a virtual velocity sensor telling the system that its velocity is zero. It may conflict briefly with GPS velocity observation when starting motion. If a slight lag at the beginning of motion is an issue, ZUPT may be disabled. Generally it should be enabled (Default). It can be disabled using `DID_FLASH_CONFIG.sysCfgBits` or using the General Settings tab of the EvalTool.

## Disable Zero Angular Rate Updates

Zero angular rate updates (ZARU) rely on analysis of either IMU (gyro) data or wheel encoders when available. When angular motion is very slow and no wheel encoders are available a zero angular rate may be mistakenly detected, which will lead to gyro bias estimation errors. In these cases it can be beneficial  to disable ZARU if the applications has slow rotation rates (approximately below 3 deg/s). It is not encouraged to disable ZARU if there is no rotation or faster rotation. It can be disabled using `DID_FLASH_CONFIG.sysCfgBits` or using the General Settings tab of the EvalTool.

