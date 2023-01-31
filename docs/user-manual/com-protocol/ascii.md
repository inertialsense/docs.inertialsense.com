# ASCII (NMEA) Protocol

For simple use, the Inertial Sense device supports ASCII based communications protocol, including several common GPS [NMEA](http://www.gpsinformation.org/dale/nmea.htm) messages.  The ASCII protocol is human readable from in a command line terminal but is less optimal than the [binary protocol](binary.md).

## Communications Examples

The [ASCII Communications Example Project](../SDK/CommunicationsAscii.md) demonstrates how to implement the ASCII (NMEA) protocol.

## Packet Structure

The Inertial Sense ASCII protocol follows the standard [NMEA 0183](https://en.wikipedia.org/wiki/NMEA_0183) message structure:

 * 1 byte – Start packet, always the $ byte (`0x24`)
 * n bytes (usually 4 or 5) – packet identifier
 * 1 byte – a comma (`0x2C`)
 * n bytes – comma separated list of data, i.e. 1,2,3,4,5,6
 * 1 byte – checksum marker, always the * byte (`0x2A`)
 * 2 bytes – checksum in hex format (i.e. `f5` or `0a`), 0 padded if necessary and lowercase
 * 2 bytes – End packet, always carriage return and line feed (`\r\n` or `0x0D`, `0x0A`)

The packet checksum is an 8 bit integer and is calculated by calculating the exclusive OR of all bytes in between and not including the $ and * bytes. The packet checksum byte is converted to a 2 byte ASCII hex code, and left padded with 0 if necessary to ensure that it is always 2 bytes. The checksum is always lowercase hexadecimal characters. See [NMEA 0183](https://en.wikipedia.org/wiki/NMEA_0183) message structure for more details.  The NMEA string checksum is automatically computed and appended to string  when using the InertialSense SDK [serialPortWriteAscii function](https://github.com/inertialsense/InertialSenseSDK/blob/master/src/serialPort.c#L219-L268) or can be generated using an online checksum calculator. For example: [MTK NMEA checksum calculator](http://www.hhhh.org/wiml/proj/nmeaxor.html)

## Persistent Messages

The *persistent messages* option saves the current data stream configuration to flash memory for use following reboot,  eliminating the need to re-enable messages following a reset or power cycle.  

- **To save current ASCII persistent messages** - send the [save persistent messages](#pers) command.  
- **To disable persistent messages** - send the [stop all broadcasts](#stpb) followed by [save persistent messages](#pers). 

[Binary persistent messages](../binary/#persistent-messages) are also available.

### Enabling Persistent Messages - EvalTool

To enable persistent ASCII messages using the EvalTool:

- Enable the desired ASCII messages in the EvalTool "Data Sets" tab.  Select DID_ASCII_BCAST_PERIOD in the DID menu and set the desired ASCII messages period to a non-zero value.
- Press the "Save Persistent" button in the EvalTool "Data Logs" tab to store the current message configuration to flash memory.
- Reset the IMX and verify the messages are automatically streaming.  You can use a generic serial port program like putty or the EvalTool->Data Logs->Data Log->Messages dialog to view the ASCII messages.

**To disable all persistent messages using the EvalTool**, click the "Stop Streaming" button and then "Save Persistent" button.   

## ASCII Input Messages

The following ASCII messages can be received by the IMX.

| Message                     | Description                                                  |
| --------------------------- | ------------------------------------------------------------ |
| ```$ASCB*13\r\n```          | Query the broadcast rate of ASCII output messages.           |
| [ASCB](#ascb)               | Set the broadcast rate of ASCII output messages.             |
| ```$INFO*0E\r\n```          | Query device information.                                    |
| [```$PERS*13\r\n```](#pers) | Save persistent message to flash.                            |
| [```$STPB*15\r\n```](#stpb) | Stop broadcast of all messages (ASCII and binary) on all ports. |
| [```$STPC*14\r\n```](#stpc) | Stop broadcast of all messages (ASCII and binary) on current port. |

### ASCB

Enable ASCII message and set broadcast periods.  The period is in milliseconds with no thousands separator character. “xx” is the two-character checksum.  Each field can be left blank in which case the existing broadcast period for that field is not modified, or 0 to disable streaming.  Actual broadcast period for each message is configurable as a period multiple of the [*Data Source Update Rates*](binary/#data-source-update-rates). 

```
 $ASCB,d,d,d,d,d,d,d,d,d,d,d,d,d*xx\r\n
       1 2 3 4 5 6 7 8 9 0 1 2 3
```

| Index | Field           | Description                                                  |
| ----- | --------------- | ------------------------------------------------------------ |
| 1     | options         | Port selection.  Combine by adding options together:<br/>0=current, 1=ser0, 2=ser1, 4=ser2, 8=USB, <br/>512=persistent (remember after reset) |
| 2     | [PIMU](#pimu)   | Broadcast period multiple for PIMU IMU message.     |
| 3     | [PPIMU](#ppimu) | Broadcast period multiple for PPIMU preintegrated IMU message. |
| 4     | [PINS1](#pins1) | Broadcast period multiple for PINS1 INS output (euler, NED) message. |
| 5     | [PINS2](#pins2) | Broadcast period multiple for PINS2 INS outpout (quaterion, LLA) message. |
| 6     | [PGPSP](#pgpsp) | Broadcast period multiple for PGPSP GPS position message.    |
| 7     | [PRIMU](#primu) | Broadcast period multiple for PRIMU Raw IMU message. |
| 8     | [GPGGA](#gpgga) | Broadcast period multiple for NMEA GPGGA (fix, 3D location, and accuracy) message. |
| 9     | [GPGLL](#gpgll) | Broadcast period multiple for NMEA GPGLL (2D location and time) message. |
| 10    | [GPGSA](#gpgsa) | Broadcast period multiple for NMEA GPGSA (DOP and active satellites) message. |
| 11    | [GPRMC](#gprmc) | Broadcast period multiple for NMEA GPRMC (minimum specific GPS/Transit) message. |
| 12    | [GPZDA](#gpzda)         | Broadcast period multiple for NMEA GPZDA (UTC Time/Date) message. |
| 13    | [PASHR](#pashr)           | Broadcast period multiple for NMEA PASHR (euler) message. |

### PERS

Send this command to save current *persistent messages* to flash memory for use following reboot.   This eliminates the need to re-enable messages following a reset or power cycle.  In order to disable persistent messages,  all messages must be disabled and then the 'save persistent messages' command should be sent.

```
$PERS*14\r\n
```

### STPB

Stop all broadcasts (both binary and ASCII) on all ports by sending the following packet:

```
$STPB*15\r\n
```

The hexadecimal equivalent is:

```
24 53 54 50 42 2A 31 35 0D 0A
```

### STPC

Stop all broadcasts (both binary and ASCII) on the current port by sending the following packet:

```
$STPC*14\r\n
```

The hexadecimal equivalent is:

```
24 53 54 50 43 2A 31 34 0D 0A
```

## ASCII Output Messages

The following ASCII messages can be sent by the IMX.

| Message         | Description                                                  |
| --------------- | ------------------------------------------------------------ |
| [ASCB](#ascb)   | Broadcast rate of ASCII output messages.                     |
| [PIMU](#pimu)   | IMU data (3-axis gyros and accelerometers) in the body frame. |
| [PPIMU](#ppimu) | Preintegrated IMU: delta theta (rad) and delta velocity (m/s). |
| [PRIMU](#primu) | Raw IMU data (3-axis gyros and accelerometers) in the body frame. |
| [PINS1](#pins1) | INS output: euler rotation w/ respect to NED, NED position from reference LLA. |
| [PINS2](#pins2) | INS output: quaternion rotation w/ respect to NED, ellipsoid altitude. |
| [PGPSP](#pgpsp) | GPS position data.                                           |
| [GPGGA](#gpgga) | NMEA GPGGA GPS 3D location, fix, and accuracy.               |
| [GPGLL](#gpgll) | NMEA GPGLL GPS 2D location and time.                         |
| [GPGSA](#gpgsa) | NMEA GSA GPS DOP and active satellites.                      |
| [GPRMC](#gprmc) | NMEA Recommended minimum specific GPS/Transit data.          |
| [GPZDA](#gpzda) | NMEA UTC Time/Date message.                                  |
| [PASHR](#pashr) | NMEA PASHR (euler) message.                                  |
| [PSTRB](#pstrb) | Strobe event input time.                                     |
| [INFO](#info)   | Device information.                                          |

The field codes used in the message descriptions are: lf = double, f = float, d = int.

### PIMU

IMU sensor data (3-axis gyros and accelerometers) in the body frame.

```
$PIMU,lf,f,f,f,f,f,f*xx\r\n
       1 2 3 4 5 6 7
```

| Index | Field      | Units   | Description                 |
| ----- | ---------- | ------- | --------------------------- |
| 1     | time       | sec     | Time since system power up  |
| 3     | IMU pqr[0] | rad/sec | IMU angular rate gyro – X   |
| 2     | IMU pqr[1] | rad/sec | IMU angular rate gyro – Y   |
| 4     | IMU pqr[2] | rad/sec | IMU angular rate gyro – Z   |
| 5     | IMU acc[0] | m/s2    | IMU linear acceleration – X |
| 6     | IMU acc[1] | m/s2    | IMU linear acceleration – Y |
| 7     | IMU acc[2] | m/s2    | IMU linear acceleration – Z |

### PPIMU
Preintegrated inertial measurement unit (IMU) sensor data, delta theta in radians and delta velocity in m/s in the body frame.  Also known as coning and sculling integrals.

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
| 8     | vel[0]   | m/s   | IMU delta velocity integral – X        |
| 9     | vel[1]   | m/s   | IMU delta velocity integral – Y        |
| 10    | vel[2]   | m/s   | IMU delta velocity integral – Z        |
| 14    | dt       | s     | Integration period for delta theta vel |

### PRIMU

Raw IMU sensor data (3-axis gyros and accelerometers) in the body frame (up to 1KHz).  Use this IMU data for output data rates faster than DID_FLASH_CONFIG.startupNavDtMs.  Otherwise we recommend use of PIMU or PPIMU as they are oversampled and contain less noise. 0 to disable.

```
$PRIMU,lf,f,f,f,f,f,f*xx\r\n
        1 2 3 4 5 6 7
```

| Index | Field          | Units   | Description                     |
| ----- | -------------- | ------- | ------------------------------- |
| 1     | time           | sec     | Time since system power up      |
| 3     | Raw IMU pqr[0] | rad/sec | Raw IMU angular rate gyro – X   |
| 2     | Raw IMU pqr[1] | rad/sec | Raw IMU angular rate gyro – Y   |
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

$PGPSP,337272200,2031,1075643160,40.33057800,-111.72581630,1406.39,1425.18,0.95,0.37,0.55,-0.02,0.02,-0.03,0.17,39.5,337182.4521*4d
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
| 15    | cnoMean      | dBHz  | Average of all satellite carrier to noise ratios (signal strengths) that non-zero |
| 16    | towOffset    | s     | Time sync offset between local time since boot up to GPS time of week in seconds.  Add this to IMU and sensor time to get GPS time of week in seconds. |
| 17    | leapS        | s     | GPS leap second (GPS-UTC) offset. Receiver's best knowledge of the leap seconds offset from UTC to GPS time. Subtract from GPS time of week to get UTC time of week. |

### GPGGA
NMEA GPS fix, 3D location and accuracy data (see [NMEA GPGGA](http://www.gpsinformation.org/dale/nmea.htm#GGA) specification).

```
$GPGGA,204153,4003.3433,N,11139.5187,W,1,25,0.93,1433.997,M,18.82,M,,*6d\r\n
            1         2 3          4 5 6  7    8     9    0     1 2 3 4
```

| Index | Field         | Units   | Description                                                  | Example      |
| ----- | ------------- | ------- | ------------------------------------------------------------ | ------------ |
| 1     | HHMMSS        |         | UTC time (fix taken at 12:39:19 UTC)                         | 123519       |
| 2,3   | Latitude      | deg,min | WGS84 latitude (DDmm.mmmm,N)                                 | 4003.3433,N  |
| 4,5   | Longitude     | deg,min | WGS84 longitude (DDDmm.mmmm,E)                               | 11139.5187,W |
| 6     | Fix quality   |         | 0 = invalid, 1 = GPS fix (SPS), 2 = DGPS fix, 3 = PPS fix, 4 = RTK Fix, 5 = RTK Float, 6 = estimated (dead reckoning), 7 = Manual input mode, 8 = Simulation mode | 1            |
| 7     | \# Satellites |         | Number of satellites in use                                  | 15           |
| 8     | hDop          | m       | Horizontal dilution of precision                             | 0.9          |
| 9,10  | MSL_altitude  | m       | Elevation above mean sea level (MSL)                         | 545.4,M      |
| 11,12 | Undulation    | m       | Undulation of geoid.  Height of the geoid  above the WGS84 ellipsoid. | 46.9,M       |
| 13    | empty         | s       | Time since last DGPS update                                  |              |
| 14    | empty         |         | DGPS station ID number                                       |              |

### GPGLL
NMEA geographic position, latitude / longitude and time (see [NMEA GPGLL](http://www.gpsinformation.org/dale/nmea.htm#GLL) specification).

```
$GPGLL,4916.4512,N,12311.1232,W,225444,A*33\r\n
               1 2          3 4      5 6
```

| Index | Field     | Units   | Description                          | Example      |
| ----- | --------- | ------- | ------------------------------------ | ------------ |
| 1,2   | Latitude  | deg,min | WGS84 latitude (DDmm.mmmm,N)         | 4916.4512,N  |
| 3,4   | Longitude | deg,min | WGS84 longitude (DDDmm.mmmm,E)       | 12311.1232,W |
| 5     | HHMMSS    |         | UTC time (fix taken at 22:54:44 UTC) | 225444       |
| 6     | Valid     |         | Data valid (A=active, V=void)        | A            |

### GPGSA

NMEA GPS DOP and active satellites (see [NMEA GPGSA](http://www.gpsinformation.org/dale/nmea.htm#GSA) specification).

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

### GPRMC

NMEA GPS recommended minimum specific GPS/Transit data (see [NMEA GPRMC](http://www.gpsinformation.org/dale/nmea.htm#RMC) specification).

```
eg1. $GPRMC,081836,A,3751.65,S,14507.36,E,000.0,360.0,130998,011.3,E*62
eg2. $GPRMC,225446,A,4916.45,N,12311.12,W,000.5,054.7,191194,020.3,E*68

           225446       Time of fix 22:54:46 UTC
           A            Navigation receiver warning A = OK, V = warning
           4916.45,N    Latitude 49 deg. 16.45 min North
           12311.12,W   Longitude 123 deg. 11.12 min West
           000.5        Speed over ground, Knots
           054.7        Course Made Good, True
           191194       Date of fix  19 November 1994
           020.3,E      Magnetic variation 20.3 deg East
           *68          mandatory checksum

eg3. $GPRMC,220516,A,5133.82,N,00042.24,W,173.8,231.8,130694,004.2,W*70
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

eg4. $GPRMC,hhmmss.ss,A,llll.ll,a,yyyyy.yy,a,x.x,x.x,ddmmyy,x.x,a*hh
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

### GPZDA

NMEA GPS UTC Time and Date (see [NMEA GPZDA]( http://www.gpsinformation.org/dale/nmea.htm#ZDA ) specification).

```
$GPZDA,001924,06,01,1980,00,00*41\r\n
          1    2  3   4   5  6
```

| Index | Field    | Units | Description             | Example |
| ----- | -------- | ----- | ----------------------- | ------- |
| 1     | HrMinSec |       | UTC Time                | 001924  |
| 2     | Day      |       | Day                     | 06      |
| 3     | Month    |       | Month                   | 01      |
| 4     | Year     |       | Year                    | 2020    |
| 16    | localHrs |       | Local time zone hours   | 00      |
| 17    | localMin |       | Local time zone minutes | 00      |

### PASHR

NMEA GPS DOP and active satellites (see [NMEA GPGSA](http://www.gpsinformation.org/dale/nmea.htm#GSA) specification).

```
$PASHR,001924.600,95.81,T,+0.60,+1.05,+0.00,0.038,0.035,0.526,0,0*08\r\n
          1         2   3   4      5    6    7      8     9  10 11  
```

| Index | Field       | Units | Description                                       | Example    |
| ----- | ----------- | ----- | ------------------------------------------------- | ---------- |
| 1     |             |       | UTC Time                                          | 001924.600 |
| 2     | Fix quality |       | Heading value in decimal degrees                  | 95.81      |
| 3     | Sat ID      |       | T displayed if heading is relative to true north. | T          |
| 4     | pDop        | m     | Roll in decimal degrees.                          | +0.60      |
| 5     | hDop        | m     | Pitch in decimal degrees.                         | +1.05      |
| 6     | vDop        | m     | Instantaneous heave in meters.                    | +0.00      |
| 7     |             |       | Roll standard deviation in decimal degrees.       | +0.038     |
| 8     |             |       | Pitch standard deviation in decimal degrees.      | 0.035      |
| 9     |             |       | Heading standard deviation in decimal degrees.    | 0.526      |
| 10    |             |       | GPS Status                                        | 0          |
| 11    |             |       | INS Status                                        | 0          |

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
| 8     | Build date       |       | Build date: <br/>[1] = year-2000, [2] = month, [3] = day     |
| 9     | Build time       |       | Build date: [0] = hour, [1] = minute, <br/>[2] = second, [3] = millisecond |
| 10    | Add Info         |       | Additional information                                       |

## ASCII Examples

This section illustrates common ASCII message strings for configuration.
!!! note
    If the command strings below are altered, their checksum must be recalculated.

!!! note
    All ASCII command strings must be followed with a carriage return and new line character (`\r\n` or `0x0D`, `0x0A`).

The NMEA string checksum is automatically computed and appended to string  when using the InertialSense SDK [serialPortWriteAscii function](https://github.com/inertialsense/InertialSenseSDK/blob/master/src/serialPort.c#L219-L268) or can be generated using an online NMEA checksum calculator. For example:  [MTK NMEA checksum calculator](http://www.hhhh.org/wiml/proj/nmeaxor.html)

**Stop streams on CURRENT port**

```
$STPB*15                                	 
```

**Stop all streams on ALL ports**

```
$ASCB,255,0,0,0,0,0,0,0,0,0,0,0,0*0D
```

**Query device version information**

```
$INFO*0E
```

Response:

```
$INFO,30612,3.1.2.0,1.7.0.0,3522,1.2.74.7,6275,Inertial Sense INC,0018-10-16,23:20:38.41,INL2*58
```

**Stream INS1 @25Hz on port 0**

```
$ASCB,1,,,40,,,,,,,,,*0A
```

**Stream INS1 @10Hz on current port**

```
$ASCB,0,,,100,,,,,,,,,*3E
```

Response:

```
$PINS1,244272.398,2021,427888998,805306448,0.0468,-0.3830,-0.0909,0.232,-0.083,-0.089,40.05574940,-111.65861580,1438.451,-1.678,-5.086,-9.697*11
$PINS1,244272.498,2021,427888998,805306448,0.0469,-0.3830,-0.0902,0.232,-0.081,-0.089,40.05575000,-111.65861550,1438.451,-1.611,-5.060,-9.697*18
$PINS1,244272.598,2021,427888998,805306448,0.0469,-0.3830,-0.0902,0.232,-0.081,-0.089,40.05575022,-111.65861562,1438.449,-1.587,-5.070,-9.695*1e
```

**Stream INS1 @50Hz on serial port 1**

```
$ASCB,2,,,20,,,,,,,,,*0F
```

Response:

```
$PINS1,256270.627,2021,427888998,1073741912,0.1153,-0.1473,-0.1628,0.001,0.001,0.003,40.05569486,-111.65864500,1416.218,-7.738,-7.570,12.536*3d
$PINS1,256270.647,2021,427888998,1073741912,0.1153,-0.1473,-0.1632,0.001,0.001,0.003,40.05569486,-111.65864500,1416.219,-7.738,-7.570,12.535*32
$PINS1,256270.667,2021,427888998,1073741912,0.1153,-0.1473,-0.1631,0.001,0.001,0.003,40.05569486,-111.65864500,1416.220,-7.738,-7.570,12.534*38
```

**Stream PIMU @50Hz and GPGGA @5Hz on current port**

```
$ASCB,0,20,0,0,0,0,0,200,0,0,0,0,0*3F
```

Response:

```
$PIMU,3218.543,0.0017,-0.0059,-0.0077,-1.417,-1.106,-9.524,0.0047,0.0031,-0.0069,-1.433,-1.072,-9.585*1f
$GPGGA,231841,4003.3425,N,11139.5188,W,1,29,0.89,1434.16,M,18.82,M,,*59
$PIMU,3218.563,0.0022,-0.0057,-0.0091,-1.416,-1.123,-9.512,0.0061,0.0035,-0.0068,-1.430,-1.091,-9.563*19
$PIMU,3218.583,0.0007,-0.0059,-0.0081,-1.420,-1.125,-9.508,0.0056,0.0047,-0.0086,-1.432,-1.078,-9.591*1e
$PIMU,3218.603,0.0015,-0.0062,-0.0077,-1.419,-1.130,-9.499,0.0069,0.0044,-0.0066,-1.434,-1.079,-9.579*10
$PIMU,3218.623,-0.0001,-0.0052,-0.0097,-1.413,-1.123,-9.529,0.0066,0.0047,-0.0072,-1.427,-1.085,-9.593*39
$PIMU,3218.643,0.0012,-0.0060,-0.0080,-1.423,-1.122,-9.508,0.0071,0.0047,-0.0070,-1.425,-1.083,-9.563*19
$PIMU,3218.663,-0.0004,-0.0065,-0.0088,-1.413,-1.118,-9.540,0.0057,0.0029,-0.0059,-1.430,-1.082,-9.604*3a
$PIMU,3218.683,-0.0001,-0.0064,-0.0096,-1.418,-1.121,-9.511,0.0059,0.0033,-0.0070,-1.431,-1.084,-9.585*39
$PIMU,3218.703,0.0007,-0.0055,-0.0079,-1.417,-1.128,-9.497,0.0046,0.0043,-0.0077,-1.428,-1.085,-9.565*18
$PIMU,3218.723,0.0024,-0.0054,-0.0085,-1.416,-1.106,-9.510,0.0051,0.0033,-0.0079,-1.429,-1.089,-9.588*1b
$PIMU,3218.743,0.0019,-0.0058,-0.0081,-1.430,-1.126,-9.533,0.0063,0.0032,-0.0073,-1.435,-1.093,-9.585*1d
$GPGGA,231841,4003.3425,N,11139.5188,W,1,29,0.89,1434.19,M,18.82,M,,*56
$PIMU,3218.763,0.0019,-0.0062,-0.0086,-1.426,-1.114,-9.509,0.0054,0.0029,-0.0070,-1.431,-1.085,-9.579*13
```


### Using Tera Term App

The example ASCII command strings can be sent using standard serial port terminal that supports sending the line ending characters (carriage return and new line).  The Windows desktop app [Tera Term](https://osdn.net/projects/ttssh2/releases/) can be used for this.

**Setup:**

1. Start Tera Term > New connection.  Select the correct serial port.

2. Setup > Terminal...
    - Receive:		CR
    - Transmit:	CR+LF	**(IMPORTANT - Ensures each ASCII string ends with `\r\n` or `0x0D`, `0x0A`)** 
    - Local echo:	Yes		This shows what was sent.

3. Setup > Serial port...
    - Speed:		921600	This is the default setting and must match the IMX serial port baudrate. 
    - Data:		8 bit
    - Parity:		none
    - Stop bits: 	1 bit
    - Flow control: none

4. menu bar > setup > save setup  -  This saves time the next time Tera Term is used.

**Saving a log:**

1. File > log  -  Be sure to save as a .txt so it can be viewed in notepad. Controls for the log are in the Logger popup window after starting a log.

**Sending an ASCII command:**

1. Copy one of the command messages above to the clipboard.

2. Use the Tera Term > Edit > `Paste<CR>`  option to send the copied command.  This method in conjunction with the above "CR+LF" terminal transmit setting ensures that a carriage return and line feed character terminate the sent string.  Only one ASCII string command can be sent at a time. 
