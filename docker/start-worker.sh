#!/usr/bin/env bash
set -e

spark-config.sh
load-spark-env.sh

mkdir -p $SPARK_WORKER_LOG

ln -sf /dev/stdout $SPARK_WORKER_LOG/spark-worker.out

spark-class org.apache.spark.deploy.worker.Worker --webui-port $SPARK_WORKER_WEBUI_PORT $SPARK_MASTER >> $SPARK_WORKER_LOG/spark-worker.out
