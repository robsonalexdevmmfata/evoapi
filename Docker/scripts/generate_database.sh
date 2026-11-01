#!/bin/bash

source ./Docker/scripts/env_functions.sh

if [ "$DOCKER_ENV" != "true" ]; then
    export_env_vars
fi

if [[ "$DATABASE_PROVIDER" == "postgresql" || "$DATABASE_PROVIDER" == "mysql" || "$DATABASE_PROVIDER" == "psql_bouncer" ]]; then
    export DATABASE_URL
    echo "Generating database for $DATABASE_PROVIDER"
    echo "Database URL: $DATABASE_URL"
    echo "Skipping prisma generate on read-only filesystem"
else
    echo "Error: Database provider $DATABASE_PROVIDER invalid."
    exit 1
fi