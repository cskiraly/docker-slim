#!/usr/bin/env bash

set -e

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
SDIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

source $SDIR/env.sh
pushd $BDIR
mkdir -p _vendor
pushd $BDIR/_vendor
mkdir -p src/github.com/docker-slim
ln -sf $BDIR src/github.com/docker-slim/docker-slim
go get github.com/cloudimmunity/go-dockerclientx
go get github.com/cloudimmunity/pdiscover
go get github.com/cloudimmunity/system
go get github.com/codegangsta/cli
go get github.com/Sirupsen/logrus
go get github.com/franela/goreq
go get github.com/go-mangos/mangos
go get github.com/dustin/go-humanize
go get -d bitbucket.org/madmo/fanotify
go get github.com/docker/go-connections/nat
popd
pushd $BDIR/apps/docker-slim
gox -osarch="linux/amd64" -output="$BDIR/bin/linux/docker-slim"
gox -osarch="darwin/amd64" -output="$BDIR/bin/mac/docker-slim"
popd
pushd $BDIR/apps/docker-slim-sensor
gox -osarch="linux/amd64" -output="$BDIR/bin/linux/docker-slim-sensor"
popd
popd
