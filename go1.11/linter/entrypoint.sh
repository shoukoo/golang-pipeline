#!/bin/bash

set -exuo pipefail

export GO111MODULE=on

INSIDE=entry
OUTSIDE=entry
make setup

echo "==== from setup"
echo $test

# https://www.staticcheck.io/docs/checks
go get honnef.co/go/tools/cmd/staticcheck 
staticcheck ./...
