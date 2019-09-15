#!/bin/bash

set -exuo pipefail

. ./g-setup.sh
go test ./..
