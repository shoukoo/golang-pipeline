#!/bin/bash

set -exuo pipefail

. ./gp-setup.sh
go test ./..
