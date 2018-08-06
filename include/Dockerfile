FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y wget make texlive-full

RUN wget https://github.com/github/hub/releases/download/v2.5.0/hub-linux-amd64-2.5.0.tgz && \
	tar zxvf hub-linux-amd64-2.5.0.tgz && rm hub-linux-amd64-2.5.0.tgz

ENV PATH="${PATH}:hub-linux-amd64-2.5.0/bin"
