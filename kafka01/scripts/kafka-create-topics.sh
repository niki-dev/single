#!/bin/bash

# ELK script: kafka-create-topics.sh
# ELK script description: creates kafka topics
# Author: Roberto Rodriguez (@Cyb3rWard0g)
# *********** Waiting for Kafka broker to be up ***************
echo "[ELK-DOCKER-INSTALLATION-INFO] Checking to see if Kafka broker is up..."
while [[ "$(curl -sm5 $KAFKA_BROKER_NAME:$KAFKA_BROKER_PORT -o /dev/null; echo $?)" != 56 ]] ; do
  echo "[ELK-DOCKER-INSTALLATION-INFO] Kafka broker $KAFKA_BROKER_NAME is not available yet"
  sleep 1
done

# *********** Creating Kafka Topics**************
#Reference:https://stackoverflow.com/questions/10586153/split-string-into-an-array-in-bash
IFS=', ' read -r -a temas <<< "$KAFKA_CREATE_TOPICS"

for t in ${temas[@]}; do
  echo "[ELK-DOCKER-INSTALLATION-INFO] Creating Kafka ${t} Topic.."
  ${KAFKA_HOME}/bin/kafka-topics.sh --create --zookeeper ${ZOOKEEPER_NAME}:2181 --replication-factor ${REPLICATION_FACTOR} --partitions 1 --topic ${t} --if-not-exists
done

wait
