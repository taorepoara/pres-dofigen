# Démo


## Dofigen de base

- Création depuis l'image `eclipse-temurin:17-jdk`
- définir le répertoire de travail: `/app`
- copie des sources
- En tant que `root`:
  - Génération du jar: `./mvnw package -DskipTests`
  - copie du jar généré en dehors du dossier de build: `mv target/*.jar app.jar`
- Définition de la commande de lancement: `java -jar app.jar`




Image un peu lourde: 280 Mo
Temps de build et rebuild de 25 sec (sans le pull des images)
Contient un JDK

Mais user non root



```bash
cp ../v1/dofigen.yml ./dofigen.yml
```

```bash
dofigen gen
code Dockerfile -r
```

```bash
docker build -t demo:1 .
docker run --rm -dt --name demo -p 8081:8080 demo:1
```

```bash
curl http://localhost:8081/greeting && echo ""
```

```bash
docker stop demo
```





## Réduction de la taille de l'image


- Création d'un builder:
  - utilisation d'une image Maven Alpine: `maven:3.9-eclipse-temurin-17-alpine`
  - utilisation de la commande `mvn` au lieu du wrapper
- utilisation d'une image JRE et Alpine: `eclipse-temurin:17-jre-alpine`
- copy du jar généré


280 Mo -> 78 Mo (/3.5)

```bash
cp ../v2/dofigen.yml ./dofigen.yml
```




## Optimisation du temps de build

- restriction du contexte au `pom.xml` et au dossier `src/main`
- cache des dépendances Maven `/root/.m2` et du cache de build `target`. Obligation de déplacer le JAR généré en dehors du dossier de build.
- utilisation de bind au lieu de copy (oblgation de bind le pom et `src` séparémment pour ne pas être en conflit avec le cache)


Temps rebuild: 25s -> 5s (/5)

```bash
cp ../v3/dofigen.yml ./dofigen.yml
```
