#!/bin/bash

set -exuo pipefail

export GO111MODULE=on

./setup.sh

# https://www.staticcheck.io/docs/checks
go get honnef.co/go/tools/cmd/staticcheck 
staticcheck ./...
