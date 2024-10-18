# IMX System Status
## Solution Status

### Solution Alignment

Solution alignment occurs when aiding sensor and state estimation are in agreement and indicates that solution output can be trusted.   

#### Heading Alignment

Heading alignment varies based on available heading aiding sensors and conditions of motion.  

`INS_STATUS_HDG_ALIGN_COARSE` and `INS_STATUS_HDG_ALIGN_FINE` flags indicate whether INS heading is aided by any heading sensor (including GPS or magnetometer).  More accurate heading sensors (i.e. GPS) are prioritized over less accurate sensors (i.e. magnetometers) and will fall back to the less accurate sensors when the more accurate sensors are not available.  A momentary blip in these alignment flags may occur during heading transition from higher to lower accuracy aiding sensors (i.e. GPS to magnetometer).  `INS_STATUS_HDG_ALIGN_FINE` and `INS_STATUS_HDG_ALIGN_COARSE` flags will not be set when no heading aiding is available.

Heading aiding status is also identified when the `INS_STATUS_SOLUTION_MASK` of the `insStatus` equals: 

- `INS_STATUS_SOLUTION_NAV`
- `INS_STATUS_SOLUTION_NAV_HIGH_VARIANCE`
- `INS_STATUS_SOLUTION_AHRS` 
- `INS_STATUS_SOLUTION_AHRS_HIGH_VARIANCE`

The source of heading aiding can be identified by the following flags:

* `INS_STATUS_GPS_AIDING_HEADING` - either dual or single GPS. 
* `INS_STATUS_MAG_AIDING_HEADING` - when GPS heading is not available.

### Status Flags
This section lists the commonly used status flags. A complete listing of status flags is available in data_sets.h.

#### INS Status Flags (insStatus)
The INS status flags, **insStatus**, are found in the DID_INS1, DID_INS2, DID_INS3, and DID_SYS_PARAMS messages. Bitmasks for the **insStatus** flags are defined in _eInsStatusFlags_ in data_sets.h.

| Flag                         | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
|----------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| INS_STATUS_HDG_ALIGN_COARSE | Heading estimate is usable but outside spec.|
| INS_STATUS_HDG_ALIGN_FINE | Heading estimate is within spec.                                                                                                                                           |
| INS_STATUS_VEL_ALIGN_COARSE | Velocity estimate is usable but outside spec. |
| INS_STATUS_VEL_ALIGN_FINE | Velocity estimate is within spec. |
| INS_STATUS_POS_ALIGN_COARSE | Position estimate is usable but outside spec. |
| INS_STATUS_POS_ALIGN_FINE | Position estimate is within spec. |
| INS_STATUS_GPS_AIDING_HEADING | INS heading are being corrected by GPS.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| INS_STATUS_GPS_AIDING_POS | INS position and velocity are being corrected by GPS. |
| INS_STATUS_GPS_UPDATE_IN_SOLUTION | GPS update event occurred in INS, potentially causing discontinuity in position path.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| INS_STATUS_MAG_AIDING_HEADING | INS heading are being corrected by magnetometer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| INS_STATUS_NAV_MODE              | AHRS = 0 (no position or velocity), NAV = 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| INS_STATUS_MAG_RECALIBRATING     | Magnetometer is recalibrating.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| INS_STATUS_MAG_INTERFERENCE_OR_BAD_CAL | Magnetometer is experiencing interference or calibration is bad.  Attention may be required to remove interference (move the device) or recalibrate the magnetometer.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| INS_STATUS_SOLUTION_MASK         | 0=INS_STATUS_SOLUTION_OFF – The INS is not running  <br>**1=INS_STATUS_SOLUTION_ALIGNING** – The INS is aligning on startup <br>**3=INS_STATUS_SOLUTION_NAV** – The INS is in NAV mode and the state estimate is good.   <br>**4=INS_STATUS_SOLUTION_NAV_HIGH_VARIANCE** – The INS is in NAV mode and the state estimate is experiencing high variance. This may be caused by excessive noise on one or more sensors, such as vibration, magnetic interference, poor GPS sky visibility and/or GPS multipath errors. See DID_INL2_VARIANCE.   <br>**5=INS_STATUS_SOLUTION_AHRS** – INS is in AHRS mode and the solution is good. There is no valid position correction data from GPS or other aiding sensor. Only the attitude states are estimated.   <br>**6=INS_STATUS_SOLUTION_AHRS_HIGH_VARIANCE** – INS is in AHRS mode and the state estimate has high variance. See DID_INL2_VARIANCE.  <br>**7=INS_STATUS_SOLUTION_VRS** - System is in VRS mode (no earth relative heading) and roll and pitch are good. <br>**8=INS_STATUS_SOLUTION_VRS_HIGH_VARIANCE** System is in VRS mode (no earth relative heading) but roll and pitch uncertainty has exceeded the threshold. |
| INS_STATUS_RTK_COMPASSING_MASK | **0x00100000=INS_STATUS_RTK_COMPASSING_BASELINE_UNSET** - GPS compassing antenna offsets are not set in flashCfg.<br/>**0x00200000=INS_STATUS_RTK_COMPASSING_BASELINE_BAD** - GPS antenna baseline specified in flashCfg and measured by GPS do not match. |
| INS_STATUS_GPS_NAV_FIX_MASK | GPS navigation fix type (see eGpsNavFixStatus) |
| INS_STATUS_RTK_COMPASSING_VALID | RTK compassing heading is accurate.  (RTK fix and hold status) |
| INS_STATUS_RTK_ERROR_MASK | See eInsStatusFlags in data_sets.h. |


