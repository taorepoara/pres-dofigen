#!/bin/bash

num=$1

#reset
echo "defaultGreeting=World" > src/main/resources/application.properties
docker builder prune --filter type=exec.cachemount -f
export DOCKER_BUILDKIT=1

# Generation via Dofigen
if [ -f v${num}/dofigen.yml ]; then
	pushd v${num}
	dofigen dofigen.yml
	popd
fi

# Build de l'image
echo "Build de l'image"
(time docker build -t devquest-${num} -f v${num}/Dockerfile --no-cache .) 2>&1 | tee .tmp.txt
# Récupération du temps de build
build_time="$(grep "real" .tmp.txt | awk '{print $2}')"
# Utilisateur dans l'image Docker
user="$(docker run --rm  devquest-${num} id -u)"
javac_present="$([ "$(docker run --rm  devquest-${num} which javac)" != "" ] && echo "Présent" || echo "Absent")"
# Taille de l'image
size="$(docker inspect -f "{{ .Size }}" devquest-${num} | numfmt --to=si)"


# Temps avant premier accès
echo "Lancement de l'image"
(time (docker run --rm -d --name devquest-${num} -p 8080:8080 devquest-${num};
echo "Attente de la disponibilité";
while ! curl -s http://localhost:8080/greeting | grep -q "Hello"; do
	sleep 0.1
done)) 2>&1 | tee .tmp.txt

access_time="$(grep "real" .tmp.txt | awk '{print $2}')"

docker stop devquest-${num}


# Temps de rebuild après modification
echo "Rebuild après modification"
echo "defaultGreeting=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13)" > src/main/resources/application.properties
(time docker build -t devquest-${num} -f v${num}/Dockerfile .) 2>&1 | tee .tmp.txt

rebuild_time="$(grep "real" .tmp.txt | awk '{print $2}')"

# Taille du context
printf "FROM scratch\nCOPY . /" > v${num}/context.Dockerfile
if [ -f v${num}/.dockerignore ]; then
	cp v${num}/.dockerignore v${num}/context.Dockerfile.dockerignore
fi
docker build -t context-size -f v${num}/context.Dockerfile --no-cache -q . 2>&1> /dev/null
context_size="$(docker inspect -f "{{ .Size }}" context-size | numfmt --to=si)"

rm -f .tmp.txt v${num}/context.Dockerfile v${num}/context.Dockerfile.dockerignore

format_time() {
	echo $1 | awk -Fm '{print $2}'
}

echo
echo
echo "Résultats:"
echo 
echo "Taille: $size"
echo "Taille du context: $context_size"
echo "Utilisateur: $user"
echo "javac: $javac_present"
echo "Temps de build: $(format_time $build_time)"
echo "Temps de rebuild après modification: $(format_time $rebuild_time)"
echo "Temps avant premier accès: $(format_time $access_time)"

