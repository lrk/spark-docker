#!/usr/bin/env bash
set -e

export SPARK_MASTER_URL=spark://${SPARK_MASTER_NAME}:${SPARK_MASTER_PORT}

if [ -f "${SPARK_APPLICATION_JAR_LOCATION}" ]; then
    echo "Submit ${SPARK_APPLICATION_MAIN_CLASS} from ${SPARK_APPLICATION_JAR_LOCATION} to Spark master ${SPARK_MASTER_URL}"
    echo "With arguments ${SPARK_APPLICATION_ARGS}"
    spark-submit \
        --class ${SPARK_APPLICATION_MAIN_CLASS} \
        --master ${SPARK_MASTER_URL} \
        ${SPARK_SUBMIT_ARGS} \
        ${SPARK_APPLICATION_JAR_LOCATION} ${SPARK_APPLICATION_ARGS}
else
    echo "Not recognized application."
fi
