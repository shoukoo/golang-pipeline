FROM golang:latest

LABEL name="Golang Pipeline"
LABEL maintainer="Shoukoo"
LABEL version="0.1.0"
LABEL repository="https://github.com/shoukoo/golang-pipeline"

LABEL com.github.actions.name="Golang Pieline"
LABEL com.github.actions.description="Intrudction"
LABEL com.github.actions.icon="box"
LABEL com.github.actions.color="blue"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
