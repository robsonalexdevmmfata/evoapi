#!/bin/bash

source ./Docker/scripts/env_functions.sh

if [ "$DOCKER_ENV" != "true" ]; then
    export_env_vars
fi

if [[ "$DATABASE_PROVIDER" == "postgresql" || "$DATABASE_PROVIDER" == "mysql" || "$DATABASE_PROVIDER" == "psql_bouncer" ]]; then
    export DATABASE_URL
    echo "Deploying migrations for $DATABASE_PROVIDER"
    echo "Database URL: $DATABASE_URL"
    npm run db:deploy
    if [ $? -ne 0 ]; then
        echo "Migration failed"
        exit 1
    else
        echo "Migration succeeded"
    fi
    # Hostless and other read-only filesystems cannot write Prisma Client at runtime.
    npm run db:generate
    if [ $? -ne 0 ]; then
        echo "Prisma generate skipped on read-only filesystem"
    else
        echo "Prisma generate succeeded"
    fi
else
    echo "Error: Database provider $DATABASE_PROVIDER invalid."
    exit 1
fi
