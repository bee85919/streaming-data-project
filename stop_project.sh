#!/bin/bash

# docker-compose down
cd /Users/b06/Desktop/project/streaming-data-project/ && docker-compose down

# stop hadoop
stop-all.sh

# stop spark
/opt/homebrew/opt/apache-spark/libexec/sbin/stop-master.sh
/opt/homebrew/opt/apache-spark/libexec/sbin/stop-worker.sh

# stop kafka-server
$KAFKA_HOME/bin/kafka-server-stop.sh

# stop zookeeper-server
$KAFKA_HOME/bin/zookeeper-server-stop.sh

# stop airflow
AIRFLOW_PIDS=$(ps -ef | grep "airflow" | grep -v grep | awk '{print $2}')
if [ ! -z "$AIRFLOW_PIDS" ]; then
    echo "airflow 종료 중: $AIRFLOW_PIDS"
    kill $AIRFLOW_PIDS
else
    echo "실행 중인 airflow가 없습니다."
fi

# echo
echo "모든 서비스가 종료되고 있습니다."