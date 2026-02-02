#!/bin/bash
#
# Development Environment Setup Script
# Quick setup for local development
#

set -e

echo "========================================="
echo "  Development Environment Setup"
echo "========================================="
echo ""

# Check prerequisites
echo "Checking prerequisites..."
if [ -f "./scripts/check-prerequisites.sh" ]; then
    bash ./scripts/check-prerequisites.sh || exit 1
else
    echo "Warning: Prerequisite checker not found, continuing..."
fi

echo ""
echo "=== Step 1: Install Dependencies ==="
echo ""

# Install npm dependencies
if [ -f "package.json" ]; then
    echo "Installing npm dependencies..."
    npm install
else
    echo "No package.json found, skipping npm install"
fi

echo ""
echo "=== Step 2: Environment Configuration ==="
echo ""

# Create .env file if it doesn't exist
if [ ! -f ".env" ]; then
    echo "Creating .env file from template..."

    cat > .env << 'EOF'
# Development Environment Configuration

NODE_ENV=development
PORT=3000

# Database
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/appdb_dev

# Redis
REDIS_URL=redis://localhost:6379

# JWT
JWT_SECRET=development_jwt_secret_change_in_production

# Session
SESSION_SECRET=development_session_secret

# Email (Development - use Mailhog or similar)
SMTP_HOST=localhost
SMTP_PORT=1025
SMTP_USER=
SMTP_PASSWORD=
FROM_EMAIL=noreply@localhost

# API Keys (optional)
# STRIPE_SECRET_KEY=
# TWILIO_ACCOUNT_SID=
# TWILIO_AUTH_TOKEN=

# Feature Flags
ENABLE_EMAIL_NOTIFICATIONS=false
ENABLE_SMS_NOTIFICATIONS=false
EOF

    echo "✓ .env file created"
else
    echo ".env file already exists, skipping..."
fi

echo ""
echo "=== Step 3: Database Setup ==="
echo ""

# Check if PostgreSQL is running
if ! pg_isready -h localhost -p 5432 > /dev/null 2>&1; then
    echo "Warning: PostgreSQL is not running"
    echo "Please start PostgreSQL and run this script again"
    exit 1
fi

# Create development database
echo "Creating development database..."
createdb appdb_dev 2>/dev/null || echo "Database may already exist, continuing..."

# Run migrations
if [ -d "prisma" ] && [ -f "prisma/schema.prisma" ]; then
    echo "Running database migrations..."
    npx prisma migrate dev --name init || echo "Migrations may have already run"

    echo "Generating Prisma client..."
    npx prisma generate
else
    echo "No Prisma schema found, skipping migrations"
fi

echo ""
echo "=== Step 4: Redis Setup ==="
echo ""

# Check if Redis is running
if redis-cli ping > /dev/null 2>&1; then
    echo "✓ Redis is running"
else
    echo "Warning: Redis is not running"
    echo "Start Redis with: redis-server"
fi

echo ""
echo "=== Step 5: Build Application ==="
echo ""

# Build application (if build script exists)
if grep -q "\"build\"" package.json 2>/dev/null; then
    echo "Building application..."
    npm run build
else
    echo "No build script found, skipping build"
fi

echo ""
echo "========================================="
echo "  Development Setup Complete!"
echo "========================================="
echo ""
echo "To start the development server:"
echo "  npm run dev"
echo ""
echo "Useful commands:"
echo "  npm run test        - Run tests"
echo "  npm run lint        - Run linter"
echo "  npx prisma studio   - Open Prisma Studio"
echo ""
echo "Database:"
echo "  Connection: postgresql://postgres:postgres@localhost:5432/appdb_dev"
echo "  Access: psql -d appdb_dev"
echo ""
echo "Redis:"
echo "  Connection: redis://localhost:6379"
echo "  Access: redis-cli"
echo ""
