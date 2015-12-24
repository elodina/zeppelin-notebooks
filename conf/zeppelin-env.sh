#!/bin/bash

export SPARK_HOME=/opt/spark
export SPARK_SUBMIT_OPTIONS="--master mesos://leader.mesos.service:5050 --conf spark.mesos.executor.home=/opt/spark --conf spark.mesos.coarse=true --conf spark.cassandra.connection.host=cassandra-node-0.service"

