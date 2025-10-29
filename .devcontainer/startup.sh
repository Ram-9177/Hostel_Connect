#!/bin/bash
# .devcontainer/startup.sh
# Runs every time the Codespace starts

echo "🌟 Starting HostelConnect services..."

# Wait for PostgreSQL to be ready
echo "⏳ Waiting for PostgreSQL..."
until pg_isready -h postgres -p 5432 > /dev/null 2>&1; do
  sleep 1
done
echo "✅ PostgreSQL is ready"

# Wait for Redis to be ready
echo "⏳ Waiting for Redis..."
until redis-cli -h redis ping > /dev/null 2>&1; do
  sleep 1
done
echo "✅ Redis is ready"

# Run database migrations
echo "🗄️  Running database migrations..."
cd /workspace/hostelconnect/api
npm run migration:run || echo "⚠️  Migrations failed (might be already applied)"

# Seed database if empty
echo "🌱 Checking if database needs seeding..."
npm run seed || echo "ℹ️  Seed already exists"

cd /workspace

echo ""
echo "✅ All services are ready!"
echo ""
echo "🌐 Available URLs:"
echo "  API:           http://localhost:3000"
echo "  API Docs:      http://localhost:3000/api"
echo "  Web App:       http://localhost:5173"
echo "  Flutter Web:   http://localhost:8080"
echo "  Grafana:       http://localhost:3001"
echo "  Prometheus:    http://localhost:9090"
echo ""
echo "💡 Tip: Use the aliased commands (api-start, web-start, flutter-web)"
