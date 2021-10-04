# System Status
## Solution Status

### Solution Alignment

Solution alignment occurs when aiding sensor and state estimation are in agreement and indicates that solution output can be trusted.   

#### Heading Alignment

Heading alignment varies based on available sensors and conditions of motion.  

Stationary INS and AHRS (no GPS) use the magnetometer for heading alignment.   The INS solution will start and remain in INS_ALIGNING status (1) until the magnetometer calibration is validated.  The magnetometer requires +- 45 degrees of rotation to validate calibration and ensure accurate heading.  

Moving INS (under accelerated conditions) or Dual GNSS (two GPS antennas using RTK compassing) can align the heading without use of the magnetometer.  The INS solution will start in INS_ALIGNING status (1) and immediately proceed to INS_NAV_IS_GOOD status (3) with GPS lock for Dual GNSS and accelerated horizontal movement for single GNSS INS use.

### LED Status

System status including GPS lock, INS alignment, and time synchronization are reported via the top tri-color LED. This LED can be disabled (turned off) by setting bit 0x4 of DID_FLASH_CONFIG.sysCfgBits.

<table style="padding: 5px" >
  <col width="2%">
  <col width="2%">
  <col width="2%">
  <col width="94%">
  <tr>
    <th style="padding: inherit">LED Behavior</th>
    <th style="padding: inherit">Solution<br/>Status #</th>
    <th style="padding: inherit">Status</th>
    <th style="padding: inherit">Description</th>
  </tr>
  <tr>
    <td style="padding: inherit">White <img src="http://docs.inertialsense.com/user-manual/images/circlewhite.png"></td>
    <td style="padding: inherit">1</td>
    <td style="padding: inherit">Solution Aligning</td>
    <td style="padding: inherit">The solution is aligning on startup</td>
  </tr>
  <tr>
    <td style="padding: inherit">Cyan <img src="http://docs.inertialsense.com/user-manual/images/circlecyan.png"></td>
    <td style="padding: inherit">2</td>
    <td style="padding: inherit">Solution Alignment Complete</td>
    <td style="padding: inherit">The solution has aligned but insufficient dynamics have been completed for the variance to reach nominal conditions.</td>
  </tr>
  <tr>
    <td style="padding: inherit">Green <img src="http://docs.inertialsense.com/user-manual/images/circlegreen.png"></td>
    <td style="padding: inherit">3</td>
    <td style="padding: inherit">Solution Good – NAV</td>
    <td style="padding: inherit">The solution is in Navigation mode and state estimate is good.</td>
  </tr>
  <tr>
    <td style="padding: inherit">Blue <img src="http://docs.inertialsense.com/user-manual/images/circleblue.png"></td>
    <td style="padding: inherit">5</td>
    <td style="padding: inherit">Solution Good – AHRS</td>
    <td style="padding: inherit">The solution is in AHRS mode and state estimate is good. There is no valid position or velocity data from GPS or other aiding sensor. Only the attitude states are estimated</td>
  </tr>
  <tr>
    <td style="padding: inherit">Orange <img src="http://docs.inertialsense.com/user-manual/images/circleorange.png"></td>
    <td style="padding: inherit">4,6</td>
    <td style="padding: inherit">Solution High Variance</td>
    <td style="padding: inherit">The solution is in Navigation or AHRS mode but variance (uncertainty) is high. This may be caused by excessive sensor noise such as vibration, magnetic interference, or poor GPS visibility or multipath errors. See DID_INL2_VARIANCE.</td>
  </tr>
  <tr>
    <td style="padding: inherit">Purple <img src="http://docs.inertialsense.com/user-manual/images/circlepurple.png"></td>
    <td style="padding: inherit"> </td>
    <td style="padding: inherit">Magnetometer Recalibration</td>
    <td style="padding: inherit">The system is collecting new magnetometer calibration data and requires rotation.</td>
  </tr>
  <tr>
    <td style="padding: inherit">Cyan Fading <img src="http://docs.inertialsense.com/user-manual/images/circlefadingcyan.png"></td>
    <td style="padding: inherit"> </td>
    <td style="padding: inherit">Bootloader Waiting</td>
    <td style="padding: inherit">The bootloader has started and is waiting for communications.</td>
  </tr>
  <tr>
    <td style="padding: inherit">Purple Fast Blink <img src="http://docs.inertialsense.com/user-manual/images/circlefastpurple.png"></td>
    <td style="padding: inherit"> </td>
    <td style="padding: inherit">Firmware Upload</td>
    <td style="padding: inherit">The bootloader is uploading the embedded firmware.</td>
  </tr>
  <tr>
    <td style="padding: inherit">Orange Fast Blink <img src="http://docs.inertialsense.com/user-manual/images/circlefastorange.png"></td>
    <td style="padding: inherit"> </td>
    <td style="padding: inherit">Firmware Verification</td>
    <td style="padding: inherit">The bootloader is verifying the embedded firmware.</td>
  </tr>
  <tr>
    <td style="padding: inherit">Red <img src="http://docs.inertialsense.com/user-manual/images/circlered.png"></td>
    <td style="padding: inherit"> </td>
    <td style="padding: inherit">Bootloader Failure</td>
    <td style="padding: inherit">The bootloader has experienced a failure on startup.</td>
  </tr>
  <tr>
    <th style="padding: inherit" colspan="4" align="center">Can combine with behaviors above</th>
  </tr>
  <tr>
    <td style="padding: inherit">Red pulse every 1s <img src="http://docs.inertialsense.com/user-manual/images/circletworeds.png"></td>
    <td style="padding: inherit">GPS PPS Sync</td>
    <td style="padding: inherit"></td>
    <td style="padding: inherit">The system has received and synchronized local time to UTC time using the GPS PPS signal.</td>
  </tr>
  <tr>
    <td style="padding: inherit">Red/purple pulse every 1s <img src="http://docs.inertialsense.com/user-manual/images/circleredpurple.png"></td>
    <td style="padding: inherit">RTK Base Data Received</td>
    <td style="padding: inherit"></td>
    <td style="padding: inherit">The system is receiving RTK base station data.</td>
  </tr>
  <tr>
    <td style="padding: inherit">Purple pulse every 1s <img src="http://docs.inertialsense.com/user-manual/images/circletwopurples.png"></td>
    <td style="padding: inherit">RTK Fix Status</td>
    <td style="padding: inherit"></td>
    <td style="padding: inherit">The GPS has valid RTK fix and high precision positioning</td>
  </tr>
