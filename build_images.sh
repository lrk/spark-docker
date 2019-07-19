#!/usr/bin/env bash
set -e

if [ ! ${SPARK_VERSION}]; then
  SPARK_VERSION=2.4.3
fi

if [ ! ${HADOOP_VERSION}]; then
  HADOOP_VERSION=2.7
fi

BASE_IMG_NAME=3lr1ck/spark
TAG=${SPARK_VERSION}-hadoop${HADOOP_VERSION}-jdk8

docker build --target master -t $BASE_IMG_NAME-master:$TAG -f docker/Dockerfile docker
docker build --target worker -t $BASE_IMG_NAME-worker:$TAG -f docker/Dockerfile docker
docker build --target submit -t $BASE_IMG_NAME-submit:$TAG -f docker/Dockerfile docker
