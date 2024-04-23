#!/bin/bash

# Temps de rebuild après modification
echo "defaultGreeting=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13)" > src/main/resources/application.properties
time DOCKER_BUILDKIT=1 docker build -t devquest-${num} -f v${num}/Dockerfile .
# Utilisateur dans l'image Docker
echo "Utilisateur: $(docker run --rm  devquest-${num} id -u)"
# Taille de l'image
echo "Taille: $(docker inspect -f "{{ .Size }}" devquest-${num} | numfmt --to=si)"
# Taille du context
printf "FROM scratch\nCOPY . /" > v${num}/context.Dockerfile
if [ -f v${num}/.dockerignore ]; then
	cp v${num}/.dockerignore v${num}/context.Dockerfile.dockerignore
fi
docker build -t context-size -f v${num}/context.Dockerfile --no-cache -q . 2>&1> /dev/null
echo "Taille du context: $(docker inspect -f "{{ .Size }}" context-size | numfmt --to=si)"
# Génération d'un tar avec le contexte
# docker build -f v${num}/context.Dockerfile --no-cache -q --output type=tar,dest=v${num}/context.tar . 2>&1> /dev/null
# echo "Taille du context: $(du -h v${num}/context.tar | cut -f1)"
