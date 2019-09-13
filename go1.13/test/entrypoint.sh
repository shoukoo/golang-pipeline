#!/bin/bash

set -exuo pipefail

export GO111MODULE=on
make test

