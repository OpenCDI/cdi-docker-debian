#!/bin/sh -ex

app_branch="${TRAVIS_BRANCH%%-dev}"
: ${app_branch:?app_branch not set!};

if [ "${TRAVIS_BRANCH}" = test ]; then
  for i in */*; do
    docker build -t "localhost/$app" -f $i .
    docker rmi localhost/$app
  done
else
  for i in $(ls */*); do
    app=$(echo $i | tr A-Z a-z)
    app=${app##*/}
    app=${app%%_*}
    : ${app:?app name not set for $i!}
    [ "$app" = "${app_branch:?app_branch not set!}" ] \
      && {
        # if traviz local cache have any localhost/* image, delete them
        if docker images | grep localhost; then
          docker rmi $(docker images | grep localhost\/)
        fi
        docker build -t "localhost/$app" -f $i .
      }
    echo "$app" | grep -iE "^${app_branch:?app_branch not set!}-l10n-.*" \
      && docker build -t "localhost/$app" -f $i . \
      || echo $app skipped.
  done
fi
