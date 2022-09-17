#!/bin/sh

set -exuo pipefail

STATICCHECK=${INPUT_STATICCHECK:-on}
ERRCHECK=${INPUT_ERRCHECK:-on}
GOLINT=${INPUT_GOLINT:-off}
GOLINTPATH=${INPUT_GOLINTPATH:-.}
MISSPELL=${INPUT_MISSPELL:-off}

if [[ $STATICCHECK == "on" ]]; then
  # https://www.staticcheck.io/docs/checks
  go install honnef.co/go/tools/cmd/staticcheck@latest
  staticcheck ./...
fi

if [[ $GOLINT == "on" ]]; then
  # https://github.com/golang/lint
  go install golang.org/x/lint/golint@latest
  golint -set_exit_status=1 ${GOLINTPATH}/...
fi

if [[ $ERRCHECK == "on" ]]; then
  # https://github.com/kisielk/errcheck
  go install github.com/kisielk/errcheck@latest
  errcheck ./...
fi

if [[ $MISSPELL == "on" ]]; then
  # https://github.com/client9/misspell
  go install github.com/client9/misspell/cmd/misspell@latest
  misspell -error  $(find . -name "*.go")
fi
