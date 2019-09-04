#!/bin/bash

set -exuo pipefail

export GO111MODULE=on

EVENT_DATA=$(cat $GITHUB_EVENT_PATH)
ACTION_NAME=$(echo $EVENT_DATA | jq -r .action)
RELEASE_NAME=$(echo $EVENT_DATA | jq -r .release.tag_name)
UPLOAD_URL=$(echo $EVENT_DATA | jq -r .release.upload_url)
UPLOAD_URL=${UPLOAD_URL/\{?name,label\}/}

# The release triggers multiple github action builds and we only want
# published action in the release trigger to upload the files.
# https://help.github.com/en/articles/events-that-trigger-workflows

if [[ $ACTION_NAME == "published" ]]; then
  LINUX_BIN="tfv-linux-amd64"
  DARWIN_BIN="tfv-darwin-amd64"
  WINDOWS_BIN="tfv-windows-amd64.exe"

  GOOS=linux GOARCH=amd64 go build -o $LINUX_BIN
  GOOS=darwin GOARCH=amd64 go build -o $DARWIN_BIN
  GOOS=windows GOARCH=amd64 go build -o $WINDOWS_BIN

  for i in $LINUX_BIN $DARWIN_BIN $WINDOWS_BIN; do
    curl \
      --fail \
      -X POST \
      --data-binary @${i}\
      -H 'Content-Type: application/octet-stream' \
      -H "Authorization: Bearer ${GITHUB_TOKEN}" \
      "${UPLOAD_URL}?name=${i}"

    CHECKSUM=$(md5sum $i | cut -d ' ' -f 1)

    curl \
      -X POST \
      --data $CHECKSUM \
      -H 'Content-Type: text/plain' \
      -H "Authorization: Bearer ${GITHUB_TOKEN}" \
      "${UPLOAD_URL}?name=${i}_checksum.txt"
  done
fi
