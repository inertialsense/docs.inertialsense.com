# EvalTool

## Overview

The EvalTool (Evaluation Tool) is a desktop GUI application that allows you to explore and test functionality of the Inertial Sense products in real-time. It has scrolling plots, 3D model representation, table views of all data, data logger, and firmware updating interface for the IMX, uAHRS, or uIMU. The EvalTool can simultaneously interface with multiple Inertial Sense devices.

## Download and Install

The EvalTool Windows desktop app installer (.exe) can be downloaded from the [Inertial Sense releases](https://github.com/inertialsense/InertialSenseSDK/releases) page.

## Getting Started

![](images/evaltool_settings_ports_tab.png) 

With a device connected to your computer:

1. Connect your INS to your computer using directions in the [getting started](../../../getting-started/getting-started) section of this guide.
1. Open the **Settings** > **Serial Ports** tab.
1. Click the **Find All** button.
1. Open the port to your device by checking the **Open** checkbox.
1. The status box in the **Port** column will turn green and the **Link** status bar will turn green while data is being received from the device.
1. You can specify the serial port baud rate using the **Baud Rate** dropdown menu when using a serial interface like RS232. 

#### Data Logging Steps

In order to log data from your INS device, follow the steps listed below:

1. Connected your device to the EvalTool and open the port.
2. Go to the **Data Logs** tab.
3. Enable the data that you would like collected in the **Data Streams** area:
   1. Select one of the **RMC Preset** menu options.  This automatically enables standard messages commonly used for logging.  **PPD** (Post Processed Data) is the recommended default.
   2. Enable any of the **DID** messages listed below by checking the **On** checkbox and setting the **Period Mult**.  

4. Configure and enable logging in the **Data Log** area: 
   1. The **Open Folder** button opens the log directory in a file explorer window where logs are saved.  
   2. The **Format** dropdown menu selects the output log file format (.dat .sdat .csv .kml .raw).
   3. Press **Log** to start recording a new log.

5. The data you are currently recording will be shown in the “Log Summary” sub-tab.
6. When you are finished recording data, press “Disable”. Your data will be saved in the location shown in “Open Folder”.



## Info Bar 

The Info Bar can be seen from any tab and shows basic connection information for the unit selected.

![](images/evaltool_info_bar.jpg)

1. Link Status - Shows Packets being Transmitted and Received. counts to 99 then resets to 0. 
2. Error Message - Shows error messages for the selected unit.  The kinds of messages vary from data packets lost to system had a reset.
3. RTK Base Messages - The number in this field will increment as your rover unit continues to receive RTK messages from your base station. Use this field as the main signifier that RTK messages are coming through.
4. Currently selected unit - The unit with the serial number shown here will have its live data shown on each tab in EvalTool.

## Update Firmware

![](images/evaltool_firmware_update.png)

1. Go to the **Settings** > **Serial Port** tab.
1. Open the Ports of the units you would like to update.  If the units don't open up, you may have to change the baud rate.
1. Click **Update Firmware**.
1. Select the update type using the drop down menu:

   | Update Type    | Description                                                  |
   | -------------- | ------------------------------------------------------------ |
   | FwPkg (.fpkg)  | Batch firmware update method for updating multiple devices in one process.  The .fpkg file contains multiple firmware files and instructions for sequencing firmware updates for all available devices.  **NOTE:** IMX-5 firmware update is not yet supported but will be in a future update. |
   | GPX-1 (.bin)   | GPX-1 firmware update.                                       |
   | IMX-5.0 (.hex) | (Legacy mode) IMX-5.0 firmware update that used the legacy InertialSense bootloader (ISB). |
   | IMX-5.1 (.bin) | IMX-5.1 firmware update.                                     |
1. Select the firmware file by clicking on the ellipsis (three dots) button next to the file name and navigating to and opening the file.
1. For the IMX-5.0 update type, you can optionally select the bootloader .bin file. The bootloader will only be updated if the selected file is newer than the bootloader on the connected unit.
1. Click **Start**.
1. Wait for the progress to reach 100% and click **Done**.

*Note: The firmware can only be updated at the following baud rates: 300000, 921600, 460800, 230400, 115200.

## Tab Descriptions

### INS Tab

![](images/evaltool_ins_tab.png)

1. Attitude Plot and Table - shows the Roll, Pitch, and Yaw values of the selected unit. Hover the cursor of the radio buttons to see more descriptions. 
1. Velocity Plot and Table - U,V,W velocities.
1. LLA Plot and Table - Tabular values and plot of Latitude, Longitude, and Altitude.
1. Simulation - Real-time, simulated image of the INS orientation.
1. GPS Summary - Strength of GPS signal and accuracy.
1. Mag Recal Button - Allows you to calibrate your units about either a single axis (for heavy, ground based vehicles) or multi-axes.
1. BIT (Built-In Test) Button - Runs a system of checks on your unit.
1. Link Messages - shows the performance information on connected units and displays error messages.

### Sensors Tab

![](images/evaltool_sensor_tab.png) 

1. Gyros Plot and Table - Gyroscopic data on the selected unit. Includes standard deviation.
1. Accelerometers Plot and Table - Accelerometer data on the selected unit. Includes standard deviation.
1. Magnetometers Plot and Table - Magnetometer data on the selected unit. Includes standard deviation.
1. Barometer Plot and Table - Barometric, temperature, and humidity data on the selected unit. Includes standard deviation.

### GPS Tab

![](images/evaltool_gps_tab.png)

1. GPS CNO Signal Strength - Bar graphs of each satellite being used in your solution and its strength in dBHz(CNO).
1. Position Accuracy Plot and Table - RTK mode and status. Includes number of satellites used in the RTK solution (max and mean).
1. Satellites Used Table - The GNSS ID for each satellite seen by your unit and the subsequent connection details.

### Map Tab

![](images/evaltool_map_tab.png)

1. Track Active - Tracks all units on window view.
1. Zoom to Fit - Zooms your window view around each unit being used.
1. Manual - Requires manual movement of the window view.
1. Location of Units - GPS location of each of your units. Shows RTK, GPS ublox, and INS solution.

### Data Sets Tab 

![](images/evaltool_datasets_tab.png)

1. List of DIDs (Data IDentifiers) - The data identifiers that you might need to view for measurements. See the User Manual (Binary Protocol Data Sets) for a detailed description of frequently used DIDs.
1. List of Variables within DIDs - shows what is recorded in each DID in real-time.

### Data Logs

![](images/evaltool_datalogs_tab.png)

#### Data Streams

This area allow users to enable streaming of various DIDs. 

1. RMC Presets Button - Enable a group of data sets.  PPD (post process data) is the preferred preset for post processing and debug analysis.
2. Save Persistent Button - Save currently enabled data streams to automatically begin streaming after system restart. To clear persistent streams, first stop streaming and then click Save Persistent.
3. Stop Streaming - Stops all data streams. Any streams previously saved as persistent will begin streaming at startup. 

#### Data Log

1. Enable/Disable Button - Starts/stops a log of all currently streaming data and saves it to a sub-folder with the current time-stamp within your "Logs" folder.
2. Open Folder Button - Opens the "Logs" folder where your previous logs are saved.
3. Format Dropdown - Select the file output type of the data log , such as .dat, .raw, .sdat, .csv, or .kml.

   ​	

   | Log Format             | Description                                                  |
   | ---------------------- | ------------------------------------------------------------ |
   | Serial binary (.dat)   | Binary file containing InertialSense binary (ISB) DID data sets in "chunk" groups containing data in serial order as they appear over the serial port.  Default file format.  ***Recommended for post processing.*** |
   | Raw packet (.raw)      | Binary file containing byte for byte data received over the serial ports.  All packets remain in their native form.  Used for logging InertialSense binary (ISB), NMEA, RTCM3, uBlox UBX binary and SPARTN, and any other packet formats.  ***Recommended for logging all data formats and post processing***. |
   | Sorted binary (.sdat)  | Binary file containing InertialSense binary (ISB) DID data sets in "chunk" groups organized by DID.  Each chunk contains only one DID type, and at least one chunk allocated for each DID data set type.  Not recommended for future use. |
   | Comma separated (.csv) | Plain text file that uses specific structuring to arrange tabular data. Its basic format involves separating each data field (or cell in a table) with a comma and each record (or row) is on a new line. This simple format allows for ease in data import and export between programs that handle tabular data, such as databases and spreadsheets. |

   
4. Summary Window - Shows the log directly path, the elapsed time the data log has been running, the total size of the log file, and a list currently recording DIDs with corresponding dt (time between measurements).
5. File Conversion Utility - Enables you to convert the data log file type in a specified directory.  (e.g. .dat to .csv)

### Settings Tab

The Settings tab has 3 sub tabs and they are as follows:

**Settings - Serial Ports Tab**

![](images/evaltool_settings_ports_tab.png)

1. Open All - Opens all of the ports shown.
2. Close All - Closes all of the ports shown.
3. Find Devices - Determines which peripherals into your computer are Inertial Sense units, and opens those ports while closing the others.
4. Baud Rate - The rate at which data will be communicated over your data channel.
6. Update Firmware - Allows you to update your unit's firmware when an update is released from Inertial Sense.
7. Port Status - Shows a list of all connected comports and basic information for each of them. Clicking the check box opens the port. 

**Settings - General Tab**

![](images/evaltool_settings_general_tab.png)

1. Software Reset - Allows the user to issue a reset to the unit. has options for all open comports and only the currently connected unit.
2. Zero Motion - Allows the user to informs the EKF that the system is stationary on the ground and is used to aid in IMU bias estimation which can reduce drift in the INS attitude.
3. DID_Flash_Config - Gives the user option to disable or enable different features normally found in the "Data Sets" tab.  For more information about the Flash Config see [Data sets](../../com-protocol/DID-descriptions/#data-sets-dids).

**Settings - GPS Tab** 

![](images/evaltool_settings_gps_tab.png)

1. IMX Parameters - Shows flash config settings commonly used when setting up RTK units 
1. Status - Shows information important to using RTK.
1. Rover/Base Mode - Used in setup of RTK Rovers and RTK base Stations.
1. Message Window - Shows confirmation messages and Flash Config writes.

### About Tab

The about tab shows version information for the EvalTool and connected device.  It also provides helpful links to online documentation and software release information.

![](images/evaltool_about_tab.png)

