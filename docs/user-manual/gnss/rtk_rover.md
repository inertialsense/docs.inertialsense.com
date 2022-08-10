## System Configuration
A µINS must be configured as a Rover to receive RTK Base messages. This can be done through the EvalTool or the CLTool by enabling "Rover Mode".

#### [EvalTool](../software/evaltool.md)
1. Navigate to Settings > GPS > Rover > RTK.
2. Change the first drop-down menu to "Positioning (GPS1)", or one of the F9P options depending on the hardware setup.
3. Press Accept.
4. Verify the `RTKCfgBits` was automatically set correctly to any one of the [rover modes](../../com-protocol/DID-descriptions/#rtk-configuration) listed in our binary communications protocol page.

#### [CLTool](../software/cltool.md)
Use the `-flashConfig=rtkCfgBits=0x01` argument to configure the unit as rover where 0x01 can be any one of the [rover modes](../../com-protocol/DID-descriptions/#rtk-configuration) listed in our binary communications protocol page.

## Communications Setup

The IMX automatically parses data that arrives at any of the ports and recognizes base corrections data. Any communications method that sends the base corrections to one of the ports is suitable. Several common methods are described below.

### **EVB2 Radio**

#### [EvalTool](../software/evaltool.md)  

The EVB-2 radio can be configured by pressing the "CONFIG" tactile switch until the light next to it is blue. This enables the radio and configures the radio settings.  See the [Configurations](../../hardware/EVB2/#configurations) and [EVB-2 Connections](../../hardware/EVB2/#evb-2-connections) sections of the [EVB-2](../../hardware/EVB2) documentation.

1. Under "IMX Parameters" section verify the following:
   - Check the Baud Rate for the serial port of the radio (`ser0BaudRate` or `ser1BaudRate`). This should match the Baud Rate of the radio. The Digi Xbee Pro SX module on the EVB2 runs at **115200** baud.
1. Navigate to Data Sets > `DID_EVB_FLASH_CFG`
   - Change `cbPreset` - This should be set to `0x3` to enable the Digi Xbee Pro SX module. 
   - Change `radioPID`- Radio Preamble ID. Should be the same number used as the Base radio. (`0x0 to 0x9`)
   - Change `radioNID`- Radio Network ID. Should be the same number used as the Base radio. (`0x0 to 0x7FFF`)
   - Change `radioPowerLevel`- Used to adjust the radio output power level. (0=20dbm, 1=27dbm, and 2=30dbm)
1. Reset the EVB2 and Rover radio setup is complete.

For more information on `DID_EVB_FLASH_CFG` see [DID-descriptions](../../com-protocol/DID-descriptions/).

<!-- #### EvalTool - Radio to Computer to Rover

1. Navigate to Settings > RTK > Rover Mode.

2. Change the first drop-down menu to "RTK - GPS1."

3. Edit the following fields under "Correction Input":

   - Type = `Serial`

   - Serial Port = `#` Replace the '#' with the COM port number of the radio.

   - Select the desired baud rate. This should match the baud rate the radio is running at.  

4. Press Accept and Rover radio setup is complete.

#### CLTool - Radio to Computer to Rover

Enter the following arguments when running the CLTool executable: 

- `-c #`
  Open the COM port of the µINS. Windows users will use the name of the COM port, e.g. COM7. Linux users must enter the path to the correct COM port, e.g. /dev/ttyUSB0.
- `-baud=#`
  Set the baud rate at which the µINS will receive corrections (Replace # with baud rate number). This number will vary depending on setup. For lower quality radios use of lower baud rates maybe necessary. (ex: 57600).

- `-rover=`
  Specify where format/corrections will come from.
  - `SERIAL:`
    The serial port where the radio is connected. The computer will receive corrections through this port and pass them to the µINS.
  - `RTCM3:`
    Standard data format for RTK corrections.

Example:

```
cltool.exe -flashConfig=rtkCfgBits=0x01 -rover=SERIAL:RTCM3:COM9:57600
```

!!! Note
​	It is recommended that the rover and base station are set to the same baud rate as the radio. This will avoid over-saturating the radio. -->

### **NTRIP Client**

For the Rover to receive messages from an NTRIP Caster, it must be connected to an interface with internet access (e.g. computer).

#### [EvalTool](../software/evaltool.md)

Follow the proceeding steps in order to set up the Rover to receive messages through NTRIP:

1. Navigate to Settings > RTK > Rover Mode.
2. Change the first drop-down menu to "RTK - GPS1" 
3. Under Correction Input:
   - Type = `NTRIP`
   
   - Address:Port = <URL of NTRIP Caster>:<Port number>
     Ex: `rtgpsout.unavco.org:2101`
   
   - Username/Password = Enter the Username and Password to the account used as the NTRIP Caster. Some Casters do not require this field.
   
   - Format = RTCM3 or UBLOX
   
   - Mount Point = Specify the mount point of the caster.
     Ex: `P016_RTCM3`
4. Press Apply.

#### [CLTool](../software/cltool.md)

With the Rover µINS connected to the computer, use the -rover argument when running the CLTool executable:

- `-rover=TCP:`
  Set the type to "TCP".
- `PROTOCOL:`
  Set the protocol to "RTCM3" or "UBLOX". UBLOX requires more bandwidth and is not available from NTRIP casters.
- `URL:`
  The URL for the NTRIP Caster.
- `Port:`
  The port number will be provided by the NTRIP Caster.
- `MountPoint:`
  The mount point specifies which base station the corrections come from. This number will be provided by the NTRIP Caster.
- `Username:Password`
  The username and password for the account at the given URL (Not required by some public NTRIP casters).

Example:

```
cltool.exe -c COM10 -flashConfig=rtkCfgBits=0x01 -baud=57600 -rover=TCP:RTCM3:rtgpsout.unavco.org:2101:P016_RTCM3:username:password
```

### **TCP/IP**

For the Rover to receive messages from a Base Station on a local network, it must be connected to an interface with network access (e.g. computer).

#### [EvalTool](../software/evaltool.md)

Follow these steps:

1. Navigate to Settings > GPS1
1. Under Correction Input:
   - Type = `TCP`
   - Address:Port = <IP address of base station>:<Port number>
     e.g.`192.168.1.145:2001`
   - Change Format to "ublox" or "RTCM3". Ublox requires more bandwidth but will result in better performance.
1. Press Accept.

!!! hint
	For **serial ports**, view available comport numbers in the Settings tab of the EvalTool.

#### [CLTool](../software/cltool.md)

With the µINS Rover connected to the computer, enter the -rover argument when running the CLTool executable:

- `-rover=TCP:`
  Set the type to "TCP".
- `RTCM3`
  Set the message type to "RTCM3" or "UBLOX". UBLOX requires more bandwidth and may be unavailable from some NTRIP Casters.  
- `IP_Address`
  The IP Address of the Base Station to receive messages from.
- `Port`
  You may choose any number here. This should match the port number used for the Base Station.

Example: `cltool.exe -c COM10 -flashConfig=rtkCfgBits=0x01 -baud=57600 -rover=RTCM3:100.100.1.100:7777`

### **EVB2 Wifi**

Using the EVB2 WiFi module to connect to the TCP/IP Base. EVB2 can save up to 3 Networks information. (Wifi[0], Wifi[1], Wifi[2]) Follow these steps using the EvalTool:

1. Under "IMX Parameters" section verify the following:
   - Verify the `RTKCfgBits` was automatically set to 0x00000001
1. Navigate to Data Sets > `DID_EVB_FLASH_CFG`
   - Change `cbPreset` - This should be set to `0x4` to enable the WiFi module. 
   - Change `wifi[0].ssid`- WiFi [0] Service Set Identifier or network name.
   - Change `wifi[0].psk`- WiFi [0] Pre-Shared Key authentication or network password.
   - Change `server[0].ipAddr`- server [0] IP address.
   - Change `server[0].port`- server [0] port.
1. Reset the EVB2 and Rover WiFi setup is complete.
