#!/bin/bash

throw(){ echo $@ >&2 ; exit 1; }
          
set_image_name(){ 
  image_name="$(echo $1 | tr A-Z a-z | sed s/_\.\*//g)"
  image_name="${image_name#*/}"
  tag_name="$(echo $1 | tr A-Z a-z | sed s/\.\*_//g)"
  [ ! -z "$tag_name" ] || tag_name=null
  img_desc="${LOGIN_NAME:-coshapp}/${image_name:?no imagename}:${tag_name:?no tagname}-${coshapp_ver:?no ver}${TAG_POSTFIX:+-$TAG_POSTFIX}" 
}

is_non_l10n_img(){
  [ "${tag_name#buster}" = "" ] && return 0 || return 1
}

is_non_test_img(){
  [ "${TAG_POSTFIX}" = "${TAG_POSTFIX%-test}" ] && return 0 || return 1
}
          
build_image(){ 
  set -o xtrace
  for coshapp_ver in ${COSHAPP_DEBIAN_VERSION:-10.7}; do 
    for j in $@; do
      export coshapp_ver;
      set_image_name "$j" ;
      docker build --build-arg=coshapp_ver=$coshapp_ver -t ${img_desc:?img not specified} -f "$j" .;
      : ${tag_name:? tag_name not set} 
      is_non_l10n_img && is_non_test_img && {
          docker tag $img_desc ${img_desc%%:*}:latest
      } || echo skipping...
    done
  done
}

push_image(){
  set -o xtrace
  for coshapp_ver in ${COSHAPP_DEBIAN_VERSION:-10.7}; do 
    for j in $@; do
      export coshapp_ver;
      set_image_name "$j" ;
      : ${img_desc:?img not specified}
      docker push $img_desc
      is_non_l10n_img && is_non_test_img && {
          docker push ${img_desc%%:*}:latest
      } || echo skipping...
    done
  done
}

## filter target images for test images releases on *-dev branch
filter_image(){
  if [ "${GITHUB_REF}" != "${GITHUB_REF%-dev}" ]; then
    filter_target="${TEST_TARGET:-${GITHUB_REF%-dev}}"
    echo */* | tr \\\  \\\n | grep -i "${filter_target:?no filter_target!}"
  elif [ "${GITHUB_REF}" != "${GITHUB_REF%-script}" ]; then
    echo */* | tr \\\  \\\n | grep -i "${TEST_TARGET:-firefox}"
  else
    echo */*  ## equal to build_all
  fi
}

filtered_build(){
  build_image $(filter_image)
}

filtered_push(){
  push_image $(filter_image)
}

build_all(){
  build_image */*
}
