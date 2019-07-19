#!/usr/bin/env bash
set -e

DOCKER_BUILD_ARGS=
if [ ! ${SPARK_VERSION} ]; then
  SPARK_VERSION=2.4.3
  DOCKER_BUILD_ARGS="${DOCKER_BUILD_ARGS} --build-arg SPARK_VERSION=${SPARK_VERSION}"
fi

if [ ! ${HADOOP_VERSION} ]; then
  HADOOP_VERSION=2.7
  DOCKER_BUILD_ARGS="${DOCKER_BUILD_ARGS} --build-arg HADOOP_VERSION=${HADOOP_VERSION}"
fi

BASE_IMG_NAME=3lr1ck/spark
TAG=${SPARK_VERSION}-hadoop${HADOOP_VERSION}-jdk8

echo "Build arguments: ${DOCKER_BUILD_ARGS}"

docker build ${DOCKER_BUILD_ARGS} --target master -t $BASE_IMG_NAME-master:$TAG -f docker/Dockerfile docker
docker build ${DOCKER_BUILD_ARGS} --target worker -t $BASE_IMG_NAME-worker:$TAG -f docker/Dockerfile docker
docker build ${DOCKER_BUILD_ARGS} --target submit -t $BASE_IMG_NAME-submit:$TAG -f docker/Dockerfile docker
