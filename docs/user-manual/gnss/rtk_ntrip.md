Networked Transport of RTCM via internet protocol, or NTRIP, is an open standard protocol for
streaming differential data over the internet in accordance with specifications published by RTCM.
There are three major parts to the NTRIP system: The NTRIP client, the NTRIP server, and the NTRIP
caster:

1. The NTRIP server is a PC or on-board computer running NTRIP server software communicating directly with a GNSS reference station. 
2. The NTRIP caster is an HTTP server which receives streaming RTCM data from one or more NTRIP servers and in turn streams the RTCM data to one or more NTRIP clients via the internet.
3. The NTRIP client receives streaming RTCM data from the NTRIP caster to apply as real-time corrections to a GNSS receiver. 

![](./images/ntrip.png)

The EvalTool/CLTool software applications provide NTRIP client functionality to be used with the IMX RTK rover.  Typically an EvalTool NTRIP client connects over the internet to an NTRIP service provider. The EvalTool/CLTool NTRIP client then provides the RTCM 3.3 corrections to the IMX and ZED-F9P rover connected over USB or serial.  Virtual reference service (VRS) is also supported by the EvalTool/CLTool NTRIP client.

!!! important
    If using a **virtual reference service** (**VRS**), the rover must output the **NMEA GGA** message to return to the NTRIP caster.  Without this, the NTRIP caster will not provide correction information.

## NTRIP RTCM3 Messages

The NTRIP server must provide the necessary subset of [RTCM3 messages](../multi_band_gnss/#zed-f9-rover-messages) supported by the IMX-RTK.  The following is an example of compatible RTCM3 base output messages provided from a Trimble NTRIP RTK base station.

| Message Type | Period (sec) | Description                           |
| ---- | ------------ | ------------------------------------- |
| RTCM 1005 | 5            | Stationary RTK reference station ARP  |
| RTCM 1007 | 5            | Antenna Descriptor                    |
| RTCM 1030 | 3            | GPS Network RTK Residual              |
| RTCM 1031 | 3            | GLONASS Network RTK Residual          |
| RTCM 1032 | 1            | Physical Reference Station Position   |
| RTCM 1033 | 5            | Receiver and Antenna Descriptors      |
| RTCM 1075 | 1            | GPS MSM5                              |
| RTCM 1085 | 1            | GLONASS MSM5                          |
| RTCM 1095 | 1            | Galileo MSM5                          |
| RTCM 1230 | 5            | GLONASS code-phase biases             |
| RTCM 4094 | 5            | Assigned to : Trimble Navigation Ltd. |
