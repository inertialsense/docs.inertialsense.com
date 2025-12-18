# Docs Knowledge Quiz (Hidden)

This page is intentionally left out of the navigation. Share the direct URL to run a 25-question quiz based on content from the rest of the documentation.

<div class="quiz-shell">
  <div class="quiz-card">
    <div class="quiz-header">
      <div class="quiz-pill" id="question-counter"></div>
      <div class="quiz-feedback" id="feedback"></div>
    </div>
    <h2 id="question-text"></h2>
    <div id="options" class="quiz-options"></div>
    <div id="results" class="quiz-results" hidden></div>
  </div>
  <div class="quiz-progress">
    <div class="quiz-progress-text" id="progress-text"></div>
    <div class="quiz-progress-track">
      <div class="quiz-progress-bar" id="progress-bar"></div>
    </div>
  </div>
</div>

<style>
.quiz-shell {
  max-width: 900px;
  margin: 0 auto;
  padding: 1.5rem;
  background: linear-gradient(135deg, #f4f7fb, #ffffff);
  border: 1px solid #e3e8f0;
  border-radius: 14px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
}

.quiz-card {
  background: #fff;
  border-radius: 12px;
  padding: 1.25rem;
  border: 1px solid #e5e7eb;
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.05);
}

.quiz-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 0.75rem;
}

.quiz-pill {
  display: inline-flex;
  align-items: center;
  padding: 0.25rem 0.75rem;
  border-radius: 999px;
  background: #0f172a;
  color: #fff;
  font-size: 0.9rem;
  letter-spacing: 0.01em;
}

.quiz-feedback {
  font-weight: 600;
  min-height: 1.2em;
}

.quiz-feedback.correct {
  color: #0f9d58;
}

.quiz-feedback.incorrect {
  color: #c53030;
}

h2#question-text {
  margin: 0.4rem 0 1rem;
  font-size: 1.25rem;
  line-height: 1.4;
}

.quiz-options {
  display: grid;
  gap: 0.75rem;
}

.quiz-options button {
  text-align: left;
  padding: 0.9rem 1rem;
  border-radius: 10px;
  border: 1px solid #e2e8f0;
  background: #f8fafc;
  cursor: pointer;
  transition: all 0.18s ease;
  font-size: 1rem;
}

.quiz-options button:hover {
  border-color: #0f172a;
  background: #eef2ff;
  transform: translateY(-1px);
}

.quiz-options button:disabled {
  cursor: not-allowed;
  opacity: 0.7;
}

.quiz-progress {
  margin-top: 1.2rem;
}

.quiz-progress-text {
  font-weight: 600;
  margin-bottom: 0.35rem;
}

.quiz-progress-track {
  height: 10px;
  border-radius: 999px;
  background: #e5e7eb;
  overflow: hidden;
}

.quiz-progress-bar {
  height: 100%;
  width: 0%;
  background: linear-gradient(90deg, #ef4444, #f97316);
  transition: width 0.25s ease;
}

.quiz-results {
  margin-top: 1rem;
  border-top: 1px solid #e5e7eb;
  padding-top: 1rem;
}

.quiz-results h3 {
  margin: 0 0 0.35rem 0;
}

.quiz-score {
  font-size: 1.1rem;
  margin-bottom: 0.5rem;
}

.quiz-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
  gap: 0.6rem;
}

.result-item {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.6rem 0.75rem;
  border-radius: 10px;
  border: 1px solid #e5e7eb;
  background: #f8fafc;
  font-weight: 600;
}

.result-item.correct {
  border-color: #16a34a;
  background: #ecfdf3;
}

.result-item.correct::after {
  content: "\\2713";
  color: #16a34a;
}

.result-item.incorrect {
  border-color: #dc2626;
  background: #fef2f2;
}

.result-item.incorrect::after {
  content: "\\2717";
  color: #dc2626;
}

.quiz-restart {
  margin-top: 0.75rem;
  display: inline-flex;
  align-items: center;
  gap: 0.35rem;
  padding: 0.65rem 0.95rem;
  background: #0f172a;
  color: #fff;
  border: none;
  border-radius: 10px;
  cursor: pointer;
}

