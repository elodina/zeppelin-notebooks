#!/bin/sh

# Prerequisites:
# - Zeppelin 0.5.5 dist
# - zeppelin-env.sh w/ Zeppelin and Spark submit configurations
# - notebook.tar.gz w/ bootstrap Zeppelin notebooks
# - notebook-deps.tar.gz w/ jars needed to launch notebooks 
# - Spark distribution on every Mesos slave on /tmp/spark-1.5.1-bin-hadoop2.3 directory

# Copy configurations of Zeppelin and it's interpreters
cp zeppelin-env.sh zeppelin-0.5.5-incubating-bin-all/conf/zeppelin-env.sh
cp interpreter.json zeppelin-0.5.5-incubating-bin-all/conf/interpreter.json

# Copy bootstrap notebooks
cp -R notebook zeppelin-0.5.5-incubating-bin-all/

# Copy notebook jar dependencies
cp -R notebook-deps zeppelin-0.5.5-incubating-bin-all/

# Launch Zeppelin from the appropriate directory
cd zeppelin-0.5.5-incubating-bin-all/bin

ZEPPELIN_PORT=$PORT1 ./zeppelin.sh



