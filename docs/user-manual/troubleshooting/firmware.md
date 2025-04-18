# Firmware Troubleshooting

Please email [support@inertialsense.com](mailto:support@inertialsense.com) for assistance or to provide feedback on this user guide.

## Data doesn't look right
If the EvalTool or SDK are from a different release from the firmware on the unit, there may be communication protocol related issues. It's best to keep both the software and firmware in sync with each other. The EvalTool should flag a protocol mismatch in the settings tab.

## Bootloader Not Responding
Check the following:

- The input supply is at 3.3V and clean without noise.
- The serial connection is grounded (no floating grounds).
- The serial wires between the uINS module and the next active device (buffer, converter, or processor) are not longer than 1 meter when bootloading firmware.
- Reset or power cycle the IMX and promptly run the firmware update within 30 seconds of reset.  A known issue in the IMX-5.0 bootloader version v6g and prior versions that disables all UARTS if no handshake is received within 50 second following startup.  Resetting the IMX will re-enable UARTs for 50 seconds.

## Bootloader Update fails first time

If updating the bootloader firmware and using the USB direct connection on the IMX module (pins 1 and 2) or the EVB-2 (EVB USB connector), the serial port number will change when the device switches from application mode to Bootloader Update mode.  This is expected and requires reselecting the new serial port and running the Bootloader Update process a second time. 

## System in AHRS mode despite GPS messages being received

If attempting to enter NAV mode but the system reports AHRS despite GPS data beig received, then assure your units are not set to Rover RTK mode. This will override your ability to lock in GPS Nav mode.

## "IMX-5 Bricked" System Recovery
Assert chip erase pin high (3.3V) while booting (power cycle or reset) to erase all flash memory and place IMX into ROM bootloader (DFU) mode.  

Note: the IMX bootloader will timeout and disable all UARTS (not USB) after 30 seconds if the sync handshake is not received.  This will render the IMX unresponsive over UART.  To prevent this, do not interrupt the standard firmware update process.  To recover the IMX, reset the IMX and then re-apply the firmware update within 30 seconds of reset.  https://docs.inertialsense.com/user-manual/reference/bootloader/#known-issues

Note: Following chip erase:
Update firmware using standard procedure including app and bootloader firmware images. 
Upload IMU calibration.

## "GPX-1 and IMX-5.1 Bricked" System Recovery

Assert boot mode pin high (3.3V) while booting (power cycle or reset) to put the device into bootloader mode.  Inertial Sense customer support is required to facilitate bootloader communications with this device.

## "uINS Bricked" System Recovery
There are different reasons a system may appear unresponsive and not communicate.  The following sections describe how to recover a system from these states.  

!!! attention
    The ONLY indicator that the bootloader is running is the fading cyan module LED.  NO communications will appear in the EvalTool or CLTool.  **Attempt to update the firmware before performing a [chip erase](chip_erase.md).**

!!! attention
    Hardware v3.1.3 and firmware IS_uINS-3_v1.2.1.0_b287_2017-09-17_103826.hex and older will not communicate and require following these instructions to be recovered. Do NOT use the [chip erase](chip_erase.md) procedure for this scenario.

### Stuck in Bootloader Mode

In some cases, the bootloader may fail to completely update firmware.  This is indicated by the fading cyan status LED on the IMX module.  This can happen if older bootloader firmware is on the uINS and firmware version 1.7.1 is uploaded.  If this happens, the system will appear to be unresponsive in the EvalTool.  The following process can be used to recover the system to a working state:

If the **bootloader is running**, identified with the fading cyan color LED on the uINS module, following these steps:

