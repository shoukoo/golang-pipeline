#!/bin/bash
set exou pipefail

echo $INPUT_TEST
echo $TEST
echo "INSIDE $INSIDE"
echo "OUTSIDE $INSIDE"

test=${INPUT_TEST:-off}

if [[ $test == "off" ]]; then
  echo "hello there"
fi

