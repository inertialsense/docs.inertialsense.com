# System Configuration

See the [Binary Protocol](../com-protocol/binary.md) page for descriptions of each [flash configuration](../../com-protocol/DID-descriptions/#did_flash_config) value and [enumeration bit values](../../com-protocol/DID-descriptions/#enumerations-and-defines).

## Serial Port Baud Rates

Standard UART baud rates available on the IMX are: 921600, 460800, 230400, 115200, 57600, 38400, 19200.  

### High Speed Baud Rates

Non-standard high speed UART baud rates (>921600 bps) can be set to arbitrary values up to 10 Mbps.  Due to hardware limitations, the applied baud rate will be rounded to the closest available baud rate and reported back via the `DID_FLASH_CONFIG.serXBaudRate` parameter. 

### Baud Rate Configuration

The IMX baud rate can be manually set by changing the following flash configuration parameters:

| Configuration                   | Description                      |
| ------------------------------- | -------------------------------- |
| `DID_FLASH_CONFIG.ser0BaudRate` | baud rate for IMX serial port 0 |
| `DID_FLASH_CONFIG.ser1BaudRate` | baud rate for IMX serial port 1 |
| `DID_FLASH_CONFIG.ser2BaudRate` | baud rate for IMX serial port 2 |

These parameters can be changed using the EvalTool or the CLTool.  The following examples show how the EvalTool and CLtool can be used to set the IMX serial port 1 baud rate to 460,800 bps. 

`EvalTool -> Data Sets -> DATA_FLASH_CONFIG.ser1BaudRate = 460800`

```
cltool -c COM# -flashConfig=ser0BaudRate=460800
```

