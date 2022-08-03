# Firmware Update (Bootloader) Example Project

This [ISBootloaderExample](https://github.com/inertialsense/InertialSenseSDK/tree/release/ExampleProjects/Bootloader) project demonstrates firmware update with the <a href="https://inertialsense.com">InertialSense</a> products (IMX, uAHRS, and uIMU) using the Inertial Sense SDK.

## Files

#### Project Files

* [ISBootloaderExample.c](https://github.com/inertialsense/InertialSenseSDK/tree/release/ExampleProjects/Bootloader/ISBootloaderExample.c)

#### SDK Files

* [data_sets.c](https://github.com/inertialsense/InertialSenseSDK/tree/master/src/data_sets.c)
* [data_sets.h](https://github.com/inertialsense/InertialSenseSDK/tree/master/src/data_sets.h)
* [inertialSenseBootLoader.c](https://github.com/inertialsense/InertialSenseSDK/tree/master/src/inertialSenseBootLoader.c)
* [inertialSenseBootLoader.h](https://github.com/inertialsense/InertialSenseSDK/tree/master/src/inertialSenseBootLoader.h)
* [ISComm.c](https://github.com/inertialsense/InertialSenseSDK/tree/master/src/ISComm.c)
* [ISComm.h](https://github.com/inertialsense/InertialSenseSDK/tree/master/src/ISComm.h)
* [serialPort.c](https://github.com/inertialsense/InertialSenseSDK/tree/master/src/serialPort.c)
* [serialPort.h](https://github.com/inertialsense/InertialSenseSDK/tree/master/src/serialPort.h)
* [serialPortPlatform.c](https://github.com/inertialsense/InertialSenseSDK/tree/master/src/serialPortPlatform.c)
* [serialPortPlatform.h](https://github.com/inertialsense/InertialSenseSDK/tree/master/src/serialPortPlatform.h)


## Implementation

### Step 1: Add Includes

```C++
// Change these include paths to the correct paths for your project
#include "../../src/ISComm.h"
#include "../../src/serialPortPlatform.h"
#include "../../src/inertialSenseBootLoader.h"
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
$ cd InertialSenseSDK/ExampleProjects/Bootloader
$ mkdir build
```
2. Run cmake from within build directory
``` bash
$ cd build
$ cmake ..
```
3. Compile using make
 ``` bash
 $ make
 ```
4. If necessary, add current user to the "dialout" group in order to read and write to the USB serial communication ports:
```bash
$ sudo usermod -a -G dialout $USER
$ sudo usermod -a -G plugdev $USER
(reboot computer)
```
5. Run executable
``` bash
$ ./ISBootloaderExample /dev/ttyUSB0 IS_uINS-3.hex SAMx70-Bootloader.bin
```
## Compile & Run (Windows MS Visual Studio)

1. [Install and Configure Visual Studio](../../software/SDK/#installing-and-configuring-visual-studio)
2. Open Visual Studio solution file (InertialSenseSDK\ExampleProjects\Bootloader\VS_project\ISBootloaderExample.sln)
3. Build (F7)
4. Run executable
``` bash
C:\InertialSenseSDK\ExampleProjects\Bootloader\VS_project\Release\ISBootloaderExample.exe COM3 IS_uINS-3.hex SAMx70-Bootloader.bin
```

## Summary

This section has covered the basic functionality you need to set up and communicate with <a href="https://inertialsense.com">Inertial Sense</a> products.  If this doesn't cover everything you need, feel free to reach out to us on the <a href="https://github.com/inertialsense/InertialSenseSDK">Inertial Sense SDK</a> GitHub repository, and we will be happy to help.
