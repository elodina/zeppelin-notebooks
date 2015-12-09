#!/bin/bash

export SPARK_HOME=/tmp/spark-1.5.1-bin-hadoop2.3
export SPARK_SUBMIT_OPTIONS="--master mesos://leader.mesos.service:5050 --conf spark.mesos.executor.home=/tmp/spark-1.5.1-bin-hadoop2.3"

