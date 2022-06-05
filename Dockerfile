FROM azul/zulu-openjdk-debian:11.0.13

ENV KAFKA_VERSION=3.2.0
ENV SCALA_VERSION=2.13
ENV KAFKA_HOME=/docker-kafka-home

WORKDIR /docker-kafka-home

RUN apt-get update && apt-get dist-upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata curl ca-certificates fontconfig \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

RUN curl -O https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
    tar --strip-components=1 -xvzf kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
    rm -r kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz site-docs

VOLUME ["/kafka"]

EXPOSE 9092

CMD ["bin/kafka-server-start.sh", "config/server.properties", "--override", "zookeeper.connect=zookeeper:2181"]
