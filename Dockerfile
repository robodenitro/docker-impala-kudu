FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y curl

ADD cloudera.list /etc/apt/sources.list.d/

RUN curl -o archive.key https://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh/archive.key \
    && apt-key add archive.key \
    && apt-key update \
    && apt-get update

RUN apt-get install -y hadoop-hdfs-namenode \
    hadoop-hdfs-datanode hive hive-metastore \
    impala-kudu impala-kudu-catalog impala-kudu-server \
    impala-kudu-state-store impala-kudu-shell \
    kudu-master kudu-tserver \
    rsyslog

COPY ./etc /etc/cdh/

RUN echo "Configuring Hadoop, Hive and Impala" \
 && ln -sf /etc/cdh/core-site.xml /etc/hadoop/conf/  \
 && ln -sf /etc/cdh/hdfs-site.xml /etc/hadoop/conf/  \
 && ln -sf /etc/cdh/hive-site.xml /etc/hive/conf/  \
 && ln -sf /etc/cdh/hdfs-site.xml /etc/impala/conf/  \
 && ln -sf /etc/cdh/core-site.xml /etc/impala/conf/  \
 && ln -sf /etc/cdh/hive-site.xml /etc/impala/conf/  \
 && mkdir -p /var/run/hdfs-sockets \
 && chown hdfs:hadoop /var/run/hdfs-sockets \
 && echo "Formatting HDFS..." \
 && service hadoop-hdfs-namenode init \
 && echo "--use_hybrid_clock=false" >> /etc/kudu/conf/master.gflagfile \
 && echo "--use_hybrid_clock=false" >> /etc/kudu/conf/tserver.gflagfile

VOLUME /var/lib/hadoop-hdfs /var/lib/hive /var/lib/impala /var/lib/kudu

EXPOSE 7050 7051 8020 8050 8051 9083 15000 15001 15002 21000 21050 22000 23000 23020 24000 25000 25010 26000 28000 50010 25020 50070 50075

COPY ./docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
