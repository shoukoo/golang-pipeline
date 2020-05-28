#!/bin/sh

set -exuo pipefail

EVENT_DATA=$(cat $GITHUB_EVENT_PATH)
UPLOAD_URL=$(echo $EVENT_DATA | jq -r .release.upload_url)
UPLOAD_URL=${UPLOAD_URL/\{?name,label\}/}

if [ -z "${BINARY_NAME}" ]; then
  BINARY_NAME=$(basename $GITHUB_REPOSITORY)
fi

EXT=""
if [ $GOOS == 'windows' ]; then
    EXT='.exe'
fi

ARTIFACT_NAME="${BINARY_NAME}-${GOOS}-${GOARCH}${EXT}"

echo "Building $ARTIFACT_NAME" 
CGO_ENABLED=0 go build -ldflags "-s -w" -o "${BINARY_NAME}"

tar cvfz tmp.tgz "${BINARY_NAME}"
CHECKSUM=$(sha256sum tmp.tgz | cut -d ' ' -f 1)

curl \
  --fail \
  -X POST \
  --data-binary @tmp.tgz\
  -H 'Content-Type: application/octet-stream' \
  -H "Authorization: Bearer ${GITHUB_TOKEN}" \
  "${UPLOAD_URL}?name=${ARTIFACT_NAME}.tar.gz"


curl \
  -X POST \
  --data "$CHECKSUM" \
  -H 'Content-Type: text/plain' \
  -H "Authorization: Bearer ${GITHUB_TOKEN}" \
  "${UPLOAD_URL}?name=${ARTIFACT_NAME}_checksum_sha256.txt"
