#!/bin/bash 

set -euo pipefail

mkdir -p .github/workflows
if [ -f ".github/workflows/push.yml" ]; then 
  echo ".github/workflows/push.yml already exists!"
  exit 1
fi

cat << EOF > .github/workflows/push.yaml
on: push
name: build
jobs:
  go-test:
    name: Go Test
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: go1.12  linters
      uses: shoukoo/golang-pipeline/go1.12/linter@master
    - name: go1.12 test
      uses: shoukoo/golang-pipeline/go1.12/test@master
EOF

echo "> Created .github/worflows/push.yml"
echo "> Done!"
