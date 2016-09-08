#!/bin/bash

service hadoop-hdfs-namenode start
service hadoop-hdfs-datanode start
service hive-metastore start
service impala-state-store start
service impala-catalog start
service impala-server start
service kudu-master start
service kudu-tserver start
tail -f /var/log/kudu/kudu-master.INFO -f /var/log/kudu/kudu-tserver.INFO -f /var/log/impala/impalad.INFO -f /var/log/impala/catalogd.INFO -f /var/log/impala/statestored.INFO
