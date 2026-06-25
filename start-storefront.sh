#!/bin/sh
set -e

echo "Waiting for Medusa backend..."
until wget -q --spider http://medusa:9000/health 2>/dev/null; do
  echo "Medusa backend not ready, waiting..."
  sleep 2
done

cd /server/apps/storefront

echo "Starting Next.js Starter Storefront production server..."
exec pnpm start