#!/bin/sh

set -exuo pipefail

EVENT_DATA=$(cat $GITHUB_EVENT_PATH)
UPLOAD_URL=$(echo $EVENT_DATA | jq -r .release.upload_url)
UPLOAD_URL=${UPLOAD_URL/\{?name,label\}/}
PROJECT_NAME=$(basename $GITHUB_REPOSITORY)
EXT=""
if [ $GOOS == 'windows' ]; then
    EXT='.exe'
fi
NAME="${PROJECT_NAME}-${GOOS}-${GOARCH}${EXT}"

echo "Building $NAME under $GOOS/$GOARCH"
go build -o "${PROJECT_NAME}"

tar cvfz tmp.tgz "${PROJECT_NAME}"
CHECKSUM=$(sha256sum tmp.tgz | cut -d ' ' -f 1)

curl \
  --fail \
  -X POST \
  --data-binary @tmp.tgz\
  -H 'Content-Type: application/octet-stream' \
  -H "Authorization: Bearer ${GITHUB_TOKEN}" \
  "${UPLOAD_URL}?name=${NAME}.tar.gz"


curl \
  -X POST \
  --data "$CHECKSUM" \
  -H 'Content-Type: text/plain' \
  -H "Authorization: Bearer ${GITHUB_TOKEN}" \
  "${UPLOAD_URL}?name=${NAME}_checksum_sha256.txt"
