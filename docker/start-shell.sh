#!/usr/bin/env bash
set -e

export SPARK_MASTER_HOST=`hostname`

spark-config.sh
load-spark-env.sh

mkdir -p $SPARK_SHELL_LOG

ln -sf /dev/stdout $SPARK_SHELL_LOG/spark-shell.out

spark-shell >> $SPARK_SHELL_LOG/spark-shell.out
# spark-class org.apache.spark.deploy.master.Master --ip $SPARK_MASTER_HOST --port $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT >> $SPARK_MASTER_LOG/spark-master.out
