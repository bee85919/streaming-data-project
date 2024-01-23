#!/bin/bash


# Airflow 웹 서버 및 스케줄러 백그라운드 실행
airflow webserver --port 1502 &
airflow scheduler &


# Zookeeper 서버 백그라운드 실행
nohup $KAFKA_HOME/bin/zookeeper-server-start.sh $KAFKA_HOME/config/zookeeper.properties > /dev/null 2>&1 &


# Kafka 서버 백그라운드 실행
nohup $KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties > /dev/null 2>&1 &


# Hadoop 시작
start-all.sh


# Docker Compose를 사용하여 컨테이너 백그라운드 실행
cd /Users/b06/Desktop/project/streaming-data-project/docker-compose.yaml/ && docker-compose up -d