#!/bin/bash
set -e

# Run DB setup if not already initialized
if [ ! -f /app/.db_initialized ]; then
    echo "Initializing database..."
    internet_application create-db
    internet_application populate-db
    internet_application add-user -u admin -p 1234
    touch /app/.db_initialized
else
    echo "Database already initialized."
fi

# Run the app
exec internet_application run --host 0.0.0.0 --port 5000

