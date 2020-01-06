#!/bin/sh

set -exuo pipefail

STATICCHECK=${INPUT_STATICCHECK:-on}
ERRCHECK=${INPUT_ERRCHECK:-on}
GOLINT=${INPUT_GOLINT:-off}
GOLINTPATH=${INPUT_GOLINTPATH:-.}
MISSPELL=${INPUT_MISSPELL:-off}

if [[ $STATICCHECK == "on" ]]; then
  # https://www.staticcheck.io/docs/checks
  go get honnef.co/go/tools/cmd/staticcheck 
  staticcheck ./...
fi

if [[ $GOLINT == "on" ]]; then
  # https://github.com/golang/lint
  go get -u golang.org/x/lint/golint
  golint -set_exit_status=1 ${GOLINTPATH}/...
fi

if [[ $ERRCHECK == "on" ]]; then
  # https://github.com/kisielk/errcheck
  go get -u github.com/kisielk/errcheck
  errcheck ./...
fi

if [[ $MISSPELL == "on" ]]; then
  # https://github.com/client9/misspell
  go get -u github.com/client9/misspell/cmd/misspell
  misspell -error  $(find . -name "*.go")
fi
