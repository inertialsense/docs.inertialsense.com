#IMX Quick Start Guide
## Basic Configuration
The configuration settings found in DID_FLASH_CONFIG are used to configure the various features of the device. These can be modified directly to the appropriate values using either the [EvalTool](../user-manual/software/evaltool.md), the [CLTool](../user-manual/software/cltool.md), or the [SDK](../user-manual/software/SDK.md). However, it is convenient initially to configure the main features by modifying the settings in the GPS and General tabs withing the Settings tab of the EvalTool. 

The antenna offset should also be configured by going to the Data Sets Tab and selecting DID_FLASH_CONFIG. The values of each field can then be edited. Modify the following fields after identifying the [antenna positions](../user-manual/gnss/rtk_compassing.md#dual-antenna-locations):

1. gps1AntOffset[X-Z] - Position offset of sensor frame with respect to GPS1 antenna.

2. gps2AntOffset[X-Z] - Position offset of sensor frame with respect to GPS2 antenna.

IMX-5 data sets can then be requested by one of several methods:

1. Requesting NMEA data using the [ASCE](../../user-manual/com-protocol/nmea/#asce) command. There is a convenient tool in the lower left corner of the Data Logs tab of the EvalTool.

2. Request data using the SDK commands: [SDK Function](../..//user-manual/com-protocol/isb/#getting-data)

3. Use the EvalTool to modify the value of DID_GPX_RMC.bits as outlined in the [SDK](https://github.com/inertialsense/inertial-sense-sdk/blob/68e5f20b994a0df43ef57720815aa7a16035d51f/src/data_sets.h#L2055).


## Demonstration Videos
### Rugged-3-G2 GPS Compassing Configuration Demo

<center>
<iframe width="800" height="400" src="https://www.youtube.com/embed/3pCre66Wbxw?si=-zPEm2B2ivJ5v-61" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

</center>

### Rugged-3-G2 RS-485/422 Configuration Demo

<center>
<iframe width="800" height="400" src="https://www.youtube.com/embed/dG4w2MkVch4?si=awCGX5lEGiaDz7FY" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

</center>

## Troubleshooting
If at any time issues are encountered, please check the troubleshooting sections of this manual.