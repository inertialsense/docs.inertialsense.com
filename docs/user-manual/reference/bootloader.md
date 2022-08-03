# Bootloader

The bootloader is embedded firmware stored on the IMX and is used to update the IMX application firmware.  Updating the bootloader firmware is required occasionally when new functionality is required.

## Bootloader Update

The bootloader is now checked and updated at the same time as loading new firmware. The following steps outline how to update the IMX bootloader and firmware.

1. **Ensure IMX Firmware is Running** - *(This step is not necessary if the IMX firmware is running and the EvalTool is communicating with the IMX)*. If the bootloader is running but the firmware is not, version information will not appear in the EvalTool. The LED will also be a fading cyan.
2. **Select Baud Rate** - Select a slower baud rate (i.e. 115,200 or 230,400) for systems with known baud rate limits. 
3. **Update the Bootloader and Firmware** - Use the EvalTool "Update Firmware" button in the Settings tab to upload the latest [bootloader](https://github.com/inertialsense/InertialSenseSDK/releases/tag/bootloader) and the latest firmware. **The bootloader can only be updated using serial0 or the native USB ports.**

