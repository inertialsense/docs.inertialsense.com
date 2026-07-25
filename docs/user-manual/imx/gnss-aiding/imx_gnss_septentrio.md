# Septentrio GNSS Aiding IMX

The IMX can be configured for use with Septentrio GNSS receivers such as the Mosaic-G5.  This can be done using either the EvalTool GNSS Setting tab or the IMX `DID_FLASH_CONFIG.ioConfig` and `DID_FLASH_CONFIG.RTKCfgBits` fields.    

| GNSS Ports      | Value                                            |
| --------------- | ------------------------------------------------ |
| GNSS Source     | serial 0, serial 1, or serial 2                  |
| GNSS Type       | Septentrio                                       |
| GNSS1 Timepulse | *Disable* or IMX pin connected to Septentrio PPS |
| GNSS2 Timepulse | *Disable*                                        |

| RTK Rover     | Value                          |
| ------------- | ------------------------------ |
| GNSS RTK Mode | Precision Position or Compass  |

| RTK Base                         | Value        |
| --------------------------------- | ------------ |
| Serial Port 0 (Single GNSS only) | GNSS1 - RTCM3 |
| USB Port                         | GNSS1 - RTCM3 |

The following sections detail how to interface and configure the IMX for operation using a Septentrio receiver.  See [RTK precision positioning](../../gnss/rtk_positioning_overview.md) and [RTK compassing](../../gnss/rtk_compassing.md) for RTK operation principles.

## Single-Receiver, Dual-Antenna Architecture

Unlike the ublox ZED or the GPX-1, which use two independent receiver modules for dual-antenna RTK compassing (one wired to GNSS1, a second to GNSS2), the Septentrio Mosaic-G5 is a **single receiver with two antenna inputs** (Main and Aux1).  Only GNSS1 needs a **Source** and **Type** of **Septentrio** configured — GNSS2 stays disabled.  Enabling RTK Compassing in `RTKCfgBits` tells the IMX to command the Mosaic-G5 into its own internal dual-antenna heading mode, rather than routing a second physical receiver.

## How the IMX Talks to the Septentrio Receiver

The IMX communicates with the Septentrio receiver using its native **SBF (Septentrio Binary Format)** protocol rather than translating to/from RTCM or NMEA.  Once a serial port's GNSS Type is set to **Septentrio**, the IMX automatically initializes the receiver:

1. Raises the receiver's baud rate from its factory default of 115200 to the IMX's operating baud rate of 921600, and switches its own UART to match.
2. Configures the receiver's antenna mode — multi-antenna heading mode if RTK Compassing is enabled, single-antenna otherwise.
3. Enables SBF output on the port.
4. Streams the position, velocity, satellite-visibility, and dual-antenna measurement messages the IMX needs, at a 500 ms (2 Hz) interval.
5. Configures a 1 Hz PPS output from the receiver.

RTK correction data (RTCM3) received on any IMX serial port is forwarded byte-for-byte to the Septentrio receiver.  The IMX withholds corrections until the initialization sequence above has completed.

## Firmware Update

Septentrio GNSS firmware updates are performed through the IMX's own fwUpdate protocol — the same mechanism used for IMX application firmware updates — rather than the serial-bridge-plus-vendor-tool procedure used for ublox ZED receivers.  Use `cltool -ufpkg <package>` or the EvalTool firmware update dialog; the IMX forwards the update to the Septentrio receiver internally.
