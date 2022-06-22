# Magnetometer
The magnetometer is used to estimate heading when the system is in any of the following conditions:

1. is in AHRS mode
2. has no GPS fix
3. has GPS fix and constant velocity (non-accelerating motion)

To have accurate heading under these conditions, the magnetometer must be calibrated. The system allows for two types of modes for recalibration, external initiated and automatically initiated re-calibration. Regardless of the recalibration mode, a slower online background calibration runs that continuously improves the magnetometer calibration to handle local magnetic environment changes. All magnetometer calibration is stored in flash memory and available on bootup.

## Disable Magnetometer Updates

Magnetometer fusion into the INS and AHRS filter can be disabled by setting bit `SYS_CFG_BITS_DISABLE_MAGNETOMETER_FUSION` (0x00001000) of `DID_FLASH_CONFIG.sysCfgBits`.

## Magnetometer Recalibration
Occasionally the magnetometer will require a complete recalibration, replacing the old calibration with an entirely new calibration. This is accomplished either through external or automatic initiated recalibration. Use of the different modes is generally governed by the particular use case for the end customer and is intended to allow for the most flexibility in an integrated product design.

### External Recalibration
External magnetometer recalibration allows the most flexibility in determining when an end user will need to recalibrate the system. This control over the timing of the recalibration is critical for many use cases and allows product designers to implement their desired workflows for customers. Further there are use cases where automatic recalibration is not possible because the quality of the magnetometer calibration is not observable. Such use cases would include AHRS operation, extended periods without motion or no GNSS fix. External magnetometer recalibration, as the name suggests is triggered by an external command from the application managing the uINS hardware. The uINS provides a set of status messages indicating the quality of the magnetometer calibration and leaves the timing and implementation of a recalibration up to the product designer. Specifically, `INS_STATUS_MAG_INTERFERENCE_OR_BAD_CAL` is an indication of the quality of the magnetometer calibration (see [system status flags](../system_status/#status-flags) for details).

During the calibration process, the system should be clear of steel, iron, magnets, or other ferrous materials (i.e. steel desks, tables, building structures). The uINS should be attached to the system in which it is operating and rotated together during the calibration process. The following is the


**Force magnetometer recalibration procedure:**

1. Set `DID_MAG_CAL.recalCmd` to either:
	* `MAG_CAL_STATE_MULTI_AXIS` (0) for Multi-Axis which is more accurate and requires 360⁰
rotation about two different axes.
	* `MAG_CAL_STATE_SINGLE_AXIS` (1) for Single-Axis which is less accurate and requires 360⁰
rotation about one axis.
2. Rotate the system accordingly.


**Recalibration completion is indicated by either:**

1. `INS_STATUS_MAG_RECALIBRATING` bit of the insStatus word set to zero. The insStatus word is found
in standard INS output messages (`DID_INS_1`, `DID_INS_2`, `DID_INS_3`, and `DID_INS_4`).
2. `DID_MAG_CAL.progress` is 100.

Recalibration progress is indicated as a percentage (0-100%) is indicated can be observed from variable
`DID_MAG_CAL.progress`. The recalibration process can be canceled and the prior calibration restored anytime by setting `DID_MAG_CAL.enMagRecal` = `MAG_RECAL_MODE_ABORT` (101).

The “Mag used” indicator in the EvalTool INS tab will be green when magnetometer data is being fused into the solution, black when not being fused into the solution, and red during recalibrating.

Example code:

```C++
#include "com_manager.h"
// Set DID_MAG_CAL.enMagRecal = 0 for multi-axis recalibration
int32_t value = MAG_RECAL_MODE_MULTI_AXIS;
sendDataComManager(0, DID_MAG_CAL, &value, 4, offsetof(mag_cal_t, enMagRecal));
// Enable broadcast of DID_MAG_CAL.progress every 100ms to observe the percent complete
sendDataComManager(0, DID_MAG_CAL, 0, sizeof(mag_cal_t), 100);
```

### Automatic Recalibration
Automatic magnetometer recalibration is useful for systems where user intervention to start external calibration is not convenient or practical. In this mode, the solution will determine that the system needs to be recalibrated and will attempt to do so while in normal operation. In the period while the system is recalibrating, the uncalibrated magnetometer data is used to prevent the INS heading from drifting but it does not provide heading measurements to the state estimator. This feature is enabled by setting bit `SYS_CFG_BITS_AUTO_MAG_RECAL` (0x00000004) of `DID_FLASH_CONFIG.sysCfgBits` non-volatile word.

```C++
// Enable automatic magnetometer calibration.
DID_FLASH_CONFIG.sysCfgBits |= SYS_CFG_BITS_AUTO_MAG_RECAL;
// Disable automatic magnetometer calibration.
DID_FLASH_CONFIG.sysCfgBits &= ~SYS_CFG_BITS_AUTO_MAG_RECAL;
```

## Magnetometer Continuous Calibration
To mitigate the need for recalibration (completely replace calibration data), continuous calibration improves the magnetometer calibration slowly over time. Continuous calibration always runs in the background.

## Magnetometer Calibration Settings
The magnetometer calibration algorithm can produce higher quality calibrations when data more data is collected across multiple axes of rotation. However, there are use cases where data collection beyond a single axis is impractical if not impossible. To address this issue there is a setting in the flash to configure the data requirement threshold for magnetometer calibration. The available settings include:

* Single Axis Calibration – This setting requires a full rotation in the yaw axis (relative to earth) to
  determine the calibration. Additional data that is collected via motion on other axes is used but not
  required. Once a full rotation is completed the calibration is calculated and the online continuous
  calibration is started.
* Multi Axis Calibration – This setting requires data to be collected across at least two axes, where one is
  the yaw axis. This calibration mode does not have any specific angular rotational requirements in any
  given axes, but it does require that data has been collected across a sufficient angular span. There is an
  indicator (**mag_cal_threshold_complete**) in the **`DID_SYS_PARAMS`** message that relates the total percent
  of the required threshold that has been collected. As more data is collected this value will increment to 100% at which point the calibration will be calculated and the online continuous calibration will continue
  to run

```C++
/*! Magnetometer recalibration. 0 = multi-axis, 1 = single-axis */
SYS_CFG_BITS_MAG_RECAL_MODE_MASK = (int)0x00000700,
SYS_CFG_BITS_MAG_RECAL_MODE_OFFSET = 8,
```