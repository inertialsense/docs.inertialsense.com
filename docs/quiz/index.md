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

.quiz-review {
  margin-top: 1rem;
  border-top: 1px solid #e5e7eb;
  padding-top: 0.75rem;
}

.review-list {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
  margin-bottom: 0.75rem;
}

.review-button {
  padding: 0.45rem 0.7rem;
  border-radius: 8px;
  border: 1px solid #e5e7eb;
  background: #f8fafc;
  cursor: pointer;
  font-weight: 600;
}

.review-button.correct {
  border-color: #16a34a;
  color: #166534;
  background: #ecfdf3;
}

.review-button.incorrect {
  border-color: #dc2626;
  color: #991b1b;
  background: #fef2f2;
}

.review-panel {
  border: 1px solid #e5e7eb;
  border-radius: 10px;
  padding: 0.75rem;
  background: #fff;
}

.review-question {
  font-weight: 700;
  margin-bottom: 0.5rem;
}

.review-meta {
  font-size: 0.9rem;
  color: #4b5563;
  margin-bottom: 0.5rem;
}

.review-options {
  display: grid;
  gap: 0.45rem;
}

.review-option {
  padding: 0.6rem 0.75rem;
  border-radius: 8px;
  border: 1px solid #e5e7eb;
  background: #f8fafc;
}

.review-option.correct {
  border-color: #16a34a;
  background: #ecfdf3;
  font-weight: 700;
}

