#!/bin/sh
set -exuo pipefail

export GO111MODULE=on

WORK_SPACE=${PROJECT_PATH:-}

# Set PROJECT_PATH to change your working directory
if [ -z "${WORK_SPACE}" ]; then
  WORK_SPACE="."
fi

cd $WORK_SPACE
