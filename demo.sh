#!/bin/bash

num=$1
debug="$2"

get_output=" > .tmp.txt"

progress=""

if [ "$debug" != "" ]; then
	get_output=" | tee .tmp.txt"
fi

if [ "$debug" == "2" ]; then
	progress=" --progress=plain"
fi

log() {
	# [ "$debug" != "" ] && echo $1
	echo $1
}

eval_cmd() {
	[ "$debug" == "2" ] && echo $1
	eval "$1"
}

eval_nooutput() {
	cmd="$1 2>&1 > /dev/null"
	eval_cmd "$cmd"
}

eval_time() {
	[ "$debug" != "" ] && exec 3>&1 4>&2
	local time_cmd=""
	for arg in "$@"
	do
		[ "$time_cmd" != "" ] && time_cmd="$time_cmd; "
		time_cmd="${time_cmd}$arg"
		if [ "$debug" == "" ]; then
			time_cmd="$time_cmd 2>&1 > /dev/null"
		else
			time_cmd="$time_cmd 1>&3 2>&4"
		fi
	done
	time_cmd="(TIMEFORMAT=\"%R\"; time ($time_cmd)) 2>&1"
	
	exec_time=`eval_cmd "$time_cmd" | tail -n 1`
	
	[ "$debug" != "" ] && exec 3>&- 4>&-
}

#reset
echo "defaultGreeting=World" > project/src/main/resources/application.properties
eval_nooutput "docker builder prune --filter type=exec.cachemount -f"
export DOCKER_BUILDKIT=1

# Generation via Dofigen
if [ -f v${num}/dofigen.yml ]; then
	eval_nooutput "pushd v${num}"
	eval_nooutput "dofigen gen"
	eval_nooutput "popd"
fi

# Build de l'image
log "Build de l'image"
eval_time "docker build -t devquest-${num} -f v${num}/Dockerfile --no-cache $progress project"
build_time="$exec_time"

# Récupération du temps de build
# build_time="$(grep "real" .tmp.txt | awk '{print $2}')"
# Utilisateur dans l'image Docker
user="$(docker run --rm  devquest-${num} id -u)"
javac_present="$([ "$(docker run --rm  devquest-${num} which javac)" != "" ] && echo "Présent" || echo "Absent")"
# Taille de l'image
size="$(docker inspect -f "{{ .Size }}" devquest-${num} | numfmt --to=si)"


# Temps avant premier accès
log "Lancement de l'image"
eval_time \
"docker run --rm -d --name devquest-${num} -p 8080:8080 devquest-${num}" \
"log 'Attente de la disponibilité'" \
"while ! curl -s http://localhost:8080/greeting | grep -q 'Hello'; do	sleep 0.1; done"

access_time="$exec_time"

eval_nooutput "docker stop devquest-${num}"


# Temps de rebuild après modification
log "Rebuild après modification"
echo "defaultGreeting=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13)" > project/src/main/resources/application.properties
eval_time "docker build -t devquest-${num} -f v${num}/Dockerfile $progress project"

rebuild_time="$exec_time"

# Taille du context
printf "FROM scratch\nCOPY . /" > v${num}/context.Dockerfile
if [ -f v${num}/.dockerignore ]; then
	eval_nooutput "cp v${num}/.dockerignore v${num}/context.Dockerfile.dockerignore"
fi
eval_nooutput "docker build -t context-size -f v${num}/context.Dockerfile --no-cache -q ."
context_size="$(docker inspect -f "{{ .Size }}" context-size | numfmt --to=si)"

eval_nooutput "rm -f .tmp.txt .out.log v${num}/context.Dockerfile v${num}/context.Dockerfile.dockerignore"

echo
echo
echo "Résultats:"
echo 
echo "Taille: $size"
echo "Taille du context: $context_size"
echo "Utilisateur: $user"
echo "javac: $javac_present"
echo "Temps de build: ${build_time}s"
echo "Temps de rebuild après modification: ${rebuild_time}s"
echo "Temps avant premier accès: ${access_time}s"

