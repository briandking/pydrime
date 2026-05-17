# Usage examples

## Build
docker build -f docker/Dockerfile --build-arg VERSION=1.0.0 -t pydrime .
cd docker ; docker compose up -d

## Run S3 server (default)
docker run -e DRIME_API_KEY=xxx -p 8000:8000 pydrime

## Run restic server
docker run -e DRIME_API_KEY=xxx -e PYDRIME_SERVER_MODE=restic -p 8000:8000 pydrime

## Run WebDAV server
docker run -e DRIME_API_KEY=xxx -e PYDRIME_SERVER_MODE=webdav -p 8000:8000 pydrime

## Change port
docker run -e DRIME_API_KEY=xxx -e PYDRIME_LISTEN=:9000 -p 9000:9000 pydrime

## Add server-specific flags
docker run -e DRIME_API_KEY=xxx pydrime --append-only

## Via docker-compose
VERSION=$(git describe --tags) DRIME_API_KEY=xxx docker compose -f docker/docker-compose.yml up

## With a workspace
docker run -e DRIME_API_KEY=xxx -e PYDRIME_WORKSPACE=42 pydrime
