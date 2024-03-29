# Getting Started

The following video is a quick intro to the EvalTool for Windows. For other applications scroll below.
<center>
<iframe width="800" height="450" src="https://www.youtube.com/embed/31Sv49VBa9Q" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

</center>

## 1. Installing Software

Inertial Sense software provides a way to view, manipulate, stream, and record the data generated by a µINS, µAHRS, or µIMU.

### [EvalTool](../user-manual/software/evaltool.md) (Windows Only)

The EvalTool is a graphical Windows-based desktop program that allows users to explore and test functionality of the Inertial Sense products in real-time.

Download the EvalTool installer from the Inertial Sense [releases](https://github.com/inertialsense/InertialSenseSDK/releases) page. Run the .exe file and follow the instructions to complete the installation.

### [CLTool](../user-manual/software/cltool.md) (Windows, Linux, and OS X)
The CLTool is a command line utility that can be used to read and display data, update firmware, and log data from Inertial Sense products.

CLTool must be compiled from our source code. Follow the instructions on the [CLTool](../user-manual/software/cltool.md) page.

### [SDK](../user-manual/software/SDK.md) (Windows, Linux)

Software development kit to interface with Inertial Sense products.

Download the file named "Source code" from our [releases](https://github.com/inertialsense/InertialSenseSDK/releases) page. The extracted folder contains code libraries as well as example projects.

## 2. Connecting Your Hardware
Select the evaluation product from the list below to view instructions on basic connection to a computer.

- [Rugged-3 Units](../user-manual/hardware/rugged3.md)
- [Rugged-2 Units](../user-manual/hardware/rugged2.md)
- [IMX-5 PCB Module](../user-manual/hardware/module_imx5.md)
- [GPX-1 PCB Module](../user-manual/hardware/module_gpx1.md)

## 3. Configuring Settings
The configuration settings found in DID_FLASH_CONFIG need to be set to appropriate values using either the [EvalTool](../user-manual/software/evaltool.md), the [CLTool](../user-manual/software/cltool.md), or the [SDK](../user-manual/software/SDK.md). A full explanation can be found on the [System Configuration](../user-manual/application-config/system_configuration.md) page. Most users initially configure the unit using the [EvalTool](../user-manual/software/evaltool.md). This is done by going to the Data Sets Tab and selecting DID_FLASH_CONFIG. The values of each field can then be edited. Pay special attention to the following fields:

1. gps1AntOffset[X-Z] - Position offset of sensor frame with respect to GPS1 antenna.

2. gps2AntOffset[X-Z] - Position offset of sensor frame with respect to GPS2 antenna.

3. dynamicModel - Dynamic model that most closely represents sensor application.*

   *Note - This feature is experimental. For most applications setting 8 will yield the best results. The user is encouraged to try different settings.



## 4. Evaluation and Testing

Once a connection to the unit has been established, please follow one of the following guides to get started with the software tool of choice:

- [EvalTool](../user-manual/software/evaltool.md)
- [CLTool](../user-manual/software/cltool.md)
- [SDK Example Projects](../user-manual/software/SDK.md)


## Demonstration Videos
### Rugged-3-G2 GPS Compassing Configuration Demo

<center>
<iframe width="800" height="400" src="https://www.youtube.com/embed/3pCre66Wbxw?si=-zPEm2B2ivJ5v-61" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

</center>

### Rugged-3-G2 RS-485/422 Configuration Demo

<center>
<iframe width="800" height="400" src="https://www.youtube.com/embed/dG4w2MkVch4?si=awCGX5lEGiaDz7FY" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

</center>

## Troubleshooting
If at any time issues are encountered, please check the troubleshooting sections of this manual.