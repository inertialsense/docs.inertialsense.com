# IMX Bootloader

The IMX bootloader is embedded firmware stored on the IMX and is used to update the IMX application firmware.  

## Application Firmware Update

The following are conditions for the IMX firmware update.

- **Bootloader Enable** - At start of the firmware update process, the IMX is sent a "bootloader enable" command to reboot the processor into bootloader mode.  The IMX will not reboot into application mode until a valid firmware upload has completed.
- **Handshake Sequence** - A handshake sequence consisting of five consecutive sync characters (`U`) spaced 10 ms (minimum 5 ms) apart is sent to the IMX to initiate a given port and close all other ports to prevent interference.
- **UART Auto Close** - A known issue that exists in the IMX-5.0 bootloader version v5g and prior versions will disable all UARTs if no handshake sequence is received within 50 seconds of the bootloader start.  The USB port does not automatically close due to no handshake reception.
- **Application Enable** - The IMX reboots into application mode only after a valid firmware upload has completed. 

## Bootloader Update

Updating the bootloader firmware is required occasionally when new functionality is required.  The bootloader is checked and updated at the same time as loading new firmware. The following steps outline how to update the IMX bootloader and firmware.

1. **Ensure IMX Firmware is Running** - *(This step is not necessary if the IMX firmware is running and the EvalTool is communicating with the IMX)*. If the bootloader is running but the firmware is not, version information will not appear in the EvalTool. The LED will also be a fading cyan.
2. **Select Baud Rate** - Select a slower baud rate (i.e. 115,200 or 230,400) for systems with known baud rate limits. 
3. **Update the Bootloader and Firmware** - Use the EvalTool "Update Firmware" button in the Settings tab to upload the latest [bootloader](https://github.com/inertialsense/InertialSenseSDK/releases/tag/bootloader) and the latest firmware. **The bootloader can only be updated using serial0 or the native USB ports.**