#### Hardware Status Flags (hdwStatus)
The hardware status flags, **hdwStatus**, are found in the `DID_INS1`, `DID_INS2`, `DID_INS3`, and `DID_SYS_PARAMS` messages. Bitmasks for the **hdwStatus** flags are defined in `eHdwStatusFlags` in data_sets.h.

| **Field**                 | **Description**                          |
| ------------------------- | ---------------------------------------- |
| HDW_STATUS_MOTION_MASK | Accelerometers and Gyros are operational |
| HDW_STATUS_GPS_SATELLITE_RX | Antenna is connected to the GPS receiver and signal is received |
| HDW_STATUS_STROBE_IN_EVENT | Event occurred on strobe input pin |
| HDW_STATUS_GPS_TIME_OF_WEEK_VALID | GPS time of week is valid and reported.  Otherwise the timeOfWeek is local system time. |
| HDW_STATUS_SATURATION_MASK | Acc., Gyro, Mag or Baro is saturated |
| HDW_STATUS_SYSTEM_RESET_REQUIRED | System Reset is required for proper function |
| HDW_STATUS_ERR_GPS_PPS_NOISE | GPS PPS timepulse signal has noise and occurred too frequently |
| HDW_STATUS_MAG_RECAL_COMPLETE | Magnetometer recalibration has finished (when INS_STATUS_MAG_RECALIBRATING is unset). |
| HDW_STATUS_ERR_COM_TX_LIMITED | Communications Tx buffer limited |
| HDW_STATUS_ERR_COM_RX_OVERRUN | Communications Rx buffer overrun |
| HDW_STATUS_ERR_NO_GPS_PPS | GPS PPS timepulse signal has not been received or is in error |
| HDW_STATUS_GPS_PPS_TIMESYNC | Time synchronized by GPS PPS |
|  | (BIT) Built-in self-test mask |
| HDW_STATUS_ERR_TEMPERATURE | Outside of operational range |
| HDW_STATUS_FAULT_BOD_RESET | Low Power Reset |
| HDW_STATUS_FAULT_POR_RESET | Software or Triggered Reset |

## Built-in Test (BIT)
Built-in test (BIT) is enabled by setting `DID_BIT.command` to any of the following values. 

