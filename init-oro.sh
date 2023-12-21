#!/bin/sh
docker-compose up -d
docker-compose exec --user root php8.2 service ssh start
docker-compose exec --user root php8.2 git config --global --add safe.directory "*"
