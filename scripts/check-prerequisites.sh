#!/bin/bash
#
# Prerequisite Checker for Universal Application Setup
# Verifies all required software and system requirements
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
PASSED=0
FAILED=0
WARNINGS=0

echo "========================================="
echo "  Universal App Prerequisite Checker"
echo "========================================="
echo ""

# Function to check command existence
check_command() {
    local cmd=$1
    local name=$2
    local required_version=$3

    if command -v $cmd &> /dev/null; then
        local version=$($cmd --version 2>&1 | head -n1)
        echo -e "${GREEN}✓${NC} $name is installed: $version"
        ((PASSED++))
        return 0
    else
        echo -e "${RED}✗${NC} $name is NOT installed (required: $required_version)"
        ((FAILED++))
        return 1
    fi
}

# Function to check version
check_version() {
    local current=$1
    local required=$2
    local name=$3

    if [ "$(printf '%s\n' "$required" "$current" | sort -V | head -n1)" = "$required" ]; then
        echo -e "${GREEN}✓${NC} $name version $current meets requirement ($required+)"
        ((PASSED++))
        return 0
    else
        echo -e "${YELLOW}⚠${NC} $name version $current is below recommended ($required+)"
        ((WARNINGS++))
        return 1
    fi
}

# Function to check port availability
check_port() {
    local port=$1

    if lsof -Pi :$port -sTCP:LISTEN -t >/dev/null 2>&1; then
        echo -e "${YELLOW}⚠${NC} Port $port is in use"
        ((WARNINGS++))
        return 1
    else
        echo -e "${GREEN}✓${NC} Port $port is available"
        ((PASSED++))
        return 0
    fi
}

# Function to check disk space
check_disk_space() {
    local required_gb=$1
    local available=$(df -BG / | tail -1 | awk '{print $4}' | sed 's/G//')

    if [ "$available" -ge "$required_gb" ]; then
        echo -e "${GREEN}✓${NC} Disk space: ${available}GB available (required: ${required_gb}GB)"
        ((PASSED++))
        return 0
    else
        echo -e "${RED}✗${NC} Disk space: ${available}GB available (required: ${required_gb}GB)"
        ((FAILED++))
        return 1
    fi
}

# Function to check RAM
check_ram() {
    local required_gb=$1
    local available=$(free -g | awk '/^Mem:/{print $2}')

    if [ "$available" -ge "$required_gb" ]; then
        echo -e "${GREEN}✓${NC} RAM: ${available}GB available (required: ${required_gb}GB)"
        ((PASSED++))
        return 0
    else
        echo -e "${RED}✗${NC} RAM: ${available}GB available (required: ${required_gb}GB)"
        ((FAILED++))
        return 1
    fi
}

echo "=== System Requirements ==="
echo ""

# Check CPU cores
CPU_CORES=$(nproc)
if [ "$CPU_CORES" -ge 4 ]; then
    echo -e "${GREEN}✓${NC} CPU: $CPU_CORES cores (required: 4+)"
    ((PASSED++))
else
    echo -e "${YELLOW}⚠${NC} CPU: $CPU_CORES cores (recommended: 4+)"
    ((WARNINGS++))
fi

# Check RAM
check_ram 8

# Check disk space
check_disk_space 50

echo ""
echo "=== Required Software ==="
echo ""

# Check Node.js
if command -v node &> /dev/null; then
    NODE_VERSION=$(node -v | sed 's/v//')
    NODE_MAJOR=$(echo $NODE_VERSION | cut -d. -f1)

    if [ "$NODE_MAJOR" -ge 24 ]; then
        echo -e "${GREEN}✓${NC} Node.js $NODE_VERSION is installed (required: 24.x or 25.x)"
        ((PASSED++))
    else
        echo -e "${YELLOW}⚠${NC} Node.js $NODE_VERSION is installed (recommended: 24.x or 25.x)"
        ((WARNINGS++))
    fi
else
    echo -e "${RED}✗${NC} Node.js is NOT installed (required: 24.x or 25.x)"
    ((FAILED++))
fi

# Check npm
check_command npm "npm" "9.x+"

# Check PostgreSQL
if command -v psql &> /dev/null; then
    PG_VERSION=$(psql --version | awk '{print $3}' | cut -d. -f1)
    if [ "$PG_VERSION" -ge 18 ]; then
        echo -e "${GREEN}✓${NC} PostgreSQL $PG_VERSION is installed (required: 18.1+)"
        ((PASSED++))
    else
        echo -e "${YELLOW}⚠${NC} PostgreSQL $PG_VERSION is installed (recommended: 18.1+)"
        ((WARNINGS++))
    fi
else
    echo -e "${RED}✗${NC} PostgreSQL is NOT installed (required: 18.1+)"
    ((FAILED++))
fi

# Check Redis
if command -v redis-server &> /dev/null; then
    REDIS_VERSION=$(redis-server --version | awk '{print $3}' | sed 's/v=//' | cut -d. -f1)
    if [ "$REDIS_VERSION" -ge 8 ]; then
        echo -e "${GREEN}✓${NC} Redis $REDIS_VERSION is installed (required: 8.x+)"
        ((PASSED++))
    else
        echo -e "${YELLOW}⚠${NC} Redis $REDIS_VERSION is installed (recommended: 8.x+)"
        ((WARNINGS++))
    fi
else
    echo -e "${RED}✗${NC} Redis is NOT installed (required: 8.x+)"
    ((FAILED++))
fi

# Check Docker
check_command docker "Docker" "29.x+"

# Check Docker Compose
if command -v docker-compose &> /dev/null || docker compose version &> /dev/null; then
    echo -e "${GREEN}✓${NC} Docker Compose is installed"
    ((PASSED++))
else
    echo -e "${RED}✗${NC} Docker Compose is NOT installed (required: 2.x+)"
    ((FAILED++))
fi

# Check Git
check_command git "Git" "2.40+"

echo ""
echo "=== Port Availability ==="
echo ""

check_port 3000  # Application
check_port 5432  # PostgreSQL
check_port 6379  # Redis
check_port 80    # HTTP
check_port 443   # HTTPS

echo ""
echo "=== Network Connectivity ==="
echo ""

# Check internet connection
if ping -c 1 google.com &> /dev/null; then
    echo -e "${GREEN}✓${NC} Internet connection available"
    ((PASSED++))
else
    echo -e "${RED}✗${NC} No internet connection"
    ((FAILED++))
fi

# Check DNS resolution
if nslookup google.com &> /dev/null; then
    echo -e "${GREEN}✓${NC} DNS resolution working"
    ((PASSED++))
else
    echo -e "${RED}✗${NC} DNS resolution not working"
    ((FAILED++))
fi

echo ""
echo "========================================="
echo "  Summary"
echo "========================================="
echo ""
echo -e "${GREEN}Passed:${NC} $PASSED"
echo -e "${YELLOW}Warnings:${NC} $WARNINGS"
echo -e "${RED}Failed:${NC} $FAILED"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ All required prerequisites are met!${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Run './scripts/setup-dev.sh' for development setup"
    echo "  2. Or run './scripts/setup-prod.sh' for production setup"
    exit 0
else
    echo -e "${RED}✗ Some prerequisites are missing. Please install them and try again.${NC}"
    echo ""
    echo "Installation guides:"
    echo "  Node.js: https://nodejs.org/"
    echo "  PostgreSQL: https://www.postgresql.org/download/"
    echo "  Redis: https://redis.io/download"
    echo "  Docker: https://docs.docker.com/get-docker/"
    exit 1
fi
