

## Getting started


### La présentation

Avant de lancer la présentation (et avec une connexion internet correcte), récupérer les images Docker de base:

```console
docker pull eclipse-temurin:17-jdk
docker pull docker/dockerfile:1.4
docker pull maven:3.9-eclipse-temurin-17-alpine
docker pull eclipse-temurin:17-jre-alpine
```

Lancer un terminale et exécuter la commande suivante:

```console
cd /home/taorepoara/presentations/pres-dofigen
```


Dans un autre terminal:

```console
bunx slidesk@2.7.7 presentation -n -t
```

#### Générer un backup des slides

```console
bunx slidesk@2.7.7 presentation -s backup
```


### lancer le projet en local

```console
./mvnw spring-boot:run
```
