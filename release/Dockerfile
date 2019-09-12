FROM golang:latest

LABEL name="Golang Pipeline"
LABEL maintainer="Shoukoo"
LABEL version="0.2.0"
LABEL repository="https://github.com/shoukoo/golang-pipeline"

LABEL com.github.actions.name="Golang Pipeline"
LABEL com.github.actions.description="Run Golang commands"
LABEL com.github.actions.icon="mic"
LABEL com.github.actions.color="yellow"

RUN apt-get update && apt-get install -y jq
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
