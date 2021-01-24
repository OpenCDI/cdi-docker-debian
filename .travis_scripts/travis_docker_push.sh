#!/bin/sh -ex

app_branch=$(echo $TRAVIS_BRANCH | tr A-Z a-z)
app_branch="${app_branch%%-dev}"
: ${app_branch:?app_branch not set!};

case "${TRAVIS_BRANCH}" in
  master) 
  echo "${DOCKER_SECRET:?DOCKER_SECRET not set} \
    | docker login \
      --username "${DOCKER_USER:?DOCKER_USER not set} \
      --password-stdin \
      || { echo Cannot login to DockerHub!; exit 1;}
  for i in */*; do
    app=${i%%_*}:${i#*_}
    app=$(echo ${app:?app not set} | tr A-Z a-z)
    app=${app#*/}
    docker push "coshapp/$app"
    docker push "coshapp/${app}-${COSHAPP_BASE_VERSION:-10.7}"
    [ "$app" = "debian" ] && docker push "coshapp/${app%%:*}:latest"
  done ;;

  *) return 0 ;;
esac

