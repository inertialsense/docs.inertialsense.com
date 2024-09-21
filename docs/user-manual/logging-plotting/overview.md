# Data Logging/Plotting
Inertial Sense provides data a logging capability in the EvalTool, CLTool, and SDK (C++) that can record data in binary, comma separated (.CSV), and KML file formats.  This logging capability is useful for storing, replaying, and analyzing data.

## Data Log Types

### Comma Seperated Values (`*.csv`)

The comma separated value (.csv) file format can be imported into many software packages, including Excel, Matlab, and Python.

### KML (`*.kml`)

KML is a file format used to display geographic data in an Earth browser such as Google Earth.

### Binary Data Log (`*.raw` and `*.dat`)

<table>
<tr>
    <td></td>
    <td><b>Raw Logger (*.raw)</b></td>
    <td><b>Serial Logger (*.dat)</b></td>
</tr>
<tr>
    <td><b>Description</b></td>
    <td>Data stored in the same byte for byte form as it appears over a serial port, without parsing and removing packet header/footer.</td>
    <td>Stores data to file in the same serial order it was passed into the logger. This is the default logger used in the CLTool and EvalTool.</td>
</tr>
<tr>
    <td><b>Advantages</b></td>
    <td>Allows logging of all data/packet formats.  Preserves all data in the original form as communicated over serial port. Can be logged by writting serial port data to file, no parsing needed.</td>
    <td>Optimized for real-time data logging.</td>
</tr>
<tr>
    <td><b>Source File</b></td>
    <td>DeviceLogRaw.h / .cpp</td>
    <td>DeviceLogSerial.h / .cpp</td>
</tr>
<tr>
    <td><b>File extension</b></td>
    <td>.raw</td>
    <td>.dat</td>
</tr>
</table>


## Binary Data Log Format

This section outlines the Inertial Sense binary data log types known as raw data and serial data (`.raw` and `.dat` file extensions).  The .dat data log file type are composed of several data containers know as chunks.  Each chunk contains a header, sub-header, and data.  

### File

The data log file name has the format _LOG_SNXXXXX_YYYYMMDD_HHMMSS_CNT.dat_ which contains the device
serial number, date, time, and log file count. The serial data log file formats is  `.dat`. This log consist of files containing series of data Chunks.

![DataLogFile](../images/DataLogFile.png)

Standard data types are stored in the log files and are defined as:

<table>
<tr>
    <td>U32</td>
    <td>unsigned int</td>
</tr>
<tr>
    <td>U16</td>
    <td>unsigned short</td>
</tr>
<tr>
    <td>S8</td>
    <td>char</td>
</tr>
<tr>
    <td>U8</td>
    <td>unsigned char</td>
</tr>
</table>

### Chunk
The data log file is composed of Chunks. A Chunk is a data container that provides an efficient method for
organizing, handling, and parsing data in a file. A Chunk starts with a header which has a unique identifiable marker and ends with the data to be stored.

![Chunk](../images/Chunk.png)

### Chunk Header
The header, found at the start of each Chunk, is as follows:

![ChunkHeader](../images/ChunkHeader.png)

The C structure implementation of the Chunk header is:

```C
//!< Chunk Header
#pragma pack(push,1)
struct sChunkHeader
{
uint32_t marker; //!< Chunk marker (0xFC05EA32)
uint16_t version; //!< Chunk Version
uint16_t classification; //!< Chunk classification
char name[4]; //!< Chunk name
char invName[4]; //!< Bitwise inverse of chunk name
uint32_t dataSize; //!< Chunk data length in bytes
uint32_t invDataSize; //!< Bitwise inverse of chunk data length
uint32_t grpNum; //!< Chunk Group Number: 0 = serial data...
uint32_t devSerialNum; //!< Device serial number
uint32_t pHandle; //!< Device port handle
uint32_t reserved; //!< Unused
};
#pragma pack(pop)
```

### Chunk Data
The Chunk data is defined for both the `.dat` and `.sdat` file types.

![ChunkData](../images/ChunkData.png)

### Chunk Sub-Header
The Chunk sub-header is used for `.sdat` file types.

![ChunkSubHeader](../images/ChunkSubHeader.png)

### Data Set Header
The Data set header is used for both the `.dat` and `.sdat` file types.

![DataSetHeader](../images/DataSetHeader.png)
