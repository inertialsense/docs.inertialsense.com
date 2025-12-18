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
  const userManualPages = [
    { title: "IMX-6 Module", path: "user-manual/hardware/module_imx6.md", topic: "IMX-6 hardware integration" },
    { title: "IMX-5 Module", path: "user-manual/hardware/module_imx5.md", topic: "IMX-5 hardware integration" },
    { title: "GPX-1 Module", path: "user-manual/hardware/module_gpx1.md", topic: "GPX-1 hardware integration" },
    { title: "Rugged-3", path: "user-manual/hardware/rugged3.md", topic: "Rugged-3 unit hardware" },
    { title: "IG-1", path: "user-manual/hardware/IG1.md", topic: "IG-1 unit hardware" },
    { title: "IG-2", path: "user-manual/hardware/IG2.md", topic: "IG-2 unit hardware" },
    { title: "IK-1", path: "user-manual/hardware/IK1.md", topic: "IK-1 unit hardware" },
    { title: "Hardware Design Files", path: "user-manual/hardware/hardware_design.md", topic: "open hardware design files" },
    { title: "Reflow Soldering", path: "user-manual/hardware/reflow.md", topic: "reflow soldering guidance" },
    { title: "CLTool", path: "user-manual/software/cltool.md", topic: "CLTool usage" },
    { title: "EvalTool", path: "user-manual/software/evaltool.md", topic: "EvalTool usage" },
    { title: "SDK Overview", path: "user-manual/software/SDK.md", topic: "SDK overview" },
    { title: "Log Inspector", path: "user-manual/software/logInspector.md", topic: "Log Inspector usage" },
    { title: "Com Protocol Overview", path: "user-manual/com-protocol/overview.md", topic: "communications protocol overview" },
    { title: "DID Descriptions", path: "user-manual/com-protocol/DID-descriptions.md", topic: "data set (DID) descriptions" },
    { title: "Inertial Sense Binary", path: "user-manual/com-protocol/isb.md", topic: "ISB binary protocol" },
    { title: "NMEA", path: "user-manual/com-protocol/nmea.md", topic: "NMEA protocol integration" },
    { title: "SPI", path: "user-manual/com-protocol/SPI.md", topic: "SPI protocol usage" },
    { title: "CAN", path: "user-manual/com-protocol/CAN.md", topic: "CAN protocol usage" },
    { title: "Multi-band GNSS Overview", path: "user-manual/gnss/multi_band_gnss_overview.md", topic: "multi-band GNSS overview" },
    { title: "IS GPX-1 Multi-band", path: "user-manual/gnss/multi_band_GPX.md", topic: "multi-band GNSS with GPX-1" },
    { title: "Ublox F9P Multi-band", path: "user-manual/gnss/multi_band_F9P.md", topic: "multi-band GNSS with Ublox F9P" },
    { title: "External NMEA GNSS", path: "user-manual/gnss/external_gnss.md", topic: "external NMEA GNSS setup" },
    { title: "GNSS Antennas", path: "user-manual/gnss/gnss_antennas.md", topic: "GNSS antennas selection" },
    { title: "GNSS Constellations", path: "user-manual/gnss/gnss_constellations.md", topic: "GNSS constellations" },
    { title: "RTK Positioning Overview", path: "user-manual/gnss/rtk_positioning_overview.md", topic: "RTK positioning overview" },
    { title: "RTK Rover", path: "user-manual/gnss/rtk_rover.md", topic: "RTK rover configuration" },
    { title: "RTK Base", path: "user-manual/gnss/rtk_base.md", topic: "RTK base configuration" },
    { title: "RTK NTRIP", path: "user-manual/gnss/rtk_ntrip.md", topic: "RTK NTRIP configuration" },
    { title: "Point Perfect", path: "user-manual/gnss/ublox_pointperfect.md", topic: "Ublox PointPerfect setup" },
    { title: "SBAS", path: "user-manual/gnss/SBAS.md", topic: "SBAS information" },
    { title: "RTK Compassing", path: "user-manual/gnss/rtk_compassing.md", topic: "RTK compassing setup" },
    { title: "Dead Reckoning Overview", path: "user-manual/dead-reckoning/dead_reckoning.md", topic: "dead reckoning overview" },
    { title: "Dead Reckoning Examples", path: "user-manual/dead-reckoning/dead_reckoning_examples.md", topic: "dead reckoning examples" },
    { title: "Infield Calibration", path: "user-manual/application-config/infield_calibration.md", topic: "infield calibration" },
    { title: "Platform Configuration", path: "user-manual/application-config/platform_configuration.md", topic: "platform configuration" },
    { title: "IMU INS GNSS Configuration", path: "user-manual/application-config/imu_ins_gnss_configuration.md", topic: "IMU/INS/GNSS configuration" },
    { title: "System Configuration", path: "user-manual/application-config/system_configuration.md", topic: "system configuration" },
    { title: "Time Sync / Strobe", path: "user-manual/application-config/time_sync.md", topic: "time synchronization and strobe" },
    { title: "Zero Motion Command", path: "user-manual/application-config/zero_motion_command.md", topic: "zero motion command" },
    { title: "UART", path: "user-manual/application-config/UART.md", topic: "UART configuration" },
    { title: "SDK Overview (README)", path: "user-manual/SDK/README.md", topic: "SDK overview and layout" },
    { title: "Comm-Binary (C)", path: "user-manual/SDK/CommunicationsBinary.md", topic: "binary communications example" },
    { title: "Comm-NMEA (C)", path: "user-manual/SDK/CommunicationsAscii.md", topic: "NMEA communications example" },
    { title: "Comm-Arduino (C)", path: "user-manual/SDK/CommunicationsArduino.md", topic: "Arduino communications example" },
    { title: "Firmware Update (C)", path: "user-manual/SDK/FirmwareUpdate.md", topic: "firmware update example" },
    { title: "InertialSense Class CLTool (C++)", path: "user-manual/SDK/InertialSenseClassCLTool.md", topic: "C++ CLTool class example" },
    { title: "Data Logging (C++)", path: "user-manual/SDK/DataLogger.md", topic: "data logging example" },
    { title: "Data Logging Overview", path: "user-manual/logging-plotting/overview.md", topic: "logging and plotting overview" },
    { title: "Logging", path: "user-manual/logging-plotting/data_logging.md", topic: "logging setup" },
    { title: "Plotting", path: "user-manual/logging-plotting/data_plotting.md", topic: "plotting data" },
    { title: "Bootloader", path: "user-manual/reference/bootloader.md", topic: "bootloader reference" },
    { title: "Coordinate Frames", path: "user-manual/reference/coordinate_frames.md", topic: "coordinate frames reference" },
    { title: "Definitions", path: "user-manual/reference/definitions.md", topic: "definitions reference" },
    { title: "IMU Specifications", path: "user-manual/reference/imu_specifications.md", topic: "IMU specifications" },
    { title: "Interference", path: "user-manual/reference/interference.md", topic: "interference reference" },
    { title: "Magnetometer", path: "user-manual/reference/magnetometer.md", topic: "magnetometer reference" },
    { title: "System Status", path: "user-manual/reference/system_status.md", topic: "system status reference" },
    { title: "User Manual PDF", path: "user-manual/reference/user_manual_pdf.md", topic: "user manual PDF export" },
    { title: "FAQ", path: "user-manual/faq.md", topic: "frequently asked questions" },
    { title: "Troubleshooting Firmware", path: "user-manual/troubleshooting/firmware.md", topic: "troubleshooting firmware" },
    { title: "Troubleshooting Chip Erase", path: "user-manual/troubleshooting/chip_erase.md", topic: "chip erase troubleshooting" },
    { title: "Troubleshooting GNSS", path: "user-manual/troubleshooting/gnss.md", topic: "GNSS troubleshooting" }
  ];

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
    { question: "What is pin 20 (G15/GNSS_PPS) used for on the IMX-6?", correct: "Input for GNSS PPS time synchronization pulse", distractors: ["3.3V power input", "USB data line", "CAN transceiver enable"], source: "user-manual/hardware/module_imx6.md" },
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
    { question: "What should you do with IMX-6 pin 0?", correct: "Connect it to ground because it is not connected internally", distractors: ["Leave it floating for antenna detect", "Tie it to VUSB", "Use it as a GPIO output"], source: "user-manual/hardware/module_imx6.md" },
    { question: "What is IMX-6 pin 1 (USB_P)?", correct: "USB Data Positive line", distractors: ["USB Data Negative line", "Power input", "CAN transmit line"], source: "user-manual/hardware/module_imx6.md" },
    { question: "What is IMX-6 pin 2 (USB_N)?", correct: "USB Data Negative line", distractors: ["USB Data Positive line", "Reset line", "CAN receive line"], source: "user-manual/hardware/module_imx6.md" },
    { question: "What is IMX-6 pin 3 (VBKUP)?", correct: "GNSS backup supply 1.4V to 3.6V; connect to VCC if no backup battery", distractors: ["5V main supply", "Ground reference", "SPI chip select"], source: "user-manual/hardware/module_imx6.md" },
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

  const templates = [
    (page) => `Which documentation page covers ${page.topic}?`,
    (page) => `Where should you look for details on ${page.topic}?`,
    (page) => `Which user manual page provides guidance on ${page.topic}?`,
    (page) => `If you need information about ${page.topic}, which page would you open?`,
    (page) => `Which page in the docs focuses on ${page.topic}?`
  ];

  function buildPageQuestions(pages) {
    const pool = [];
    pages.forEach((page) => {
      const others = pages.filter((p) => p !== page).map((p) => p.title);
      templates.forEach((template) => {
        const options = shuffle([page.title, ...shuffle(others).slice(0, 3)]);
        pool.push({
          question: template(page),
          options,
          answer: options.indexOf(page.title),
          source: page.path
        });
      });
    });
    return pool;
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
    const generated = buildPageQuestions(userManualPages);
    const pool = [...generated, ...contentQuestions.map(finalizeQuestion)];
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
