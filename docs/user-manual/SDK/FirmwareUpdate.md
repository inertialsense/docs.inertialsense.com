# Firmware Update (Bootloader) Example Project

This [ISBootloaderExample](https://github.com/inertialsense/InertialSenseSDK/tree/release/ExampleProjects/Bootloader) project demonstrates firmware update with the <a href="https://inertialsense.com">InertialSense</a> products (IMX, uAHRS, and uIMU) using the Inertial Sense SDK.

## Files

#### Project Files

* [ISBootloaderExample.cpp](https://github.com/inertialsense/inertial-sense-sdk/blob/main/ExampleProjects/Bootloader/ISBootloaderExample.cpp)

#### SDK Files

* [data_sets.c](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/data_sets.c)
* [data_sets.h](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/data_sets.h)
* [inertialSenseBootLoader.c](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/ISBootloaderBase.cpp)
* [inertialSenseBootLoader.h](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/ISBootloaderBase.h)
* [ISComm.c](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/ISComm.c)
* [ISComm.h](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/ISComm.h)
* [serialPort.c](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/serialPort.c)
* [serialPort.h](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/serialPort.h)
* [serialPortPlatform.c](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/serialPortPlatform.c)
* [serialPortPlatform.h](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/serialPortPlatform.h)


## Implementation

### Step 1: Add Includes

```C++
// Change these include paths to the correct paths for your project
#include "../../src/ISComm.h"
#include "../../src/serialPortPlatform.h"
#include "../../src/ISBootloaderThread.h"
#include "../../src/ISBootloaderBase.h"
#include "../../src/ISSerialPort.h"
```

### Step 2: Initialize and open serial port

```C++
	serial_port_t serialPort;

	// initialize the serial port (Windows, MAC or Linux) - if using an embedded system like Arduino,
	//  you will need to either bootload from Windows, MAC or Linux, or implement your own code that
	//  implements all the function pointers on the serial_port_t struct.
	serialPortPlatformInit(&serialPort);

	// set the port - the bootloader uses this to open the port and enable bootload mode, etc.
	serialPortSetPort(&serialPort, argv[1]);
```

### Step 3: Set bootloader parameters

```C++
	// bootloader parameters
	bootload_params_t param;

	// very important - initialize the bootloader params to zeros
	memset(&param, 0, sizeof(param));

	// the serial port
	param.port = &serialPort;
	param.baudRate = atoi(argv[2]);

	// the file to bootload, *.hex
	param.fileName = argv[3];

	// optional - bootloader file, *.bin
	param.forceBootloaderUpdate = 0;	//do not force update of bootloader
	if (argc == 5)
		param.bootName = argv[4];
	else
		param.bootName = 0;
```

### Step 4: Run bootloader

```C++
	if (bootloadFileEx(&param)==0)
	{
		printf("Bootloader success on port %s with file %s\n", serialPort.port, param.fileName);
		return 0;
	}
	else
	{
		printf("Bootloader failed! Error: %s\n", errorBuffer);
		return -1;
	}
```

## Compile & Run (Linux/Mac)

1. Create build directory
   ``` bash
   cd InertialSenseSDK/ExampleProjects/Bootloader
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
   ./ISBootloaderExample /dev/ttyUSB0 IS_uINS-3.hex bootloader-SAMx70.bin
   ```
## Compile & Run (Windows Powershell)
*Note - Install CMake for Windows natively, or install the CMake for Windows extension for Visual Studio

1. Create build directory
   ``` bash
   cd InertialSenseSDK/ExampleProjects/IS_firmwareUpdate_v2
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
   C:\InertialSenseSDK\ExampleProjects\IS_firmwareUpdate_v2\build\Release\ISBootloaderExample.exe COM3 IS_uINS-3.hex bootloader-SAMx70.bin
   ```

## Summary

This section has covered the basic functionality you need to set up and communicate with <a href="https://inertialsense.com">Inertial Sense</a> products.  If this doesn't cover everything you need, feel free to reach out to us on the <a href="https://github.com/inertialsense/InertialSenseSDK">Inertial Sense SDK</a> GitHub repository, and we will be happy to help.
