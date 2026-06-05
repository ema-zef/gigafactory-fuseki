# Gigafactory Knowledge Graph (Apache Fuseki)

This repository deploys an Apache Jena Fuseki server on Render.

The Fuseki server hosts the Gigafactory Knowledge Graph and exposes:

- SPARQL Query endpoint
- SPARQL Update endpoint
- RDF dataset storage

---

## Dataset

Dataset name:

gigafactory

SPARQL endpoint:

/gigafactory/sparql

Example:

https://your-fuseki-service.onrender.com/gigafactory/sparql

---

## Local Development

Build Docker image:

```bash
docker build -t gigafactory-fuseki .
