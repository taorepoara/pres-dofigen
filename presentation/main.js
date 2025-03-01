(async () => {
	const modal = document.createElement('dialog');
	modal.innerHTML = `<p>Initialisation du partage d'écran</p>`;
	const cancelButton = document.createElement('button');
	cancelButton.textContent = 'Annuler';
	cancelButton.onclick = () => {
		modal.close();
	};
	modal.appendChild(cancelButton);
	const startButton = document.createElement('button');
	startButton.textContent = 'Commencer';
	startButton.onclick = async () => {
		const video = document.querySelector('video');
		video.onclick = () => {
			video.parentNode.classList.toggle('fullscreen');
		};

		const stream = await navigator.mediaDevices
			.getDisplayMedia({ audio: false })
			.catch((err) => {
				console.error(err);
				alert("Une erreur est survenue lors de la récupération de l'écran");
				throw err;
			});

		video.srcObject = stream;
		video.onloadedmetadata = () => {
			video.play();
			console.log("Video is playing");
		};
		modal.close();
	};
	modal.appendChild(startButton);
	document.body.appendChild(modal);
	modal.showModal();
})();

