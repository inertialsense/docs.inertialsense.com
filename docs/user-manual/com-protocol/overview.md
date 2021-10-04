# Protocol Overview

The Inertial Sense products support binary and ASCII protocol for communication.

## Binary vs. ASCII

The following table compares the differences and advantages between the binary and ASCII protocols.

<!-- THIS TABLE IS DUPLICATED IN THE BINARY AND ASCII PROTOCOL SECTIONS -->

|                       | **ASCII (NMEA) Protocol**                        | **Binary Protocol**                             |
| --------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| **Data Efficient**    | No.  Numbers must be converted to IEEE float and integers for application.  Data occupies more memory. | Numbers are in floating point and integer binary format used in computers.  Data occupies less memory. |
| **Human Readable**    | Yes                                                          | No                                                           |
| **Complexity**        | Packet are easier to parse.                                  | Packet encoding, decoding, and parsing are MORE complicated.  Using SDK is recommended. |
| **SDK Support**       | Yes, less                                                    | Yes, more                                                    |
| **Data Access**       | Limited to sensor and INS output.                            | Comprehensive access to all data and configuration settings. |
| **Recommended Use**   | Rapid prototypes and simple projects.  Devices supporting NMEA. | Moderate to advanced applications.                           |
| **Apps and Examples** | [ASCII Communications Example](../SDK/CommunicationsAscii.md) | EvalTool, CLTool, [Binary Communications Example](../SDK/CommunicationsBinary.md), [Fimrware Update Example](../SDK/FirmwareUpdate.md), [Data Logger Example](../SDK/DataLogger.md) |
