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

is_non_test_no_core_img(){
  if [ -z "${TEST_TARGET}" ] || [ "${image_name}" = "core" ]; then
    return 0
  else
    return 1
  fi
}
          
build_image(){ 
  set -o xtrace
  # for autobuild and shipping on \*-test (but not core-test) branches
  if [ -n "$TEST_TARGET" ] && [ "$TEST_TARGET" = "${TEST_TARGET#Core_*}" ]; then 
    docker pull coshapp/core:buster-10.9-test
    docker pull coshapp/core:buster-l10n-ja-10.9-test
    docker tag coshapp/core:buster-10.9-test coshapp/core:buster-10.9
    docker tag coshapp/core:buster-l10n-ja-10.9-test coshapp/core:buster-l10n-ja-10.9
  fi
  for coshapp_ver in ${COSHAPP_DEBIAN_VERSION:-10.9}; do 
    for j in $@; do
      export coshapp_ver;
      set_image_name "$j" ;
      docker build --build-arg=coshapp_ver=$coshapp_ver -t ${img_desc:?img not specified} -f "$j" .;
      : ${tag_name:? tag_name not set} 
      is_non_l10n_img && is_non_test_no_core_img && {
          docker tag $img_desc ${img_desc%%:*}:latest
      } || echo skipping...
    done
  done
}

push_image(){
  set -o xtrace
  for coshapp_ver in ${COSHAPP_DEBIAN_VERSION:-10.9}; do 
    for j in $@; do
      export coshapp_ver;
      set_image_name "$j" ;
      : ${img_desc:?img not specified}
      docker push $img_desc
      is_non_l10n_img && is_non_test_no_core_img && {
          docker push ${img_desc%%:*}:latest
      } || echo skipping...
    done
  done
}

## filter target images for test images releases on *-test branch
filter_image(){
  if [ "${GITHUB_REF}" != "${GITHUB_REF%-test}" ]; then
    filter_target="${TEST_TARGET:-${GITHUB_REF%-test}}"
    echo */* | tr \\\  \\\n | grep -i "${filter_target##*/}"
  elif [ "${GITHUB_REF}" != "${GITHUB_REF%-script}" ]; then
    echo */* | tr \\\  \\\n | grep -i "${TEST_TARGET:-firefox}"
  else
    echo */*  ## equal to build_all
  fi
}

# build with branch filtering
filtered_build(){ build_image $(filter_image); }

# push with branch filtering
filtered_push(){ push_image $(filter_image); }

# build all images ontshot
build_all(){ build_image */*; }

push_core(){ push_image Debian-Base/Core_*; }

build_core(){ build_image Debian-Base/Core_*; }

# remove all image without core
rmi_without_core(){
  images="$(docker images | grep ${LOGIN_NAME:-coshapp} | awk '{print $1 ":" $2}' | grep -v ${LOGIN_NAME:-coshapp}/core:)"
  docker rmi $images
}

# variable TEST_TARGET is created from branch name
# for *-test branches, TEST_TARGET=*
# for test branch, TEST_TARET not set
set_test_target(){
  TAG_POSTFIX="test" 
  [ $# -ne 0 ] && TEST_TARGET="$1"
  [ $# -eq 0 ] && [ "${GITHUB_REF}" != "${GITHUB_REF%-test}" ] && {
    TEST_TARGET="${GITHUB_REF%-test}"
    TEST_TARGET="${TEST_TARGET##*/}"
  }
}
