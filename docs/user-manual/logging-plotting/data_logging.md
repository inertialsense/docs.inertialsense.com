# Logging

The SDK logging interface is defined in [SDK/src/ISLogger.h](https://github.com/inertialsense/InertialSenseSDK/blob/master/src/ISLogger.h). Data logs can be converted between file formats using the Inertial Sense data logger. The logging interface is used in the Inertial Sense software described below.

## Logging using Inertial Sense software

### [EvalTool](../software/evaltool.md)


1. Go to **“Data Logs”** tab in EvalTool.
1. Select the **“Format”** file type from the drop-down menu.
1. Select the data to record within the Data Streams section of the **"Data Logs**" tab:
   1. **Manual Selection** – Allows the user to select the specific datasets to stream and their update rates by setting the checkbox and period multiple in Manual Selection table.
   1. **INS** – Log INS output (attitude, velocity, position) at 100 Hz by selecting "**INS**" from the RMC Presets dropdown.
   1. [**Post Process**](#post-process-data-ppd-logging-instructions) – Used for beta testing and internal testing. Includes IMU, GPS, INS and other messages. Log by selecting "**PPD**" from the RMC Presets dropdown.
1. Press **“Enable”** to begin logging data.
1. Press **“Disable”** to stop logging data.
1. The **“Open Folder”** button opens the File Explorer location to the data logs, i.e.
`C:\Users\[username]\Documents\Inertial_Sense\logs`.
1. To change the root log folder in the Eval Tool, edit `Documents/Inertial Sense/settings.json`, and add or change the logger key: "Directory": "FOLDER_FOR_LOGS".

### [CLTool](../software/cltool.md)
The CLTool, provided in the SDK, is a command line application that can record post process data.  The CLTool help menu is displayed using the option `-h`.  See the [CLTool section](../software/cltool.md) for more information on using the CLTool.

## Post Process Data (PPD) Logging Instructions

Post process data (PPD) logs include both the input to and output from the navigation filter. The data is used for analyzing, troubleshooting, and improving system performance. PPD logs can be recorded using the EvalTool, CLTool, or SDK.

### PPD RMC bits Preset

PPD logs are created by enabling PPD data streaming by setting the RMC bits to `RMC_PRESET_PPD_BITS` and logging this stream to a .dat binary file.  `RMC_PRESET_PPD_BITS` is [defined in data_sets.h](https://github.com/inertialsense/InertialSenseSDK/blob/master/src/data_sets.h#L1153-L1169).

### Logging PPD in EvalTool

The following steps outline how to record post process data in the EvalTool

1. Go to the "Data Logs" tab in the EvalTool.
2. Press "**Data Streams: RMC Preset: PPD**" button to start PPD data streaming. 
3. Toggle the "**Data Log: Enable**" button to start logging.
4. Toggle the "**Data Log: Disable**" button to stop logging.
5. The "**Open Folder**" button will open the directory where the data logs are stored.

### Logging PPD in CLTool

  Streaming and logging a PPD log using the CLTool is done using the `-presetPPD -lon` options:

```bash
cltool -c /dev/ttyS2 -presetPPD -lon
```
See the [CLTool section](../software/cltool.md) for more information on using the CLTool.
