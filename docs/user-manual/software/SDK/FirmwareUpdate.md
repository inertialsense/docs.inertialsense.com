# Firmware Update (Bootloader) Example Project

This [ISBootloaderExample](https://github.com/inertialsense/inertial-sense-sdk/tree/main/ExampleProjects/Bootloader) project demonstrates firmware update with the <a href="https://inertialsense.com">InertialSense</a> products (IMX) using the Inertial Sense SDK.

## Files

#### Project Files

* [ISBootloaderExample.cpp](https://github.com/inertialsense/inertial-sense-sdk/blob/main/ExampleProjects/Bootloader/ISBootloaderExample.cpp)

#### SDK Files

* [data_sets.c](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/data_sets.c)
* [data_sets.h](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/data_sets.h)
* [ISBootloaderBase.cpp](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/ISBootloaderBase.cpp)
* [ISBootloaderBase.h](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/ISBootloaderBase.h)
* [ISBootloaderThread.cpp](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/ISBootloaderThread.cpp)
* [ISBootloaderThread.h](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/ISBootloaderThread.h)
* [ISSerialPort.cpp](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/ISSerialPort.cpp)
* [ISSerialPort.h](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/ISSerialPort.h)
* [ISComm.c](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/ISComm.c)
* [ISComm.h](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/ISComm.h)


## Implementation

### Step 1: Add Includes

```C++
// Change these include paths to the correct paths for your project
#include "../../src/ISComm.h"
#include "../../src/serialPortPlatform.h"
#include "../../src/ISBootloaderThread.h"
#include "../../src/ISBootloaderBase.h"
#include "../../src/ISSerialPort.h"

using namespace ISBootloader;
```

### Step 2: Define progress and status callbacks

The bootloader thread reports upload progress, verify progress, and status/log text through three callbacks that you supply:

```C++
static is_operation_result bootloaderUploadProgress(const std::any& obj, float pct, const std::string& stepName, int stepNo, int totalSteps)
{
    int percent = (int)(pct * 100.0f);
    printf("\rUpload Progress: %d%%\r", percent);
    return IS_OP_OK;
}

static is_operation_result bootloaderVerifyProgress(const std::any& obj, float pct, const std::string& stepName, int stepNo, int totalSteps)
{
    int percent = (int)(pct * 100.0f);
    printf("\rVerify Progress: %d%%\r", percent);
    return IS_OP_OK;
}

static void bootloaderStatusText(const std::any& obj, eLogLevel level, const char* str, ...)
{
    static char buffer[256];
    va_list ap;
    va_start(ap, str);
    vsnprintf(buffer, sizeof(buffer) - 1, str, ap);
    va_end(ap);
    printf("%s\r\n", buffer);
}
```

### Step 3: Discover connected devices and select firmware files

Rather than targeting one specific port directly, the example enumerates every connected serial port and lets the bootloader logic identify which firmware/bootloader file is appropriate for each device it finds. The same firmware file path is assigned to every device-type slot in `firmwares_t`; the bootloader only uses the slot that matches what it actually finds on that port.

```C++
	// Enumerate all connected serial ports
	std::vector<std::string> portStrings;
	cISSerialPort::GetComPorts(portStrings);

	// Assign the same file to every device-type slot; the bootloader identifies
	// the connected device and only applies the file to the matching slot(s).
	firmwares_t files;
	files.fw_uINS_3.path = std::string(argv[2]);
	files.bl_uINS_3.path = std::string(argv[2]);
	files.fw_IMX_5.path  = std::string(argv[2]);
	files.bl_IMX_5.path  = std::string(argv[2]);
	files.fw_EVB_2.path  = std::string(argv[2]);
	files.bl_EVB_2.path  = std::string(argv[2]);
```

### Step 4: Put devices into bootloader mode

```C++
	std::vector<cISBootloaderThread::confirm_bootload_t> confirm_device_list;
	if (!cISBootloaderThread::set_mode_and_check_devices(
			portStrings,
			atoi(argv[1]),
			files,
			bootloaderUploadProgress,
			bootloaderVerifyProgress,
			bootloaderStatusText,
			NULL,
			&confirm_device_list))
		return -1;   // Error or no devices found
```

### Step 5: Run the firmware update

```C++
	std::vector<std::string> all_ports;
	cISSerialPort::GetComPorts(all_ports);

	cISBootloaderThread::update(
		all_ports,
		true,
		atoi(argv[1]),
		files,
		bootloaderUploadProgress,
		bootloaderVerifyProgress,
		bootloaderStatusText,
		NULL);
```

!!! note
    The example's own usage message (`{COMx} {Baudrate} {Firmware file} {Bootloader file (optional)}`) is out of date relative to what the code actually reads: `argv[1]` is the baud rate and `argv[2]` is the firmware file path, applied to every device-type slot as shown in Step 3 above. There is no separate command-line argument to target one specific COM port — the tool auto-discovers and updates every connected, supported device.

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
5. Run executable (baud rate, then firmware file path)
   ``` bash
   ./ISBootloaderExample 921600 IS_uINS-3.hex
   ```
## Compile & Run (Windows Powershell)
*Note - Install CMake for Windows natively, or install the CMake for Windows extension for Visual Studio

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
   cmake --build .
   ```

4. Run executable (baud rate, then firmware file path)
   ``` bash
   C:\InertialSenseSDK\ExampleProjects\Bootloader\build\Release\ISBootloaderExample.exe 921600 IS_uINS-3.hex
   ```

## Summary

This section has covered the basic functionality you need to set up and communicate with <a href="https://inertialsense.com">Inertial Sense</a> products.  If this doesn't cover everything you need, feel free to reach out to us on the <a href="https://github.com/inertialsense/inertial-sense-sdk">Inertial Sense SDK</a> GitHub repository, and we will be happy to help.
