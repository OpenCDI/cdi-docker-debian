#!/bin/sh -e

app_branch="${TRAVIS_BRANCH%%-dev}"
: ${app_branch:?app_branch not set!};

if [ "${TRAVIS_BRANCH}" = test ]; then
  for i in */*; do
    docker build -t "localhost/$app" -f $i .
    docker rmi localhost/$app
  done
else
  for i in $(ls */*) do
    app=$(echo $i | tr A-Z a-z)
    : ${app:?app name not set for $i!}
    [ "$app" = "${app_branch:?app_branch not set!}" ] \
      && {
        docker rmi $(docker images | grep localhost\/)
        docker build -t "localhost/$app" -f $i .
      }
    echo "$app" | grep -iE "^${app_branch:?app_branch not set!}-l10n-.*" \
      && docker build -t "localhost/$app" -f $i .
  done
fi
