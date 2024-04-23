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

## Getting started

```console
./mvnw spring-boot:run
```


## Les tests

```console
export num=0
./build.sh
docker run --rm -it -p 8080:8080 devquest-${num}
./stats.sh
```

## La présentation

```console
bunx slidesk presentation
```