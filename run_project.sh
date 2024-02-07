# !/bin/bash

# airflow
airflow webserver --port 1502 &
airflow scheduler &

# zookeeper-server
nohup $KAFKA_HOME/bin/zookeeper-server-start.sh $KAFKA_HOME/config/zookeeper.properties > /dev/null 2>&1 &

# kafka-server
nohup $KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties > /dev/null 2>&1 &

# spark
export SPARK_LOCAL_IP="127.0.0.1"
export SPARK_MASTER_HOST=localhost
/opt/homebrew/opt/apache-spark/libexec/sbin/start-master.sh
/opt/homebrew/opt/apache-spark/libexec/sbin/start-worker.sh spark://localhost:7077

# hadoop
start-all.sh

# elasticsearch, kibana, minio
cd /Users/b06/Desktop/project/streaming-data-project/ && docker-compose up -d

# echo
echo "모든 서비스가 시작되고 있습니다."