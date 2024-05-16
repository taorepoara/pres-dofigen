

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
cd /home/taorepoara/presentations/devquest-2024
```


Dans un autre terminal:

```console
bunx slidesk presentation -n -t
```

### Les tests

```console
export num=0
./build.sh
docker run --rm -it -p 8080:8080 devquest-${num}
./stats.sh
```

### lancer le projet en local

```console
./mvnw spring-boot:run
```


## Notes

Ce coaching serait réussi si:
- Je n'ai pas peur d'être ridicule de ma présentation (peur de que des personnes plus techiniques que moi me jugent)
  - S'il voient la valeur de l'outil, ils vont voir l'intérêt
- Qu'on arrive à rendre la présentation intéressante et facile à comprendre pour tout le monde


# Préparer un plan du talk:
## intro: poser la problématique et ce qui ne me plait pas dans la création d'image Docker actuellemnt (pourquoi j'ai créé Dofigen)
## quels concepts sont derrières Dofigen
## comment ça marche
## 
## PKI: temps de compilation, taille des images, temps de mise en place des images, lisibilité du Dockerfile
## Conclusion: pourquoi Dofigen est une solution à ces problèmes, 


# plan

Intro
Poser le problème + ton retour d'expérience lié à ce problème
Quel concept répond à ce problème  ?
Comment ce concept est implémenter dans Dofigen ?
Comment Dofigen aide à résoudre le problème initial ?
Montrer des bénéfices quantifiables: Temps gagné , énergie fournie , Ressenti après utilisation, etc..
Conclusion 


En suivant cette doc: https://spring.io/guides/gs/rest-service

Création d'un projet généré avec [Spring Initializr](https://start.spring.io/) (Maven, Spring Boot 2.5.4, Jar, Java 17, Spring Web)

En suivant cette doc: 



## Debreifing

Pour les problématiques, séparer en trois slides (une slide par problématique) et pour chaque problématique, mettre une image en face pour illustrer le problème.

4 min pour l'intro

Faire des alias shell pour les commandes plutôt que de les écrire à chaque fois un seul script qui fait tout.

Expliciter le nombre des dépendances et leur poid.
449 dépendances dont 133 jar pour un total de 45 Mo

Pour l'URL faire un curl ou un lien vers la page

Pour la v1 (et chaque version suivante):
 faire un highlight les différences dans le code
 ne pas expliciter les métriques et les problèmes, mais juste dire qu'il n'y a pas de surprise/changement et plus insiter sur les avantages


Faire que Dofigen ajoute un commentaire dans le Dockerfile pour dire que c'est généré par Dofigen avec la version

