#!/bin/bash

escape(){
  local str="$1"

  # "path/to/file" -> "path\/to\/file"
  echo "$str" | sed --expression 's|/|\\\/|g'
}

export_tar_gz(){
  local src_dir="$1"
  local output_dir="$2"
  local parent_directory="$(dirname "$src_dir")"
  local directory_name="$(basename "$src_dir")"

  pushd "$parent_directory" \
  && tar \
    --create \
    --gzip \
    --transform "s/${directory_name}/app/" \
    --file "${output_dir}/app-linux-arm.tar.gz" \
    "${directory_name}"

  local exit_code=$?
  popd
  return $exit_code
}

fatal(){
  local message="$1"
  echo "$message"
  exit 1
}

fix_build_paths(){
  local build_paths="$(find . -type d -name 'node-*-linux-x64')"

  rename -e 's/linux-x64/linux-arm/' $build_paths # intentionally unquoted
}

install_dependencies(){
  npm_install \
  && fix_build_paths
}

npm_install(){
  env \
    npm_config_arch=arm \
    CC=arm-linux-gnueabihf-gcc-4.9 \
    CXX=arm-linux-gnueabihf-g++-4.9 \
    /opt/node/bin/npm install --build-from-source

}

main(){
  local src_dir="$1"
  local output_dir="$2"

  install_dependencies || fatal "Failed to install dependencies"
  export_tar_gz "$src_dir" "$output_dir" || fatal "Failed to export package"
}
main $@
