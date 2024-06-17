#!/bin/sh
docker-compose up -d
docker-compose exec --user root php8.3 service ssh start
docker-compose exec --user root php8.3 git config --global --add safe.directory "*"
