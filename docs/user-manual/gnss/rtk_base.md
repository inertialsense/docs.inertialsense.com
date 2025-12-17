## **RTK Base Configuration**

!!! Note
		 If using an **NTRIP** service or **3rd Party Base Station** instead of your own base station, please skip this page and see the [**NTRIP**](../rtk_ntrip) page or reference the setup instructions for the 3rd Party Base Station.  **NTRIP services** do not require additional setup.

An essential part of an RTK system is the Base Station which supplies correction messages from a known, surveyed location to the RTK Rover. The µINS Rover supports receiving RTCM3 and UBLOX correction messages.


![](images/RTKDiagram_Base_Station.png)

## **Surveying In Base Position**

!!! Important
​Accuracy of the base position directly effects the rover absolute position accuracy. It is critical that the base position be surveyed in for rover absolute position accuracy.

The base survey cannot happen at the same time as base correction output messages are enabled.  If a survey is started the base correction output will automatically be disabled.

The base position is stored in `DID_FLASH_CONFIG.reflla` and transmitted to the rover during RTK operation. The following steps outline how to survey in the base position.

1. **Mount base station in fixed location** - The location should not change during or following a survey.

2. **Set survey-in parameters** -  This step can either be done using the EvalTool or programmatically using the data set (`DID_SURVEY_IN`).

#### **[EvalTool](../software/evaltool.md)**

1. Navigate to Settings > RTK > Base Mode.
2. In the "Survey In" section select one of the States:

  - **Manual**:  Direct entry of base position.

  - **Average GPS 3D** - Requires standard GPS 3D lock (non-RTK mode) for survey.*

  - **Average RTK Float** - Requires RTK float state for survey.*

  - **Average RTK Fix** - Requires RTK fix for survey.

  *The average methods will not run if the minimum requirements are not met. The system will wait until the requirements are met and then begin the survey.

3. Use the slider to select the Survey In runtime. Generally the longer the survey runs the more accurate the results will be.

4. Press the Start button. 

!!! Note
        The current estimate of the survey is listed in the Position area above the Survey In section. If the survey completes successfully the results stored in flash memory (`DID_FLASH_CONFIG.reflla`) which will only change if the survey is re-run.

#### **Using DID_SURVEY_IN**

1. The location of the base can be manually entered using (`DID_FLASH_CONFIG.RefLLA`) if location is known.

2. Set `DID_SURVEY_IN.maxDurationSec` - Maximum time in milliseconds the survey will run. This is ignored if it is set to 0.

3. Set `DID_SURVEY_IN.minAccuracy` - Minimum horizontal accuracy in meters for survey to complete before maxDuration. This is ignored if it is set to 0.

4. Set (`DID_SURVEY_IN.state`) to begin the survey according to the desired survey State:

  - **2 = Average GPS 3D** - Requires standard GPS 3D lock (non-RTK mode) or better for survey.*

  - **3 = Average RTK Float** - Requires RTK float fix or better for survey.*

  - **4 = Average RTK Fix** - Requires RTK fix for survey.

  *The average methods will not run if the minimum requirements are not met. The system will wait until the requirements are met and then begin the survey.

## Communications Setup

### **Radio**

The Base IMX must be configured to stream base corrections to the radio so it can be broadcast to the rover.	

#### [EvalTool](../software/evaltool.md) 

1. Open the COM port for the µINS under Settings > Serial Ports.
2. Navigate to Settings > RTK > Base Mode.
3. Under "Correction Output", find the fields for serial ports 0, 1, or USB. Select the serial port from which the corrections will be transmitted. This port must also be connected to the radio. Choose one of the options listed below. Leave the unused serial port off.
   - "GPS1 - RTCM3": *Output standard RTCM3 messages.*
   - "GPS1 - uBlox": *Output uBlox messages. This will provide more accuracy but requires significantly more bandwidth.*
4. Change the "Data Rate(ms)" field. This determines how many milliseconds pass between message outputs (e.g. Data Rate(ms) = 1,000 means one message/second). It is usually best to match the startupGNSSDtMs value found in DID_FLASH_CONFIG.
5. In the "Position" section, a the Base Station position is required so that it can transmit accurate corrections. Please refer to [Surveying In Base Position](#surveying-in-base-position) if the base station location is unknown.
6. Click Apply, and reset the µINS. The unit will now start up in Base Station mode. Verify the base station is working by looking in the section labeled "Status". It will display the serial port of the radio and the message type. 
   e.g. "SER1:UBX"
7. Navigate to Data Sets > `DID_EVB_FLASH_CFG`
   - Change `cbPreset` - This should be set to `0x3` to enable the Digi Xbee Pro SX module. 
   - Change `radioPID`- Radio Preamble ID. Should be the same number used as the Rover radio. (`0x0 to 0x9`)
   - Change `radioNID`- Radio Network ID. Should be the same number used as the Rover radio. (`0x0 to 0x7FFF`)
   - Change `radioPowerLevel`- Used to adjust the radio output power level. (0 = 20dbm, 1 = 27dbm, and 2 = 30dbm)
8. Reset the EVB2 and Base radio setup is complete.

For more information on `DID_EVB_FLASH_CFG` see [DID-descriptions](../com-protocol/DID-descriptions.md).

#### [CLTool](../software/cltool.md)

The RTK config bit must be set manually when using the CLTool. Use the following command line arguments when executing the CLTool from a prompt/terminal. 

- `-c #`
  Open the COM port of the µINS. Windows users will use the name of the COM port, e.g. COM7. Linux users must enter the path to the correct COM port, e.g. /dev/ttyUSB0.
- `-baud=#`
  Set the baud rate for communications output (Replace # with baud rate number). This number will vary depending on setup. For lower quality radios it maybe necessary to use a lower baud rate (ex: 57600).
- `-flashConfig=rtkCfgBits=0x00`
  Configure the unit to cast Base corrections. For more configuration options see [eRTKConfigBits](../com-protocol/DID-descriptions.md#rtk-configuration)

Example:

```
cltool.exe -c COM29 -baud=57600 -flashConfig=rtkCfgBits=0x80
```

!!! warning
    If the Base Station is not communicating properly, it maybe necessary to verify that the baud rate is set to match that of the radios used. This rate varies depending on radio type.

### **TCP/IP Setup**

#### **[CLTool](../software/cltool.md)**

It is required to manually set the RTK config bits in the CLTool. Passed these to the CLTool when run from the command prompt/terminal. 

- `-c #`
  Open the COM port of the µINS. Windows users will use the name of the COM port, e.g. COM7. Linux users must enter the path to the correct COM port, e.g. /dev/ttyUSB0.
- `-baud=#`
  Set the baud rate for communications output (Replace # with baud rate number).
- ``-flashConfig=rtkCfgBits=0x00`
  Configure the unit to cast Base corrections. For more configuration options see [eRTKConfigBits](../com-protocol/DID-descriptions.md#rtk-configuration)
- `-base=:#`
  Create the port over which corrections will be transmitted. Choose any unused port number.

Example:

```
cltool.exe -c COM29 -baud=921600 -flashConfig=rtkCfgBits=0x10 -base=:7777
```

!!! Important
    If the console displays the error <b>"Failed to open port at COMx"</b>, reset the device immediately after attempting to change the baud rate in the CLTool.

