# Kudu/Impala container from CDH5 stack

This is a standalone container which has Apache Kudu and Impala installed with dependencies (HDFS, Hive etc).

## Run container

```
docker run -d -p 8050:8050 -p 8051:8051 -p 21050:21050 -p 25000:25000 -p 25010:25010 -p 25020:25020 -p 50070:50070 -p 50075:50075 andreysabitov/impala-kudu:latest
```

Exposed ports are:
* 8050 Kudu: TabletServer HTTP (Web UI)
* 8051 Kudu: Master HTTP (Web UI)
* 21050 Impala: Daemon RPC
* 25000 Impala: Daemon HTTP (Web UI)
* 25010 StateStore HTTP (Web UI)
* 25020 Catalog HTTP (Web UI)
* 50070 HDFS: NameNode HTTP (Web UI)
* 50075 HDFS: DataNode HTTP (Web UI)
