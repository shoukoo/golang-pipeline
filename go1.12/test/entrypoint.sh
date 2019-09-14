#!/bin/bash

set -exuo pipefail

. ./setup.sh
go test ./..
