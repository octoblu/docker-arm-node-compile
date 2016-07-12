#!/bin/bash

build(){
  docker build -t local/arm-node-compile:latest .
}

fatal(){
  local message="$1"
  echo "$message"
  exit 1
}

push(){
  docker push octoblu/arm-node-compile:latest
}

tag(){
  docker tag local/arm-node-compile:latest octoblu/arm-node-compile:latest
}

main(){
  build || fatal "Failed to build"
  tag   || fatal "Failed to tag"
  push  || fatal "Failed to push"
}
main $@
