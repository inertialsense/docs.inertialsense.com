

# NMEA 0183 (ASCII) Protocol

For simple use, the InertialSense device supports a human-readable NMEA protocol based on NMEA 0183. The NMEA protocol is human-readable in a command-line terminal, but it is less efficient than the [binary protocol](isb.md) for the same data volume.

## Communications Example

The [NMEA Communications Example Project](../SDK/CommunicationsAscii.md) demonstrates how to implement the protocol.

## Packet Structure

The Inertial Sense NMEA protocol follows the standard [NMEA 0183](https://en.wikipedia.org/wiki/NMEA_0183) message structure:

* 1 byte – Start packet, `$` (`0x24`)
* n bytes – packet identifier
* 1 byte – comma (`0x2C`)
* n bytes – comma separated list of data, can include decimals and text
* 1 byte – checksum marker, `*` (`0x2A`)
* 2 bytes – checksum in hex format (i.e. `f5` or `0a`), zero-padded and lowercase
* 2 bytes – End packet, `\r\n` (`0x0D`, `0x0A`)

The packet checksum is an 8-bit integer and is calculated by XORing all bytes between (but not including) the $ and * bytes. The packet checksum byte is converted to a 2-byte NMEA hex code, and left-padded with 0 if necessary to ensure that it is always 2 bytes. The checksum is always lowercase hexadecimal characters. See [NMEA 0183](https://en.wikipedia.org/wiki/NMEA_0183) message structure for more details. The NMEA string checksum is automatically computed and appended to the string when using the Inertial Sense SDK [serialPortWriteAscii function](https://github.com/inertialsense/InertialSenseSDK/blob/main/src/serialPort.c#L219-L268) or can be generated using an online checksum calculator. For example: [MTK NMEA checksum calculator](http://www.hhhh.org/wiml/proj/nmeaxor.html)

## Persistent Messages

The *persistent messages* option saves the current data stream configuration to flash memory for use following reboot, eliminating the need to re-enable messages following a reset or power cycle.  

- **To save current NMEA persistent messages** - send the [$PERS](#pers) command.  
- **To disable persistent messages** - send [$STPB](#stpb) followed by [$PERS](#pers). 

[Binary persistent messages](../isb/#persistent-messages) are also available.

### Enabling Persistent Messages - EvalTool

To enable persistent NMEA messages using the EvalTool:

- Enable the desired NMEA messages in the EvalTool "Data Sets" tab. Select DID_NMEA_BCAST_PERIOD in the DID menu and set the desired NMEA messages period to a non-zero value.
- Press the "Save Persistent" button in the EvalTool "Data Logs" tab to store the current message configuration to flash memory.
- Reset the IMX and verify the messages are automatically streaming. You can use a generic serial port program like putty or the EvalTool->Data Logs->Data Log->Messages dialog to view the NMEA messages.

**To disable all persistent messages using the EvalTool**, click the "Stop Streaming" button and then "Save Persistent" button.   

## NMEA Input Messages

The following NMEA messages can be received by the IMX.

| Message                     | Description                                                       |
| --------------------------- | ------------------------------------------------------------------|
| ```$ASCE*14\r\n```          | Query the broadcast rate of NMEA output messages.                 |
| [ASCE](#asce)               | Set the broadcast period of selected NMEA output messages.        |
| ```$INFO*0E\r\n```          | Query device information.                                         |
| ```$SRST*06\r\n```          | Software reset.                                                   |
| [```$PERS*14\r\n```](#pers) | Save persistent messages to flash.                                |
| [```$STPB*15\r\n```](#stpb) | Stop broadcast of all messages (NMEA and binary) on all ports.    |
| [```$STPC*14\r\n```](#stpc) | Stop broadcast of all messages (NMEA and binary) on current port. |

### ASCE

Enable NMEA message output streaming by specifying the [NMEA message identifier or ID](#nmea-output-messages) and broadcast period. The period is the multiple of the [*data source period*](../isb/#data-source-update-rates) (i.e., a GNSS message with period multiple of 2 and data source period of 200 ms (5 Hz) will broadcast every 400 ms). "xx" is the two-character checksum. The broadcast period for each message is configurable as a period multiple of the [*Data Source Update Rates*](binary/#data-source-update-rates). Up to 20 different NMEA messages can be enabled by repeating the message ID and period sequence within an ASCE message.

**Note:** A period value of 0 requests a single (one-shot) message and disables streaming for that message. This provides a convenient way to query an NMEA message without enabling continuous streaming.

```
$ASCE,OPTIONS,(ID,PERIOD)*xx\r\n
```

| Index | Field     | Description                                                  |
| ----- | --------- | ------------------------------------------------------------ |
| 1     | `OPTIONS` | Port selection. Combine by adding options together:<br/>0=current, 1=ser0, 2=ser1, 4=ser2, 8=USB, <br/>512=persistent (remember after reset) |
|       |           | *Start of repeated group (1...20 times)*                     |
| 2+n*2 | `ID`      | Either **1.) message identifier string** (i.e., PPIMU, PINS1, GNGGA) excluding packet start character `$` or **2.) message ID** (eNmeaAsciiMsgId) of the NMEA message to be streamed. See the message ID in the [NMEA output messages](#nmea-output-messages) table. |
| 3+n*2 | `PERIOD`  | Broadcast period multiple for specified message. Zero queries one message and disables streaming. |
|       |           | *End of repeated group (1...20 times)*                       |

#### Example Messages

The following example NMEA messages enable IMX data streaming output. The data period is 1, full [data source rates](binary/#data-source-update-rates), for those that do not specify the output rate.

The following two examples both enable the same NMEA message output:

```
$ASCE,0,PPIMU,1,PINS2,10,GNGGA,1*26\r\n
$ASCE,0,2,1,5,10,7,1*39\r\n
```

The following example will query one PINS1 message without streaming.

```
$ASCE,0,PINS1,0*0D\r\n
```

| Message             | Data (Output Rate)** |
| ------------------- | ------- |
| $ASCE,0,6,1,7,1,8,1,10,1,14,1*04\r\n | GGA, GLL, GSA, ZDA, GSV (all at 5Hz) |
| $ASCE,0,5,2,2,1,7,1*0A\r\n | PINS2 (31.25 Hz), PPIMU (62.5Hz), GGA (5Hz) |
| $ASCE,0,0,1*09\r\n  | PIMU    |
| $ASCE,0,1,1*08\r\n  | PPIMU   |
| $ASCE,0,2,1*0B\r\n  | PRIMU   |
| $ASCE,0,3,1*0A\r\n  | PINS1   |
| $ASCE,0,4,1*0D\r\n  | PINS2   |
| $ASCE,0,5,1*0C\r\n  | PGPSP   |
| $ASCE,0,6,1*0F\r\n  | GGA     |
| $ASCE,0,7,1*0E\r\n  | GLL     |
| $ASCE,0,8,1*01\r\n  | GSA     |
| $ASCE,0,9,1*00\r\n  | RMC     |
| $ASCE,0,10,1*38\r\n | ZDA     |
| $ASCE,0,11,1*39\r\n | PASHR   |
| $ASCE,0,12,1*3A\r\n | PSTRB   |
| $ASCE,0,13,1*3B\r\n | INFO    |
| $ASCE,0,14,1*3C\r\n | GSV     |
| $ASCE,0,15,1*3D\r\n | VTG     |

<sup>**</sup> These rates assume the default settings for [data source rates](binary/#data-source-update-rates).

### PERS

Send this command to save current *persistent messages* to flash memory for use following reboot. This eliminates the need to re-enable messages following a reset or power cycle. To disable persistent messages, all messages must be disabled and then the 'save persistent messages' command should be sent.

```
$PERS*14\r\n
```

### STPB

Stop all broadcasts (both binary and NMEA) on all ports by sending the following packet:

```
$STPB*15\r\n
```

The hexadecimal equivalent is:

```
24 53 54 50 42 2A 31 35 0D 0A
```

### STPC

Stop all broadcasts (both binary and NMEA) on the current port by sending the following packet:

```
$STPC*14\r\n
```

The hexadecimal equivalent is:

```
24 53 54 50 43 2A 31 34 0D 0A
```

## NMEA Output Messages

The following NMEA messages can be sent by the IMX. The message ID (`eNmeaAsciiMsgId`) is used with the `$ASCE` message to enable message streaming. 

| Identifier      | ID   | Description                                                  |
| --------------- | ---- | ------------------------------------------------------------ |
| [ASCB](#ascb)   |      | Broadcast period of NMEA output messages.                    |
| [PIMU](#pimu)   | 1    | IMU data (3-axis gyros and accelerometers) in the body frame. |
| [PPIMU](#ppimu) | 2    | Preintegrated IMU: delta theta (rad) and delta velocity (m/s). |
| [PRIMU](#primu) | 3    | Raw IMU data (3-axis gyros and accelerometers) in the body frame. |
| [PINS1](#pins1) | 4    | INS output: euler rotation w/ respect to NED, NED position from reference LLA. |
| [PINS2](#pins2) | 5    | INS output: quaternion rotation w/ respect to NED, ellipsoid altitude. |
| [PGPSP](#pgpsp) | 6    | GPS position data.                                           |
| [GGA](#gga)     | 7    | Standard NMEA GGA GPS 3D location, fix, and accuracy.        |
| [GLL](#gll)     | 8    | Standard NMEA GLL GPS 2D location and time.                  |
| [GSA](#gsa)     | 9    | Standard NMEA GSA GPS DOP and active satellites.             |
| [RMC](#rmc)     | 10   | Standard NMEA RMC Recommended minimum specific GPS/Transit data. |
| [ZDA](#zda)     | 11   | Standard NMEA ZDA UTC Time/Date message.                     |
| [PASHR](#pashr) | 12   | Standard NMEA PASHR (euler) message.                         |
| [PSTRB](#pstrb) | 13   | Strobe event input time.                                     |
| [INFO](#info)   | 14   | Device information.                                          |
| [GSV](#gsv)     | 15   | Standard NMEA GSV satellite info (all active constellations sent with corresponding talker IDs). |
| [VTG](#VTG)     | 16   | Standard NMEA VTG track made good and speed over ground.     |

The field codes used in the message descriptions are: lf = double, f = float, d = int.

### NMEA Output GNSS Source

Following IMX power on/reset, the default source for NMEA output is GPS1 if available or GPS2 if GPS1 is disabled. This source is reported via bit SYS_STATUS_PRIMARY_GNSS_SOURCE_IS_GNSS2 (0x00000004) of DID_SYS_PARAMS.sysStatus where cleared means GNSS1 and set means GNSS2. Users may manually set or clear this bit to control the NMEA output GNSS source.

### PIMU

IMU sensor data (3-axis gyros and accelerometers) in the body frame.

```
$PIMU,lf,f,f,f,f,f,f*xx\r\n
       1 2 3 4 5 6 7
```

| Index | Field      | Units   | Description                 |
| ----- | ---------- | ------- | --------------------------- |
| 1     | time       | sec     | Time since system power up  |
| 2     | IMU pqr[0] | rad/sec | IMU angular rate gyro – X   |
| 3     | IMU pqr[1] | rad/sec | IMU angular rate gyro – Y   |
| 4     | IMU pqr[2] | rad/sec | IMU angular rate gyro – Z   |
| 5     | IMU acc[0] | m/s2    | IMU linear acceleration – X |
| 6     | IMU acc[1] | m/s2    | IMU linear acceleration – Y |
| 7     | IMU acc[2] | m/s2    | IMU linear acceleration – Z |

### PPIMU

Preintegrated inertial measurement unit (IMU) sensor data, delta theta in radians and delta velocity in m/s in the body frame. Also known as coning and sculling integrals.

```
$PPIMU,lf,f,f,f,f,f,f,f*xx\r\n
        1 2 3 4 5 6 7 8
```

| Index | Field    | Units | Description                            |
| ----- | -------- | ----- | -------------------------------------- |
| 1     | time     | sec   | Time since system power up             |
| 2     | theta[0] | rad   | IMU delta theta integral – X           |
| 3     | theta[1] | rad   | IMU delta theta integral – Y           |
| 4     | theta[2] | rad   | IMU delta theta integral – Z           |
| 5     | vel[0]   | m/s   | IMU delta velocity integral – X        |
| 6     | vel[1]   | m/s   | IMU delta velocity integral – Y        |
| 7     | vel[2]   | m/s   | IMU delta velocity integral – Z        |
| 8     | dt       | s     | Integration period for delta theta vel |

### PRIMU

Raw IMU sensor data (3-axis gyros and accelerometers) in the body frame (up to 1KHz). Use this IMU data for output data rates faster than DID_FLASH_CONFIG.startupNavDtMs. Otherwise, we recommend use of PIMU or PPIMU as they are oversampled and contain less noise. 0 to disable.

```
$PRIMU,lf,f,f,f,f,f,f*xx\r\n
        1 2 3 4 5 6 7
```

| Index | Field          | Units   | Description                     |
| ----- | -------------- | ------- | ------------------------------- |
| 1     | time           | sec     | Time since system power up      |
| 2     | Raw IMU pqr[0] | rad/sec | Raw IMU angular rate gyro – X   |
| 3     | Raw IMU pqr[1] | rad/sec | Raw IMU angular rate gyro – Y   |
| 4     | Raw IMU pqr[2] | rad/sec | Raw IMU angular rate gyro – Z   |
| 5     | Raw IMU acc[0] | m/s2    | Raw IMU linear acceleration – X |
| 6     | Raw IMU acc[1] | m/s2    | Raw IMU linear acceleration – Y |
| 7     | Raw IMU acc[2] | m/s2    | Raw IMU linear acceleration – Z |

### PINS1

INS output with Euler angles and NED offset from the reference LLA.

```
$PINS1,lf,d,d,d,f,f,f,f,f,f,lf,lf,lf,f,f,f*xx\r\n
        1 2 3 4 5 6 7 8 9 0  1  2  3 4 5 6
```

| Index | Field        | Units | Description                                                  |
| ----- | ------------ | ----- | ------------------------------------------------------------ |
| 1     | timeOfWeek   | sec   | Seconds since Sunday morning in GMT                          |
| 2     | GPS week     | weeks | Number of weeks since January 1st of 1980 in GMT             |
| 3     | insStatus    |       | [INS Status Flags](../DID-descriptions/#ins-status-flags)    |
| 4     | hdwStatus    |       | [Hardware Status Flags](../DID-descriptions/#hardware-status-flags) |
| 5     | theta[0]     | rad   | Euler angle – roll                                           |
| 6     | theta[1]     | rad   | Euler angle – pitch                                          |
| 7     | theta[2]     | rad   | Euler angle – yaw                                            |
| 8     | UVW[0]       | m/s   | Velocity in body frame – X                                   |
| 9     | UVW[1]       | m/s   | Velocity in body frame – Y                                   |
| 10    | UVW[2]       | m/s   | Velocity in body frame – Z                                   |
| 11    | Latitude     | deg   | WGS84 Latitude                                               |
| 12    | Longitude    | deg   | WGS84 Longitude                                              |
| 13    | HAE Altitude | m     | Height above ellipsoid (vertical elevation)                  |
| 14    | NED[0]       | m     | Offset from reference LLA – North                            |
| 15    | NED[1]       | m     | Offset from reference LLA – East                             |
| 16    | NED[2]       | m     | Offset from reference LLA – Down                             |

### PINS2

INS output with quaternion attitude.

```
$PINS2,lf,d,d,d,f,f,f,f,f,f,f,lf,lf,lf*xx\r\n
        1 2 3 4 5 6 7 8 9 0 1  2  3  4
```

| Index | Field        | Units | Description                                                  |
| ----- | ------------ | ----- | ------------------------------------------------------------ |
| 1     | timeOfWeek   | sec   | Seconds since Sunday morning in GMT                          |
| 2     | GPS week     | weeks | Number of weeks since January 1st of 1980 in GMT             |
| 3     | insStatus    |       | [INS Status Flags](../DID-descriptions/#ins-status-flags)    |
| 4     | hdwStatus    |       | [Hardware Status Flags](../DID-descriptions/#hardware-status-flags) |
| 5     | qn2b[0]      |       | Quaternion rotation (NED to body) – W                        |
| 6     | qn2b[1]      |       | Quaternion rotation (NED to body) – X                        |
| 7     | qn2b[2]      |       | Quaternion rotation (NED to body) – Y                        |
| 8     | qn2b[3]      |       | Quaternion rotation (NED to body) – Z                        |
| 9     | UVW[0]       | m/s   | Velocity in body frame – X                                   |
| 10    | UVW[1]       | m/s   | Velocity in body frame – Y                                   |
| 11    | UVW[2]       | m/s   | Velocity in body frame – Z                                   |
| 12    | Latitude     | deg   | WGS84 Latitude                                               |
| 13    | Longitude    | deg   | WGS84 Longitude                                              |
| 14    | HAE altitude | m     | Height above ellipsoid (vertical elevation)                  |

### PGPSP

GPS navigation data.

```
$PGPSP,d,d,d,lf,lf,lf,f,f,f,f,f,f,f,f,f,f*xx\r\n
       1 2 3  4  5  6 7 8 9 0 1 2 3 4 5 6

$PGPSP,337272200,2031,1075643160,40.33057800,-111.72581630,1406.39,1425.18,0.95,0.37,0.55,-0.02,0.02,-0.03,0.17,39.5,337182.4521*4d\r\n
```

| Index | Field        | Units | Description                                                  |
| ----- | ------------ | ----- | ------------------------------------------------------------ |
| 1     | timeOfWeekMs | ms    | GPS time of week in milliseconds since Sunday morning in GMT |
| 2     | GPS week     | weeks | GPS number of weeks since January 1st of 1980 in GMT         |
| 3     | status       |       | (see [eGpsStatus](../DID-descriptions/#gps-status)) GPS status: [0x000000xx] number of satellites used, [0x0000xx00] fix type, [0x00xx0000] status flags |
| 4     | Latitude     | deg   | WGS84 Latitude                                               |
| 5     | Longitude    | deg   | WGS84 Longitude                                              |
| 6     | HAE altitude | m     | Height above WGS84 ellipsoid                                 |
| 7     | MSL altitude | m     | Elevation above mean sea level                               |
| 8     | pDOP         | m     | Position dilution of precision                               |
| 9     | hAcc         | m     | Horizontal accuracy                                          |
| 10    | vAcc         | m     | Vertical accuracy                                            |
| 11    | Velocity X   | m/s   | ECEF X velocity                                              |
| 12    | Velocity Y   | m/s   | ECEF Y velocity                                              |
| 13    | Velocity Z   | m/s   | ECEF Z velocity                                              |
| 14    | sAcc         | m/s   | Speed accuracy                                               |
| 15    | cnoMean      | dBHz  | Average of all satellite carrier-to-noise ratios (signal strengths) that are non-zero |
| 16    | towOffset    | s     | Time sync offset between local time since boot up to GPS time of week in seconds. Add this to IMU and sensor time to get GPS time of week in seconds. |
| 17    | leapS        | s     | GPS leap second (GPS-UTC) offset. Receiver's best knowledge of the leap seconds offset from UTC to GPS time. Subtract from GPS time of week to get UTC time of week. |

### GGA
NMEA GPS fix, 3D location and accuracy data.

```
$GPGGA,204153.200,4003.34331,N,11139.51872,W,1,25,0.93,1433.997,M,18.82,M,,*6d\r\n
                1          2 3           4 5 6  7    8     9    0     1 2 3 4
```

| Index | Field         | Units   | Description                                                  | Example      |
| ----- | ------------- | ------- | ------------------------------------------------------------ | ------------ |
| 1     | HHMMSS.sss    |         | UTC time (fix taken at 20:41:53.200 UTC)                     | 204153.200    |
| 2,3   | Latitude      | deg,min | WGS84 latitude (DDmm.mmmmm,N)                                | 4003.34331,N  |
| 4,5   | Longitude     | deg,min | WGS84 longitude (DDDmm.mmmmm,E)                              | 11139.51872,W |
| 6     | Fix quality   |         | 0 = invalid, 1 = GPS fix (SPS), 2 = DGPS fix, 3 = PPS fix, 4 = RTK Fix, 5 = RTK Float, 6 = estimated (dead reckoning), 7 = Manual input mode, 8 = Simulation mode | 1            |
| 7     | \# Satellites |         | Number of satellites in use                                  | 15           |
| 8     | hDop          | m       | Horizontal dilution of precision                             | 0.9          |
| 9,10  | MSL_altitude  | m       | Elevation above mean sea level (MSL)                         | 545.4,M      |
| 11,12 | Undulation    | m       | Undulation of geoid.  Height of the geoid  above the WGS84 ellipsoid. | 46.9,M       |
| 13    | empty         | s       | Time since last DGPS update                                  |              |
| 14    | empty         |         | DGPS station ID number                                       |              |

### GLL
NMEA geographic position, latitude / longitude and time.

```
$GPGLL,4916.45123,N,12311.12324,W,225444.800,A*33\r\n
                1 2           3 4          5 6
```

| Index | Field      | Units   | Description                          | Example      |
| ----- | ---------- | ------- | ------------------------------------ | ------------ |
| 1,2   | Latitude   | deg,min | WGS84 latitude (DDmm.mmmmm,N)        | 4916.45123,N  |
| 3,4   | Longitude  | deg,min | WGS84 longitude (DDDmm.mmmmm,E)      | 12311.12324,W |
| 5     | HHMMSS.sss |         | UTC time (fix taken at 22:54:44.8 UTC) | 225444.800   |
| 6     | Valid      |         | Data valid (A=active, V=void)        | A            |

### GSA

NMEA GPS DOP and active satellites.

```
$GPGSA,A,3,04,05,,09,12,,,24,,,,,2.5,1.3,2.1*39\r\n
       1 2  3  4 ...              15  16  17
```

| Index | Field       | Units | Description                                 | Example                |
| ----- | ----------- | ----- | ------------------------------------------- | ---------------------- |
| 1     |             |       | Auto selection of 2D or 3D fix (M = manual) | A                      |
| 2     | Fix quality |       | Fix quality (1 = none, 2 = 2D, 3 = 3D)      | 3                      |
| 3-14  | Sat ID      |       | Satellite ID (PRNs)                         | 04,05,,09,12,,,24,,,,, |
| 15    | pDop        | m     | Dilution of precision                       | 2.5                    |
| 16    | hDop        | m     | Horizontal dilution of precision            | 1.3                    |
| 17    | vDop        | m     | Vertical dilution of precision              | 2.1                    |

### RMC

NMEA GPS recommended minimum specific GPS/Transit data.

```
eg1. $GPRMC,081836,A,3751.65,S,14507.36,E,000.0,360.0,130998,011.3,E*62\r\n
eg2. $GPRMC,225446,A,4916.45,N,12311.12,W,000.5,054.7,191194,020.3,E*68\r\n

           225446       Time of fix 22:54:46 UTC
           A            Navigation receiver warning A = OK, V = warning
           4916.45,N    Latitude 49 deg. 16.45 min North
           12311.12,W   Longitude 123 deg. 11.12 min West
           000.5        Speed over ground, Knots
           054.7        Course Made Good, True
           191194       Date of fix  19 November 1994
           020.3,E      Magnetic variation 20.3 deg East
           *68          mandatory checksum

eg3. $GPRMC,220516,A,5133.82,N,00042.24,W,173.8,231.8,130694,004.2,W*70\r\n
              1    2    3    4    5     6    7    8      9     10  11 12

      1   220516     Time Stamp
      2   A          validity - A-ok, V-invalid
      3   5133.82    current Latitude
      4   N          North/South
      5   00042.24   current Longitude
      6   W          East/West
      7   173.8      Speed in knots
      8   231.8      True course
      9   130694     Date Stamp
      10  004.2      Variation
      11  W          East/West
      12  *70        checksum

eg4. $GPRMC,hhmmss.ss,A,llll.ll,a,yyyyy.yy,a,x.x,x.x,ddmmyy,x.x,a*hh\r\n
1    = UTC of position fix
2    = Data status (V=navigation receiver warning)
3    = Latitude of fix
4    = N or S
5    = Longitude of fix
6    = E or W
7    = Speed over ground in knots
8    = Track made good in degrees True
9    = UT date
10   = Magnetic variation degrees (Easterly var. subtracts from true course)
11   = E or W
12   = Checksum
```

### VTG

NMEA GPS track made good and speed over ground.

```
eg1. $GPVTG,140.88,T,,M,8.04,N,14.89,K,D*05\r\n

0	Message ID $GPVTG
1	Track made good (degrees true)
2	T: track made good is relative to true north
3	Track made good (degrees magnetic)
4	M: track made good is relative to magnetic north
5	Speed, in knots
6	N: speed is measured in knots
7	Speed over ground in kilometers/hour (kph)
8	K: speed over ground is measured in kph
9	Mode indicator:
        A: Autonomous mode
        D: Differential mode
        E: Estimated (dead reckoning) mode
        M: Manual Input mode
        S: Simulator mode
        N: Data not valid
10	The checksum data, always begins with *
```

### ZDA

NMEA GPS UTC Time and Date specification.

```
$GPZDA,213301.200,31,08,2023,00,00*41\r\n
                1  2  3    4  5  6
```

| Index | Field       | Units | Description             | Example    |
|-------|-------------|-------|-------------------------|------------|
| 1     | HHMMSS.sss  |       | UTC Time                | 213301.200 |
| 2     | Day         |       | Day                     | 31         |
| 3     | Month       |       | Month                   | 08         |
| 4     | Year        |       | Year                    | 2023       |
| 5     | localHrs    |       | Local time zone hours   | 00         |
| 6     | localMin    |       | Local time zone minutes | 00         |

### GSV

NMEA GNSS satellites in view. `xx` corresponds to a constellation talker ID, shown in the table below.

Contains the number of sats in view, PRN numbers, elevation, azimuth and SNR value. Each message includes up to four satellites. When there are more than 4 sats for a constellation, multiple messages are sent. The total number of messages and the message number are included in each message.

Example:
```
$GPGSV,6,1,23,02,40,310,43,08,07,324,31,10,48,267,45,15,37,053,45*7C\r\n
$GPGSV,6,2,23,16,12,268,35,18,69,078,41,23,74,336,40,24,15,111,37*79\r\n
$GPGSV,6,3,23,26,02,239,31,27,35,307,38,29,12,162,37,32,14,199,39*7B\r\n
$GPGSV,6,4,23,44,43,188,43,46,40,206,43,522,48,267,45,527,37,053,26*73\r\n
$GPGSV,6,5,23,530,69,078,34,535,74,336,34,536,15,111,25,538,02,239,18*74\r\n
$GPGSV,6,6,23,539,35,307,27,541,12,162,21,544,14,199,25*73\r\n
$GAGSV,2,1,08,05,65,144,41,09,39,052,43,34,71,341,42,36,46,105,39*6A\r\n
$GAGSV,2,2,08,517,65,144,30,521,39,052,30,546,71,341,27,548,46,105,30*64\r\n
$GBGSV,3,1,10,11,09,141,34,14,52,047,44,27,32,313,43,28,80,263,44*64\r\n
$GBGSV,3,2,10,33,81,039,43,41,43,230,42,43,33,148,42,58,,,44*5B\r\n
$GBGSV,3,3,10,11,09,141,16,14,52,047,32*60\r\n
$GQGSV,1,1,01,02,45,101,30*49\r\n
$GLGSV,2,1,07,65,85,260,33,66,28,217,30,72,36,034,35,81,20,324,33*69\r\n
$GLGSV,2,2,07,87,47,127,35,88,73,350,34,87,47,127,20*53\r\n
```

Example NMEA version 4.11:
```
$GPGSV,4,1,14,02,40,310,43,08,07,324,31,10,48,267,45,15,37,053,45,1*67\r\n
$GPGSV,4,2,14,16,12,268,35,18,69,078,41,23,74,336,40,24,15,111,37,1*62\r\n
$GPGSV,4,3,14,26,02,239,31,27,35,307,38,29,12,162,37,32,14,199,39,1*60\r\n
$GPGSV,4,4,14,44,43,188,43,46,40,206,43,1*65\r\n
$GPGSV,3,1,09,10,48,267,45,15,37,053,26,18,69,078,34,23,74,336,34,6*68\r\n
$GPGSV,3,2,09,24,15,111,25,26,02,239,18,27,35,307,27,29,12,162,21,6*64\r\n
$GPGSV,3,3,09,32,14,199,25,6*58\r\n
$GAGSV,1,1,04,05,65,144,41,09,39,052,43,34,71,341,42,36,46,105,39,7*7E\r\n
$GAGSV,1,1,04,05,65,144,30,09,39,052,30,34,71,341,27,36,46,105,30,2*73\r\n
$GBGSV,2,1,08,11,09,141,34,14,52,047,44,27,32,313,43,28,80,263,44,1*71\r\n
$GBGSV,2,2,08,33,81,039,43,41,43,230,42,43,33,148,42,58,,,44,1*4E\r\n
$GBGSV,1,1,02,11,09,141,16,14,52,047,32,B*0D\r\n
$GQGSV,1,1,01,02,45,101,30,1*54\r\n
$GLGSV,2,1,06,65,85,260,33,66,28,217,30,72,36,034,35,81,20,324,33,1*75\r\n
$GLGSV,2,2,06,87,47,127,35,88,73,350,34,1*75\r\n
$GLGSV,1,1,01,87,47,127,20,3*41\r\n
```

| Talker ID | Constellation                        |
|-----------|--------------------------------------|
| GP        | GPS                                  |
| GQ        | QZSS                                 |
| GA        | Galileo                              |
| GL        | Glonass                              |
| GB        | BeiDou                               |
| GN        | Combination of active constellations |

| Index   | Field   | Units | Description                                               |
|---------|---------|-------|-----------------------------------------------------------|
| 1       | numMsgs |       | Total number of messages for this constellation and epoch |
| 2       | msgNum  |       | Message number                                            |
| 3       | numSats |       | Total number of known satellites for the talker ID and signal ID |
| 4+(n*5) | prn     |       | Satellite PRN number                                      |
| 5+(n*5) | elev    | deg   | Elevation (0-90)                                          |
| 6+(n*5) | azim    | deg   | Azimuth (000 to 359)                                      |
| 7+(n*5) | snr     | dB    | SNR (00-99, empty when not tracking)                      |
| variable | system ID |    | GNSS system ID (distinguishes frequency band).  This field is only output if the NMEA version is 4.11. | 

Where n is 0-3, for the four satellites supported by this message. 

#### GSV Output Filtering

Verbosity and size of the GSV NMEA message can be reduced to only select constellation and frequencies by using a [Filtered GSV NMEA Message IDs](#filtered-gsv-nmea-message-ids) instead of the standard GSV message ID `GPGSV` or `15` (`NMEA_MSG_ID_GNGSV`), either ASCII or integer.  Note that the GSV output filter can only hide or mask information for satellites currently enabled in the `DID_FLASH_CONFIG.gnssSatSigConst` satellite system constellation.  Usage:

```c++
$ASCE,[options],[Message ID]*[checksum]\r\n
```

For example, using message ID `GPGSV_1` or `3857` (`NMEA_MSG_ID_GPGSV_1`) will output only the GPS L1 frequency and prevent all other frequency and constellation satellite information from being displayed.

```
$ASCE,0,GPGSV_1,2*01\r\n
$ASCE,0,3857,2*33\r\n
```

##### Filtered GSV NMEA Message IDs

The following extended GSV NMEA message IDs are defined in data_sets.h.

| All Constellations          | Message ID ASCII | Message ID Int | Description |
|-----------------------------|------------------|----------------|-------------|
| NMEA_MSG_ID_GNGSV_0         | GNGSV_0 | 3840 | Clear all constellations and frequencies |
| NMEA_MSG_ID_GNGSV_1         | GNGSV_1 | 3841 | Enable all constellations band1 |
| NMEA_MSG_ID_GNGSV_2         | GNGSV_2 | 3842 | Enable all constellations band2 |
| NMEA_MSG_ID_GNGSV_2_1       | GNGSV_2_1 | 3843 | Enable all constellations band1, band2 |
| NMEA_MSG_ID_GNGSV_3         | GNGSV_3 | 3844 | Enable all constellations band3 |
| NMEA_MSG_ID_GNGSV_3_1       | GNGSV_3_1 | 3845 | Enable all constellations band1, band3 |
| NMEA_MSG_ID_GNGSV_3_2       | GNGSV_3_2 | 3846 | Enable all constellations band2, band3 |
| NMEA_MSG_ID_GNGSV_3_2_1     | GNGSV_3_2_1 | 3847 | Enable all constellations band1, band2, band3 |
| NMEA_MSG_ID_GNGSV_5         | GNGSV_5 | 3848 | Enable all constellations band5 |
| NMEA_MSG_ID_GNGSV_5_1       | GNGSV_5_1 | 3849 | Enable all constellations band1, band5 |
| NMEA_MSG_ID_GNGSV_5_2       | GNGSV_5_2 | 3850 | Enable all constellations band2, band5 |
| NMEA_MSG_ID_GNGSV_5_2_1     | GNGSV_5_2_1 | 3851 | Enable all constellations band1, band2, band5 |
| NMEA_MSG_ID_GNGSV_5_3       | GNGSV_5_3 | 3852 | Enable all constellations band3, band5 |
| NMEA_MSG_ID_GNGSV_5_3_1     | GNGSV_5_3_1 | 3853 | Enable all constellations band1, band3, band5 |
| NMEA_MSG_ID_GNGSV_5_3_2     | GNGSV_5_3_2 | 3854 | Enable all constellations band2, band3, band5 |
| NMEA_MSG_ID_GNGSV_5_3_2_1   | GNGSV_5_3_2_1 | 3855 | Enable all constellations band1, band2, band3, band5 |

| GPGSV - GPS                 | Message ID ASCII | Message ID Int | Description |
|-----------------------------|------------------|----------------|-------------|
| NMEA_MSG_ID_GPGSV_0         | GPGSV_0 | 3856 | Disable all GPS frequencies |
| NMEA_MSG_ID_GPGSV_1         | GPGSV_1 | 3857 | Enable GPS L1 |
| NMEA_MSG_ID_GPGSV_2         | GPGSV_2 | 3858 | Enable GPS L2 |
| NMEA_MSG_ID_GPGSV_2_1       | GPGSV_2_1 | 3859 | Enable GPS L1, L2 |
| NMEA_MSG_ID_GPGSV_5         | GPGSV_5 | 3864 | Enable GPS L5 |
| NMEA_MSG_ID_GPGSV_5_1       | GPGSV_5_1 | 3865 | Enable GPS L1, L5 |
| NMEA_MSG_ID_GPGSV_5_2       | GPGSV_5_2 | 3866 | Enable GPS L2, L5 |
| NMEA_MSG_ID_GPGSV_5_2_1     | GPGSV_5_2_1 | 3867 | Enable GPS L1, L2, L5 |
| NMEA_MSG_ID_GPGSV           | GPGSV | 3871 | Enable all GPS frequencies |

| GAGSV - Galileo             | Message ID ASCII | Message ID Int | Description |
|-----------------------------|------------------|----------------|-------------|
| NMEA_MSG_ID_GAGSV_0         | GAGSV_0 | 3888 | Disable all Galileo frequencies |
| NMEA_MSG_ID_GAGSV_1         | GAGSV_1 | 3889 | Enable Galileo E1 |
| NMEA_MSG_ID_GAGSV_5         | GAGSV_5 | 3896 | Enable Galileo E5 |
| NMEA_MSG_ID_GAGSV_5_1       | GAGSV_5_1 | 3897 | Enable Galileo E1, E5 |
| NMEA_MSG_ID_GAGSV           | GAGSV | 3903 | Enable all Galileo frequencies     |

| GBGSV - Beido               | Message ID ASCII | Message ID Int | Description |
|-----------------------------|------------------|----------------|-------------|
| NMEA_MSG_ID_GBGSV_0         | GBGSV_0 | 3904 | Disable all Beidou frequencies |
| NMEA_MSG_ID_GBGSV_1         | GBGSV_1 | 3905 | Enable Beidou B1 |
| NMEA_MSG_ID_GBGSV_2         | GBGSV_2 | 3906 | Enable Beidou B2 |
| NMEA_MSG_ID_GBGSV_2_1       | GBGSV_2_1 | 3907 | Enable Beidou B1, B2 |
| NMEA_MSG_ID_GBGSV_3         | GBGSV_3 | 3908 | Enable Beidou B3  |
| NMEA_MSG_ID_GBGSV_3_1       | GBGSV_3_1 | 3909 | Enable Beidou B1, B3 |
| NMEA_MSG_ID_GBGSV_3_2       | GBGSV_3_2 | 3910 | Enable Beidou B2, B3 |
| NMEA_MSG_ID_GBGSV_3_2_1     | GBGSV_3_2_1 | 3911 | Enable Beidou B1, B2, B3 |
| NMEA_MSG_ID_GBGSV           | GBGSV | 3919 | Enable all Beidou frequencies |

| GQGSV - QZSS                | Message ID ASCII | Message ID Int | Description |
|-----------------------------|------------------|----------------|-------------|
| NMEA_MSG_ID_GQGSV_0         | GQGSV_0 | 3920 | Disable all QZSS frequencies |
| NMEA_MSG_ID_GQGSV_1         | GQGSV_1 | 3921 | Enable QZSS L1 |
| NMEA_MSG_ID_GQGSV_2         | GQGSV_2 | 3922 | Enable QZSS L2 |
| NMEA_MSG_ID_GQGSV_2_1       | GQGSV_2_1 | 3923 | Enable QZSS L1, L2 |
| NMEA_MSG_ID_GQGSV_5         | GQGSV_5 | 3928 | Enable QZSS L5 |
| NMEA_MSG_ID_GQGSV_5_1       | GQGSV_5_1 | 3929 | Enable QZSS L1, L5 |
| NMEA_MSG_ID_GQGSV_5_2       | GQGSV_5_2 | 3930 | Enable QZSS L2, L5 |
| NMEA_MSG_ID_GQGSV_5_2_1     | GQGSV_5_2_1 | 3931 | Enable QZSS L1, L2, L5 |
| NMEA_MSG_ID_GQGSV           | GQGSV | 3935 | Enable all QZSS frequencies |

| GLGSV - Glonass             | Message ID ASCII | Message ID Int | Description |
|-----------------------------|------------------|----------------|-------------|
| NMEA_MSG_ID_GLGSV_0         | GLGSV_0 | 3936 | Disable all Glonass frequencies |
| NMEA_MSG_ID_GLGSV_1         | GLGSV_1 | 3937 | Enable Glonass L1 |
| NMEA_MSG_ID_GLGSV_2         | GLGSV_2 | 3938 | Enable Glonass L2 |
| NMEA_MSG_ID_GLGSV_2_1       | GLGSV_2_1 | 3939 | Enable Glonass L1, L2 |
| NMEA_MSG_ID_GLGSV_3         | GLGSV_3 | 3940 | Enable Glonass L3 |
| NMEA_MSG_ID_GLGSV_3_1       | GLGSV_3_1 | 3941 | Enable Glonass L1, L3 |
| NMEA_MSG_ID_GLGSV_3_2       | GLGSV_3_2 | 3942 | Enable Glonass L2, L3 |
| NMEA_MSG_ID_GLGSV_3_2_1     | GLGSV_3_2_1 | 3943 | Enable Glonass L1, L2, L3 |
| NMEA_MSG_ID_GLGSV           | GLGSV | 3951 | Enable all Glonass frequencies |

### VTG

NMEA GPS track made good and speed over ground.

```
$GPVTG,140.88,T,,M,8.04,N,14.89,K,D*05\r\n
            1 2 3 4   5 6     7 8 9
```
| Index | Field  | Units | Description                                        | Example |
|-------|--------|-------|----------------------------------------------------|---------|
| 1     | track true | deg   | Ground track heading (true north)                  | 140.88  |
| 2     | T      |       | Ground track heading is relative to true north     | T       |
| 3     | track mag | deg   | Ground track heading (magnetic north)              |         |
| 4     | M      |       | Ground track heading is relative to magnetic north (track mag = track true + magVarCorrection) | M       |
| 5     | speed Kn  | knots | Speed                                              | 8.04    |
| 6     | N      |       | Speed is measured in knots                         | N       |
| 7     | speed Km  | kph   | Speed over ground in kilometers/hour               | 14.89   |
| 8     | K      |       | Speed over ground is measured in kph               | K       |
| 9     | mode ind   |       | Mode indicator:                                    | D       |
|       |        |       |   A: Autonomous mode                               |         |
|       |        |       |   D: Differential mode                             |         |
|       |        |       |   E: Estimated (dead reckoning) mode               |         |
|       |        |       |   M: Manual Input mode                             |         |
|       |        |       |   S: Simulator mode                                |         |
|       |        |       |   N: Data not valid                                |         |

### PASHR

NMEA GPS DOP and active satellites.

```
$PASHR,001924.600,95.81,T,+0.60,+1.05,+0.00,0.038,0.035,0.526,0,0*08\r\n
          1         2   3   4      5    6    7      8     9  10 11  
```

| Index | Field       | Units | Description                                       | Example    |
| ----- | ---------------- | ----- | ------------------------------------------------- | ---------- |
| 1     | Time             |       | UTC Time                                          | 001924.600 |
| 2     | Heading          |       | Heading value in decimal degrees                  | 95.81      |
| 3     | True Heading     |       | T displayed if heading is relative to true north. | T          |
| 4     | Roll             | m     | Roll in decimal degrees.                          | +0.60      |
| 5     | Pitch            | m     | Pitch in decimal degrees.                         | +1.05      |
| 6     | Heave            | m     | Instantaneous heave in meters.                    | +0.00      |
| 7     | Roll Accuracy    |       | Roll standard deviation in decimal degrees.       | +0.038     |
| 8     | Pitch Accuracy   |       | Pitch standard deviation in decimal degrees.      | 0.035      |
| 9     | Heading Accuracy |       | Heading standard deviation in decimal degrees.    | 0.526      |
| 10    | GPS Status       |       | GPS Status                                        | 0          |
| 11    | INS Status       |       | INS Status                                        | 0          |

### PSTRB

Strobe input time.  This message is sent when an assert event occurs on a strobe input pin.

```
$PSTRB,d,d,d,d*xx\r\n
       1 2 3 4
```

| Index | Field        | Units | Description                                      |
| ----- |--------------|-------|--------------------------------------------------|
| 1     | GPS week     | weeks | Number of weeks since January 1st of 1980 in GMT |
| 2     | timeMsOfWeek | ms    | Milliseconds since Sunday morning in GMT         |
| 3     | pin          |       | Strobe event input pin number                    |
| 4     | count        |       | Strobe event serial index number                 |

### INFO

Device version information.  Query this message by sending `$INFO*0E\r\n`.

```
$INFO,d,d.d.d.d,d.d.d.d,d,d.d.d.d,d,s,YYYY-MM-DD,hh:mm:ss.ms,s*xx\r\n
      1 2       3       4 5       6 7 8          9           10
```

| Index | Field            | Units | Description                                                  |
| ----- | ---------------- | ----- | ------------------------------------------------------------ |
| 1     | Serial number    |       | Manufacturer serial number                                   |
| 2     | Hardware version |       | Hardware version                                             |
| 3     | Firmware version |       | Firmware version                                             |
| 4     | Build number     |       | Firmware build number                                        |
| 5     | Protocol version |       | Communications protocol version                              |
| 6     | Repo revision    |       | Repository revision number                                   |
| 7     | Manufacturer     |       | Manufacturer name                                            |
| 8     | Build date       |       | Build date: <br/>[1] = year, [2] = month, [3] = day          |
| 9     | Build time       |       | Build date: [0] = hour, [1] = minute, <br/>[2] = second, [3] = millisecond |
| 10    | Add Info         |       | Additional information                                       |
| 11    | Hardware         |       | Hardware: 1=uINS, 2=EVB, 3=IMX, 4=GPX                        |
| 12    | Reserved         |       | Reserved for internal purpose.                               |
| 13    | Build type       |       | Build type: 'a'=ALPHA, 'b'=BETA, 'c'=RELEASE CANDIDATE, 'r'=PRODUCTION RELEASE, 'd'=debug |

## NMEA Examples

This section illustrates common NMEA message strings for configuration.
!!! note
    If the command strings below are altered, their checksum must be recalculated.

!!! note
    All NMEA command strings must be followed with a carriage return and new line character (`\r\n` or `0x0D`, `0x0A`).

The NMEA string checksum is automatically computed and appended to string when using the Inertial Sense SDK [serialPortWriteAscii function](https://github.com/inertialsense/InertialSenseSDK/blob/main/src/serialPort.c#L219-L268) or can be generated using an online NMEA checksum calculator. For example:  [MTK NMEA checksum calculator](http://www.hhhh.org/wiml/proj/nmeaxor.html)

**Stop streams on CURRENT port**

```
$STPB*15                                	 
```

**Stop all streams on ALL ports**

```
$STPC*14
```

**Query device version information**

```
$INFO*0E
```

Response:

```
$INFO,30612,3.1.2.0,1.7.0.0,3522,1.2.74.7,6275,Inertial Sense Inc,0018-10-16,23:20:38.41,INL2*58
```

**Stream INS1 @5Hz on port 0**

```
$ASCE,1,3,1*0B
```

**Stream INS1 @400ms on current port**

```
$ASCE,0,3,2*09
```

Response:

```
$PINS1,244272.398,2021,427888998,805306448,0.0468,-0.3830,-0.0909,0.232,-0.083,-0.089,40.05574940,-111.65861580,1438.451,-1.678,-5.086,-9.697*11
$PINS1,244272.498,2021,427888998,805306448,0.0469,-0.3830,-0.0902,0.232,-0.081,-0.089,40.05575000,-111.65861550,1438.451,-1.611,-5.060,-9.697*18
$PINS1,244272.598,2021,427888998,805306448,0.0469,-0.3830,-0.0902,0.232,-0.081,-0.089,40.05575022,-111.65861562,1438.449,-1.587,-5.070,-9.695*1e
```

**Stream INS1 @600ms on serial port 1**

```
$ASCE,2,3,3*0A
```

Response:

```
$PINS1,256270.627,2021,427888998,1073741912,0.1153,-0.1473,-0.1628,0.001,0.001,0.003,40.05569486,-111.65864500,1416.218,-7.738,-7.570,12.536*3d
$PINS1,256270.647,2021,427888998,1073741912,0.1153,-0.1473,-0.1632,0.001,0.001,0.003,40.05569486,-111.65864500,1416.219,-7.738,-7.570,12.535*32
$PINS1,256270.667,2021,427888998,1073741912,0.1153,-0.1473,-0.1631,0.001,0.001,0.003,40.05569486,-111.65864500,1416.220,-7.738,-7.570,12.534*38
```

**Stream PIMU @400ms and GGA @5Hz on current port**

```
$ASCE,0,6,1,0,2*0D
```

Response:

```
$PIMU,3218.543,0.0017,-0.0059,-0.0077,-1.417,-1.106,-9.524,0.0047,0.0031,-0.0069,-1.433,-1.072,-9.585*1f
$GPGGA,231841,4003.3425,N,11139.5188,W,1,29,0.89,1434.16,M,18.82,M,,*59
$GPGGA,231841,4003.3425,N,11139.5188,W,1,29,0.89,1434.19,M,18.82,M,,*56
$PIMU,3218.763,0.0019,-0.0062,-0.0086,-1.426,-1.114,-9.509,0.0054,0.0029,-0.0070,-1.431,-1.085,-9.579*13
$GPGGA,231841,4003.3425,N,11139.5188,W,1,29,0.89,1434.16,M,18.82,M,,*59
$GPGGA,231841,4003.3425,N,11139.5188,W,1,29,0.89,1434.19,M,18.82,M,,*56
$PIMU,3218.543,0.0017,-0.0059,-0.0077,-1.417,-1.106,-9.524,0.0047,0.0031,-0.0069,-1.433,-1.072,-9.585*1f
```

## Linux Command Line NMEA Query

This section illustrates how to request NMEA output using standard Linux commands without relying on the Inertial Sense SDK, cltool, or EvalTool.  This provides a simple way to communicate directly with the device over a port, making it useful for quickly identifying device information, firmware version, or any available NMEA message.   

Configure the serial port parameters (i.e. baudrate, etc).

```bash
stty -F /dev/ttyACM0 921600 raw -echo -crtscts
```

Stop message streaming on the current port. This prevents previously streamed messages from interfering with the response to a specific request.

```bash
cat < /dev/ttyACM0 & printf '%s\r\n' '$STPC*14' > /dev/ttyACM0
```

Request the device information.

```bash
cat < /dev/ttyACM0 & printf '%s\r\n' '$INFO*0E' > /dev/ttyACM0
```

Request the device information and exit after receiving the response.

```bash
printf '%s\r\n' '$INFO*0E' > /dev/ttyACM0 ; sleep 0.2 ; timeout 0.2 cat < /dev/ttyACM0
```

Request the $PINS1 solution output and exit after receiving the response.

```bash
printf '%s\r\n' '$ASCE,0,PINS1,0*0D' > /dev/ttyACM0 ; sleep 0.2 ; timeout 0.2 cat < /dev/ttyACM0
```

