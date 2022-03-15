FROM ubuntu:22.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y vim build-essential texlive-full && \
    rm -rf /var/lib/apt/lists/*
