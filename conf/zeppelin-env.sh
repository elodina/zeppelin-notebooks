#!/bin/bash

export SPARK_HOME=${SPARK_HOME-/opt/spark}
export DRIVER_MEMORY=${DRIVER_MEMORY-1536M}
export EXECUTOR_MEMORY=${EXECUTOR_MEMORY-2560M}
export CORES_MAX=${CORES_MAX-6}

if [[ -z "$SPARK_SUBMIT_OPTIONS" ]]; then
    export SPARK_SUBMIT_OPTIONS="--master ${SPARK_MESOS_MASTER-mesos://leader.mesos.service:5050} --conf spark.logConf=true --conf spark.mesos.executor.home=$SPARK_HOME --conf spark.mesos.coarse=true --conf spark.cassandra.connection.host=${SPARK_CASSANDRA_CONNECTION_HOST-cassandra-node-0.service}"
fi

if [[ -z "$ZEPPELIN_MEM" ]]; then
    export ZEPPELIN_MEM="-Xmx1024m -XX:MaxPermSize=512m"
fi

if [[ -z "$ZEPPELIN_INTP_MEM" ]]; then
    export ZEPPELIN_INTP_MEM="-Xmx$DRIVER_MEMORY -XX:MaxPermSize=512m"
fi

if [[ -z "$ZEPPELIN_JAVA_OPTS" ]]; then
    export ZEPPELIN_JAVA_OPTS="-Dspark.home=$SPARK_HOME -Dspark.driver.memory=$DRIVER_MEMORY -Dspark.executor.memory=$EXECUTOR_MEMORY -Dspark.cores.max=$CORES_MAX -Dspark.ui.port=${PORT0-4040}"
fi
