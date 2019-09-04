#!/bin/bash

set -exuo pipefail

export GO111MODULE=on
go test -v

