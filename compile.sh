#!/bin/bash

clone_repository(){
  local git_repository="$1"
  local git_ref="$2"

  git clone "$git_repository" .
  git checkout "$git_ref"
}

export_tar_gz(){
  cd /usr/src \
  && tar -czf /export/app-linux-arm.tar.gz app
}

fatal(){
  local message="$1"
  echo "$message"
  exit 1
}

install_apt_dependencies(){
  local apt_dependencies="$@"

  if [ -z "$apt_dependencies" ]; then
    return
  fi

  apt-get install $apt_dependencies # intentionally unquoted
}

install_dependencies(){
  npm install --silent
}

prepare_environment(){
  mkdir -p /usr/src/app \
  && cd /usr/src/app
}

main(){
  local git_repository="$1"; shift
  local git_ref="$1"; shift
  local apt_dependencies="$@"

  prepare_environment                           || fatal "Failed to prepare environment"
  install_apt_dependencies "$apt_dependencies"  || fatal "Failed to install apt dependencies"
  clone_repository "$git_repository" "$git_ref" || fatal "Failed to clone repository"
  install_dependencies || fatal "Failed to install dependencies"
  export_tar_gz        || fatal "Failed to export package"
}
main $@
