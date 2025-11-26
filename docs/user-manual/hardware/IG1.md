# Hardware Integration: IG-1-IMX-5

<center>

![IG-1](../images/ig-1.1-g2.png)

</center>

The Inertial Sense IG-1 is a PCB module with IMX-5 and dual ublox ZED-F9P multi-frequency GNSS receivers.

- Surface mount reflowable. 
- Onboard dual GNSS for simultaneous RTK positioning and GPS compassing. 
- Micro USB and 14 pin I/O header for convenient evaluation.

## Connecting Your Unit

For the purposes of basic evaluation, the easiest interface available on the IG-1 is by using a micro-USB cable. A cable included in the evaluation kit. The cable provides power and communications with the installed module via USB virtual communications port.

## Pinout

**Module Pinout**

![IG1 Module Pinout](images/ig1_pinout.svg)

**Header H1 Pinout**

![IG1 H1 Pinout](images/ig-1.1_h1_pinout.png)

The module and header H1 have the same pinout assignment for pins 1-14.  All pins 15 and above are only on the module.

| Module<br/>& H1 Pin                | Name                                       | I/O  | Description                                                  |
| ---------------------------------- | :----------------------------------------- | ---- | ------------------------------------------------------------ |
| ![](../images/square-black.png)1   | GND                                        | PWR  | -                                                            |
| ![](../images/square-black.png)2   | VIN                                        | PWR  | 4V-20V supply voltage input                                  |
| ![](../images/square-red.png)3     | +3.3V                                      | PWR  | Regulated 3.3V supply input/output.                          |
| ![](../images/square-red.png)4     | Reserved                                   |      | Not Connected                                                |
| ![](../images/square-brown.png)5   | G1/Rx2/RxCAN/SCL                           | I/O  | (**Internally connected to GPS2 ZED-F9P TXD)<br />GPIO1 <br />Serial 2 input (TTL) <br />Serial input pin from CAN transceiver<sup>\*</sup> <br />I2C SCL line6 |
| ![](../images/square-orange.png)6  | G2/Tx2/TxCAN/SDA/STROBE                    | I/O  | (**Internally connected to GPS2 ZED-F9P RXD)<br />GPIO2 <br />Serial 2 output (TTL)<br /> Serial output pin to CAN transceiver<sup>\*</sup><br /> I2C SDA line<br />Strobe time sync input |
| ![](../images/square-yellow.png)7  | G3/Tx0                                     | I/O  | (**Internally connected to GPS1 ZED-F9P RXD)<br />GPIO3<br /> Serial 0 output (TTL) |
| ![](../images/square-green.png)8   | G4/Rx0                                     | I/O  | (**Internally connected to GPS1 ZED-F9P TXD)<br />GPIO4<br /> Serial 0 input (TTL) |
| ![](../images/square-blue.png)9    | G5/SCLK/STROBE                             | I/O  | GPIO5<br /> SPI SCLK<br /> Strobe time sync input            |
| ![](../images/square-purple.png)10 | G6/Rx1/MOSI                                | I/O  | GPIO6<br /> Serial 1 input (TTL)<br /> SPI MOSI              |
| ![](../images/square-white.png)11  | G7/Tx1/MISO                                | I/O  | GPIO7<br /> Serial 1 output (TTL)<br /> SPI MISO             |
| ![](../images/square-grey.png)12   | G8/CS/STROBE                               | I/O  | GPIO8<br /> SPI CS<br /> Strobe time sync input              |
| ![](../images/square-brown.png)13  | G9/nSPI_EN/STROBE<br/>/STROBE_OUT/SPI_DRDY | I/O  | GPIO9<br /> SPI Enable: Hold LOW during boot to enable SPI on G5-G8<br /> Strobe time sync input or output. SPI data ready alternate location. |
| ![](../images/square-orange.png)14 | GPS_TIMEPULSE                              | O    | GPS1 PPS UTC time synchronization signal.                    |
| 15                                 | GND                                        | I/O  | -                                                            |
| 16                                 | VBAT                                       | I/O  | GPS backup supply voltage. (1.4V to 3.6V) enables GPS hardware backup mode for hot or warm startup (faster GPS lock acquisition). MUST connect GPS_VBAT to VCC if no backup battery is used. |
| 17                                 | G10/BOOT_MODE                              | I/O  | Leave unconnected. BOOT MODE used in manufacturing. !!! WARNING !!! Asserting a logic high (+3.3V) will cause the IMX to reboot into ROM bootloader (DFU) mode. |
| 18                                 | G11                                        | I/O  | GPIO11                                                       |
| 19                                 | G12                                        | I/O  | GPIO12<br/>GPS reset                                         |
| 20                                 | G13/DRDY                                   | I/O  | GPIO13<br/>SPI data ready                                    |
| 21                                 | G14/SWCLK                                  | I/O  | GPIO14                                                       |
| 22                                 | nRESET                                     | I    | System reset on logic low. May be left unconnected if not used. |
| 23                                 | GND                                        | PWR  | -                                                            |
| 24                                 | USB_N                                      | I/O  | USB  Data Negative Line                                      |
| 25                                 | USB_P                                      | I/O  | USB Data Positive Line                                       |
| 26                                 | GPS1_RX2                                   | I    | Ublox ZED-F9P RXD2 (GPS1)                                    |
| 27                                 | GPS1_TX2                                   | O    | Ublox ZED-F9P TXD2 (GPS1)                                    |
| 28                                 | GPS2_RX2                                   | I    | Ublox ZED-F9P RXD2 (GPS2)                                    |
| 29                                 | GPS2_TX2                                   | O    | Ublox ZED-F9P TXD2 (GPS2)                                    |
| 30                                 | +3.3V                                      | PWR  | Regulated 3.3V supply input/output.                          |
| 31                                 | GPS2_TIMEPULSE                             | O    | GPS2 PPS UTC time synchronization signal.                    |
| 32-36                              | NC                                         | -    | Not connected internally                                     |
| 37-69                              | GND                                        | PWR  | -                                                            |

