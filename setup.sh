#!/bin/bash
set -exuo pipefail

export GO111MODULE=on

# Set PROJECT_PATH to change your working directory
if [[ "${PROJECT_PATH:-None}" == "None" ]]; then
  PROJECT_PATH="."
fi

cd $PROJECT_PATH
