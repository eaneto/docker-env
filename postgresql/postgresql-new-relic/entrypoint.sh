#!/usr/bin/env bash

/etc/init.d/newrelic-infra start

docker-entrypoint.sh postgres
