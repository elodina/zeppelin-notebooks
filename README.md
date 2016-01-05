# Zeppelin Notebooks

Contains required configurations and bootstrap notebooks for Apache Zeppelin.

### Running on Marathon

`marathon` dir contains necessary files for running Zeppelin with supplied bootstrap notebooks and configurations 
on Marathon. In order to gather all necessary files in one dir:

```
./marathon-build.sh
```

To run on Marathon, upload all the files of the `build` directory somewhere, where `marathon/zeppelin.json` would be 
able to reach them. In order to run against Marathon:

```
curl -X PUT -d@zeppelin.json -H "Content-Type: application/json" http://leader.mesos.service:18080/v2/apps/zeppelin
```

#### Configure resources

Zeppelin and Spark related settings are configured in conf/zeppelin-env.sh
however it has sensible defaults, thus you can use it as is.

Marathon environment variables

    SPARK_HOME - the directory in which Spark is installed on the executors in Mesos (default: /opt/spark)
    (configures spark.mesos.executor.home, spark.home) (see: http://spark.apache.org/docs/1.5.1/running-on-mesos.html)

    DRIVER_MEMORY - amount of memory to use for the driver process (default: 1536M)
    (NOTE: Zeppelin runs driver program in subprocess, this option sets -Xmx for it)

    EXECUTOR_MEMORY - amount of memory to use per executor process (default: 2560M)
    (configures: spark.executor.memory)

    CORES_MAX - the maximum amount of CPU cores to request for the application from across the cluster (not from each machine)
    (default: 6) (configures: spark.cores.max)

    SPARK_CASSANDRA_CONNECTION_HOST - the Cassandra host
    (default: cassandra-node-0.service) (configures: spark.cassandra.connection.host)


    Usually you don't have to configure following, however if you really need to then

    ZEPPELIN_MEM - the Xmx for Zeppelin server and possibly additional GC settings
    (default: -Xmx1024m -XX:MaxPermSize=512m)

    ZEPPELIN_INTP_MEM - the Xmx for Zeppelin interpreter
    (default: -Xmx$DRIVER_MEMORY -XX:MaxPermSize=512m)

    ZEPPELIN_JAVA_OPTS - the options for Zeppelin server (using them to pass Spark options, since its the process that spawns everything else)
    (default: -Dspark.home=$SPARK_HOME -Dspark.driver.memory=$DRIVER_MEMORY -Dspark.executor.memory=$EXECUTOR_MEMORY -Dspark.cores.max=$CORES_MAX -Dspark.ui.port=${PORT0-4040})

    NOTE: Marathon exports env variable PORT0 which configures spark.ui.port


### Export notebooks and configurations

After you have created and tested your notebooks, and want to export them, for example to launch them at Zeppelin start 
up, you should copy `notebook/<notebook-id>` folder from the Zeppelin running directory. So, for example, if running
on Marathon, go to your Mesos UI, see where on the Mesos slave Zeppelin instance is running, and copy desired notebook 
`note.json` via scp:

```
scp centos@slave0:/<path-to-zeppelin-dir>/notebook/<notebook-id>/note.json notebook/<notebook-id>/
```

You may also want to export your interpreter configurations, if want them to be applied on start up. In this case all 
you need to do is to copy your `conf/interpreter.json`. When running on Marathon exporting it would look like this:

```
scp centos@slave0:/<path-to-zeppelin-dir>/conf/interpreter.json conf/
```

### Notebook jar dependencies

If there are some jar dependencies needed to be provided for running your notebooks, place them into `notebook-deps` 
directory. They will be provided along with Zeppelin dist, when you deploy the app with Marathon. You will be able to 
load them as a dependency by running the following paragraph:

```
%dep
z.load("../notebook-deps/<jar-name>.jar")
```

**NOTE:** This should be run *before* launching Spark interpreter, which means before any Spark paragraphs, in other 
case Zeppelin should be restarted
