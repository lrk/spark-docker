#!/usr/bin/env bash

set -e

BASE_IMG_NAME=3lr1ck/spark-
TAG=2.4.0-hadoop2.7-jdk8

################################################
# Build docker image based on:
# $1: image name
# $2: override image path (if empty $1 is used)
################################################
function build_img(){
  NAME=$1
  IMAGE=$BASE_IMG_NAME$NAME:$TAG
  cd $([ -z "$2" ] && echo "./$NAME" || echo "$2")
  echo "- Building $IMAGE docker image from $(pwd)"
  docker build -t $IMAGE .
  cd -
}

build_img base
