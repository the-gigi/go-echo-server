#!/usr/bin/env zsh

VERSION=0.1
IMAGE=g1g1/echo-server:${VERSION}


function docker_build() {
  docker build -t ${IMAGE} .
}

function docker_push() {
	echo ${DOCKERHUB_PASSWORD} | docker login -u ${DOCKERHUB_USERNAME} --password-stdin
	docker push ${IMAGE}
}

function docker_run() {
  docker run -p 7070:7070 g1g1/echo-server:0.1
}
# Run the function that was passed as argument
$1
