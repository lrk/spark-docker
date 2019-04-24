#!/usr/bin/env bash
set -e

BASE_IMG_NAME=3lr1ck/spark
TAG=2.4.1-hadoop2.7-jdk8

docker build --target master -t $BASE_IMG_NAME-master:$TAG -f docker/Dockerfile docker
docker build --target worker -t $BASE_IMG_NAME-worker:$TAG -f docker/Dockerfile docker
