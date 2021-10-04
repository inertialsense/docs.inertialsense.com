# UART Interface

The uINS has different UART TTL serial ports.  These serial ports can be converted from TTL to RS232 or RS422 using a level converter, such as found on the Rugged, EVB-1, and EVB-2 carrier boards. 

## Actual Baud Rates - UART (Serial 0 and Serial 2)

The serial ports use different peripherals so the actual baud rates of the ports differ. Serial ports 0 and 2 are UART and Serial 1 is USART.

Due to UART hardware integer rounding on the uINS serial ports 0 and 2, the following table outlines the difference between desired and actual UART baud rate settings. Note that the difference is more significant at higher baud rates.

| Desired Baud Rate (bps) | Actual Baud Rate (bps) |
| ----------------------- | ---------------------- |
| 19200                   | 19211                  |
| 38400                   | 38422                  |
| 57600                   | 57870                  |
| 115200                  | 115740                 |
| 230400                  | 234375                 |
| 460800                  | 468750                 |
| 921600                  | 937500                 |
| 3000000                 | 3125000                |

