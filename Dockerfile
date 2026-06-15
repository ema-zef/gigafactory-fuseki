FROM eclipse-temurin:21-jre

ENV FUSEKI_VERSION=5.6.0

RUN apt-get update && apt-get install -y wget && \
    wget https://archive.apache.org/dist/jena/binaries/apache-jena-fuseki-${FUSEKI_VERSION}.tar.gz && \
    tar -xzf apache-jena-fuseki-${FUSEKI_VERSION}.tar.gz && \
    mv apache-jena-fuseki-${FUSEKI_VERSION} /fuseki

WORKDIR /fuseki

COPY config.ttl /fuseki/config.ttl
COPY data /fuseki/data

RUN mkdir -p /fuseki/DB

# Render injects $PORT; default to 3030 for local runs
ENV PORT=3030
EXPOSE 3030

# Use exec form + shell so ${PORT} expands, and tee logs to stdout
CMD ["sh", "-c", "\
  echo \"[startup] launching fuseki-server on port ${PORT}\" && \
  /fuseki/fuseki-server --port=${PORT} --tdb2 --loc=/fuseki/DB /gigafactory & \
  FPID=$!; \
  # Poll the built-in ping endpoint until it answers, then log success \
  for i in $(seq 1 30); do \
    if wget -qO- http://127.0.0.1:${PORT}/$/ping >/dev/null 2>&1; then \
      echo \"[startup] ✅ fuseki-server bound to ${PORT} (ping OK) after ${i}s\"; \
      break; \
    fi; \
    echo \"[startup] waiting for fuseki to bind... (${i}/30)\"; \
    sleep 1; \
  done; \
  wait $FPID \
"]
