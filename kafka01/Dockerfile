FROM phusion/baseimage

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
ENV KAFKA_VERSION=2.4.0
ENV SCALA_VERSION=2.13
ENV KAFKA_LOGS_PATH=/var/log/kafka
ENV KAFKA_CONSOLE_LOG=/var/log/kafka/elk-kafka.log
ENV KAFKA_HOME=/opt/elk/kafka
ENV KAFKA_GID=910
ENV KAFKA_UID=910
ENV KAFKA_USER=kafkauser

ENV KAFKA_SCRIPT=$KAFKA_HOME/bin/kafka-server-start.sh
ENV KAFKA_CONFIG=$KAFKA_HOME/config/server.properties


RUN apt-get update -qq   && apt-get install -qqy   openjdk-8-jre-headless wget && apt-get -qy clean   autoremove
RUN rm -rf /var/lib/apt/lists/*
RUN bash -c 'mkdir -pv /opt/elk/kafka'
RUN wget -qO- https://mirrors.ocf.berkeley.edu/apache/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz |  tar xvz -C /opt/elk/kafka/ --strip-components=1
RUN mkdir -v $KAFKA_LOGS_PATH
RUN groupadd -g ${KAFKA_GID} ${KAFKA_USER}
RUN useradd -u ${KAFKA_UID} -g ${KAFKA_GID} -d ${KAFKA_HOME} --no-create-home -s /bin/bash ${KAFKA_USER}
RUN chown -R ${KAFKA_USER}:${KAFKA_USER} ${KAFKA_HOME} ${KAFKA_LOGS_PATH}

RUN mv $KAFKA_CONFIG ${KAFKA_HOME}/config/backup_server.properties
COPY server.properties ${KAFKA_HOME}/config/
COPY scripts ${KAFKA_HOME}/scripts
RUN chmod +x ${KAFKA_HOME}/scripts/kafka-entrypoint.sh
RUN chmod +x ${KAFKA_HOME}/scripts/kafka-create-topics.sh

USER ${KAFKA_USER}

WORKDIR /opt/elk/kafka/scripts/
ENTRYPOINT ["./kafka-entrypoint.sh"]
CMD ["/bin/bash","-c","$KAFKA_SCRIPT $KAFKA_CONFIG"]

