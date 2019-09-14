#!/bin/bash
set -exuo pipefail

export GO111MODULE=on

# Set PROJECT_PATH to change your working directory
if [ -z "${PROJECT_PATH}" ]; then
  PROJECT_PATH="."
fi

# Move required files into project path
[ -e "linter.sh" ] && cp "linter.sh" "$PROJECT_PATH/linter.sh" || true

cd $PROJECT_PATH
