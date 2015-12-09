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
