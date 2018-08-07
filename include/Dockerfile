FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
ENV HUB_VERSION="2.5.0"

RUN apt-get update && apt-get install -y git wget make texlive-full

RUN wget https://github.com/github/hub/releases/download/v${HUB_VERSION}/hub-linux-amd64-${HUB_VERSION}.tgz && \
	tar zxvf hub-linux-amd64-${HUB_VERSION}.tgz && \
	      rm hub-linux-amd64-${HUB_VERSION}.tgz && \
	      mv hub-linux-amd64-${HUB_VERSION} ~/hub_toolkit
