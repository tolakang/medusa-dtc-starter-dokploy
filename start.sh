#!/bin/sh
set -e

echo "Waiting for PostgreSQL..."
until pg_isready -h postgres -U postgres >/dev/null 2>&1; do
  echo "PostgreSQL not ready, waiting..."
  sleep 2
done

cd /server/apps/backend

echo "Running database migrations..."
pnpm medusa db:migrate

echo "Seeding database..."
pnpm seed || echo "Seeding failed, continuing..."

echo "Starting Medusa production server..."
exec pnpm start