# Data Logging Example Project

This [ISLoggerExample](https://github.com/inertialsense/InertialSenseSDK/tree/release/ExampleProjects/Logger) project demonstrates data logging with the <a href="https://inertialsense.com">InertialSense</a> products (IMX, uAHRS, and uIMU) using the Inertial Sense SDK.

## Files

#### Project Files

* [ISLoggerExample.cpp](https://github.com/inertialsense/InertialSenseSDK/tree/release/ExampleProjects/Logger/ISLoggerExample.cpp)

#### SDK Files

* [SDK](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src)


## Implementation

### Step 1: Add Includes

```C++
// Change these include paths to the correct paths for your project
#include "../../src/InertialSense.h"
```

### Step 2: Instantiate InertialSense class

```C++
	// InertialSense class wraps communications and logging in a convenient, easy to use class
	InertialSense inertialSense(dataCallback);
	if (!inertialSense.Open(argv[1]))
	{
		std::cout << "Failed to open com port at " << argv[1] << std::endl;
	}
```

### Step 3: Enable data logger

```C++
	// get log type from command line
	cISLogger::sSaveOptions options;
	options.logType = (argc < 3 ? cISLogger::LOGTYPE_DAT : cISLogger::ParseLogType(argv[2]));
	inertialSense.EnableLogger(true, "", options);
```

### Step 4: Enable data broadcasting

```C++
	// broadcast the standard set of post processing messages (ins, imu, etc.)
	inertialSense.BroadcastBinaryDataRmcPreset();

	// instead of the rmc preset (real-time message controller) you can request individual messages...
	// inertialSense.BroadcastBinaryData(DID_IMU, 6); // (startupNavDtMs default)
```

By default, data logs will be stored in the "IS_logs" directory in the current directory.

``` bash
build/IS_logs/LOG_SN30664_20180323_112822_0001.dat
```

## Compile & Run (Linux/Mac)

1. Create build directory
   ``` bash
   cd InertialSenseSDK/ExampleProjects/Logger
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
   ./ISLoggerExample /dev/ttyUSB0
   ```
## Compile & Run (Windows Powershell)
*Note - Install CMake for Windows natively, or install the CMake for Windows extension for Visual Studio

1. Create build directory
   ``` bash
   cd InertialSenseSDK/ExampleProjects/Logger
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
   C:\InertialSenseSDK\ExampleProjects\Logger\build\Release\ISLoggerExample.exe COM3
   ```

## Summary

This section has covered the basic functionality you need to set up and communicate with <a href="https://inertialsense.com">Inertial Sense</a> products.  If this doesn't cover everything you need, feel free to reach out to us on the <a href="https://github.com/inertialsense/InertialSenseSDK">Inertial Sense SDK</a> GitHub repository, and we will be happy to help.
