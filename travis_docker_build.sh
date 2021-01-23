#!/bin/sh -ex

app_branch=$(echo $TRAVIS_BRANCH | tr A-Z a-z)
app_branch="${app_branch%%-dev}"
: ${app_branch:?app_branch not set!};

case "${TRAVIS_BRANCH}" in
  master) 
  docker login \
    -u "${DOCKERHUB_USER:?DOCKERHUB_USER not set} \
    -p "${DOCKERHUB_SECRET:?DOCKERHUB_SECRET not set} \
    || { echo Cannot login to DockerHub!; exit 1;}
  for i in */*; do
    app=${i%%_*}:${i#*_}
    app=$(echo ${app:?app not set} | tr A-Z a-z)
    docker build -t "coshapp/$app" -f $i .
    docker push "coshapp/$app"
    docker tag "coshapp/$app" "coshapp/${app}-${OPENCDI_BASE_VERSION:-10.7}"
    docker push "coshapp/${app}-${OPENCDI_BASE_VERSION:-10.7}"
  done ;;

  test)
  for i in */*; do
    app=${i%%_*}:${i#*_}
    app=$(echo ${app:?app not set} | tr A-Z a-z)
    # if traviz local cache have any localhost/* image in other app, delete them
    if docker images | grep localhost | grep -v $app; then
      docker rmi $(docker images | grep localhost\/ | awk '{print $1 ":" $2}')
    fi
    docker build -t "localhost/$app" -f $i .
    docker rmi localhost/$app
  done ;;
  *-dev)
  for i in $(ls */*); do
    app=$(echo $i | tr A-Z a-z)
    app=${app##*/}
    app=${app%%_*}
    : ${app:?app name not set for $i!}
    [ "$app" = "${app_branch:?app_branch not set!}" ] \
      && {
        docker build -t "localhost/$app" -f $i .
      }
    echo "$app" | grep -iE "^${app_branch:?app_branch not set!}-l10n-.*" \
      && docker build -t "localhost/$app" -f $i . \
      || echo $app skipped.
  done ;;
esac

