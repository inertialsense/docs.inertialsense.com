# Multi-band GNSS

## Advantages

The advent of multi-band GNSS (multiple frequency global navigation satellite systems) improves accuracy by reducing the impact of errors caused by multi-path and atmospheric distortion.  When compared to traditional single-band GNSS, dual-band technology provides about a 2x reduction in average position error (circular error probable - CEP).  Benefits of multi-band GNSS systems like the uBlox ZED-F9P receiver include:  

- Concurrent reception of GPS, GLONASS, Galileo and BeiDou for better coverage.
- Faster convergence time (GPS time to fix).
- More reliable / robust performance.
- ~2x reduction in average position error (CEP). 
- Centimeter-level RTK position accuracy. 
- Small and energy efficient module.
- Easy integration of RTK for fast time-to-market.

## Overview

The IMX (GPS-INS) can be interfaced with external multi-band (multi-frequency) GNSS receiver(s) connected via serial port(s) to improve precision the EKF solution.  The supported message protocols are uBlox binary and NMEA.  The following are the GPS settings (accessible in the EvalTool GPS Settings tab and IMX `DID_FLASH_CONFIG.ioConfig` and `DID_FLASH_CONFIG.RTKCfgBits`):

| Setting        | Value                                                        |
| -------------- | ------------------------------------------------------------ |
| GPS Source     | Serial port of the GNSS (serial 0 or 1)                      |
| GPS Type       | GNSS model or protocol (ublox M8, ublox F9, or NMEA)         |
| GPS RTK        | *Position* for L1 RTK precision positioning<br/>*Compass* for L1 RTK Dual GNSS heading<br/>*F9 Position* for ZED-F9P mult-frequency RTK precision positioning<br/>*F9 Compass* for ZED-F9P multi-frequency Dual GNSS heading |
| GPS1 Timepulse | Source of the GNSS PPS time synchronization, uBlox GPS type only. |

Refer to the Hardware section of this manual for serial port pinout information. 

