#!/bin/bash
set -e

echo "[INFO] Starting entrypoint script..."

# Run DB setup (will silently fail if already exists, which is OK)
echo "[INFO] Creating database (if not exists)..."
internet_application create-db || echo "[WARN] Database might already exist."

echo "[INFO] Checking if admin user exists..."
ADMIN_EXISTS=$(internet_application shell -c "from internet_application.models import User; print(User.query.filter_by(username='admin').first() is not None)")

if [ "$ADMIN_EXISTS" = "False" ]; then
    echo "[INFO] Admin user not found. Creating..."
    internet_application add-user -u admin -p 1234
else
    echo "[INFO] Admin user already exists. Skipping creation."
fi

echo "[INFO] Starting application server..."
exec internet_application run --host 0.0.0.0 --port 5000

