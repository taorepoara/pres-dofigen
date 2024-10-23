function openCode() {
	window.slidesk.io.send(
		JSON.stringify({
			plugin: "xterm",
			data: 'code project\nsleep 2\nsleep 1\nxdotool key "Ctrl+plus"\nxdotool key "F11"\n'
		})
	);
}