# UART Interface

The IMX has different UART TTL serial ports.  These serial ports can be converted from TTL to RS232 or RS422 using a level converter, such as found on the Rugged, EVB-1, and EVB-2 carrier boards. 

## Actual Baud Rates - UART (Serial 0 and Serial 2)

The serial ports use different peripherals so the actual baud rates of the ports differ. Serial ports 0 and 2 are UART and Serial 1 is USART.

Due to UART limitations, the ***actual baud rate*** that the hardware is capable of generating differs from the target or desired baud rate.  This difference is more pronounced at higher baud rates (>921600 bps).  The following table outlines these differences.      

| Target Baud Rate (bps) | IMX-5 <br/>Actual Baud Rate (bps) | uINS-3 <br/>Actual Baud Rate (bps) |
| ---------------------- | --------------------------------- | ---------------------------------- |
| 19,200                 | 19,198                            | 19,191                             |
| 38,400                 | 38,406                            | 38,422                             |
| 57,600                 | 57,595                            | 57,515                             |
| 115,200                | 115,273                           | 115,030                            |
| 230,400                | 230,547                           | 231,481                            |
| 460,800                | 459,770                           | 457,317                            |
| 921,600                | 919,540                           | 937,500                            |
|                        | 3,200,000                         | 3,125,000                          |
|                        | 4,000,000                         | 3,750,000                          |
|                        | 5,000,000                         | 4,687,500                          |
|                        | 8,000,000                         | 6,250,000                          |
|                        | 10,000,000                        | 9,375,000                          |

### IMX-5 UART Baud Rate Equation

The actual baud rate that the IMX-5 hardware is capable of generating is described in the following equation. 

```
Divisor = floor((80e6 + ((Target Baud Rate)/2)) / (Target Baud Rate))
Actual Baud Rate = floor( 80e6 / Divisor )
```

### uINS-3 UART Baud Rate Equation

The actual baud rate that the IMX-5 hardware is capable of generating is described in the following equation.

```
Divisor = floor((18750000 + ((Target Baud Rate)/2)) / (Target Baud Rate))
Actual Baud Rate = floor( 18750000 / Divisor )
```