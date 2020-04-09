#!/bin/sh

set -exuo pipefail

. /gp-setup.sh
go test ./...
