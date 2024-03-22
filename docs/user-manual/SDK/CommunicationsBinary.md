# Binary Communications Example Project

This [IS Communications Example](https://github.com/inertialsense/InertialSenseSDK/tree/release/ExampleProjects/Communications) project demonstrates binary communications with the<br>
<a href="https://inertialsense.com/products">Inertial Sense Products</a> (IMX, uAHRS, and uIMU) using the Inertial Sense SDK.

## Files

#### Project Files

* [ISCommunicationsExample.c](https://github.com/inertialsense/InertialSenseSDK/tree/release/ExampleProjects/Communications/ISCommunicationsExample.c)

#### SDK Files

* [data_sets.c](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/data_sets.c)
* [data_sets.h](https://github.com/inertialsense/inertial-sense-sdk/blob/main/src/data_sets.h)
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
#include "../../src/ISPose.h"
```

### Step 2: Init comm instance

```C++
	is_comm_instance_t comm;
	uint8_t buffer[2048];

	// Initialize the comm instance, sets up state tracking, packet parsing, etc.
	is_comm_init(&comm, buffer, sizeof(buffer));
```

### Step 3: Initialize and open serial port

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
		return -2;
	}
```

### Step 4: Stop any message broadcasting

```c++
	int messageSize = is_comm_stop_broadcasts_all_ports(comm);
	if (messageSize != serialPortWrite(serialPort, comm->buf.start, messageSize))
	{
		printf("Failed to encode and write stop broadcasts message\r\n");
	}
```

### Step 5: Set configuration (optional)

```C++
	// Set INS output Euler rotation in radians to 90 degrees roll for mounting
	float rotation[3] = { 90.0f*C_DEG2RAD_F, 0.0f, 0.0f };
	int messageSize = is_comm_set_data(comm, DID_FLASH_CONFIG, sizeof(float) * 3, offsetof(nvm_flash_cfg_t, insRotation), rotation);
	if (messageSize != serialPortWrite(serialPort, comm->buf.start, messageSize))
	{
		printf("Failed to encode and write set INS rotation\r\n");
	}
```

### Step 6: Enable message broadcasting

```C++
	// Ask for INS message w/ update 40ms period (4ms source period x 10).  Set data rate to zero to disable broadcast and pull a single packet.
	int messageSize = is_comm_get_data(comm, DID_INS_1, 0, 0, 10);
	if (messageSize != serialPortWrite(serialPort, comm->buf.start, messageSize))
	{
		printf("Failed to encode and write get INS message\r\n");
	}

	// Ask for GPS message at period of 200ms (200ms source period x 1).  Offset and size can be left at 0 unless you want to just pull a specific field from a data set.
	messageSize = is_comm_get_data(comm, DID_GPS1_POS, 0, 0, 1);
	if (messageSize != serialPortWrite(serialPort, comm->buf.start, messageSize))
	{
		printf("Failed to encode and write get GPS message\r\n");
	}

	// Ask for IMU message at period of 96ms (DID_FLASH_CONFIG.startupNavDtMs source period x 6).  This could be as high as 1000 times a second (period multiple of 1)
	messageSize = is_comm_get_data(comm, DID_IMU, 0, 0, 6);
	if (messageSize != serialPortWrite(serialPort, comm->buf.start, messageSize))
	{
		printf("Failed to encode and write get IMU message\r\n");
	}
```

### Step 7: Save Persistent Messages

(OPTIONAL) Save currently enabled streams as persistent messages enabled after reboot.

```c++
   	system_command_t cfg;
	cfg.command = SYS_CMD_SAVE_PERSISTENT_MESSAGES;
	cfg.invCommand = ~cfg.command;

	int messageSize = is_comm_set_data(comm, DID_SYS_CMD, 0, 0, &cfg);
	if (messageSize != serialPortWrite(serialPort, comm->buf.start, messageSize))
	{
		printf("Failed to write save persistent message\r\n");
	}
```

### Step 8: Handle received data

```C++
	uint8_t inByte;

	// You can set running to false with some other piece of code to break out of the loop and end the program
	while (running)
	{
		// Read one byte with a 20 millisecond timeout
		while (serialPortReadCharTimeout(&serialPort, &inByte, 20) > 0)
		{
			switch (is_comm_parse_byte(&comm, inByte))
			{
			case _PTYPE_INERTIAL_SENSE_DATA:
				switch (comm.dataHdr.id)
				{
				case DID_INS_1:
					handleIns1Message((ins_1_t*)comm.pkt.data.ptr);
					break;

				case _DID_INS_LLA_QN2B:
					handleIns2Message((ins_2_t*)comm.pkt.data.ptr);
					break;

				case DID_GPS1_POS:
					handleGpsMessage((gps_pos_t*)comm.pkt.data.ptr);
					break;

				case _DID_PIMU:
					handleImuMessage((dual_imu_t*)comm.pkt.data.ptr);
					break;

				// TODO: add other cases for other data ids that you care about
				}
				break;

			default:
				break;
			}
		}
	}
```

## Compile & Run (Linux/Mac)

1. Create build directory
   ``` bash
   cd InertialSenseSDK/ExampleProjects/Communications
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
   ./ISCommunicationsExample /dev/ttyUSB0
   ```
## Compile & Run (Windows Powershell)
*Note - Install CMake for Windows natively, or install the CMake for Windows extension for Visual Studio

1. Create build directory
   ``` bash
   cd InertialSenseSDK/ExampleProjects/Communications
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
   C:\InertialSenseSDK\ExampleProjects\Communications\build\Release\ISCommunicationsExample.exe COM3
   ```

## Summary

This section has covered  the basic functionality you need to set up and communicate with <a href="https://inertialsense.com">Inertial Sense</a> products.  If this doesn't cover everything you need, feel free to reach out to us on the <a href="https://github.com/inertialsense/InertialSenseSDK">Inertial Sense SDK</a> GitHub repository, and we will be happy to help.