@media (max-width: 640px) {
  .quiz-shell {
    padding: 1rem;
  }

  .quiz-options button {
    font-size: 0.95rem;
  }
}
</style>

<script>
(() => {
  const fullQuestions = [
    { question: "Which tool is the graphical desktop program used to explore, configure, and test Inertial Sense products in real time?", correct: "EvalTool", distractors: ["CLTool", "SDK", "Log Inspector"], source: "getting-started/Overview.md" },
    { question: "According to Getting Started, which tool must be compiled from source?", correct: "CLTool", distractors: ["EvalTool", "Log Inspector", "Reflow utility"], source: "getting-started/Overview.md" },
    { question: "How do you obtain the SDK code libraries and example projects?", correct: "Download the \"Source code\" asset from the releases page", distractors: ["Install via pip with inertialsense-sdk", "Request an email package from support", "Clone the firmware repo submodule"], source: "getting-started/Overview.md" },
    { question: "In the RTK Rover guide, which EvalTool menu path enables Rover Mode?", correct: "Settings > GPS > Rover > RTK", distractors: ["Data Sets > INS > Rover", "Diagnostics > GNSS > RTK", "System > Network > RTK"], source: "user-manual/gnss/rtk_rover.md" },
    { question: "When setting Rover Mode in EvalTool, what do you change the first dropdown to?", correct: "Positioning (GPS1) or the matching F9P option", distractors: ["Desired log file format", "UART port number", "Mount point for NTRIP"], source: "user-manual/gnss/rtk_rover.md" },
    { question: "Which CLTool argument configures the unit as a rover by writing flash config?", correct: "-flashConfig=rtkCfgBits=0x01", distractors: ["-roverMode=1", "-presetINS", "-setRover"], source: "user-manual/gnss/rtk_rover.md" },
    { question: "How does the IMX treat base correction data arriving at its ports?", correct: "It automatically parses data arriving at any port and recognizes base corrections", distractors: ["It only accepts corrections on USB", "It ignores corrections unless set to RTK Base mode", "It requires manual parsing via SDK API"], source: "user-manual/gnss/rtk_rover.md" },
    { question: "What baud rate does the Digi Xbee Pro SX module on the EVB-2 use?", correct: "115200", distractors: ["57600", "921600", "230400"], source: "user-manual/gnss/rtk_rover.md" },
    { question: "In EVB-2 rover setup, what should cbPreset be set to in DID_EVB_FLASH_CFG to enable the radio?", correct: "0x3", distractors: ["0x1", "0x7", "0x0"], source: "user-manual/gnss/rtk_rover.md" },
    { question: "In EVB-2 rover setup, what output power does radioPowerLevel value 0 correspond to?", correct: "20 dBm", distractors: ["27 dBm", "30 dBm", "10 dBm"], source: "user-manual/gnss/rtk_rover.md" },
    { question: "When configuring the Rover NTRIP client in EvalTool, which correction formats can you select?", correct: "RTCM3 or UBLOX", distractors: ["CAN or SPI", "NMEA or AIS", "Proprietary binary only"], source: "user-manual/gnss/rtk_rover.md" },
    { question: "What is the default serial baud rate used by CLTool if -baud is not specified?", correct: "921600", distractors: ["115200", "460800", "230400"], source: "user-manual/software/cltool.md" },
    { question: "What does the -lm flag do in CLTool?", correct: "Listen mode for ISB that disables device validation and skips the stop-broadcast command on start", distractors: ["Locks magnetometer calibration", "Limits maximum INS update rate", "Logs messages to memory"], source: "user-manual/software/cltool.md" },
    { question: "What does the -dboc flag do in CLTool?", correct: "Sends a stop-broadcast command ($STPB) on close", distractors: ["Disables binary output conversion", "Drops bandwidth on connection", "Delays boot output capture"], source: "user-manual/software/cltool.md" },
    { question: "If you enable logging without setting -lp, where does CLTool store log files by default?", correct: "./IS_logs", distractors: ["/tmp/is_logs", "~/Downloads", "logs/current"], source: "user-manual/software/cltool.md" },
    { question: "Which flag forces a bootloader update regardless of version when updating firmware with CLTool?", correct: "-fb", distractors: ["-forceBL", "-bootforce", "-fbldr"], source: "user-manual/software/cltool.md" },
    { question: "Which flag runs verification after an application firmware update in CLTool?", correct: "-uv", distractors: ["-verifyApp", "-va", "-checkfw"], source: "user-manual/software/cltool.md" },
    { question: "Before compiling CLTool on Linux or Mac, which tool must be installed?", correct: "CMake", distractors: ["Node.js", "GDB", "Docker"], source: "user-manual/software/cltool.md" },
    { question: "For the IMX-6 module, what should you do with VBKUP (pin 3) if no backup battery is used?", correct: "Connect VBKUP to VCC so the module performs a cold start on power-up", distractors: ["Leave VBKUP floating to save power", "Tie VBKUP to ground", "Connect VBKUP to GPIO5"], source: "user-manual/hardware/module_imx6.md" },
    { question: "How do you enable the SPI interface on the IMX-6?", correct: "Hold pin 10 low during boot", distractors: ["Short pins 6 and 7 during boot", "Send an SPI enable command over UART", "Tie pin 20 high at reset"], source: "user-manual/hardware/module_imx6.md" },
    { question: "What happens if the IMX-6 BOOT_MODE pin (pin 17) is driven high?", correct: "It reboots into ROM bootloader (DFU) mode", distractors: ["It enters low-power sleep", "It forces GNSS PPS output", "It disables USB enumeration"], source: "user-manual/hardware/module_imx6.md" },
    { question: "What is pin 20 (G15/GNSS_PPS) used for on the IMX-6?", correct: "Input for GNSS PPS time synchronization pulse", distractors: ["3.3V power input", "USB data line", "CAN transceiver enable"], source: "user-manual/hardware/module_imx6.md" },
    { question: "What voltage is required on VUSB (pin 30) of the IMX-6 for USB operation?", correct: "3.0V to 3.6V", distractors: ["1.2V", "5.0V", "2.4V to 2.8V"], source: "user-manual/hardware/module_imx6.md" },
    { question: "Where should the recommended 100nF decoupling capacitor be placed on the IMX-6 PCB?", correct: "Between pins 21 (GND) and 22 (VCC), close to the module on the same PCB side", distractors: ["Between pins 1 and 2 near the USB lines", "Across pins 28 and 29 only", "Between VBKUP and ground with long vias"], source: "user-manual/hardware/module_imx6.md" },
    { question: "What packaging options are available for IMX-6 modules?", correct: "Cut tape as well as tape and reel", distractors: ["Loose bulk bags only", "Through-hole trays only", "Wafer-level tape only"], source: "user-manual/hardware/module_imx6.md" },
    { question: "Which CLTool option lists discovered device ports?", correct: "-list-devices", distractors: ["-devices", "-ports", "-scan"], source: "user-manual/software/cltool.md" },
    { question: "Which CLTool flag disables device validation so ports remain open?", correct: "-vd", distractors: ["-validateOff", "-novalidate", "-keepopen"], source: "user-manual/software/cltool.md" },
    { question: "Which option sets the serial port baud rate in CLTool?", correct: "-baud=BAUDRATE", distractors: ["-speed=BAUDRATE", "-bps=BAUDRATE", "-serialrate=BAUDRATE"], source: "user-manual/software/cltool.md" },
    { question: "Which CLTool option issues a software reset?", correct: "-reset", distractors: ["-reboot", "-boot", "-softreset"], source: "user-manual/software/cltool.md" },
    { question: "Which CLTool option scrolls displayed messages to show history?", correct: "-s", distractors: ["-scroll", "-history", "-tail"], source: "user-manual/software/cltool.md" },
    { question: "Which CLTool flag enables quiet mode with no display?", correct: "-q", distractors: ["-quietmode", "-silent", "-mute"], source: "user-manual/software/cltool.md" },
    { question: "Which CLTool option displays statistics of data received?", correct: "-stats", distractors: ["-metrics", "-report", "-summary"], source: "user-manual/software/cltool.md" },
    { question: "Which option recalibrates magnetometers with 0=multi-axis and 1=single-axis?", correct: "-magRecal[n]", distractors: ["-magCal", "-recalMag", "-magReset"], source: "user-manual/software/cltool.md" },
    { question: "Which flag runs listen mode for NMEA without sending the stop-broadcast command on start?", correct: "-nmea", distractors: ["-nmeaListen", "-nmeaOnly", "-nmeaMode"], source: "user-manual/software/cltool.md" },
    { question: "Which argument runs a survey-in and stores base position to refLla?", correct: "-survey=[s],[d]", distractors: ["-surveyIn", "-surveyStart", "-svy"], source: "user-manual/software/cltool.md" },
    { question: "Which CLTool option streams and allows editing one dataset?", correct: "-edit [DID#<=PERIODMULT>]", distractors: ["-streamEdit", "-editDid", "-editStream"], source: "user-manual/software/cltool.md" },
    { question: "Which CLTool option prints the list of all DID datasets?", correct: "-dids", distractors: ["-listDids", "-didlist", "-showdids"], source: "user-manual/software/cltool.md" },
    { question: "Which CLTool option saves current streams as persistent messages enabled on startup?", correct: "-persistent", distractors: ["-saveStreams", "-persistStreams", "-keepStreams"], source: "user-manual/software/cltool.md" },
    { question: "Which preset flag enables INS data streaming in CLTool?", correct: "-presetINS", distractors: ["-presetINS1", "-insPreset", "-insStream"], source: "user-manual/software/cltool.md" },
    { question: "Which preset flag enables IMX post processing data (PPD) streaming in CLTool?", correct: "-presetPPD", distractors: ["-ppdPreset", "-presetPPD1", "-ppdStream"], source: "user-manual/software/cltool.md" },
    { question: "Which preset flag enables GPX post processing data streaming in CLTool?", correct: "-presetGPXPPD", distractors: ["-presetGPX", "-gpxPpd", "-ppdGPX"], source: "user-manual/software/cltool.md" },
    { question: "Which CLTool argument configures the device as an RTK Base server to send corrections?", correct: "-base=[IP]:[port]", distractors: ["-serveBase", "-baseMode", "-rtkBase"], source: "user-manual/software/cltool.md" },
    { question: "Which CLTool argument specifies where Rover corrections come from (type, protocol, address)?", correct: "-rover=[type]:[protocol]:[address]:[port]...", distractors: ["-roverMode=[type]", "-roverSource=[addr]", "-roverCfg=[param]"], source: "user-manual/software/cltool.md" },
    { question: "Which CLTool option returns values of dataset(s) using YAML input?", correct: "-get \"{DID: {field}}\"", distractors: ["-fetch", "-readDid", "-pullDid"], source: "user-manual/software/cltool.md" },
    { question: "Which CLTool option sets values of dataset(s) using YAML input?", correct: "-set \"{DID: {field: value}}\"", distractors: ["-writeDid", "-pushDid", "-updateDid"], source: "user-manual/software/cltool.md" },
    { question: "Which CLTool argument streams one or more datasets with optional period multiplier?", correct: "-did [DID#<=PERIODMULT> ...]", distractors: ["-streamDid", "-didStream", "-periodDid"], source: "user-manual/software/cltool.md" },
    { question: "Which CLTool flag enables logging?", correct: "-lon", distractors: ["-logon", "-logging", "-enablelog"], source: "user-manual/software/cltool.md" },
    { question: "Which CLTool flag selects the log file type?", correct: "-lt=LOG_TYPE", distractors: ["-logtype=", "-type=", "-logformat="], source: "user-manual/software/cltool.md" },
    { question: "Which CLTool option sets the path where log files are written?", correct: "-lp DIRECTORY", distractors: ["-logpath", "-outdir", "-logdir"], source: "user-manual/software/cltool.md" },
    { question: "Which log types are valid values for -lt?", correct: "raw, dat, or csv", distractors: ["txt, bin, or xml", "json, yaml, or csv", "pcap, txt, or bin"], source: "user-manual/software/cltool.md" },
    { question: "Which log type is the default when using CLTool logging?", correct: "dat", distractors: ["raw", "csv", "kml"], source: "user-manual/software/cltool.md" },
    { question: "What does the raw log type capture?", correct: "Byte-for-byte data received over serial in native packet formats", distractors: ["Only decoded INS messages", "Only GNSS RTCM corrections", "Only CSV rows for IMU"], source: "user-manual/software/cltool.md" },
    { question: "What does the dat log type contain?", correct: "InertialSense binary DID data sets grouped in serial order for post processing", distractors: ["Plain text console output", "Only NMEA sentences", "Only firmware update logs"], source: "user-manual/software/cltool.md" },
    { question: "What does the csv log type produce?", correct: "Comma-separated values text arranged in rows and columns", distractors: ["Encrypted binary blobs", "Hex dumps of packets", "SQLite database files"], source: "user-manual/software/cltool.md" },
    { question: "In the raw logging example, which flag sets the output directory to /media/usbdrive/data?", correct: "-lp /media/usbdrive/data", distractors: ["-out=/media/usbdrive/data", "-dir /media/usbdrive/data", "-save=/media/usbdrive/data"], source: "user-manual/software/cltool.md" },
    { question: "What file extension is used for a firmware package file in CLTool?", correct: ".fpkg", distractors: [".hex", ".bin", ".pkg"], source: "user-manual/software/cltool.md" },
    { question: "What benefit does the firmware package method provide?", correct: "Updates multiple devices such as an IMX-GPX pair in one process", distractors: ["It removes the need for a serial port", "It disables bootloader checks", "It only updates the bootloader"], source: "user-manual/software/cltool.md" },
    { question: "What current limitation is noted for firmware package updates?", correct: "Updating the IMX firmware using a package is not yet supported", distractors: ["Packages only work on Windows", "Packages require Wi-Fi", "Packages erase user settings"], source: "user-manual/software/cltool.md" },
    { question: "Which products are supported by the legacy single firmware file update method?", correct: "IMX-5 and earlier products such as uINS-3 and EVB-2", distractors: ["Only IMX-6", "Only GPX-1", "Only Rugged-2"], source: "user-manual/software/cltool.md" },
    { question: "Which optional flag supplies the bootloader firmware file during legacy update?", correct: "-ub [BL_FILEPATH]", distractors: ["-boot [BL_FILEPATH]", "-bl [BL_FILEPATH]", "-bootloader [BL_FILEPATH]"], source: "user-manual/software/cltool.md" },
    { question: "Which baud rates are allowed for firmware updates according to the guide?", correct: "300000, 921600, 460800, 230400, 115200", distractors: ["9600, 19200, 38400 only", "1M only", "Any baud rate works"], source: "user-manual/software/cltool.md" },
    { question: "After building CLTool on Linux/Mac, how do you run it from the build directory?", correct: "./cltool", distractors: ["make run", "python cltool.py", "cmake --run"], source: "user-manual/software/cltool.md" },
    { question: "On Linux, which groups might you add your user to for serial port access?", correct: "dialout and plugdev", distractors: ["sudo and tty", "adm and wheel", "gpio and users"], source: "user-manual/software/cltool.md" },
    { question: "In Windows CMake (CL) instructions, which command builds the project from the build directory?", correct: "cmake --build .", distractors: ["make", "nmake build", "msbuild cltool.sln"], source: "user-manual/software/cltool.md" },
    { question: "After building CLTool on Windows with CMake, from where do you run the executable?", correct: "From the Release (or Debug) directory", distractors: ["From the source root", "From Program Files", "From Documents"], source: "user-manual/software/cltool.md" },
    { question: "Where do you set command line arguments in Visual Studio for CLTool?", correct: "Configuration Properties -> Debugging -> Command Arguments", distractors: ["Build -> Build Events", "Tools -> Options -> CMake", "Project -> Properties -> General"], source: "user-manual/software/cltool.md" },
    { question: "What directory do you create before running cmake .. when building CLTool?", correct: "A build directory inside cltool (e.g., mkdir build)", distractors: ["A src directory", "A dist directory", "A docs directory"], source: "user-manual/software/cltool.md" },
    { question: "When building CLTool, where do you run cmake .. from?", correct: "From inside the build directory", distractors: ["From the repository root", "From the SDK folder", "From the bin directory"], source: "user-manual/software/cltool.md" },
    { question: "For TCP/IP base corrections in EvalTool, what Correction Input type should you select?", correct: "TCP", distractors: ["Serial", "NTRIP", "CAN"], source: "user-manual/gnss/rtk_rover.md" },
    { question: "For TCP/IP base corrections, which formats can you choose in EvalTool?", correct: "ublox or RTCM3", distractors: ["NMEA or AIS", "CAN or SPI", "CSV or JSON"], source: "user-manual/gnss/rtk_rover.md" },
    { question: "In the NTRIP client setup, which field specifies the caster mount point?", correct: "Mount Point", distractors: ["Station ID", "Link Name", "Channel"], source: "user-manual/gnss/rtk_rover.md" },
    { question: "In the NTRIP client setup, which field holds the caster address and port?", correct: "Address:Port", distractors: ["Server URL only", "Hostname only", "Port only"], source: "user-manual/gnss/rtk_rover.md" },
    { question: "How do you configure the EVB-2 radio quickly on the rover?", correct: "Press the CONFIG switch until the light is blue", distractors: ["Hold reset for 10 seconds", "Short pins 1 and 2", "Cycle power three times"], source: "user-manual/gnss/rtk_rover.md" },
    { question: "For EVB-2 rover setup, how should radioPID and radioNID be set?", correct: "Match the values used by the base radio", distractors: ["Set both to zero", "Set random values for each device", "Set radioPID only"], source: "user-manual/gnss/rtk_rover.md" },
    { question: "How many WiFi networks can EVB2 store when connecting to TCP/IP base?", correct: "Up to 3 networks (Wifi[0], Wifi[1], Wifi[2])", distractors: ["One network only", "Two networks", "Unlimited networks"], source: "user-manual/gnss/rtk_rover.md" },
    { question: "What should you do with IMX-6 pin 0?", correct: "Connect it to ground because it is not connected internally", distractors: ["Leave it floating for antenna detect", "Tie it to VUSB", "Use it as a GPIO output"], source: "user-manual/hardware/module_imx6.md" },
    { question: "What is IMX-6 pin 1 (USB_P)?", correct: "USB Data Positive line", distractors: ["USB Data Negative line", "Power input", "CAN transmit line"], source: "user-manual/hardware/module_imx6.md" },
    { question: "What is IMX-6 pin 2 (USB_N)?", correct: "USB Data Negative line", distractors: ["USB Data Positive line", "Reset line", "CAN receive line"], source: "user-manual/hardware/module_imx6.md" },
    { question: "What is IMX-6 pin 3 (VBKUP)?", correct: "GNSS backup supply 1.4V to 3.6V; connect to VCC if no backup battery", distractors: ["5V main supply", "Ground reference", "SPI chip select"], source: "user-manual/hardware/module_imx6.md" },
    { question: "Which IMX-6 pin hosts GPIO1 / Serial 2 input / CAN RX / I2C SCL?", correct: "Pin 4 (G1/Rx2/RxCAN/SCL)", distractors: ["Pin 5", "Pin 6", "Pin 7"], source: "user-manual/hardware/module_imx6.md" },
    { question: "Which IMX-6 pin hosts GPIO2 / Serial 2 output / CAN TX / I2C SDA / Strobe?", correct: "Pin 5 (G2/Tx2/TxCAN/SDA/STROBE)", distractors: ["Pin 4", "Pin 6", "Pin 8"], source: "user-manual/hardware/module_imx6.md" },
    { question: "Which IMX-6 pin is GPIO6 / Serial 1 input / SPI MOSI?", correct: "Pin 6", distractors: ["Pin 7", "Pin 8", "Pin 9"], source: "user-manual/hardware/module_imx6.md" },
    { question: "Which IMX-6 pin is GPIO7 / Serial 1 output / SPI MISO?", correct: "Pin 7", distractors: ["Pin 6", "Pin 8", "Pin 9"], source: "user-manual/hardware/module_imx6.md" },
    { question: "Which IMX-6 pin is GPIO8 / SPI CS / Strobe input?", correct: "Pin 8", distractors: ["Pin 7", "Pin 9", "Pin 10"], source: "user-manual/hardware/module_imx6.md" },
    { question: "Which IMX-6 pin is GPIO5 / SPI SCLK / Strobe input?", correct: "Pin 9", distractors: ["Pin 8", "Pin 10", "Pin 11"], source: "user-manual/hardware/module_imx6.md" },
    { question: "Which IMX-6 pin provides nSPI_EN / STROBE_OUT / DRDY functions along with GPIO9?", correct: "Pin 10", distractors: ["Pin 12", "Pin 15", "Pin 20"], source: "user-manual/hardware/module_imx6.md" },
    { question: "Which IMX-6 pins are ground?", correct: "Pins 11, 21, and pad P", distractors: ["Pins 1 and 2", "Pins 20 and 22", "Pins 28 and 29"], source: "user-manual/hardware/module_imx6.md" },
    { question: "What is IMX-6 pin 12?", correct: "nRESET; logic low resets the system", distractors: ["SPI chip select", "I2C SDA", "USB enable"], source: "user-manual/hardware/module_imx6.md" },
    { question: "Which IMX-6 pin carries SWCLK (G14)?", correct: "Pin 13", distractors: ["Pin 14", "Pin 15", "Pin 16"], source: "user-manual/hardware/module_imx6.md" },
    { question: "Which IMX-6 pin is DRDY/XSDA and can serve as alternate I2C SDA?", correct: "Pin 14", distractors: ["Pin 13", "Pin 15", "Pin 16"], source: "user-manual/hardware/module_imx6.md" },
    { question: "Which IMX-6 pin is G12/SWO/XSCL and can serve as alternate I2C SCL?", correct: "Pin 15", distractors: ["Pin 14", "Pin 16", "Pin 10"], source: "user-manual/hardware/module_imx6.md" },
    { question: "Which IMX-6 pin is G11/SWDIO?", correct: "Pin 16", distractors: ["Pin 13", "Pin 14", "Pin 15"], source: "user-manual/hardware/module_imx6.md" },
    { question: "Which IMX-6 pin is GPIO4 / Serial 0 input (Rx0)?", correct: "Pin 18", distractors: ["Pin 19", "Pin 6", "Pin 7"], source: "user-manual/hardware/module_imx6.md" },
    { question: "Which IMX-6 pin is GPIO3 / Serial 0 output (Tx0)?", correct: "Pin 19", distractors: ["Pin 18", "Pin 6", "Pin 7"], source: "user-manual/hardware/module_imx6.md" },
    { question: "What is IMX-6 pin 22?", correct: "VCC 3.3V supply input", distractors: ["USB 5V input", "Ground", "Backup battery input"], source: "user-manual/hardware/module_imx6.md" },
    { question: "Which IMX-6 pin is QDEC0.A (wheel sensor 0 channel A input)?", correct: "Pin 28", distractors: ["Pin 29", "Pin 31", "Pin 32"], source: "user-manual/hardware/module_imx6.md" },
    { question: "Which IMX-6 pin is QDEC0.B (wheel sensor 0 channel B input)?", correct: "Pin 29", distractors: ["Pin 28", "Pin 31", "Pin 32"], source: "user-manual/hardware/module_imx6.md" },
    { question: "Which IMX-6 pin is QDEC1.A (wheel sensor 1 channel A input)?", correct: "Pin 31", distractors: ["Pin 32", "Pin 28", "Pin 29"], source: "user-manual/hardware/module_imx6.md" },
    { question: "Which IMX-6 pin is QDEC1.B (wheel sensor 1 channel B input)?", correct: "Pin 32", distractors: ["Pin 31", "Pin 28", "Pin 29"], source: "user-manual/hardware/module_imx6.md" },
    { question: "Where can you find open source hardware design files and 3D models for the IMX module?", correct: "In the Inertial Sense Hardware Design repository on GitHub", distractors: ["Only on the product CD", "They are not available", "Inside the firmware package"], source: "user-manual/hardware/module_imx6.md" }
  ];

  function shuffle(arr) {
    const a = [...arr];
    for (let i = a.length - 1; i > 0; i -= 1) {
      const j = Math.floor(Math.random() * (i + 1));
      [a[i], a[j]] = [a[j], a[i]];
    }
    return a;
  }

  function prepareQuestion(base) {
    const options = shuffle([base.correct, ...base.distractors]);
    const answer = options.indexOf(base.correct);
    return { ...base, options, answer };
  }

  function pickQuestions() {
    return shuffle([...fullQuestions]).slice(0, 25).map(prepareQuestion);
  }

  const state = {
    index: 0,
    score: 0,
    answers: [],
    questions: pickQuestions()
  };

  const els = {
    question: document.getElementById("question-text"),
    options: document.getElementById("options"),
    progressBar: document.getElementById("progress-bar"),
    progressText: document.getElementById("progress-text"),
    counter: document.getElementById("question-counter"),
    feedback: document.getElementById("feedback"),
    results: document.getElementById("results")
  };

  function updateProgress() {
    const total = state.questions.length;
    const current = Math.min(state.index + 1, total);
    const percent = (current / total) * 100;
    els.progressBar.style.width = `${percent}%`;
    els.progressText.textContent = state.index < total
      ? `Question ${current} of ${total}`
      : `Quiz complete (${state.score}/${total})`;
    els.counter.textContent = state.index < total
      ? `Q${current}`
      : "Done";
  }

  function renderQuestion() {
    const total = state.questions.length;
    if (state.index >= total) {
      return showResults();
    }

    const q = state.questions[state.index];
    els.question.textContent = q.question;
    els.feedback.textContent = "";
    els.feedback.className = "quiz-feedback";

    els.options.innerHTML = "";
    q.options.forEach((opt, idx) => {
      const btn = document.createElement("button");
      btn.type = "button";
      btn.textContent = opt;
      btn.addEventListener("click", () => handleAnswer(idx));
      els.options.appendChild(btn);
    });

    updateProgress();
  }

  function handleAnswer(selectedIdx) {
    const q = state.questions[state.index];
    const isCorrect = selectedIdx === q.answer;
    state.answers[state.index] = isCorrect;
    if (isCorrect) {
      state.score += 1;
    }

    els.feedback.textContent = isCorrect ? "Correct" : "Incorrect";
    els.feedback.className = `quiz-feedback ${isCorrect ? "correct" : "incorrect"}`;

    disableButtons();
    setTimeout(() => {
      state.index += 1;
      renderQuestion();
    }, 450);
  }

  function disableButtons() {
    const buttons = els.options.querySelectorAll("button");
    buttons.forEach((btn) => (btn.disabled = true));
  }

  function showResults() {
    els.question.textContent = "Quiz complete";
    els.options.innerHTML = "";
    els.feedback.textContent = "";
    els.counter.textContent = "Done";

    els.results.hidden = false;
    els.results.innerHTML = "";

    const score = document.createElement("div");
    score.className = "quiz-score";
    score.textContent = `Final score: ${state.score} / ${total}`;

    const heading = document.createElement("h3");
    heading.textContent = "Per-question results";

    const grid = document.createElement("div");
    grid.className = "quiz-grid";

    state.answers.forEach((correct, idx) => {
      const item = document.createElement("div");
      item.className = `result-item ${correct ? "correct" : "incorrect"}`;
      item.textContent = `Question ${idx + 1}`;
      grid.appendChild(item);
    });

    const restart = document.createElement("button");
    restart.className = "quiz-restart";
    restart.type = "button";
    restart.textContent = "Restart quiz";
    restart.addEventListener("click", resetQuiz);

    els.results.append(score, heading, grid, restart);
    state.index = total;
    updateProgress();
  }

  function resetQuiz() {
    state.index = 0;
    state.score = 0;
    state.answers = [];
    state.questions = pickQuestions();
    els.results.hidden = true;
    renderQuestion();
  }

  renderQuestion();
})();
</script>
