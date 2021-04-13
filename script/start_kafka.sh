#!/bin/bash


KAFKA_HOME=/opt/kafka/kafka

#docker run -p 9092:9092 -e ALLOW_PLAINTEXT_LISTENER=yes -e KAFKA_ZOOKEEPER_CONNECT=192.168.1.41:2181 bitnami/kafka:latest
#some_command &
#P1=$!
#other_command &
#P2=$!
#wait $P1 $P2

#$KAFKA_HOME/bin/zookeeper-server-start.sh $KAFKA_HOME/config/zookeeper.properties &
#P1=$!
#
#$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties &
#P2=$!
#
#wait $P1 $P2


(trap 'kill 0' SIGINT; \
  $KAFKA_HOME/bin/zookeeper-server-start.sh $KAFKA_HOME/config/zookeeper.properties & \
  $KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties )
