# System Configuration

See the [Binary Protocol](../com-protocol/binary.md) page for descriptions of each [flash configuration](../../com-protocol/DID-descriptions/#did_flash_config) value and [enumeration bit values](../../com-protocol/DID-descriptions/#enumerations-and-defines).

## Serial Port Baud Rate

Choose the baud rate for serial communications through either available port. (3000000, 921600, 460800, 230400, 115200, 57600, 38400, 19200).

### Manual Baud Configuration

The uINS baud rate can be manually set by changing the following flash configuration parameters:

| Configuration                   | Description                      |
| ------------------------------- | -------------------------------- |
| `DID_FLASH_CONFIG.ser0BaudRate` | baud rate for uINS serial port 0 |
| `DID_FLASH_CONFIG.ser1BaudRate` | baud rate for uINS serial port 1 |
| `DID_FLASH_CONFIG.ser2BaudRate` | baud rate for uINS serial port 2 |

These parameters can be changed using the EvalTool or the CLTool.  The following examples show how the EvalTool and CLtool can be used to set the uINS serial port 1 baud rate to 460,800 bps. 

`EvalTool -> Data Sets -> DATA_FLASH_CONFIG.ser1BaudRate = 460800`

```
cltool -c COM# -flashConfig=ser0BaudRate=460800
```

