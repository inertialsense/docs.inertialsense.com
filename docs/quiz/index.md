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
  const questions = [
    {
      question: "Which tool is the graphical desktop program used to explore, configure, and test Inertial Sense products in real time?",
      options: ["EvalTool", "CLTool", "SDK", "Log Inspector"],
      answer: 0,
      source: "getting-started/Overview.md"
    },
    {
      question: "According to Getting Started, which tool must be compiled from source?",
      options: ["CLTool", "EvalTool", "Log Inspector", "Reflow utility"],
      answer: 0,
      source: "getting-started/Overview.md"
    },
    {
      question: "How do you obtain the SDK code libraries and example projects?",
      options: [
        "Download the \"Source code\" asset from the releases page",
        "Install via pip with inertialsense-sdk",
        "Request an email package from support",
        "Clone the firmware repo submodule"
      ],
      answer: 0,
      source: "getting-started/Overview.md"
    },
    {
      question: "In the RTK Rover guide, which EvalTool menu path enables Rover Mode?",
      options: [
        "Settings > GPS > Rover > RTK",
        "Data Sets > INS > Rover",
        "Diagnostics > GNSS > RTK",
        "System > Network > RTK"
      ],
      answer: 0,
      source: "user-manual/gnss/rtk_rover.md"
    },
    {
      question: "When setting Rover Mode in EvalTool, what do you change the first dropdown to?",
      options: [
        "Positioning (GPS1) or the matching F9P option",
        "Desired log file format",
        "UART port number",
        "Mount point for NTRIP"
      ],
      answer: 0,
      source: "user-manual/gnss/rtk_rover.md"
    },
    {
      question: "Which CLTool argument configures the unit as a rover by writing flash config?",
      options: [
        "-flashConfig=rtkCfgBits=0x01",
        "-roverMode=1",
        "-presetINS",
        "-setRover"
      ],
      answer: 0,
      source: "user-manual/gnss/rtk_rover.md"
    },
    {
      question: "How does the IMX treat base correction data arriving at its ports?",
      options: [
        "It automatically parses data arriving at any port and recognizes base corrections",
        "It only accepts corrections on USB",
        "It ignores corrections unless set to RTK Base mode",
        "It requires manual parsing via SDK API"
      ],
      answer: 0,
      source: "user-manual/gnss/rtk_rover.md"
    },
    {
      question: "What baud rate does the Digi Xbee Pro SX module on the EVB-2 use?",
      options: ["115200", "57600", "921600", "230400"],
      answer: 0,
      source: "user-manual/gnss/rtk_rover.md"
    },
    {
      question: "In EVB-2 rover setup, what should cbPreset be set to in DID_EVB_FLASH_CFG to enable the radio?",
      options: ["0x3", "0x1", "0x7", "0x0"],
      answer: 0,
      source: "user-manual/gnss/rtk_rover.md"
    },
    {
      question: "In EVB-2 rover setup, what output power does radioPowerLevel value 0 correspond to?",
      options: ["20 dBm", "27 dBm", "30 dBm", "10 dBm"],
      answer: 0,
      source: "user-manual/gnss/rtk_rover.md"
    },
    {
      question: "When configuring the Rover NTRIP client in EvalTool, which correction formats can you select?",
      options: [
        "RTCM3 or UBLOX",
        "CAN or SPI",
        "NMEA or AIS",
        "Proprietary binary only"
      ],
      answer: 0,
      source: "user-manual/gnss/rtk_rover.md"
    },
    {
      question: "What is the default serial baud rate used by CLTool if -baud is not specified?",
      options: ["921600", "115200", "460800", "230400"],
      answer: 0,
      source: "user-manual/software/cltool.md"
    },
    {
      question: "What does the -lm flag do in CLTool?",
      options: [
        "Listen mode for ISB that disables device validation and skips the stop-broadcast command on start",
        "Locks magnetometer calibration",
        "Limits maximum INS update rate",
        "Logs messages to memory"
      ],
      answer: 0,
      source: "user-manual/software/cltool.md"
    },
    {
      question: "What does the -dboc flag do in CLTool?",
      options: [
        "Sends a stop-broadcast command ($STPB) on close",
        "Disables binary output conversion",
        "Drops bandwidth on connection",
        "Delays boot output capture"
      ],
      answer: 0,
      source: "user-manual/software/cltool.md"
    },
    {
      question: "If you enable logging without setting -lp, where does CLTool store log files by default?",
      options: ["./IS_logs", "/tmp/is_logs", "~/Downloads", "logs/current"],
      answer: 0,
      source: "user-manual/software/cltool.md"
    },
    {
      question: "Which flag forces a bootloader update regardless of version when updating firmware with CLTool?",
      options: ["-fb", "-forceBL", "-bootforce", "-fbldr"],
      answer: 0,
      source: "user-manual/software/cltool.md"
    },
    {
      question: "Which flag runs verification after an application firmware update in CLTool?",
      options: ["-uv", "-verifyApp", "-va", "-checkfw"],
      answer: 0,
      source: "user-manual/software/cltool.md"
    },
    {
      question: "Before compiling CLTool on Linux or Mac, which tool must be installed?",
      options: ["CMake", "Node.js", "GDB", "Docker"],
      answer: 0,
      source: "user-manual/software/cltool.md"
    },
    {
      question: "For the IMX-6 module, what should you do with VBKUP (pin 3) if no backup battery is used?",
      options: [
        "Connect VBKUP to VCC so the module performs a cold start on power-up",
        "Leave VBKUP floating to save power",
        "Tie VBKUP to ground",
        "Connect VBKUP to GPIO5"
      ],
      answer: 0,
      source: "user-manual/hardware/module_imx6.md"
    },
    {
      question: "How do you enable the SPI interface on the IMX-6?",
      options: [
        "Hold pin 10 low during boot",
        "Short pins 6 and 7 during boot",
        "Send an SPI enable command over UART",
        "Tie pin 20 high at reset"
      ],
      answer: 0,
      source: "user-manual/hardware/module_imx6.md"
    },
    {
      question: "What happens if the IMX-6 BOOT_MODE pin (pin 17) is driven high?",
      options: [
        "It reboots into ROM bootloader (DFU) mode",
        "It enters low-power sleep",
        "It forces GNSS PPS output",
        "It disables USB enumeration"
      ],
      answer: 0,
      source: "user-manual/hardware/module_imx6.md"
    },
    {
      question: "What is pin 20 (G15/GNSS_PPS) used for on the IMX-6?",
      options: [
        "Input for GNSS PPS time synchronization pulse",
        "3.3V power input",
        "USB data line",
        "CAN transceiver enable"
      ],
      answer: 0,
      source: "user-manual/hardware/module_imx6.md"
    },
    {
      question: "What voltage is required on VUSB (pin 30) of the IMX-6 for USB operation?",
      options: ["3.0V to 3.6V", "1.2V", "5.0V", "2.4V to 2.8V"],
      answer: 0,
      source: "user-manual/hardware/module_imx6.md"
    },
    {
      question: "Where should the recommended 100nF decoupling capacitor be placed on the IMX-6 PCB?",
      options: [
        "Between pins 21 (GND) and 22 (VCC), close to the module on the same PCB side",
        "Between pins 1 and 2 near the USB lines",
        "Across pins 28 and 29 only",
        "Between VBKUP and ground with long vias"
      ],
      answer: 0,
      source: "user-manual/hardware/module_imx6.md"
    },
    {
      question: "What packaging options are available for IMX-6 modules?",
      options: [
        "Cut tape as well as tape and reel",
        "Loose bulk bags only",
        "Through-hole trays only",
        "Wafer-level tape only"
      ],
      answer: 0,
      source: "user-manual/hardware/module_imx6.md"
    }
  ];

  const state = {
    index: 0,
    score: 0,
    answers: []
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

  const total = questions.length;

  function updateProgress() {
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
    if (state.index >= total) {
      return showResults();
    }

    const q = questions[state.index];
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
    const q = questions[state.index];
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
    els.results.hidden = true;
    renderQuestion();
  }

  renderQuestion();
})();
</script>
