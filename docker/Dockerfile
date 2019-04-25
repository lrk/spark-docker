ARG SPARK_ROOT=/spark

###############################################################################
# Base stage
###############################################################################
FROM openjdk:8-jdk-alpine as base

LABEL maintainer="sfxelrick@gmail.com"

ARG SPARK_ROOT
ARG SPARK_VERSION=2.4.2
ARG HADOOP_VERSION=2.7

RUN apk add --no-cache curl bash && \
    mkdir -p ${SPARK_ROOT} && \
    curl -L https://www-us.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz | \
    tar xz -C ${SPARK_ROOT} --strip-components=1 && \
    find ${SPARK_ROOT} -type f -name *.cmd -delete && \
    find ${SPARK_ROOT} -type f -iname "*.sh" -exec chmod +x "{}" \;

###############################################################################
# Master stage
###############################################################################
FROM openjdk:8-jdk-alpine as master

LABEL maintainer="sfxelrick@gmail.com"

ARG SPARK_ROOT

ENV SPARK_HOME=${SPARK_ROOT}
ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080
ENV SPARK_MASTER_LOG /spark/logs

COPY --from=base ${SPARK_ROOT} ${SPARK_ROOT}

COPY start-master.sh /

RUN apk add --no-cache bash && \
    ln -s ${SPARK_ROOT}/bin/* /usr/bin && \
    ln -s ${SPARK_ROOT}/sbin/* /usr/sbin && \
    chmod +x start-master.sh

EXPOSE 8080 7077 6066

CMD ["/bin/bash", "/start-master.sh"]

###############################################################################
# Worker stage
###############################################################################
FROM openjdk:8-jdk-alpine as worker

LABEL maintainer="sfxelrick@gmail.com"

ARG SPARK_ROOT

ENV SPARK_HOME=${SPARK_ROOT}
ENV SPARK_WORKER_WEBUI_PORT 8081
ENV SPARK_WORKER_LOG /spark/logs
ENV SPARK_MASTER "spark://spark-master:7077"

COPY --from=base ${SPARK_ROOT} ${SPARK_ROOT}

COPY start-worker.sh /

RUN apk add --no-cache bash && \
    ln -s ${SPARK_ROOT}/bin/* /usr/bin && \
    ln -s ${SPARK_ROOT}/sbin/* /usr/sbin && \
    chmod +x start-worker.sh

EXPOSE 8081

CMD ["/bin/bash", "/start-worker.sh"]

###############################################################################
# Submit stage
###############################################################################
FROM openjdk:8-jdk-alpine as submit

LABEL maintainer="sfxelrick@gmail.com"

ARG SPARK_ROOT

ENV SPARK_HOME=${SPARK_ROOT}
ENV SPARK_MASTER_NAME spark-master
ENV SPARK_MASTER_PORT 7077
ENV SPARK_APPLICATION_JAR_LOCATION /app/application.jar
ENV SPARK_APPLICATION_MAIN_CLASS my.main.Application
ENV SPARK_APPLICATION_ARGS ""

COPY start-submit.sh /

RUN apk add --no-cache bash && \
    ln -s ${SPARK_ROOT}/bin/* /usr/bin && \
    ln -s ${SPARK_ROOT}/sbin/* /usr/sbin && \
    chmod +x start-submit.sh

CMD ["/bin/bash", "/start-submit.sh"]