</table>



Status flags described in this section that can be observed by bitwise ANDing any of the status flag bitmasks with the corresponding status flags variable.

### Status Flags
This section lists the commonly used status flags. A complete listing of status flags is available in data_sets.h.

#### insStatus – INS Status Flags
The INS status flags, **insStatus**, are found in the DID_INS1, DID_INS2, DID_INS3, and DID_SYS_PARAMS messages. Bitmasks for the **insStatus** flags are defined in _eInsStatusFlags_ in data_sets.h.

| Field                            | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
|----------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| INS_STATUS_ALIGN_COARSE_MASK     | Position, Velocity & Attitude are usable. Variance of the state estimate are outside spec.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| INS_STATUS_ALIGN_GOOD_MASK       | Position, Velocity & Attitude are good. Variance of state estimate are within spec.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| INS_STATUS_GPS_AIDING_HEADING | INS heading are being corrected by GPS.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| INS_STATUS_GPS_AIDING_POS | INS position and velocity are being corrected by GPS. |
| INS_STATUS_GPS_UPDATE_IN_SOLUTION | GPS update event occurred in INS, potentially causing discontinuity in position path.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| INS_STATUS_MAG_AIDING_HEADING | INS heading are being corrected by magnetometer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| INS_STATUS_NAV_MODE              | AHRS = 0 (no position or velocity), NAV = 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| INS_STATUS_MAG_RECALIBRATING     | Magnetometer is recalibrating.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| INS_STATUS_MAG_NOT_GOOD          | Magnetometer is experiencing interference.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| INS_STATUS_SOLUTION_MASK         | 0=INS_INACTIVE – The INS is not runnning  <br>**1=INS_STATUS_SOLUTION_ALIGNING** – The INS is aligning on startup   <br>**2=INS_STATUS_SOLUTION_ALIGNMENT_COMPLETE** – The INS has aligned but insufficient dynamics have been completed for the variance to reach nominal conditions.   <br>**3=INS_STATUS_SOLUTION_NAV** – The INS is in NAV mode and the state estimate is good.   <br>**4=INS_STATUS_SOLUTION_NAV_HIGH_VARIANCE** – The INS is in NAV mode and the state estimate is experiencing high variance. This may be caused by excessive noise on one or more sensors, such as vibration, magnetic interference, poor GPS sky visibility and/or GPS multipath errors. See DID_INL2_VARIANCE.   <br>**5=INS_STATUS_SOLUTION_AHRS** – INS is in AHRS mode and the solution is good. There is no valid position correction data from GPS or other aiding sensor. Only the attitude states are estimated.   <br>**6=INS_STATUS_SOLUTION_AHRS_HIGH_VARIANCE** – INS is in AHRS mode and the state estimate has high variance. See DID_INL2_VARIANCE. |


