const OPTIONS_TERM = {
  useStyle: true,
  screenKeys: true,
  cursorBlink: true,
  //You have to set the same number in your server
  cols: 100,
  theme: {
    background: "#333",
    fontFamily: 'Arial',
  }
};

let term;

window.slidesk.xterm_response = (data) => {
  console.log(data);
  if (data.data)
    term.write(data.data);
};

document.querySelectorAll(".xterm").forEach((xterm, _) => {
  term = new Terminal(OPTIONS_TERM);
  term.open(xterm);
  term.onData((data) => {
    window.slidesk.io.send(
      JSON.stringify({
        plugin: "xterm",
        data
      })
    );
  });
  setTimeout(() => {
    window.slidesk.io.send(
      JSON.stringify({
        plugin: "xterm",
        data: 'export PS1="\\033[1;34m\\W\\033[0m\\$ "\n'
      })
    );
    window.slidesk.io.send(
      JSON.stringify({
        plugin: "xterm",
        data: "clear\n"
      })
    );
  }, 500)
});