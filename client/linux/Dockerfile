FROM ubuntu:24.04

ENV TZ=Asia/Jerusalem
# RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y tzdata chrony vim && \
    rm -rf /var/lib/apt/lists/*

ADD chrony.conf /etc/chrony/chrony.conf

EXPOSE 123/udp