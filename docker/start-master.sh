#!/usr/bin/env bash
set -e

export SPARK_MASTER_HOST=`hostname`

spark-config.sh
load-spark-env.sh

mkdir -p $SPARK_MASTER_LOG

ln -sf /dev/stdout $SPARK_MASTER_LOG/spark-master.out

if [ "$SPARK_START_SHELL" = 1 ]; then
  spark-shell
else
  spark-class org.apache.spark.deploy.master.Master --ip $SPARK_MASTER_HOST --port $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT >> $SPARK_MASTER_LOG/spark-master.out
fi
