#!/bin/bash
set -exuo pipefail

export GO111MODULE=on

# Set PROJECT_PATH to change your working directory
if [ -z "${PROJECT_PATH}" ]; then
  PROJECT_PATH="."
fi

# Move required files into project path
[ -e "gp-linter.sh" ] && cp "gp-linter.sh" "$PROJECT_PATH/gp-linter.sh" || true
[ -e "gp-setup.sh" ] && cp "gp-setup.sh" "$PROJECT_PATH/gp-setup.sh" || true

ls -al

cd $PROJECT_PATH
