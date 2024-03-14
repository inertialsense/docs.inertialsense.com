# ASCII Communications Example Project

This [IS Communications Example](https://github.com/inertialsense/InertialSenseSDK/tree/release/ExampleProjects/Ascii) project demonstrates binary communications with the<br>
<a href="https://inertialsense.com/products">Inertial Sense Products</a> (IMX, uAHRS, and uIMU) using the Inertial Sense SDK. See the<br>
[ASCII protocol](../com-protocol/nmea.md) section for details on the ASCII packet structures.

## Files

#### Project Files

* [ISAsciiExample.c](https://github.com/inertialsense/InertialSenseSDK/tree/release/ExampleProjects/Ascii/ISAsciiExample.c)

#### SDK Files

* [data_sets.c](https://github.com/inertialsense/InertialSenseSDK/tree/master/src/data_sets.c)
* [data_sets.h](https://github.com/inertialsense/InertialSenseSDK/tree/master/src/data_sets.h)
* [ISComm.c](https://github.com/inertialsense/InertialSenseSDK/tree/master/src/ISComm.c)
* [ISComm.h](https://github.com/inertialsense/InertialSenseSDK/tree/master/src/ISComm.h)
* [ISConstants.h](https://github.com/inertialsense/InertialSenseSDK/tree/master/src/ISConstants.h)
* [serialPort.c](https://github.com/inertialsense/InertialSenseSDK/tree/master/src/serialPort.c)
* [serialPort.h](https://github.com/inertialsense/InertialSenseSDK/tree/master/src/serialPort.h)
* [serialPortPlatform.c](https://github.com/inertialsense/InertialSenseSDK/tree/master/src/serialPortPlatform.c)
* [serialPortPlatform.h](https://github.com/inertialsense/InertialSenseSDK/tree/master/src/serialPortPlatform.h)

## Implementation

### Step 1: Add Includes

```C++
// Change these include paths to the correct paths for the project
#include "../../src/ISComm.h"
#include "../../src/serialPortPlatform.h"
```

### Step 2: Initialize and open serial port

```C++
	serial_port_t serialPort;

	// Initialize the serial port (Windows, MAC or Linux) - if using an embedded system like Arduino,
	//  you will need to handle the serial port creation, open and reads yourself. In this
	//  case, you do not need to include serialPort.h/.c and serialPortPlatform.h/.c in your project.
	serialPortPlatformInit(&serialPort);

	// Open serial, last parameter is a 1 which means a blocking read, you can set as 0 for non-blocking
	// you can change the baudrate to a supported baud rate (IS_BAUDRATE_*), make sure to reboot the IMX
	//  if you are changing baud rates, you only need to do this when you are changing baud rates.
	if (!serialPortOpen(&serialPort, argv[1], IS_BAUDRATE_921600, 1))
	{
		printf("Failed to open serial port on com port %s\r\n", argv[1]);
	}
```

### Step 3: Disable prior message broadcasting

```c++
// Stop all broadcasts on the device on all ports.  We don't want binary message coming through while we are doing ASCII
if (!serialPortWriteAscii(&serialPort, "STPB", 4))
{
	printf("Failed to encode stop broadcasts message\r\n");
}
```
### Step 4: Enable message broadcasting

```C++
   	// ASCII protocol is based on NMEA protocol https://en.wikipedia.org/wiki/NMEA_0183
	// turn on the INS message at a period of 100 milliseconds (10 hz)
	// serialPortWriteAscii takes care of the leading $ character, checksum and ending \r\n newline
	// ASCE message enables ASCII broadcasts
	// ASCE fields: 1:options, ID0, Period0, ID1, Period1, ........ ID19, Period19
	// IDs:
	// NMEA_MSG_ID_PIMU      = 0,
    // NMEA_MSG_ID_PPIMU     = 1,
    // NMEA_MSG_ID_PRIMU     = 2,
    // NMEA_MSG_ID_PINS1     = 3,
    // NMEA_MSG_ID_PINS2     = 4,
    // NMEA_MSG_ID_PGPSP     = 5,
    // NMEA_MSG_ID_GxGGA     = 6,
    // NMEA_MSG_ID_GxGLL     = 7,
    // NMEA_MSG_ID_GxGSA     = 8,
    // NMEA_MSG_ID_GxRMC     = 9,
    // NMEA_MSG_ID_GxZDA     = 10,
    // NMEA_MSG_ID_PASHR     = 11, 
    // NMEA_MSG_ID_PSTRB     = 12,
    // NMEA_MSG_ID_INFO      = 13,
    // NMEA_MSG_ID_GxGSV     = 14,
    // NMEA_MSG_ID_GxVTG     = 15,
    // NMEA_MSG_ID_INTEL     = 16,

	// options can be 0 for current serial port, 1 for serial 0, 2 for serial 1 or 3 for both serial ports
	// Instead of a 0 for a message, it can be left blank (,,) to not modify the period for that message
	// please see the user manual for additional updates and notes

    // Get PINS1 @ 5Hz on the connected serial port, leave all other broadcasts the same, and save persistent messages.
	const char* asciiMessage = "ASCE,0,3,1";

    // Get PINS1 @ 1Hz and PGPSP @ 1Hz on the connected serial port, leave all other broadcasts the same
	// const char* asciiMessage = "ASCE,0,5,5";

	// Get PIMU @ 50Hz, GGA @ 5Hz, serial0 and serial1 ports, set all other periods to 0
    //  const char* asciiMessage = "ASCE,3,6,1";

    if (!serialPortWriteAscii(&serialPort, asciiMessage, (int)strnlen(asciiMessage, 128)))
	{
		printf("Failed to encode ASCII get INS message\r\n");
	}
```

### Step 5: Save persistent messages

(OPTIONAL) This remembers the current communications and automatically streams data following reboot.

```c++
if (!serialPortWriteAscii(&serialPort, "PERS", 4))
{
    printf("Failed to encode ASCII save persistent message\r\n");
}
```
### Step 6: Handle received data

```C++
	// STEP 4: Handle received data
	unsigned char* asciiData;
	unsigned char asciiLine[512];

	// you can set running to false with some other piece of code to break out of the loop and end the program
	while (running)
	{
		if (serialPortReadAscii(&serialPort, asciiLine, sizeof(asciiLine), &asciiData) > 0)
		{
			printf("%s\n", asciiData);
		}
	}
```

## Compile & Run (Linux/Mac)

1. Create build directory
   ``` bash
   cd InertialSenseSDK/ExampleProjects/Ascii
   mkdir build
   ```
2. Run cmake from within build directory
   ``` bash
   cd build
   cmake ..
   ```
3. Compile using make
   ``` bash
   make
   ```
4. If necessary, add current user to the "dialout" group in order to read and write to the USB serial communication ports:
   ```bash
   sudo usermod -a -G dialout $USER
   sudo usermod -a -G plugdev $USER
   (reboot computer)
   ```
5. Run executable
   ``` bash
   ./ISAsciiExample /dev/ttyUSB0
   ```
## Compile & Run (Windows Powershell)
*Note - Install CMake for Windows natively, or install the CMake for Windows extension for Visual Studio

1. Create build directory
   ``` bash
   cd InertialSenseSDK/ExampleProjects/Ascii
   mkdir build
   ```
2. Run cmake from within build directory
   ``` bash
   cd build
   cmake ..
   ```
3. Compile using make
   ``` bash
   cmake --build .
   ```

4. Run executable
   ``` bash
   C:\InertialSenseSDK\ExampleProjects\Ascii\build\Release\ISAsciiExample.exe COM3
   ```

## Summary

This section has covered the basic functionality you need to set up and communicate with <a href="https://inertialsense.com">Inertial Sense</a> products.  If this doesn't cover everything you need, feel free to reach out to us on the <a href="https://github.com/inertialsense/InertialSenseSDK">Inertial Sense SDK</a> GitHub repository, and we will be happy to help.
