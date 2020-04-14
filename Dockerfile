FROM openjdk:11-jre

ENV KAFKA_VERSION=2.2.0
ENV SCALA_VERSION=2.12
ENV KAFKA_HOME=/docker-kafka-home

WORKDIR /docker-kafka-home

RUN curl -O https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
    tar --strip-components=1 -xvzf kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
    rm -r kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz site-docs

VOLUME ["/kafka"]

EXPOSE 9092

CMD ["bin/kafka-server-start.sh", "config/server.properties", "--override", "zookeeper.connect=zookeeper:2181"]
