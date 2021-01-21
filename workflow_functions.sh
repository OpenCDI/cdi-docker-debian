#!/bin/bash

throw(){ echo $@ >&2 ; exit 1; }
          
set_image_name(){ 
  image_name=`echo $1 | tr A-Z a-z | sed s/_\.\*//g`; 
  image_name=${image_name#*/};
  tag_name=`echo $1 | tr A-Z a-z | sed s/\.\*_//g`; 
  test ! -z "$tag_name" || tag_name=null
  img_desc="${LOGIN_NAME:-coshapp}/${image_name:?no imagename}:${tag_name:?no tagname}-${coshapp_ver:?no ver}" 
}
          
build_image(){ 
  coshapp_ver=`cat ${1%%/*}/version`
  for coshapp_ver in ${coshapp_ver:-10.7}; do 
    for j in $@; do
      export coshapp_ver;
      set_image_name $j ;
      test `basename $j` = "version" && break;
      docker build --build-arg=coshapp_ver=$coshapp_ver -t ${img_desc:?img not specified} -f $j .;
      docker push $img_desc
      set -o xtrace
      test ${tag_name:? tag_name not set} != "${tag_name##debian}" && \
        test "${tag_name##debian}" = "" && {
          docker tag $img_desc ${img_desc%%:*}:latest
          docker push ${img_desc%%:*}:latest
        }
    done
  done
}
