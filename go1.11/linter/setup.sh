#!/bin/bash
set -exuo pipefail

if [ -z "${PROJECT_PATH}" ]; then
  PROJECT_PATH="."
fi

echo "============"
echo $PROJECT_PATH
cd $PROJECT_PATH