```c++
BIT_CMD_FULL_STATIONARY               = (int)2, // (FULL) Comprehensive test.  Requires system be completely stationary without vibrations. 
BIT_CMD_BASIC_MOVING                  = (int)3, // (BASIC) Ignores sensor output.  Can be run while moving.  This mode is automatically run after bootup.
BIT_CMD_FULL_STATIONARY_HIGH_ACCURACY = (int)4, // (FULL-HA) Same as BIT_CMD_FULL_STATIONARY but with higher accuracy requirements.
```

BIT takes about 5 seconds to run, and is completed when `DID_BIT.state == BIT_STATE_DONE (1)`.  All BIT tests except those related to GPS require the system to be stationary to be accurate.

### BIT Hardware Flags (hdwBitStatus)
Hardware BIT flags are contained in **hdwBitStatus**, found in the `DID_BIT` message. Bitmasks for the **hdwBitStatus**
flags are defined in `eHdwBitStatusFlags` in data_sets.h.

| **Field** | **Description** |
|----- | ----- |
| HDW_BIT_PASSED_ALL | All HBIT are passed |
| HDW_BIT_PASSED_AHRS | All Self Tests passed without GPS signal |
| HDW_BIT_FAILED_MASK | One of the built-in tests failed |
| HDW_BIT_FAULT_GPS_NO_COM | No GPS Signal |
| HDW_BIT_FAULT_GPS_POOR_CNO | Poor GPS signal. Check Antenna |
| HDW_BIT_FAULT_GPS_ACCURACY | Poor GPS Accuracy or Low number of satellites |

### calBitStatus – Calibration BIT Flags
Calibration BIT flags are contained in **calBitStatus**, found in the `DID_BIT` message. Bitmasks for the **calBitStatus**
flags are defined in `eCalBitStatusFlags` in data_sets.h.

| **Field** | **Description** |
| ----- | ----- |
| CAL_BIT_PASSED_ALL | Passed all calibration checks |
| CAL_BIT_FAILED_MASK | One of the calibration checks failed |

## Health Monitoring
This section illustrates tests used for system health monitoring in common application.

1. **Communication Check**

   To check that cabling between the unit and the application is working after initialization, expect that the initial expected packets are received within 3 seconds.

2. **Sensor Test (Must be Stationary)**

   These tests are ideal for manufacturing and periodic in-field testing. Initiate by setting `DID_BIT.state = 2`.

| **Test** | **Description** |
| ----- | ----- |
| hdwBitStatus & HDW_BIT_PASSED_ALL | Hardware is good |
| calBitStatus & CAL_BIT_PASSED_ALL | Sensor calibration is good |

3. **GPS Hardware Test**

  Initiate by setting `DID_BIT.state = 2`.

| **Test** | **Description** |
| ----- | ----- |
| hdwBitStatus & HDW_BIT_FAULT_GPS_NO_COM | No GPS serial communications. |
| hdwBitStatus & HDW_BIT_FAULT_GPS_POOR_CNO | Poor GPS signal strength.  Check antenna. |

4. **GPS Lock Test**

| **Test** | **Description** |
| ----- | ----- |
| hdwStatus & INS_STATUS_USING_GPS_IN_SOLUTION | GPS is being fused into INS solution |

5. **INS Output Valid**

| **Test** | **Description** |
| ----- | ----- |
| insStatus & INS_STATUS_ATT_ALIGN_GOOD | Attitude estimates are valid |
| insStatus & INS_STATUS_VEL_ALIGN_GOOD | Velocity estimates are valid |
| insStatus & INS_STATUS_POS_ALIGN_GOOD | Position estimates are valid |

6. **System Temperature**

   System temperature is available at DID_SYS_SENSORS.temp.

7. **Communications Errors**

   HDW_STATUS_COM_PARSE_ERROR_COUNT(DID_SYS_SENSORS.hStatus) is the number of parsed packet errors encountered.
