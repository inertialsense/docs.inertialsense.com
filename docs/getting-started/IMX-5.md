
## 3. Configuring Settings
The configuration settings found in DID_FLASH_CONFIG need to be set to appropriate values using either the [EvalTool](../user-manual/software/evaltool.md), the [CLTool](../user-manual/software/cltool.md), or the [SDK](../user-manual/software/SDK.md). A full explanation can be found on the [System Configuration](../user-manual/application-config/system_configuration.md) page. Most users initially configure the unit using the [EvalTool](../user-manual/software/evaltool.md). This is done by going to the Data Sets Tab and selecting DID_FLASH_CONFIG. The values of each field can then be edited. Pay special attention to the following fields:

1. gps1AntOffset[X-Z] - Position offset of sensor frame with respect to GPS1 antenna.

2. gps2AntOffset[X-Z] - Position offset of sensor frame with respect to GPS2 antenna.

3. dynamicModel - Dynamic model that most closely represents sensor application.*

   *Note - This feature is experimental. For most applications setting 8 will yield the best results. The user is encouraged to try different settings.




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