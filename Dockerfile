FROM eclipse-temurin:21-jre

ENV FUSEKI_VERSION=5.1.0

RUN apt-get update && \
    apt-get install -y wget && \
    wget https://downloads.apache.org/jena/binaries/apache-jena-fuseki-${FUSEKI_VERSION}.tar.gz && \
    tar -xzf apache-jena-fuseki-${FUSEKI_VERSION}.tar.gz && \
    mv apache-jena-fuseki-${FUSEKI_VERSION} /fuseki

COPY config.ttl /fuseki/config.ttl

EXPOSE 3030

CMD ["/fuseki/fuseki-server", "--config=/fuseki/config.ttl"]
