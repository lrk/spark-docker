FROM openjdk:8-jdk-alpine

MAINTAINER Lrk <sfxelrick@gmail.com>

ARG SPARK_VERSION=2.4.1
ARG HADOOP_VERSION=2.7

RUN apk add --no-cache curl bash && \
    mkdir -p /opt/spark && \
    curl -L https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz | \
    tar xz -C /opt/spark --strip-components=1 && \
    ln -s /opt/spark/bin/* /usr/bin

ENV PYTHONHASHSEED 1
