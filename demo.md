# Démo

```bash
cd ./project/
```






## Dofigen de base

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

280 Mo -> 78 Mo (/3.5)

- Que le JAR SpringBoot pour le runtime.
- Images Alpine

```bash
cp ../v2/dofigen.yml ./dofigen.yml
```




## Optimisation du temps de build

Temps rebuild: 25s -> 5s (/5)

- restriction du contexte
- utilisation de bind au lieu de copy
- cache des dépendances

```bash
cp ../v3/dofigen.yml ./dofigen.yml
```




## Dofigen Hub

https://github.com/lenra-io/dofigen-hub

```bash
cp ../v4/dofigen.yml ./dofigen.yml
```