#### hdwStatus – Hardware Status Flags
The hardware status flags, **hdwStatus**, are found in the `DID_INS1`, `DID_INS2`, `DID_INS3`, and `DID_SYS_PARAMS` messages. Bitmasks for the **hdwStatus** flags are defined in `eHdwStatusFlags` in data_sets.h.

| **Field**                 | **Description**                          |
| ------------------------- | ---------------------------------------- |
| HDW\_STATUS\_MOTION\_MASK | Accelerometers and Gyros are operational |
| HDW\_STATUS\_GPS\_SATELLITE\_RX | Antenna is connected to the GPS receiver and signal is received |
| HDW\_STATUS\_STROBE\_IN\_EVENT | Event occurred on strobe input pin |
| HDW\_STATUS\_SATURATION\_MASK | Acc., Gyro, Mag or Baro is saturated |
| HDW\_STATUS\_SELF\_TEST\_FAULT | BIT has failed |
| HDW\_STATUS\_ERR\_TEMPERATURE | Outside of operational range |
| HDW\_STATUS\_FAULT\_BOD\_RESET | Low Power Reset |
| HDW\_STATUS\_FAULT\_POR\_RESET | Software or Triggered Reset |

### Built-in Test (BIT) Flags
Built-in test (BIT) is enabled by setting `DID_BIT.state = BIT_STATE_CMD_FULL_STATIONARY (2)`. BIT takes about 1 second to run, and is completed when `DID_BIT.state == BIT_STATE_DONE (1)`. All BIT tests except those related to GPS require the system to be stationary to be accurate.

#### hdwBitStatus – Hardware BIT Flags
Hardware BIT flags are contained in **hdwBitStatus**, found in the DID_BIT message. Bitmasks for the **hdwBitStatus**
flags are defined in _eHdwBitStatusFlags_ in data_sets.h.

| **Field** | **Description** |
|----- | ----- |
| HDW\_BIT\_PASSED\_ALL | All HBIT are passed |
| HDW\_BIT\_PASSED\_AHRS | All Self Tests passed without GPS signal |
| HDW_BIT_FAILED_MASK | One of the built-in tests failed |
| HDW\_BIT\_FAULT\_GPS\_NO\_COM | No GPS Signal |
| HDW\_BIT\_FAULT\_GPS\_POOR\_CNO | Poor GPS signal. Check Antenna |
| HDW\_BIT\_FAULT\_GPS\_ACCURACY | Poor GPS Accuracy or Low number of satellites |

#### calBitStatus – Calibration BIT Flags
Calibration BIT flags are contained in **calBitStatus**, found in the DID_BIT message. Bitmasks for the **calBitStatus**
flags are defined in eCalBitStatusFlags in data_sets.h.

| **Field** | **Description** |
| ----- | ----- |
| CAL\_BIT\_PASSED\_ALL | Passed all calibration checks |
| CAL_BIT_FAILED_MASK | One of the calibration checks failed |

## Health Monitoring
This section illustrates tests used for system health monitoring in common application.

1. **Communication Check**

   To check that cabling between the unit and the application is working after initialization, expect that the initial expected packets are received within 3 seconds.

2. **Sensor Test (Must be Stationary)**

   These tests are ideal for manufacturing and periodic in-field testing. Initiate by setting DID_BIT.state = 2.

| **Test** | **Description** |
| ----- | ----- |
| hdwBitStatus & HDW\_BIT\_PASSED\_ALL | Hardware is good |
| calBitStatus & CAL\_BIT\_PASSED\_ALL | Sensor calibration is good |

3. **GPS Hardware Test**

  Initiate by setting **DID_BIT.state = 2.**

| **Test** | **Description** |
| ----- | ----- |
| hdwBitStatus & HDW\_BIT\_FAULT\_GPS\_NO\_COM | No GPS serial communications. |
| hdwBitStatus & HDW\_BIT\_FAULT\_GPS\_POOR\_CNO | Poor GPS signal strength.  Check antenna. |

4. **GPS Lock Test**

| **Test** | **Description** |
| ----- | ----- |
| hdwStatus & INS\_STATUS\_USING\_GPS\_IN\_SOLUTION | GPS is being fused into INS solution |

5. **INS Output Valid**

| **Test** | **Description** |
| ----- | ----- |
| insStatus & INS\_STATUS\_ATT\_ALIGN\_GOOD | Attitude estimates are valid |
| insStatus & INS\_STATUS\_VEL\_ALIGN\_GOOD | Velocity estimates are valid |
| insStatus & INS\_STATUS\_POS\_ALIGN\_GOOD | Position estimates are valid |

6. **System Temperature**

   System temperature is available at DID_SYS_SENSORS.temp.

7. **Communications Errors**

   HDW_STATUS_COM_PARSE_ERROR_COUNT(DID_SYS_SENSORS.hStatus) is the number of parsed packet errors encountered.
