# Assisted GNSS (A-GPS)

Assisted GNSS (A-GPS) is a method of aiding the GPS solution to reduce time to fix.  This is accomplished either by using a backup battery or by storing A-GPS data to flash memory. 

## Backup Battery

A backup battery can be used to keep the GNSS receiver real time clock (RTC) running and
retains the last known position and almanac.  Simply attach a 1.4V to 3.6V battery to the [GPS-VBAT (pin 3) on the uINS module](https://docs.inertialsense.com/user-manual/hardware/module/#pinout).  The EVB-1 and EVB-2 both include an backup battery.

## Flash Backup

In some cases using a backup battery is not feasible or desirable.  Using the flash based assisted GPS (A-GPS) backup can be used to aid GPS time to fix without the use of a backup battery.  This method typically reduces time to fix by half.  A-GPS flash backup data ages over four hours and is no longer beneficial beyond that time.   

The A-GPS flash backup is accomplished by issuing the A-GPS reset command to the uINS.   This can be done by pressing the "A-GPS Software Reset" button in the EvalTool General Settings tab or setting the `DID_CONFIG.system = 98`.  

The A-GPS reset command will store GPS position and almanac data to flash memory and then reset the processor.   This data will be loaded from flash and used each time on startup if there is no backup battery available.