1. **Ensure uINS Firmware is Running** - *(This step is not necessary if the uINS firmware is running and the EvalTool is communicating with the uINS)*.  Select the device serial port and update the firmware using [1.6.4](https://github.com/inertialsense/InertialSenseSDK/releases/tag/1.6.4) or earlier.  If the bootloader is running, version information will not appear in the EvalTool.  The following bootloader update step will not work unless the EvalTool is communicating with the uINS firmware.
2. **Update the Bootloader** - Use the EvalTool "Update Bootloader" button in the Settings tab to upload the latest [bootloader firmware](https://github.com/inertialsense/InertialSenseSDK/releases/tag/bootloader).  If it has a fading cyan color on the uINS module, the bootloader is running and ready for new firmware to be loaded. **The bootloader can only be updated using serial0 or the native USB connection.**
3. **Update the Firmware** - Use the EvalTool "Update Firmware" button to upload the [latest uINS firmware](https://github.com/inertialsense/InertialSenseSDK/releases).

If neither the bootloader or the uINS firmware are running, identified with the solid or no LED status on the uINS module, please [contacts us](mailto:support@inertialsense.com).

### Recovery for Firmware v1.2.1.0

Hardware v3.1.3 and newer and firmware IS_uINS-3_v1.2.1.0_b287_2017-09-17_103826.hex and older result in a system that runs but will not communicate properly.  This older firmware was not designed for the newer hardware and consequently runs the processor at a slower speed, which alters all of the predefined baud rates to non-standard irregular baud rates.  A symptom of this problem is the LED flashing to indicate the processor activity and the module never communicates properly. 

The following steps are provided to recover communications with the system. 

1. Install and run the [hotfix release 1.1.3 EvalTool](https://github.com/inertialsense/InertialSenseSDK/releases/download/1.1.3/EvalTool.Installer.r1.1.3.2018-06-08.221942.exe).  
2. Select the special baud rate **560,000** in the EvalTool and open the serial port.
3. Update the firmware using any version **newer than** IS_uINS-3_v1.2.1.0_b287_2017-09-17_103826.hex.

The latest EvalTool, CLTool, SDK, and firmware can be used once the firmware has been updated on the module.

## Troubleshooting with EvalTool

### Units Not Connecting

In the case that your units do not connect properly to the EvalTool, verify:

1. The baud rate is the same that you previously had when the Com Ports last opened correctly.
2. The LED on the unit is not showing solid white, flashing white, or solid red. These mean a failure occured in loading the bootloader (see User Guide for full LED descriptions).
3. If you are using a USB3.0 connection, the com port might take longer to show up than with USB2.0
4. Check your computer's Device Manager to see if your unit shows up there. If it doesn't show up, you may have an FTDI driver issue.
   1. If you suspect you don't have the FTDI driver installed on your Windows computer, use the following links to download the driver:
      - Executable for the FTDI USB driver:
        - https://ftdichip.com/wp-content/uploads/2023/09/CDM-v2.12.36.4-WHQL-Certified.zip
      - Drives without executable.
        - http://www.ftdichip.com/Drivers/D2XX.htm

## Downgrading uINS to 1.8.x Firmware

The following steps can be used to downgrade the uINS firmware to version 1.8.x (or older):

1. Ensure the uINS is running 1.9.x (or newer) firmware. 

2. Send the system commands `SYS_CMD_MANF_UNLOCK` and `SYS_CMD_MANF_DOWNGRADE_CALIBRATION` to the uINS to downgrade the IMU calibration and put the system into bootloader update mode.  This can be done using the EvalTool, cltool, or SDK .

   1. **EvalTool** (version 1.9.1 or later): Use the firmware "**Downgrade**" button (EvalTool -> Settings -> General -> Factory -> Downgrade).  

   2. **cltool** (version 1.10 or later): Use option `-sysCmd=1357924682` to send the downgrade command:

      ````
      ./cltool -c /dev/ttyACM0 -sysCmd=1357924682
      ````

      **cltool alternate method**: use option `-edit 7` to edit the DID_SYS_CMD and send the downgrade command: 

      ```
      ./cltool -c /dev/ttyACM0 -edit 7
      ```

      Use `w` and `s` to move the cursor up or down (arrow keys do not work) and enter to submit the new value.  The `invCommand` value is the bitwise inverse of the command and is required to validate the command.  The `command` value will change to zero when the IMX accepts the `command` and `invCommand` values.

      Send manufacture unlock command:
      
      ```
      command = 1122334455
      invCommand = 3172632840
      ```
      
      Send downgrade command:

      ```
      command = 1357924682
      invCommand = 2937042613
      ```
      

3. Verify the uINS has reboot into bootloader update mode.  The host serial port will disappear and reappear.  The uINS will NOT support normal DID binary or NMEA communications in this mode, but will be ready to update the bootloader.

4. Update the bootloader and firmware using the 1.8.x EvalTool, cltool, or SDK.  Be sure to use the bootloader v5d (or older) with the 1.8.x firmware. 

### Chip Erase Downgrade

The above process using the `SYS_CMD_MANF_DOWNGRADE_CALIBRATION` command is recommended as it prevents the need to reload the IMU calibration onto the uINS.  However,  an alternative method to downgrade uINS to 1.8.x firmware is as follows: 

1. Chip erase the uINS.
2. Load v5b (or older) bootloader and 1.8.x (or older) firmware using the 1.8.x EvalTool, cltool, or SDK. 
3. Restore the IMU calibration.

## 1.7.6 Bug RTK Base GPS Raw work around

If you are having base raw errors on your Rover, in the bottom right of the Evaltool, or a climbing Diffrential Age, in Data Sets DID_GPS1_RTK_REL, you maybe having this bug. Try this workaround.

1. Go-to settings tab, open the Base serial COM port.
2. Go-to Data Logs tab, under RCM Presets dropdown select PPD.
3. **NOTE:** You must leave the comport open on the Base.
4. Check your Rover to see if its still getting raw errors messages.