## Hardware Versions

The following outlines differences in the IG-1.x hardware versions.

**IG-1.2** 

- GPS1 ZED-F9P RXD2/TXD2 lines connected to IG-1 pins 26, 27.
- GPS2 ZED-F9P RXD2/TXD2 lines connected to IG-1 pins 28, 29.
- GPS1 ZED-F9P PPS (TIMEPULSE) line connected to IG-1 pin 31.
- IG-1 pins 32-36 are not connected internally (not connected to ground).

**IG-1.1**

- GPS1 PPS line connected to IMX TIMEPUSE G15 (pin 20).
- IG-1 pins 26-36 are connected to ground.

**IG-1.0**

- GPS1 PPS line connected to IMX G8 (pin 8).
- IG-1 pins 26-36 are connected to ground.

## Schematic

[Download Schematic](https://docs.inertialsense.com/datasheets/IG-1_schematic.pdf)

<object data="https://docs.inertialsense.com/datasheets/IG-1_schematic.pdf" type="application/pdf" width="700px" height="600px" >
    <embed src="https://docs.inertialsense.com/datasheets/IG-1_schematic.pdf" type="application/pdf" />
</object>

## Hardware Design

### Recommend PCB Footprint and Layout

The default forward direction is indicated in the PCB footprint figure and on the silkscreen as the X axis. The forward direction is reconfigurable in software as necessary.

[Download PDF](https://docs.inertialsense.com/dimensions/IS-IG-1.1-G2-Dual_Dimensions_and_Pinout_IG-1-IMX-5-Dual.pdf)

<object data="https://docs.inertialsense.com/dimensions/IS-IG-1.1-G2-Dual_Dimensions_and_Pinout_IG-1-IMX-5-Dual.pdf" type="application/pdf" width="700px" height="1150px" >
    <embed src="https://docs.inertialsense.com/dimensions/IS-IG-1.1-G2-Dual_Dimensions_and_Pinout_IG-1-IMX-5-Dual.pdf" type="application/pdf" />
</object>

## Soldering

The IMX-5 can be reflow soldered. Reflow information can be found in the [Reflow Information](reflow.md) section of this manual.

## Design Files

<img src="https://www.oshwa.org/wp-content/uploads/2014/03/oshw-logo.svg" width="100" align="right" />

Open source hardware design files, libraries, and example projects for the IMX module are found at the [Inertial Sense Hardware Design repository](https://github.com/inertialsense/IS-hdw) hosted on GitHub.  These include schematic and layout files for printed circuit board designs, and 3D step models of the InertialSense products usable for CAD and circuit board designs.

### Reference Design Projects

The IG-1 circuit board projects serve as reference designs that illustrate implementation of the IMX PCB module.

[IG-1 module](https://github.com/inertialsense/IS-hdw/tree/main/Products/IG-1)

## Related Parts

| Part | Manufacturer | Manufacturer # | Description                                           |
| ---- | ------------ | -------------- | ----------------------------------------------------- |
| H1   | JST          | GHR-14V-S      | 14 pin connector 1.25mm pitch for IMX I/O connection. |
