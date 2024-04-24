window.slidesk.xterm_response = (data) => {
  window.slidesk.terminals[data.response.key].writeln("");
  [...data.response.result.trim().split("\n")].forEach((l) =>
    window.slidesk.terminals[data.response.key].writeln(l)
  );
  window.slidesk.terminals[data.response.key].prompt();
};

window.slidesk.xterm_char = (data) => {
  const key = `${window.slidesk.currentSlide}_0`;
  window.slidesk.terminals[key].treat(data.char);
};

class XTerm {
  constructor(key, fromNotes) {
    this.key = key;
    this.fromNotes = fromNotes ?? false;
    this.terminal = new Terminal({
      theme: {
        foreground: "#eff0eb",
        background: "#282a36",
        selection: "#97979b33",
        black: "#282a36",
        brightBlack: "#686868",
        red: "#ff5c57",
        brightRed: "#ff5c57",
        green: "#5af78e",
        brightGreen: "#5af78e",
        yellow: "#f3f99d",
        brightYellow: "#f3f99d",
        blue: "#57c7ff",
        brightBlue: "#57c7ff",
        magenta: "#ff6ac1",
        brightMagenta: "#ff6ac1",
        cyan: "#9aedfe",
        brightCyan: "#9aedfe",
        white: "#f1f1f0",
        brightWhite: "#eff0eb",
      },
      cursorBlink: true,
      allowProposedApi: true,
    });
    this.command = "";
    this.cwd = window.slidesk.cwd;
  }

  treat(e) {
    switch (e) {
      case "\u0003": // Ctrl+C
        this.terminal.write("^C");
        this.prompt();
        break;
      case "\r": // Enter
        if (this.command === "") {
          this.prompt();
        } else if (this.command.startsWith("cd ")) {
          if (this.command.startsWith("cd /"))
            this.cwd = `${this.command.substring(3)}/`;
          else if (this.command.length <= 3) this.cwd = window.slidesk.cwd;
          else this.cwd = `${this.cwd}${this.command.substring(3)}/`;
          this.prompt();
        } else if (this.command === "clear") {
          this.terminal.clear();
          this.prompt();
        } else {
          window.slidesk.io.send(
            JSON.stringify({
              plugin: "xterm",
              key: this.key,
              command: this.command,
              cwd: this.cwd,
              env: window.slidesk.env,
            })
          );
        }
        this.command = "";
        break;
      case "\u007F": // Backspace (DEL)
        // Do not delete the prompt
        if (this.terminal._core.buffer.x > 2) {
          this.terminal.write("\b \b");
          this.command = this.command.substring(0, this.command.length - 1);
        }
        break;
      default: // Print all other characters for demo
        if (
          (e >= String.fromCharCode(0x20) && e <= String.fromCharCode(0x7e)) ||
          e >= "\u00a0"
        ) {
          this.command += e;
          this.terminal.write(e);
        }
    }
  }

  startListening() {
    this.terminal.onData((e) => {
      if (this.fromNotes)
        window.slidesk.io.send(
          JSON.stringify({ action: "xterm_char", char: e })
        );
      this.treat(e);
    });
  }

  prompt() {
    this.terminal.write(`\r\n$ `);
  }

  write(message) {
    this.terminal.write(message);
  }

  writeln(message) {
    this.terminal.writeln(message);
  }

  attachTo(container) {
    this.terminal.open(container);
    // Default text to display on terminal.
    this.terminal.write("\x1b[36;49mSliDesk Terminal\x1b[0m");
    this.terminal.write("");
    this.prompt();
  }

  clear() {
    this.terminal.clear();
  }
}

window.slidesk.terminals = [];

window.slidesk.manageXTerm = () => {
  if (
    !window.slidesk.slides[window.slidesk.currentSlide].classList.contains(
      "xtermed"
    )
  ) {
    window.slidesk.slides[window.slidesk.currentSlide].classList.add("xtermed");
    const xterms =
      window.slidesk.slides[window.slidesk.currentSlide].querySelectorAll(
        ".xterm"
      );
    if (xterms.length) {
      xterms.forEach((el, i) => {
        const key = `${window.slidesk.currentSlide}_${i}`;
        if (!window.slidesk.terminals[key]) {
          window.slidesk.terminals[key] = new XTerm(key);
          window.slidesk.terminals[key].attachTo(el);
          el.addEventListener("wheel", (e) => {
            if (
              window.slidesk.terminals[key].terminal.buffer.active.baseY > 0
            ) {
              e.preventDefault();
            }
          });
          window.slidesk.terminals[key].startListening();
        }
      });
    }
  }
};

window.slidesk.manageXTermNotes = () => {
  document.querySelector("#sd-sv-future").classList.remove("xtermed");
  setTimeout(() => {
    if (document.querySelector("#sd-sv-current .xterm")) {
      window.slidesk.terminals.notes = new XTerm("notes", true);
      window.slidesk.terminals.notes.attachTo(
        document.querySelector("#sd-sv-future")
      );
      document.querySelector("#sd-sv-future").classList.add("xtermed");
      document.querySelector("#sd-sv-future").addEventListener("wheel", (e) => {
        if (window.slidesk.terminals.notes.terminal.buffer.active.baseY > 0) {
          e.preventDefault();
        }
      });
      window.slidesk.terminals.notes.startListening();
    }
  }, 100);
};
