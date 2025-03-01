

## Getting started


### La présentation

Ne pas laisser la fenêtre de l'IDE en plein écran.
Dans le terminal de l'IDE:

```console
# Avant de lancer la présentation (et avec une connexion internet correcte), récupérer les images Docker de base
docker pull eclipse-temurin:17-jdk
docker pull docker/dockerfile:1.4
docker pull maven:3.9-eclipse-temurin-17-alpine
docker pull eclipse-temurin:17-jre-alpine

# Lancer la présentation dans un nouveau terminal
gnome-terminal -- bunx slidesk@2.11.3 presentation -n -t

# Initialiser le projet pour la démo
cd project/
rm -f dofigen.lock Dockerfile .dockerignore
echo "" > dofigen.yml
code dofigen.yml -r
export PS1="\\033[1;34m\\W\\033[0m\\$ "
window="$(xdotool search --name "Visual Studio Code")"
xdotool windowsize "$window" 960 540
xdotool windowmove "$window" 0 0
clear
```

Ouvrir la présentation:
- Les notes dans Firefox: [http://localhost:1337/notes.html](http://localhost:1337/notes.html)
- Les slides dans Chrome: [http://localhost:1337](http://localhost:1337)


#### Edition avec modifs en live

```console
bunx slidesk@2.11.3 presentation -w
```

#### Générer un backup des slides

```console
bunx slidesk@2.11.3 presentation -s backup
```


### lancer le projet en local

```console
./mvnw spring-boot:run
```