.review-option.selected:not(.correct) {
  border-color: #dc2626;
  background: #fef2f2;
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
  const contentQuestions = [
    { question: "Which tool is the graphical desktop program used to explore, configure, and test Inertial Sense products in real time?", correct: "EvalTool", distractors: ["CLTool", "SDK", "Log Inspector"], source: "getting-started/Overview.md" },
    { question: "According to Getting Started, which tool must be compiled from source?", correct: "CLTool", distractors: ["EvalTool", "Log Inspector", "Reflow utility"], source: "getting-started/Overview.md" },
    { question: "How do you obtain the SDK code libraries and example projects?", correct: "Download the \"Source code\" asset from the releases page", distractors: ["Install via pip with inertialsense-sdk", "Request an email package from support", "Clone the firmware repo submodule"], source: "getting-started/Overview.md" },
    { question: "In the RTK Rover guide, which EvalTool menu path enables Rover Mode?", correct: "Settings > GPS > Rover > RTK", distractors: ["Data Sets > INS > Rover", "Diagnostics > GNSS > RTK", "System > Network > RTK"], source: "user-manual/gnss/rtk_rover.md" },
    { question: "When setting Rover Mode in EvalTool, what do you change the first dropdown to?", correct: "Positioning (GPS1) or the matching F9P option", distractors: ["Desired log file format", "UART port number", "Mount point for NTRIP"], source: "user-manual/gnss/rtk_rover.md" },
    { question: "Which CLTool argument configures the unit as a rover by writing flash config?", correct: "-flashConfig=rtkCfgBits=0x01", distractors: ["-roverMode=1", "-presetINS", "-setRover"], source: "user-manual/gnss/rtk_rover.md" },
    { question: "How does the IMX treat base correction data arriving at its ports?", correct: "It automatically parses data arriving at any port and recognizes base corrections", distractors: ["It only accepts corrections on USB", "It ignores corrections unless set to RTK Base mode", "It requires manual parsing via SDK API"], source: "user-manual/gnss/rtk_rover.md" },
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
    { question: "What voltage is required on VUSB (pin 30) of the IMX-6 for USB operation?", correct: "3.0V to 3.6V", distractors: ["1.2V", "5.0V", "2.4V to 2.8V"], source: "user-manual/hardware/module_imx6.md" },
    { question: "Where should the recommended 100nF decoupling capacitor be placed on the IMX-6 PCB?", correct: "Between pins 21 (GND) and 22 (VCC), close to the module on the same PCB side", distractors: ["Between pins 1 and 2 near the USB lines", "Across pins 28 and 29 only", "Between VBKUP and ground with long vias"], source: "user-manual/hardware/module_imx6.md" },
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
    { question: "For IMX-5, what should you do with VBKUP (pin 3) if no backup battery is used?", correct: "Connect VBKUP to VCC so the module performs a cold start on power-up", distractors: ["Leave VBKUP floating", "Tie VBKUP to ground", "Connect VBKUP to GPIO5"], source: "user-manual/hardware/module_imx5.md" },
    { question: "How is SPI enabled on the IMX-5 module?", correct: "Hold pin 10 (G9/nSPI_EN) low during boot", distractors: ["Short pins 6 and 7 during boot", "Send an SPI enable command over UART", "Tie pin 20 high at reset"], source: "user-manual/hardware/module_imx5.md" },
    { question: "Where should the recommended 100nF decoupling capacitor be placed on the IMX-5 PCB?", correct: "Between pins 21 (GND) and 22 (VCC), close to the module on the same PCB side", distractors: ["Between pins 1 and 2 near USB", "Across pins 28 and 29 only", "Between VBKUP and ground with vias"], source: "user-manual/hardware/module_imx5.md" },
    { question: "What happens if IMX-5 BOOT_MODE (pin 17) is driven high?", correct: "It reboots into the ROM bootloader (DFU) mode", distractors: ["It enters low-power sleep", "It forces GNSS PPS output", "It disables USB enumeration"], source: "user-manual/hardware/module_imx5.md" },
    { question: "What packaging options are available for IMX-5 modules?", correct: "Cut tape as well as tape and reel", distractors: ["Loose bulk bags only", "Through-hole trays only", "Wafer-level tape only"], source: "user-manual/hardware/module_imx5.md" },
    { question: "What backup supply requirement is noted for GPX-1 VBKUP (pin 3)?", correct: "Connect to a backup battery or VCC; 1.75V to 3.6V input", distractors: ["Leave floating for hot start", "Tie to ground", "Use 5V supply only"], source: "user-manual/hardware/module_gpx1.md" },
    { question: "How do you inject DC power to GNSS RF ports on GPX-1?", correct: "Connect VCC_RF through a 33-120nH inductor to GNSS1_RF/GNSS2_RF", distractors: ["Directly tie VCC to GNSS_RF", "Use a series resistor only", "Enable via USB"], source: "user-manual/hardware/module_gpx1.md" },
    { question: "What supply range should be provided on VAUX for GPX-1 when USB or VCC_RF is needed?", correct: "3.0V to 3.6V (typically +3.3V)", distractors: ["1.8V to 2.0V", "4.5V to 5.5V", "12V"], source: "user-manual/hardware/module_gpx1.md" },
    { question: "How can you disable the GPX-1 active antenna supply VCC_RF?", correct: "Set GPX_SYS_CFG_BITS_DISABLE_VCC_RF (0x00000001) in DID_GPX_FLASH_CFG.sysCfgBits", distractors: ["Remove the inductor", "Short GNSS_RF to ground", "Lower VBKUP voltage"], source: "user-manual/hardware/module_gpx1.md" },
    { question: "What GNSS antenna requirement is emphasized for GPX-1?", correct: "Active antenna(s) are required for the GPX-1", distractors: ["Passive patch antennas only", "No antenna needed", "Loop antenna only"], source: "user-manual/hardware/module_gpx1.md" },
    { question: "What soldering guidance is given for the uINS-3 module?", correct: "Hand solder only; reflow may damage the module", distractors: ["Standard reflow is recommended", "Wave soldering is required", "Hot-air rework only"], source: "user-manual/hardware/module_uins3.md" },
    { question: "What should you do with GPS_VBAT on uINS-3 if no backup battery is used?", correct: "Connect GPS_VBAT to VCC for cold start on power-up", distractors: ["Leave it floating", "Tie it to ground", "Tie it to USB 5V"], source: "user-manual/hardware/module_uins3.md" },
    { question: "How is SPI enabled on the uINS-3 module?", correct: "Hold pin 10 (G9/nSPI_EN) low during boot", distractors: ["Pull pin 3 high", "Send an SPI unlock command", "Short pins 6 and 7"], source: "user-manual/hardware/module_uins3.md" },
    { question: "What is the warning about pin 17 (CE) on uINS-3?", correct: "Driving it high erases all IMX flash, including calibration data", distractors: ["It disables SPI permanently", "It forces sleep mode", "It reboots to bootloader without erasing"], source: "user-manual/hardware/module_uins3.md" },
    { question: "Where should the 100nF decoupling capacitor be placed for uINS-3?", correct: "Between VCC and GND close to the module on the same PCB side", distractors: ["Across USB lines", "Across PPS and ground", "Between VBAT and ground with vias"], source: "user-manual/hardware/module_uins3.md" },
    { question: "What is the easiest interface for basic EVB-1 evaluation?", correct: "Connect the micro USB port to use the onboard FTDI for power and comms", distractors: ["Use CAN only", "Use RS485 only", "Use the RS232 DB9 first"], source: "user-manual/hardware/EVB1.md" },
    { question: "What power warning is noted for EVB-1 header supplies?", correct: "Do NOT power VIN and 3.3V simultaneously", distractors: ["Never power from USB", "Only power from VIN", "3.3V must exceed 5V"], source: "user-manual/hardware/EVB1.md" },
    { question: "Where do you connect a GNSS antenna on EVB-1 when using GPS?", correct: "To the onboard SMA port", distractors: ["To H2", "To the micro USB", "To the RS232 DB9"], source: "user-manual/hardware/EVB1.md" },
    { question: "What header pin warning applies to EVB-1 connectors?", correct: "Header pin 1 location/order is reversed from the Molex standard", distractors: ["Pin 1 is fused", "Pins are keyed and cannot be reversed", "All pins are 5V only"], source: "user-manual/hardware/EVB1.md" },
    { question: "How do you switch EVB-1 USB between Ser0 and Ser1?", correct: "Move jumpers R8, R11, R12 together to S0 or S1", distractors: ["Flip a DIP switch", "Short pins 1 and 2 on H1", "Press the CONFIG button"], source: "user-manual/hardware/EVB1.md" },
    { question: "How do you change EVB-2 operating modes?", correct: "Press the CONFIG tactile switch until the LED shows the desired preset", distractors: ["Send a USB command only", "Move DIP switches on H1", "Power cycle three times"], source: "user-manual/hardware/EVB2.md" },
    { question: "In EVB-2 presets, what does the blue LED (cbPreset 3) configure?", correct: "XBee mode with RS232 and XBee on", distractors: ["WiFi/BLE only", "SPI bridge", "Off mode"], source: "user-manual/hardware/EVB2.md" },
    { question: "Which EVB-2 USB port is used to update EVB firmware and bridge to other buses?", correct: "EVB USB (SAME70) port", distractors: ["IMX USB port", "H7 header only", "External radio USB"], source: "user-manual/hardware/EVB2.md" },
    { question: "How do you confirm XBee radio configuration on EVB-2 after setting PID/NID?", correct: "Reset EVB-2; XBee LED flashes yellow then green on success, red on failure", distractors: ["Cycle power twice; green LED solid", "Hold CONFIG for 10s", "Only a beep indicates success"], source: "user-manual/hardware/EVB2.md" },
    { question: "What supply range does EVB-2 accept on H1 VIN?", correct: "4.5–17V", distractors: ["1.8–3.3V", "9–12V only", "24V only"], source: "user-manual/hardware/EVB2.md" },
    { question: "Where are Inertial Sense hardware design files hosted?", correct: "On the IS-hdw GitHub repository", distractors: ["Only on the docs site", "Bundled in firmware packages", "On the FTDI driver site"], source: "user-manual/hardware/hardware_design.md" },
    { question: "What resources are provided in the IS-hdw repository?", correct: "PCB schematic/layout libraries and 3D models for IMX, Rugged, EVB products", distractors: ["Only marketing brochures", "Only firmware binaries", "Only STL files without schematics"], source: "user-manual/hardware/hardware_design.md" },
    { question: "What alloy composition is recommended for reflow soldering?", correct: "Sn 95.5 / Ag 4 / Cu 0.5 (SAC405)", distractors: ["Sn 60 / Pb 40", "Sn 63 / Pb 37", "Pure tin"], source: "user-manual/hardware/reflow.md" },
    { question: "What is the recommended preheat temperature range for reflow?", correct: "150°C to 200°C", distractors: ["80°C to 120°C", "200°C to 260°C", "260°C to 300°C"], source: "user-manual/hardware/reflow.md" },
    { question: "What peak temperature is recommended in the reflow profile?", correct: "245°C", distractors: ["200°C", "217°C", "275°C"], source: "user-manual/hardware/reflow.md" },
    { question: "What oven type is recommended for reflow soldering?", correct: "Convection soldering oven for even heating and precise control", distractors: ["Infrared oven only", "Hot plate", "Microwave oven"], source: "user-manual/hardware/reflow.md" },
    { question: "Where should the IMX be placed during reflow to avoid falling off?", correct: "On the topside of the PCB", distractors: ["On the bottom side", "Suspended in air", "Edge-mounted"], source: "user-manual/hardware/reflow.md" },
    { question: "What is the simplest way to power and communicate with Rugged-1 for evaluation?", correct: "Use the included USB to Gecko connector cable (FTDI USB)", distractors: ["Use CAN bus only", "Use RS485 only", "Use PoE Ethernet"], source: "user-manual/hardware/rugged1.md" },
    { question: "How are GPS antennas connected on Rugged-1 for compassing?", correct: "Connect GPS1 to MMCX port 1 and GPS2 to MMCX port 2", distractors: ["Use one antenna only", "Swap GPS1 to port 2", "Connect to H2 header"], source: "user-manual/hardware/rugged1.md" },
    { question: "What supply inputs can power Rugged-1?", correct: "VIN (4–20V) or USB.VCC 5V", distractors: ["12V only", "3.3V only", "Mains AC only"], source: "user-manual/hardware/rugged1.md" },
    { question: "Which Rugged-1 pin function is available only on uINS-3.2 and later?", correct: "CAN on pins 11/12 (Serial2 alt)", distractors: ["USB.D+", "GPS_PPS", "VIN"], source: "user-manual/hardware/rugged1.md" },
    { question: "How do you disable FTDI USB on Rugged-1 and use TTL/RS232 on pins 7 and 9?", correct: "Power from VIN instead of USB.VCC", distractors: ["Remove pin 7", "Cut trace to PPS", "Hold reset low"], source: "user-manual/hardware/rugged1.md" },
    { question: "What are the added features of Rugged-2 compared to EVB-1?", correct: "Onboard multi-band GNSS receivers, dual antenna ports, integrated CAN", distractors: ["Ethernet and Wi-Fi only", "HDMI output", "Built-in battery"], source: "user-manual/hardware/rugged2.md" },
    { question: "How do you configure Rugged-2 I/O modes?", correct: "Set the DIP switches per the configuration table", distractors: ["Edit a config file", "Move solder jumpers only", "Use a touchscreen menu"], source: "user-manual/hardware/rugged2.md" },
    { question: "What supply voltage range does Rugged-2 accept on VIN?", correct: "4V to 20V", distractors: ["1.8V to 3.3V", "9V to 12V only", "24V only"], source: "user-manual/hardware/rugged2.md" },
    { question: "What caution is given when opening Rugged-2 to change DIP switches?", correct: "Do not flex past 90° to avoid ribbon damage; use ESD protection", distractors: ["Never remove screws", "Heat the case first", "Cut the ribbon cable"], source: "user-manual/hardware/rugged2.md" },
    { question: "For Rugged-2 dual GPS default, which dip switch is ON to route Serial0 to onboard GPS2?", correct: "Switch 8 ON by default (dual GPS units)", distractors: ["Switch 1 ON", "Switch 5 ON", "Switch 3 ON"], source: "user-manual/hardware/rugged2.md" },
    { question: "What core hardware does IG-1 include?", correct: "IMX-5 plus dual ublox ZED-F9P multi-frequency GNSS receivers", distractors: ["Only a single-band GNSS", "No GNSS receiver", "External GNSS over USB only"], source: "user-manual/hardware/IG1.md" },
    { question: "What is the easiest way to power and communicate with IG-1 for evaluation?", correct: "Use a micro-USB cable for power and USB VCP", distractors: ["Use CAN bus only", "Use RS485 only", "Use PoE Ethernet"], source: "user-manual/hardware/IG1.md" },
    { question: "Which IG-1 pins are internally tied to GPS2 ZED-F9P TX/RX?", correct: "G1 (pin 5) to GPS2 TXD and G2 (pin 6) to GPS2 RXD", distractors: ["G3/G4", "G5/G6", "G7/G8"], source: "user-manual/hardware/IG1.md" },
    { question: "How is SPI enabled on IG-1?", correct: "Hold pin 13 (G9/nSPI_EN) low during boot to enable SPI on G5-G8", distractors: ["Pull pin 3 high", "Send SPI enable over USB", "Short USB_P and USB_N"], source: "user-manual/hardware/IG1.md" },
    { question: "What backup supply guidance is given for IG-1 VBAT?", correct: "Connect VBAT (1.4–3.6V) to VCC if no backup battery is used", distractors: ["Leave VBAT floating", "Tie VBAT to ground", "Use 5V on VBAT"], source: "user-manual/hardware/IG1.md" },
    { question: "What core hardware does IG-2 include?", correct: "IMX-5 plus GPX-1 multi-frequency GNSS receiver", distractors: ["Only IMX-5 without GNSS", "Only GPX-1 without IMU", "An external GNSS over USB"], source: "user-manual/hardware/IG2.md" },
    { question: "What is the easiest way to power and communicate with IG-2 for evaluation?", correct: "Use a micro-USB cable for power and USB VCP", distractors: ["CAN bus only", "RS485 only", "PoE Ethernet"], source: "user-manual/hardware/IG2.md" },
    { question: "How is SPI enabled on IG-2?", correct: "Hold pin 13 (G9/nSPI_EN) low during boot to enable SPI on G5-G8", distractors: ["Send SPI enable over USB", "Pull VBAT high", "Short GPS.TIMEPULSE to ground"], source: "user-manual/hardware/IG2.md" },
    { question: "What warning applies to IMX BOOT_MODE on IG-2?", correct: "Driving G10/BOOT_MODE high reboots into ROM bootloader (DFU)", distractors: ["It erases flash", "It disables USB permanently", "It forces sleep mode"], source: "user-manual/hardware/IG2.md" },
    { question: "What backup supply guidance is given for IG-2 VBAT?", correct: "Connect VBAT (1.4–3.6V) to VCC if no backup battery is used", distractors: ["Leave VBAT floating", "Tie VBAT to ground", "Use 5V on VBAT"], source: "user-manual/hardware/IG2.md" },
    { question: "What modules can IK-1 break out for evaluation?", correct: "IMX-5 or GPX-1 multi-frequency GNSS receiver", distractors: ["Only IMX-6", "Only uINS-3", "Only IG-1"], source: "user-manual/hardware/IK1.md" },
    { question: "What is the easiest way to power and communicate with IK-1 for evaluation?", correct: "Use a micro-USB cable for power and USB VCP", distractors: ["Use CAN bus only", "Use RS485 only", "Use PoE Ethernet"], source: "user-manual/hardware/IK1.md" },
    { question: "What backup supply guidance is given for IK-1 VBKUP?", correct: "Provide 1.75V–3.6V backup or tie VBKUP to VCC for faster startup", distractors: ["Leave VBKUP floating", "Tie VBKUP to ground", "Feed 5V to VBKUP"], source: "user-manual/hardware/IK1.md" },
    { question: "How is SPI enabled on IK-1?", correct: "Hold pin 15 (G9/nSPI_EN) low during boot to enable SPI on G5-G8", distractors: ["Send SPI enable over USB", "Tie GPS PPS high", "Short USB_P and USB_N"], source: "user-manual/hardware/IK1.md" },
    { question: "What antenna connections does IK-1 provide for GPX configurations?", correct: "Dual U.FL connectors for GNSS1_RF and GNSS2_RF active antennas", distractors: ["One SMA only", "No RF connectors on board", "Passive loop antenna pads only"], source: "user-manual/hardware/IK1.md" },
    { question: "What is the purpose of publishing IS hardware design files online?", correct: "To facilitate hardware development and integration for products using IMX, Rugged, and EVB", distractors: ["To replace firmware updates", "To distribute marketing videos", "To provide customer invoices"], source: "user-manual/hardware/hardware_design.md" },
    { question: "Where can you download the EvalTool installer for Windows?", correct: "From the Inertial Sense releases page on GitHub", distractors: ["From the Microsoft Store", "Bundled with the firmware package", "Only via email request"], source: "user-manual/software/evaltool.md" },
    { question: "In EvalTool, which tab lets you open ports and set baud rates?", correct: "Settings > Serial Ports", distractors: ["Data Logs", "About", "Map"], source: "user-manual/software/evaltool.md" },
    { question: "Which EvalTool tab lets you enable RMC presets and DID streams for logging?", correct: "Data Logs tab (Data Streams area)", distractors: ["INS tab", "Sensors tab", "About tab"], source: "user-manual/software/evaltool.md" },
    { question: "What log formats can EvalTool output?", correct: ".raw, .dat, .csv, .kml", distractors: [".txt, .bin, .xml", ".json, .yaml, .pcap", ".kml only"], source: "user-manual/software/evaltool.md" },
    { question: "How do you save persistent streams in EvalTool?", correct: "Enable streams, then click Save Persistent in the Data Logs tab", distractors: ["Reboot twice", "Hold Stop Streaming for 10s", "Change the About tab"], source: "user-manual/software/evaltool.md" },
    { question: "What is Log Inspector used for?", correct: "Viewing and scrubbing InertialSense .dat log files", distractors: ["Flashing firmware", "Editing DIDs live", "Configuring GNSS antennas"], source: "user-manual/software/logInspector.md" },
    { question: "Which Python version is required to build/run Log Inspector?", correct: "Python 3", distractors: ["Python 2.7", "Node.js", "No Python is needed"], source: "user-manual/software/logInspector.md" },
    { question: "What command runs Log Inspector after building?", correct: "python3 logInspector.py", distractors: ["npm start", "make run", "cmake --build ."], source: "user-manual/software/logInspector.md" },
    { question: "Where do you place the log_inspector.yaml config on Windows?", correct: "C:\\\\Users\\\\<username>\\\\Documents\\\\Inertial_Sense\\\\log_inspector.yaml", distractors: ["Program Files\\\\InertialSense", "C:\\\\logs\\\\config.ini", "Desktop\\\\config.json"], source: "user-manual/software/logInspector.md" },
    { question: "Name one standard plot available in Log Inspector.", correct: "POS NED map (or POS NED, POS LLA, Vel NED/UVW, Attitude, Heading)", distractors: ["Firmware diff view", "CAN bus analyzer", "Binary DID editor"], source: "user-manual/software/logInspector.md" },
    { question: "What is the C implementation in the SDK suited for?", correct: "Easier, lightweight integration with smaller code size", distractors: ["Heavy GUI apps", "Only logging", "Only firmware updates"], source: "user-manual/software/SDK.md" },
    { question: "What does the C++ SDK implementation include out of the box?", correct: "Object-oriented device class with comms, serial handling, logging, firmware update", distractors: ["Only math libraries", "Only bootloader updates", "No serial handling"], source: "user-manual/software/SDK.md" },
    { question: "Which IDE setup step is required for SDK examples in Visual Studio?", correct: "Select the installed Windows SDK version in Project Properties > General", distractors: ["Disable warnings", "Turn off RTTI", "Set C++ standard to C++20"], source: "user-manual/software/SDK.md" },
    { question: "Where do you download Visual Studio for SDK examples?", correct: "From the Microsoft Visual Studio downloads page", distractors: ["From GitHub releases", "From Homebrew", "From EvalTool"], source: "user-manual/software/SDK.md" },
    { question: "Name one SDK example project described in the overview.", correct: "Binary Communications, NMEA Communications, Firmware Update, Data Logger, or C++ CLTool class", distractors: ["Bluetooth Scanner", "Web Dashboard", "3D CAD exporter"], source: "user-manual/software/SDK.md" },
    { question: "What does the protocol overview say about NMEA vs Binary data efficiency?", correct: "Binary is more data efficient; NMEA is not", distractors: ["NMEA is more efficient", "Both are equal", "Efficiency is not discussed"], source: "user-manual/com-protocol/overview.md" },
    { question: "Which protocol is human-readable according to the overview?", correct: "NMEA", distractors: ["Binary", "Both", "Neither"], source: "user-manual/com-protocol/overview.md" },
    { question: "For comprehensive access to all data/configs, which protocol is recommended?", correct: "Binary protocol", distractors: ["NMEA", "UART text only", "SPI only"], source: "user-manual/com-protocol/overview.md" },
    { question: "Which protocol does the overview recommend for rapid prototypes and simple projects?", correct: "NMEA", distractors: ["Binary only", "CAN only", "SPI only"], source: "user-manual/com-protocol/overview.md" },
    { question: "Name one app/example listed under Binary protocol use.", correct: "EvalTool, CLTool, Binary Communications example, Firmware Update example, Data Logger example", distractors: ["Chrome extension", "Mobile AR app", "3D printer slicer"], source: "user-manual/com-protocol/overview.md" },
    { question: "What byte order does the ISB protocol use?", correct: "Little-endian", distractors: ["Big-endian", "Network byte order only", "Mixed-endian"], source: "user-manual/com-protocol/isb.md" },
    { question: "Which function encodes a message to set data/config in ISB examples?", correct: "is_comm_set_data()", distractors: ["is_comm_write_cfg()", "is_set_packet()", "setDidData()"], source: "user-manual/com-protocol/isb.md" },
    { question: "Which function encodes a message to get data or enable streaming in ISB examples?", correct: "is_comm_get_data()", distractors: ["is_comm_pull()", "getDid()", "is_request_data()"], source: "user-manual/com-protocol/isb.md" },
    { question: "What option saves RMC streaming configuration across reboot?", correct: "Enable persistent messages (RMC_OPTIONS_PERSISTENT or save persistent)", distractors: ["Set baud to max", "Disable GPS", "Use only NMEA"], source: "user-manual/com-protocol/isb.md" },
    { question: "What is the default IMU/INS update rate source for DID_INS_1?", correct: "Configured by DID_FLASH_CONFIG.startupNavDtMs (7ms default)", distractors: ["Fixed 1ms", "Fixed 100ms", "Only user-set via NMEA"], source: "user-manual/com-protocol/isb.md" },
    { question: "How do you enable the CAN bus on IMX pins G1/G2?", correct: "Set IO_CONFIG_G1G2_CAN_BUS in DID_FLASH_CONFIG.ioConfig", distractors: ["Enable in NTRIP settings", "Toggle a DIP switch", "Send $PERS"], source: "user-manual/com-protocol/CAN.md" },
    { question: "How do you enable a specific CAN message broadcast?", correct: "Set a non-zero can_period_mult for that message in DID_CAN_CONFIG", distractors: ["Change baud rate only", "Reboot into CAN mode", "Set ioConfig to UART"], source: "user-manual/com-protocol/CAN.md" },
    { question: "Where are CAN data set formats defined?", correct: "In SDK/src/data_sets_canbus.h", distractors: ["Only in EvalTool", "In the RTK Rover guide", "In the FAQ"], source: "user-manual/com-protocol/CAN.md" },
    { question: "What happens to CAN messages after a Stop Streaming command?", correct: "All CAN messages are disabled but saved values persist if previously saved", distractors: ["They keep streaming", "They erase flash", "They switch to NMEA"], source: "user-manual/com-protocol/CAN.md" },
    { question: "Which pins are CAN RX/TX on the IMX for an external transceiver?", correct: "G1 = RxCAN, G2 = TxCAN", distractors: ["G5/G6", "USB D+/D-", "PPS pins"], source: "user-manual/com-protocol/CAN.md" },
    { question: "How do you enable SPI on the IMX?", correct: "Hold G9 (nSPI_EN) low at startup", distractors: ["Send an SPI unlock command", "Tie PPS high", "Disable USB"], source: "user-manual/com-protocol/SPI.md" },
    { question: "What SPI mode do IMX/GPX modules use?", correct: "SPI Mode 3 (CPOL=1, CPHA=1)", distractors: ["Mode 0", "Mode 1", "Mode 2"], source: "user-manual/com-protocol/SPI.md" },
    { question: "What is the recommended max SPI data rate without the data ready pin?", correct: "Up to 3 Mbs", distractors: ["500 kbps", "10 Mbs guaranteed", "115200 bps"], source: "user-manual/com-protocol/SPI.md" },
    { question: "What should the SPI master ensure between characters in slave mode?", correct: "At least one t_bit delay between each character transmission", distractors: ["No delay needed", "Drop CS every byte", "Hold CS high during bytes"], source: "user-manual/com-protocol/SPI.md" },
    { question: "What is a recovery action if SPI clocks get out of sync?", correct: "Toggle CS (raise and lower) to reset the shift register", distractors: ["Power-cycle IMX", "Send $STPB", "Change baud rate"], source: "user-manual/com-protocol/SPI.md" },
    { question: "What is the start character for Inertial Sense NMEA packets?", correct: "$ (0x24)", distractors: ["@", "!", "#"], source: "user-manual/com-protocol/nmea.md" },
    { question: "How is the NMEA checksum computed?", correct: "XOR all bytes between $ and *, then format as 2-digit lowercase hex", distractors: ["CRC32", "Sum of bytes", "MD5 hash"], source: "user-manual/com-protocol/nmea.md" },
    { question: "What command saves persistent NMEA messages to flash?", correct: "$PERS", distractors: ["$STPB", "$INFO", "$ASCE"], source: "user-manual/com-protocol/nmea.md" },
    { question: "What command stops all broadcasts (binary and NMEA) on all ports?", correct: "$STPB", distractors: ["$STPC", "$PERS", "$INFO"], source: "user-manual/com-protocol/nmea.md" },
    { question: "In ASCE, what does a period value of 0 do for a message?", correct: "Requests a single one-shot message and disables streaming for that message", distractors: ["Sets fastest streaming", "Disables checksum", "Forces persistent streaming"], source: "user-manual/com-protocol/nmea.md" },
    { question: "What are key advantages of multi-band GNSS over single-band?", correct: "Reduced multipath/atmospheric error, faster time-to-fix, ~2x CEP improvement, robust performance", distractors: ["Uses less power only", "No difference in accuracy", "Requires fewer satellites"], source: "user-manual/gnss/multi_band_gnss_overview.md" },
    { question: "Which GNSS protocols are supported for external multi-band receivers on IMX?", correct: "uBlox binary and NMEA", distractors: ["CAN only", "SPI only", "Proprietary only"], source: "user-manual/gnss/multi_band_gnss_overview.md" },
    { question: "In GPS RTK settings, which options correspond to ZED-F9P multi-frequency use?", correct: "F9 Position for RTK positioning and F9 Compass for dual GNSS heading", distractors: ["Position/Compass only", "NMEA Only", "SBAS only"], source: "user-manual/gnss/multi_band_gnss_overview.md" },
    { question: "How are RTK base messages used in single GNSS RTK positioning?", correct: "RTCM3 to IMX are forwarded to GPX-1 for RTK positioning and EKF use", distractors: ["They are dropped", "Only NMEA corrections are used", "Only uplinked over Wi-Fi"], source: "user-manual/gnss/multi_band_gnss_overview.md" },
    { question: "For dual GNSS RTK compassing, how are base and moving-base messages routed?", correct: "Base RTCM3 to GPS1; moving base from GPS1 to GPS2 for compassing", distractors: ["Both to GPS2 only", "Only GPS1 uses RTK", "IMX ignores moving base"], source: "user-manual/gnss/multi_band_gnss_overview.md" },
    { question: "What components are needed for RTK positioning per the overview?", correct: "A base station, a rover, and a link to send corrections from base to rover", distractors: ["Only a rover", "Only an internet link", "Only a GNSS antenna"], source: "user-manual/gnss/rtk_positioning_overview.md" },
    { question: "Name one base station option listed for RTK setup.", correct: "Inertial Sense EVB-2 (or µINS/EVB1/Rugged, 3rd party base, public NTRIP)", distractors: ["Bluetooth phone only", "Wi-Fi router only", "Laptop without GNSS"], source: "user-manual/gnss/rtk_positioning_overview.md" },
    { question: "Which EvalTool indicators confirm RTK is working?", correct: "Status moves Single→Float→Fix; Differential Age resets ~1s; Accuracy H/V drops to cm-level", distractors: ["LED blinks red only", "Baud rate doubles", "CPU temp rises"], source: "user-manual/gnss/rtk_positioning_overview.md" },
    { question: "How can CLTool show RTK progress?", correct: "Use -msgPresetPPD and watch DID_GPS_RTK_NAV status changing Single→Float→Fix", distractors: ["Check CPU usage", "Run -list-devices repeatedly", "Toggle baud rates"], source: "user-manual/gnss/rtk_positioning_overview.md" },
    { question: "Which status flags indicate RTK fix in code?", correct: "INS_STATUS_NAV_FIX_STATUS == GPS_NAV_FIX_POSITIONING_RTK_FIX or GPS_STATUS_FLAGS_GPS1_RTK_POSITION_VALID", distractors: ["Check CAN errors", "Look for NMEA checksum", "Ping the device"], source: "user-manual/gnss/rtk_positioning_overview.md" },
    { question: "Why is surveying in the base position important?", correct: "Base position accuracy directly affects rover absolute position accuracy", distractors: ["It speeds up baud rate", "It boosts antenna gain", "It reduces CPU load"], source: "user-manual/gnss/rtk_base.md" },
    { question: "What happens to base correction output when a survey starts?", correct: "Base correction output is automatically disabled during the survey", distractors: ["It continues streaming", "It switches to NMEA", "It reboots the device"], source: "user-manual/gnss/rtk_base.md" },
    { question: "Where is the surveyed base position stored?", correct: "In DID_FLASH_CONFIG.reflla", distractors: ["In RAM only", "In the SD card", "In EEPROM on the radio"], source: "user-manual/gnss/rtk_base.md" },
    { question: "Which survey-in modes are available via EvalTool?", correct: "Manual, Average GPS 3D, Average RTK Float, Average RTK Fix", distractors: ["Single-band only", "SBAS only", "Compass only"], source: "user-manual/gnss/rtk_base.md" },
    { question: "In EvalTool base setup, which correction outputs can you select?", correct: "GPS1 - RTCM3 or GPS1 - uBlox with configurable Data Rate(ms)", distractors: ["NMEA only", "CAN only", "Wi-Fi only"], source: "user-manual/gnss/rtk_base.md" },
    { question: "What are the three major parts of an NTRIP system?", correct: "NTRIP server, NTRIP caster, NTRIP client", distractors: ["Base, rover, antenna", "Wi-Fi, Bluetooth, USB", "EvalTool, CLTool, SDK"], source: "user-manual/gnss/rtk_ntrip.md" },
    { question: "When using a virtual reference service (VRS), what must the rover output?", correct: "NMEA GGA back to the NTRIP caster", distractors: ["Only RTCM1005", "Only CAN frames", "No outbound data"], source: "user-manual/gnss/rtk_ntrip.md" },
    { question: "Which RTCM messages are required for RTK positioning from an NTRIP caster?", correct: "1005 plus MSM4/5/7 for GPS (107x), GLONASS (108x), Galileo (109x), and 1230 biases", distractors: ["Only 1001", "Only MSM7 GPS", "No RTCM needed"], source: "user-manual/gnss/rtk_ntrip.md" },
    { question: "What role do EvalTool/CLTool play in NTRIP setups?", correct: "They act as NTRIP clients feeding RTCM corrections to IMX/ZED-F9P over USB/serial", distractors: ["They are NTRIP casters", "They replace the base", "They only log data"], source: "user-manual/gnss/rtk_ntrip.md" },
    { question: "What is NTRIP used for?", correct: "Streaming RTCM differential corrections over the internet", distractors: ["Uploading firmware", "Converting CSV logs", "Configuring CAN"], source: "user-manual/gnss/rtk_ntrip.md" },
    { question: "What dynamic model value enables ground vehicle dead reckoning?", correct: "Set DID_FLASH_CONFIG.dynamicModel to 4", distractors: ["Set it to 1", "Enable CAN mode", "Use SBAS only"], source: "user-manual/dead-reckoning/dead_reckoning.md" },
    { question: "What installation requirement is critical for dead reckoning accuracy?", correct: "IMX and antenna must be rigidly fixed to the vehicle", distractors: ["Loose mounting is fine", "Antenna can move freely", "Mount IMX on springs"], source: "user-manual/dead-reckoning/dead_reckoning.md" },
    { question: "How do you know learning mode has converged in EvalTool?", correct: "GV: Cal turns green and GV status shows learning converged", distractors: ["LED turns red", "Baud rate doubles", "GPS PPS stops"], source: "user-manual/dead-reckoning/dead_reckoning.md" },
    { question: "What driving pattern satisfies ground vehicle learning?", correct: "At least 200 m straight plus 5 left/5 right turns or three figure eights", distractors: ["Idle in place", "Only one straight line", "Power cycle repeatedly"], source: "user-manual/dead-reckoning/dead_reckoning.md" },
    { question: "How is wheel encoder data provided to IMX-5 for dead reckoning?", correct: "Stream DID_WHEEL_ENCODER messages (omega_l/omega_r) into an IMX port", distractors: ["Direct pin inputs on IMX-5", "Only via CAN frames", "It is unsupported"], source: "user-manual/dead-reckoning/dead_reckoning.md" },
    { question: "What should you do if running Dead Reckoning to exit Learning Mode?", correct: "Set DID_GROUND_VEHICLE.mode to 5 to stop and save calibration", distractors: ["Reboot only", "Change baud rate", "Disable PPS"], source: "user-manual/dead-reckoning/dead_reckoning.md" },
    { question: "How do wheel encoders help dead reckoning performance?", correct: "They constrain drift along the vehicle travel axis", distractors: ["They increase drift", "They are ignored by EKF", "They only power the IMX"], source: "user-manual/dead-reckoning/dead_reckoning.md" },
    { question: "Where do you set GPS antenna offsets for dead reckoning?", correct: "EvalTool > Data Sets > DID_FLASH_CONFIG > gps1AntOffsetX/Y/Z", distractors: ["In CAN config", "In SPI mode", "Via PPS line"], source: "user-manual/dead-reckoning/dead_reckoning.md" },
    { question: "What effect do heavy vibrations have per the guide?", correct: "They can degrade IMX measurements and dead reckoning solution", distractors: ["They improve accuracy", "They calibrate the IMU", "No effect"], source: "user-manual/dead-reckoning/dead_reckoning.md" },
    { question: "What two main tasks can infield calibration perform?", correct: "Zero IMU biases and zero/align INS attitude to the vehicle frame", distractors: ["Change baud rate and LEDs", "Update firmware", "Log data to SD"], source: "user-manual/application-config/infield_calibration.md" },
    { question: "For accelerometer bias correction in infield calibration, how must the axes be oriented?", correct: "Each axis must be sampled while vertical (up or down) to measure full gravity", distractors: ["Any orientation works", "Only flat on a table", "Only during motion"], source: "user-manual/application-config/infield_calibration.md" },
    { question: "What bit indicates motion detected during infield sampling?", correct: "INFIELD_CAL_STATUS_MOTION_DETECTED (0x02000000)", distractors: ["INS_STATUS_NAV_FIX", "SYS_CFG_BITS_DISABLE_MAGNETOMETER_FUSION", "RMC_OPTIONS_PERSISTENT"], source: "user-manual/application-config/infield_calibration.md" },
    { question: "How do you disable motion detection during infield calibration?", correct: "Bitwise-OR INIT_OPTION_DISABLE_MOTION_DETECT (0x00010000) with the init command", distractors: ["Set baud to 115200", "Hold reset", "Send $STPB"], source: "user-manual/application-config/infield_calibration.md" },
    { question: "How do you save infield calibration after sampling orientations?", correct: "Set DID_INFIELD_CAL.state to SAVE_AND_FINISH (9)", distractors: ["Power cycle only", "Send $PERS", "Toggle nRESET"], source: "user-manual/application-config/infield_calibration.md" },
    { question: "What does platformConfig do in DID_FLASH_CONFIG?", correct: "Specifies carrier board type and presets I/O and GPS settings", distractors: ["Sets baud only", "Formats SD card", "Disables EKF"], source: "user-manual/application-config/platform_configuration.md" },
    { question: "On RUG-3, how are I/O presets selected?", correct: "Use PLATFORM_CFG_PRESET_MASK bits in platformConfig after setting a RUG-3 type", distractors: ["Hardware jumpers only", "EvalTool About tab", "NMEA commands"], source: "user-manual/application-config/platform_configuration.md" },
    { question: "Where in EvalTool can you set platform config type?", correct: "General Settings and GPS Settings tabs", distractors: ["INS tab only", "About tab", "Data Logs tab"], source: "user-manual/application-config/platform_configuration.md" },
    { question: "What is Sensor Rotation used for?", correct: "Rotate IMU/magnetometer output by 90° multiples via sensorConfig to match sensor frame", distractors: ["Small angle trim", "Changing GPS type", "Resetting INS"], source: "user-manual/application-config/imu_ins_gnss_configuration.md" },
    { question: "What is INS Rotation used for?", correct: "Small angle alignment from sensor frame to vehicle frame via insRotation (Z,Y,X order)", distractors: ["90° gross rotation", "Moving GPS antenna", "Setting baud"], source: "user-manual/application-config/imu_ins_gnss_configuration.md" },
    { question: "What does INS Offset do?", correct: "Shifts INS output location to a desired point on the vehicle", distractors: ["Sets IMU scale", "Resets biases", "Changes GNSS type"], source: "user-manual/application-config/imu_ins_gnss_configuration.md" },
    { question: "Where do you set the GNSS antenna lever arm offsets?", correct: "DID_FLASH_CONFIG.gps1AntOffset / gpsAnt2Offset", distractors: ["insRotation", "platformConfig", "sensorConfig"], source: "user-manual/application-config/imu_ins_gnss_configuration.md" },
    { question: "How do you disable magnetometer or barometer fusion?", correct: "Set SYS_CFG_BITS_DISABLE_MAGNETOMETER_FUSION or _DISABLE_BAROMETER_FUSION in sysCfgBits", distractors: ["Unplug sensors", "Change baud rate", "Set dynamicModel"], source: "user-manual/application-config/imu_ins_gnss_configuration.md" },
    { question: "What parameter sets IMU sample period?", correct: "DID_FLASH_CONFIG.startupImuDtMs (ms)", distractors: ["startupNavDtMs", "sensorConfig", "platformConfig"], source: "user-manual/application-config/imu_ins_gnss_configuration.md" },
    { question: "Which value sets EKF output/update periods at startup?", correct: "DID_FLASH_CONFIG.startupNavDtMs (sets navOutputDtMs/navUpdateDtMs)", distractors: ["startupImuDtMs only", "gps1AntOffset", "dynamicModel"], source: "user-manual/application-config/imu_ins_gnss_configuration.md" },
    { question: "Which GNSS signals does ZED-F9P support for rover positioning per the guide?", correct: "L1/L2 GPS, L1/L2 GLONASS, E1/E5 Galileo, B1/B2 BeiDou", distractors: ["L1 only", "GLONASS only", "SBAS only"], source: "user-manual/gnss/multi_band_F9P.md" },
    { question: "How do you wire EVB-2 to ZED-F9P for rover use?", correct: "Use EVB-2 SPI mode 6 then connect E70 SPI to F9P SPI pins", distractors: ["Use only USB", "Use CAN bus pins", "Use HDMI"], source: "user-manual/gnss/multi_band_F9P.md" },
    { question: "What baud rate is recommended on EVB-2 UART when using ZED-F9P rover?", correct: "115200 bps (or match startupGPSDtMs bandwidth)", distractors: ["9600 only", "1 Mbps fixed", "Any rate works"], source: "user-manual/gnss/multi_band_F9P.md" },
    { question: "How do you enable RTCM input on ZED-F9P in this setup?", correct: "Configure UBX-CFG-MSG to enable RTCM3 inputs on the chosen port", distractors: ["Send NMEA only", "Enable CAN frames", "Use SBAS messages"], source: "user-manual/gnss/multi_band_F9P.md" },
    { question: "What EvalTool tab helps set GPS type and RTK mode for F9P rover?", correct: "Settings > GPS", distractors: ["INS tab", "About tab", "Data Logs tab"], source: "user-manual/gnss/multi_band_F9P.md" },
    { question: "What does the GPX-1 provide when paired with IMX-5?", correct: "Multi-frequency GNSS with dual antenna support for RTK positioning and compassing", distractors: ["Only Wi-Fi connectivity", "Bluetooth only", "Ethernet"], source: "user-manual/gnss/multi_band_GPX.md" },
    { question: "How is active antenna power delivered on GPX-1?", correct: "Via VCC_RF through an inductor to GNSS1_RF/GNSS2_RF (3.3V)", distractors: ["Direct 5V", "Via USB", "No antenna power"], source: "user-manual/gnss/multi_band_GPX.md" },
    { question: "Which message format is recommended between IMX and GPX-1 for RTK?", correct: "RTCM3 forwarded to GPX-1", distractors: ["Only NMEA", "CAN frames", "HTTP"], source: "user-manual/gnss/multi_band_GPX.md" },
    { question: "What type of antenna is required for GPX-1?", correct: "Active L1/L5 GNSS antenna", distractors: ["Passive only", "Loop antenna", "No antenna needed"], source: "user-manual/gnss/multi_band_GPX.md" },
    { question: "Which EvalTool setting selects GPX RTK mode?", correct: "GPS RTK set to Position or Compass for GPX-1", distractors: ["Set to SBAS only", "Disable RTK", "Use F9 Compass"], source: "user-manual/gnss/multi_band_GPX.md" },
    { question: "What is required when interfacing an external NMEA GNSS receiver?", correct: "Configure GPS Source to the serial port and GPS Type to NMEA", distractors: ["Use SPI only", "Must use CAN", "Disable all serial"], source: "user-manual/gnss/external_gnss.md" },
    { question: "Which messages are commonly used from external NMEA GNSS for IMX?", correct: "GGA and RMC (optional VTG)", distractors: ["Only PPS", "Only proprietary messages", "No NMEA needed"], source: "user-manual/gnss/external_gnss.md" },
    { question: "What PPS guidance is given for external NMEA GNSS?", correct: "Use PPS for best timing; set GPS1 Timepulse to external", distractors: ["PPS unsupported", "Use 1PPS only on USB", "Tie PPS to ground"], source: "user-manual/gnss/external_gnss.md" },
    { question: "Where do you configure external GNSS type and port in EvalTool?", correct: "Settings > GPS", distractors: ["INS tab", "Data Logs tab", "About tab"], source: "user-manual/gnss/external_gnss.md" },
    { question: "What baud rate consideration is noted for external NMEA GNSS?", correct: "Match baud to receiver output to avoid data loss", distractors: ["Use 9600 fixed", "Baud rate is irrelevant", "Only 1 Mbps works"], source: "user-manual/gnss/external_gnss.md" },
    { question: "What LNA gain is recommended for active GNSS antennas?", correct: "Typically 15–30 dB with low noise figure", distractors: ["0 dB", "60 dB", "No LNA allowed"], source: "user-manual/gnss/gnss_antennas.md" },
    { question: "Why is antenna placement important per the guide?", correct: "Reduce multipath by clear sky view and ground plane use", distractors: ["To match baud rate", "To cool the device", "To improve Wi-Fi"], source: "user-manual/gnss/gnss_antennas.md" },
    { question: "What is advised about cable selection for GNSS antennas?", correct: "Use low-loss coax and minimize length to reduce signal loss", distractors: ["Use any cable", "Use flat ribbon", "Use twisted pair"], source: "user-manual/gnss/gnss_antennas.md" },
    { question: "What connector types are mentioned for GNSS antennas?", correct: "MMCX, SMA, U.FL depending on hardware", distractors: ["RJ45", "USB-A", "HDMI"], source: "user-manual/gnss/gnss_antennas.md" },
    { question: "When using dual antennas for compassing, what baseline guidance is given?", correct: "Longer baselines improve heading accuracy; keep clear view", distractors: ["Short baseline is always better", "Place indoors", "Stack antennas"], source: "user-manual/gnss/gnss_antennas.md" },
    { question: "Which GNSS constellations are listed as supported?", correct: "GPS, GLONASS, Galileo, BeiDou", distractors: ["QZSS only", "GPS only", "Iridium"], source: "user-manual/gnss/gnss_constellations.md" },
    { question: "How does tracking multiple constellations help?", correct: "Improves coverage and robustness to obstructions", distractors: ["Reduces accuracy", "Consumes no power", "Disables RTK"], source: "user-manual/gnss/gnss_constellations.md" },
    { question: "What is noted about GLONASS biases?", correct: "RTCM message 1230 carries GLONASS code-phase biases", distractors: ["No biases exist", "Handled only in NMEA", "SBAS fixes them automatically"], source: "user-manual/gnss/gnss_constellations.md" },
    { question: "Which constellation provides E1/E5 signals?", correct: "Galileo", distractors: ["GPS only", "BeiDou only", "None"], source: "user-manual/gnss/gnss_constellations.md" },
    { question: "Which constellation contributes to L1/L2 signals in ZED-F9P setups?", correct: "GPS and GLONASS L1/L2 plus BeiDou/ Galileo equivalents", distractors: ["Only GPS L1", "Only SBAS", "Only L5"], source: "user-manual/gnss/gnss_constellations.md" },
    { question: "What is RTK compassing used for?", correct: "Dual-GNSS heading using moving-base RTK between two antennas", distractors: ["Single antenna RTK position", "SBAS-only heading", "Dead reckoning"], source: "user-manual/gnss/rtk_compassing.md" },
    { question: "Which GPS RTK mode should be selected for compassing with dual F9P?", correct: "F9 Compass", distractors: ["F9 Position", "Compass disabled", "SBAS"], source: "user-manual/gnss/rtk_compassing.md" },
    { question: "How is GPS2 configured in moving-base compassing?", correct: "GPS1 sends moving-base RTK messages to GPS2", distractors: ["GPS2 sends to GPS1", "Use only GPS1", "No RTK needed"], source: "user-manual/gnss/rtk_compassing.md" },
    { question: "What physical requirement improves RTK compassing heading?", correct: "A longer antenna baseline and clear sky view", distractors: ["Short baseline indoors", "Shield antennas", "Use only one antenna"], source: "user-manual/gnss/rtk_compassing.md" },
    { question: "Which EvalTool area helps monitor compassing status?", correct: "GPS tab and INS tab heading indicators", distractors: ["About tab", "Firmware tab", "Map tab only"], source: "user-manual/gnss/rtk_compassing.md" },
    { question: "What does SBAS provide?", correct: "Satellite-based augmentation improving integrity/accuracy without RTK", distractors: ["RTK moving base", "CAN synchronization", "SPI acceleration"], source: "user-manual/gnss/SBAS.md" },
    { question: "What is a tradeoff of SBAS vs RTK noted?", correct: "SBAS improves accuracy but not to centimeter-level like RTK", distractors: ["SBAS is always cm-accurate", "SBAS requires two antennas", "SBAS disables GNSS"], source: "user-manual/gnss/SBAS.md" },
    { question: "Which systems are examples of SBAS?", correct: "WAAS, EGNOS, MSAS", distractors: ["GLONASS", "Galileo", "BeiDou"], source: "user-manual/gnss/SBAS.md" },
    { question: "How does SBAS help in difficult environments?", correct: "Improves availability/integrity when RTK corrections are unavailable", distractors: ["Replaces PPS", "Increases baud rate", "Enables CAN"], source: "user-manual/gnss/SBAS.md" },
    { question: "Where do you select SBAS use?", correct: "In GNSS settings via EvalTool/flash config", distractors: ["Only in CLTool -nmea", "In CAN config", "In SPI mode"], source: "user-manual/gnss/SBAS.md" },
    { question: "What does PointPerfect provide?", correct: "PPP/SSR correction service for precise positioning", distractors: ["Wi-Fi connectivity", "CAN logging", "Firmware updates"], source: "user-manual/gnss/ublox_pointperfect.md" },
    { question: "Which receiver supports PointPerfect per the guide?", correct: "u-blox ZED-F9P", distractors: ["Only GPX-1", "Only IMX without GNSS", "Any NMEA receiver"], source: "user-manual/gnss/ublox_pointperfect.md" },
    { question: "What message type delivers PointPerfect corrections?", correct: "SPARTN", distractors: ["RTCM2", "Only NMEA", "CAN frames"], source: "user-manual/gnss/ublox_pointperfect.md" },
    { question: "What connectivity is needed for PointPerfect?", correct: "Internet link (e.g., NTRIP/HTTP) to receive corrections", distractors: ["Only CAN", "No connectivity", "HDMI"], source: "user-manual/gnss/ublox_pointperfect.md" },
    { question: "What is a key benefit of PointPerfect vs RTCM base?", correct: "Removes need for a local base by using PPP/SSR corrections", distractors: ["Uses less power", "Disables RTK", "Requires two antennas"], source: "user-manual/gnss/ublox_pointperfect.md" },
    { question: "What input voltage range does the Rugged-3 accept on VIN?", correct: "4V to 20V", distractors: ["1.8V to 3.3V", "9V to 12V only", "24V nominal only"], source: "user-manual/hardware/rugged3.md" },
    { question: "What is the simplest way to power and communicate with Rugged-3 for evaluation?", correct: "Use the included USB to Gecko connector cable for power and USB VCP", distractors: ["CAN bus only", "RS485 only", "PoE Ethernet"], source: "user-manual/hardware/rugged3.md" },
    { question: "How do you switch Rugged-3 pins 11/12 from CAN to Serial2 TTL or STROBE?", correct: "Remove R14/R15 and load R16/R17 with 0402 zero-ohm jumpers", distractors: ["Change firmware only", "Tie CANL to ground", "Move a DIP switch"], source: "user-manual/hardware/rugged3.md" },
    { question: "For RTK compassing on Rugged-3, how are antennas connected?", correct: "Connect GPS1 antenna to MMCX port 1 and GPS2 antenna to MMCX port 2", distractors: ["Use one antenna only", "Swap GPS1 to port 2", "Use passive loop antenna"], source: "user-manual/hardware/rugged3.md" },
    { question: "What interfaces are integrated on the Rugged-3 enclosure beyond TTL serial?", correct: "CAN transceiver, RS232, RS485, USB, and SPI", distractors: ["Ethernet only", "Bluetooth only", "HDMI"], source: "user-manual/hardware/rugged3.md" }
  ];

  function shuffle(arr) {
    const a = [...arr];
    for (let i = a.length - 1; i > 0; i -= 1) {
      const j = Math.floor(Math.random() * (i + 1));
      [a[i], a[j]] = [a[j], a[i]];
    }
    return a;
  }

  function buildPageQuestions(pages) {
    return [];
  }

  function finalizeQuestion(base) {
    if (base.options && typeof base.answer === "number") {
      return base;
    }
    const options = shuffle([base.correct, ...base.distractors]);
    const answer = options.indexOf(base.correct);
    return { ...base, options, answer };
  }

  function pickQuestions() {
    const pool = [...contentQuestions.map(finalizeQuestion)];
    return shuffle(pool).slice(0, 25);
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
    state.answers[state.index] = {
      correct: isCorrect,
      selected: selectedIdx,
      question: q
    };
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
    const total = state.questions.length;
    els.question.textContent = "Quiz complete";
    els.options.innerHTML = "";
    els.feedback.textContent = "";
    els.counter.textContent = "Done";

    els.results.hidden = false;
    els.results.innerHTML = "";

    const score = document.createElement("div");
    score.className = "quiz-score";
    const pct = Math.round((state.score / total) * 100);
    score.textContent = `Final score: ${state.score} / ${total} (${pct}%)`;

    const heading = document.createElement("h3");
    heading.textContent = "Per-question results (tap to review)";

    const grid = document.createElement("div");
    grid.className = "review-list";

    const reviewPanel = document.createElement("div");
    reviewPanel.className = "review-panel";
    reviewPanel.hidden = true;

    const renderReview = (entry, idx) => {
      reviewPanel.hidden = false;
      reviewPanel.innerHTML = "";

      const qTitle = document.createElement("div");
      qTitle.className = "review-question";
      qTitle.textContent = `Question ${idx + 1}: ${entry.question.question}`;

      const meta = document.createElement("div");
      meta.className = "review-meta";
      meta.textContent = `Source: ${entry.question.source || "user manual"}`;

      const opts = document.createElement("div");
      opts.className = "review-options";
      entry.question.options.forEach((opt, optIdx) => {
        const optDiv = document.createElement("div");
        optDiv.className = "review-option";
        if (optIdx === entry.question.answer) {
          optDiv.classList.add("correct");
        }
        if (optIdx === entry.selected && optIdx !== entry.question.answer) {
          optDiv.classList.add("selected");
        }
        optDiv.textContent = opt;
        opts.appendChild(optDiv);
      });

      reviewPanel.append(qTitle, meta, opts);
    };

    state.answers.forEach((entry, idx) => {
      const item = document.createElement("button");
      item.type = "button";
      item.className = `review-button ${entry.correct ? "correct" : "incorrect"}`;
      item.textContent = `Q${idx + 1} - ${entry.correct ? "Correct" : "Incorrect"}`;
      item.addEventListener("click", () => renderReview(entry, idx));
      grid.appendChild(item);
    });

    const restart = document.createElement("button");
    restart.className = "quiz-restart";
    restart.type = "button";
    restart.textContent = "Restart quiz";
    restart.addEventListener("click", resetQuiz);

    els.results.append(score, heading, grid, reviewPanel, restart);
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
