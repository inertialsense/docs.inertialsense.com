# Binary Communications Example Project

This [ISCommExample](https://github.com/inertialsense/inertial-sense-sdk/tree/main/ExampleProjects/ISComm) project demonstrates binary communications with the<br>
<a href="https://inertialsense.com/products">Inertial Sense Products</a> (IMX) using the Inertial Sense SDK.

## Files

#### Project Files

* [ISCommExample.cpp](https://github.com/inertialsense/inertial-sense-sdk/blob/main/ExampleProjects/ISComm/ISCommExample.cpp)

#### SDK Files

* [data_sets.c](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/data_sets.c)
* [data_sets.h](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/data_sets.h)
* [ISComm.c](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/ISComm.c)
* [ISComm.h](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/ISComm.h)
* [PortFactory.cpp](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/PortFactory.cpp)
* [PortFactory.h](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/PortFactory.h)
* [serialPort.c](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/serialPort.c)
* [serialPort.h](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/serialPort.h)


## Implementation

### Step 1: Add Includes

```C++
// Change these include paths to the correct paths for your project
#include "ISComm.h"
#include "ISPose.h"
#include "ISUtilities.h"
#include "PortFactory.h"
#include "protocol_nmea.h"
```

### Step 2: Initialize and open serial port

```C++
	// Initialize the serial port (Windows, MAC or Linux) - if using an embedded system like Arduino,
	//  you will need to handle the serial port creation, open and reads yourself.

	SerialPortFactory& spf = SerialPortFactory::getInstance();
	spf.setBaudRate(921600);
	port_handle_t port = spf.bindPort(argv[1]);

	if (port == nullptr) {
		printf("Failed to allocate port\r\n");
		return -2;
	}

	// Binding a port does not open a port.. so let's open it
	if (!portIsOpened(port) && (portOpen(port) != PORT_ERROR__NONE)) {
		printf("Failed to open port\r\n");
		return -3;
	}
```

### Step 3: Stop any message broadcasting

```c++
	is_comm_stop_broadcasts_all_ports(port);
```

### Step 4: Bind callbacks to the port

```C++
	// Any ISB protocol messages will call into this handler (defined above).
	is_comm_register_port_isb_handler(port, isbDataHandler);
```

The handler receives a `p_data_t*` for every successfully parsed message; `data->hdr.id` identifies the DID and `data->ptr` points at the payload struct:

```C++
int isbDataHandler(void* ctx, p_data_t* data, port_handle_t port) {
	switch (data->hdr.id)
	{
	case DID_INS_1:
		handleIns1Message((ins_1_t*)data->ptr);
		break;

	case DID_INS_2:
		handleIns2Message((ins_2_t*)data->ptr);
		break;

	case DID_GNSS1_POS:
		handleGpsMessage((gnss_pos_t*)data->ptr);
		break;

	case DID_IMU:
		handleImuMessage((imu_t*)data->ptr);
		break;

		// TODO: add other cases for other data ids that you care about
	}

	return 0;
}
```

### Step 5: Set configuration (optional)

```C++
	// Set INS output Euler rotation in radians to 90 degrees roll for mounting
	float rotation[3] = { 90.0f*C_DEG2RAD_F, 0.0f, 0.0f };
	is_comm_set_data(port, DID_FLASH_CONFIG, sizeof(float) * 3, offsetof(nvm_flash_cfg_t, insRotation), rotation);
```

### Step 6: Enable message broadcasting

```C++
	// Ask for INS message w/ update 40ms period (4ms source period x 10).  Set data rate to zero to disable broadcast and pull a single packet.
	is_comm_get_data(port, DID_INS_1, 0, 0, 10);

	// Ask for GPS message at period of 200ms (200ms source period x 1).  Size and offset can be left at 0 unless you want to just pull a specific field from a data set.
	is_comm_get_data(port, DID_GNSS1_POS, 0, 0, 1);

	// Ask for IMU message at period of 96ms (DID_FLASH_CONFIG.startupNavDtMs source period x 6).  This could be as high as 1000 times a second (period multiple of 1)
	is_comm_get_data(port, DID_IMU, 0, 0, 6);
```

### Step 7: Save Persistent Messages

(OPTIONAL) Save currently enabled streams as persistent messages enabled after reboot.

```c++
	system_command_t cfg;
	cfg.command = SYS_CMD_SAVE_PERSISTENT_MESSAGES;
	cfg.invCommand = ~cfg.command;

	is_comm_set_data(port, DID_SYS_CMD, 0, 0, &cfg);
```

### Step 8: Process and parse messages from the port

```C++
	// This should run a fairly fast rate, (1ms is typical) to avoid data from filling
	// the COMM buffer, which could lead to data drop.
	while (portIsOpened(port)) {
		is_comm_port_parse_messages(port);
		SLEEP_MS(1);
	}
```

## Compile & Run (Linux/Mac)

1. Create build directory
   ``` bash
   cd InertialSenseSDK/ExampleProjects/ISComm
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
   ./ISCommExample /dev/ttyUSB0
   ```
## Compile & Run (Windows Powershell)
*Note - Install CMake for Windows natively, or install the CMake for Windows extension for Visual Studio

1. Create build directory
   ``` bash
   cd InertialSenseSDK/ExampleProjects/ISComm
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
   C:\InertialSenseSDK\ExampleProjects\ISComm\build\Release\ISCommExample.exe COM3
   ```

## Summary

This section has covered  the basic functionality you need to set up and communicate with <a href="https://inertialsense.com">Inertial Sense</a> products.  If this doesn't cover everything you need, feel free to reach out to us on the <a href="https://github.com/inertialsense/InertialSenseSDK">Inertial Sense SDK</a> GitHub repository, and we will be happy to help.
