# GNSS Aiding IMX 

The IMX INS/EKF can be aided by one or more externally connected GNSS receivers.  The IMX interfaces with a variety of GNSS manufacturers and protocols, so the receiver hardware can be chosen to fit the application, while the IMX handles the details of communicating with it and fusing its position, velocity, and (optionally) dual-antenna heading data into the EKF solution.

## Supported GNSS Manufacturers and Protocols

| Manufacturer / Protocol | GNSS Type    | Description                                                                                    | Guide |
| ------------------------ | ------------ | ------------------------------------------------------------------------------------------------ | ----- |
| Inertial Sense            | GPX-1        | Inertial Sense's own multi-band GNSS/RTK receiver module, interfaced over Inertial Sense Binary (ISB). | [GPX-1](imx_gnss_gpx.md) |
| u-blox                    | ublox        | u-blox multi-band GNSS/RTK receivers (ZED-F9P, ZED-X20), interfaced using the u-blox binary protocol. | [u-blox](imx_gnss_ublox.md) |
| Septentrio                 | Septentrio   | Septentrio multi-band GNSS/RTK receivers (e.g. Mosaic-G5), interfaced using Septentrio Binary Format (SBF). | [Septentrio](imx_gnss_septentrio.md) |
| Any NMEA-compliant receiver | NMEA         | Any GNSS receiver that outputs standard NMEA ASCII sentences (GNS/GGA, ZDA, RMC, GSA).            | [NMEA](imx_gnss_nmea.md) |
| Inertial Sense Binary (ISB) | ISB          | Any device capable of generating Inertial Sense Binary GNSS DID messages directly — another Inertial Sense product, a companion computer, or a custom host. | see below |

## GNSS Antenna Offset

If the setup includes a significant distance (40cm or more) between the GNSS antenna and the IMX central unit, enter a non-zero value for the GNSS antenna lever arm, `DID_FLASH_CONFIG.gnss1AntOffset` (or `DID_FLASH_CONFIG.gnss2AntOffset`) X,Y,Z offset in meters from the [Sensor Frame](../application-config/imu_ins_configuration.md#coordinate-frame-relationship) origin to the GNSS antenna.  The Sensor Frame origin and Hardware Frame origin are always at the same location but may differ in direction according to the Sensor Rotation.

## INS-GNSS Dynamic Model
The DID_FLASH_CONFIG.dynamicModel setting allows the user to adjust how the EKF and GNSS receivers behaves in different dynamic environments. This parameter is applied to the GNSS receiver(s) engine as well as the INS EKF.