# GNSS Aiding INS Using Inertial Sense Binary (ISB)

The IMX INS/EKF can be aided directly with GNSS position and velocity data supplied as Inertial Sense Binary (ISB) messages from an external device, such as another Inertial Sense product, a companion computer, or a custom host generating GNSS solutions.  Because the data arrives already formatted as native IMX Data Identifiers (DIDs), the IMX does not need to parse a third-party GNSS receiver protocol (uBlox, NMEA, Septentrio, etc.) — it simply accepts and fuses the incoming DID messages into the EKF.

ISB GNSS aiding data can be supplied over any of the IMX serial ports (Serial 0, Serial 1, or Serial 2).  The `DID_FLASH_CONFIG.ioConfig` GNSS1 and/or GNSS2 source fields must be set to the corresponding serial port so the IMX knows which port to use for GNSS1 and GNSS2.

This is the same mechanism the [GPX-1](../hardware/module_gpx1.md) uses internally to supply GNSS1 and GNSS2 data to the IMX-5.  When `DID_FLASH_CONFIG.ioConfig` GNSS type is set to **GPX**, the IMX-5 requests this exact set of GNSS DID messages from the GPX-1 over ISB.  Setting the GNSS type to **ISB** allows any external source capable of generating these same DID messages to aid the INS in the same way.

## Configure the IMX for ISB GNSS Input

1. Connect the external ISB GNSS source to Serial 0, Serial 1, or Serial 2 (3.3V TTL UART) on the IMX.  See the [PCB Module](../hardware/module_imx5.md) hardware page for pinout.
2. Set the serial port baudrate to match `DID_FLASH_CONFIG.serXBaudRate` for the port used.
3. Configure GNSS1 (and GNSS2, if using dual antenna heading) using the EvalTool GPS Setting tab or `DID_FLASH_CONFIG.ioConfig`:

   | DID_FLASH_CONFIG | Value                                   |
   | ----------------- | --------------------------------------- |
   | GNSS1 Source       | Serial 0, Serial 1, or Serial 2         |
   | GNSS1 Type         | **ISB** (Inertial Sense Binary)         |
   | GNSS2 Source       | Serial 0, Serial 1, or Serial 2 (optional, for dual antenna heading) |
   | GNSS2 Type         | **ISB** (Inertial Sense Binary)         |

4. Stream the required DID messages (below) from the external device to the IMX at the desired GNSS update rate.  A 200ms (5Hz) period is typical and matches `DID_FLASH_CONFIG.startupGnssDtMs`.
5. Ensure the `status` field of each `DID_GNSS1_POS`/`DID_GNSS1_VEL`/`DID_GNSS2_POS`/`DID_GNSS2_VEL` message accurately reports fix type, satellites used, and accuracy (see `eGnssStatus`).  The EKF uses these status flags to determine whether the data is trustworthy enough to fuse.

## Required GNSS DID Messages

The following DID messages are needed to properly aid the INS, matching the same set the GPX-1 provides to the IMX-5.  Full field definitions for each DID are available in the [DID Descriptions](../com-protocol/DID-descriptions.md) reference.

### GNSS1 (required)

| DID | Description |
| --- | ----------- |
| `DID_GNSS1_POS` | GPS 1 position data.  Used directly by the EKF for INS position aiding. |
| `DID_GNSS1_VEL` | GPS 1 velocity data.  Used directly by the EKF for INS velocity aiding. |

### GNSS2 (required only if using a second antenna for heading/RTK compassing)

| DID | Description |
| --- | ----------- |
| `DID_GNSS2_POS` | GPS 2 position data. |
| `DID_GNSS2_VEL` | GPS 2 velocity data. |
| `DID_GNSS2_RTK_CMP_REL` | Dual GNSS RTK compassing relative info (baseline vector/heading between GNSS1 and GNSS2 antennas).  Used by the EKF to aid INS heading. |

### Supplementary (optional, recommended for full parity with the GPX-1)

These messages are not required for basic position/velocity/heading aiding, but provide status, diagnostic, and accuracy information used by the EvalTool and logging tools.

| DID | Description |
| --- | ----------- |
| `DID_GNSS1_SAT` / `DID_GNSS2_SAT` | Satellite information: identifiers, CNO, elevation/azimuth. |
| `DID_GNSS1_SIG` / `DID_GNSS2_SIG` | GNSS signal information. |
| `DID_GNSS1_VERSION` / `DID_GNSS2_VERSION` | GNSS receiver software/hardware version info. |
| `DID_GNSS1_RTK_POS_REL` / `DID_GNSS1_RTK_POS_MISC` | RTK precision positioning relative and accuracy/diagnostic info for GNSS1. |
| `DID_GNSS2_RTK_CMP_MISC` | RTK compassing accuracy/diagnostic info for GNSS2. |

## Electrical Interface

The external ISB GNSS source can be connected to Serial 0, Serial 1, and Serial 2 (3.3V TTL UART) on the IMX.  
