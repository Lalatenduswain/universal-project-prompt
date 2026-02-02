# 🚀 UNIVERSAL APPLICATION PROJECT PROMPT
## Master Template for Web, iOS & Android Applications

**Version:** 2.0  
**Date:** February 01, 2026  
**Purpose:** Comprehensive prompt template for enterprise-grade application development with security, compliance, and production-readiness

---

## 📋 PROJECT INITIALIZATION CHECKLIST

### Pre-Development Requirements
- [ ] **Port Management**: Check free/open ports before development
- [ ] **Auto-Start Configuration**: Ensure application auto-starts after server reboot
- [ ] **Environment Setup**: Configure all required environment variables
- [ ] **Access Control**: Define user roles and permissions matrix
- [ ] **Compliance Needs**: Identify required compliance standards (GDPR, ISO 27001, PCI-DSS, SOC 2, SOX, HIPAA)

---

## ⚙️ INSTALLATION & SETUP

### System Requirements

#### Hardware Requirements
```yaml
Minimum (Development):
  CPU: 4 cores
  RAM: 8GB
  Disk: 50GB SSD
  Network: 10 Mbps

Recommended (Production):
  CPU: 8+ cores
  RAM: 16GB+
  Disk: 200GB+ SSD (NVMe preferred)
  Network: 100 Mbps+
```

#### Software Requirements
```yaml
Required:
  - Node.js: 24.x (LTS) or 25.x (Current)
  - PostgreSQL: 18.1+
  - Redis: 8.x+ or Valkey 9.x
  - Docker: 29.x+ (Engine)
  - Docker Compose: 2.x+
  - Git: 2.40+

Optional (Based on Stack):
  - Python: 3.13+ (if using FastAPI)
  - nginx: 1.29.x (for production deployment)
  - Certbot: 5.2.x (for SSL/TLS certificates)
  - Jenkins: 2.546+ (for CI/CD)
```

### Pre-Installation Checklist

**Automated Prerequisite Checker:**
```bash
# Run prerequisite check script
./scripts/check-prerequisites.sh

# Or for Windows
.\scripts\check-prerequisites.ps1
```

**Manual Verification:**
- [ ] Operating system is Linux, macOS, or Windows 10/11
- [ ] All required ports are available (3000, 5432, 6379, 80, 443)
- [ ] Sufficient disk space (50GB+ available)
- [ ] Internet connection for package downloads
- [ ] User has sudo/administrator privileges
- [ ] Firewall rules configured for required ports
- [ ] DNS/hostname resolution working

### Installation Methods

#### Method 1: Interactive Installation Wizard (Recommended)

**Quick Start:**
```bash
# Clone repository
git clone https://github.com/your-org/your-app.git
cd your-app

# Run installation wizard
npx universal-setup init

# The wizard will guide you through:
# 1. Environment detection (OS, installed software)
# 2. Missing dependency installation
# 3. Database configuration
# 4. Redis configuration
# 5. Environment variable setup (.env generation)
# 6. SSL certificate generation (development)
# 7. Initial database migration
# 8. Admin user creation
# 9. Sample data loading (optional)
# 10. Service startup
# 11. Health check verification
# 12. Next steps guidance
```

**Wizard Features:**
- Automatic dependency detection
- Smart defaults based on environment
- Validation at each step
- Rollback on failure
- Detailed progress logging
- Post-installation verification

#### Method 2: Silent/Unattended Installation (CI/CD)

**Configuration File:**
```yaml
# install-config.yml
environment: production
database:
  host: localhost
  port: 5432
  name: appdb
  user: appuser
  password_env: DB_PASSWORD  # Read from environment
redis:
  host: localhost
  port: 6379
  password_env: REDIS_PASSWORD
application:
  port: 3000
  jwt_secret_env: JWT_SECRET
  admin_email: admin@company.com
  admin_password_env: ADMIN_PASSWORD
features:
  enable_ssl: true
  enable_monitoring: true
  load_sample_data: false
```

**Execute Silent Installation:**
```bash
# Set secrets in environment
export DB_PASSWORD="secure_db_password"
export REDIS_PASSWORD="secure_redis_password"
export JWT_SECRET="your_jwt_secret_here"
export ADMIN_PASSWORD="secure_admin_password"

# Run silent installation
./scripts/setup-prod.sh --config install-config.yml --silent

# Or use Docker-based approach
docker-compose -f docker-compose.prod.yml up -d
```

#### Method 3: Docker-Based Installation (Fastest)

**Development Environment:**
```bash
# Quick start with Docker Compose
docker-compose up -d

# This starts:
# - Application (Node.js)
# - PostgreSQL database
# - Redis cache
# - nginx reverse proxy

# Access application at http://localhost:3000
```

**Production Environment:**
```bash
# Use production compose file
docker-compose -f docker-compose.prod.yml up -d

# With environment file
docker-compose --env-file .env.production -f docker-compose.prod.yml up -d
```

**Docker Compose Configuration:**
```yaml
# docker-compose.yml
version: '3.8'
services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - DATABASE_URL=postgresql://user:pass@db:5432/appdb
      - REDIS_URL=redis://redis:6379
    depends_on:
      - db
      - redis
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3

  db:
    image: postgres:18.1
    volumes:
      - postgres_data:/var/lib/postgresql/data
    environment:
      - POSTGRES_DB=appdb
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=pass

  redis:
    image: redis:8-alpine
    volumes:
      - redis_data:/data
    command: redis-server --requirepass redis_password

volumes:
  postgres_data:
  redis_data:
```

### Post-Installation Configuration

#### Security Hardening
```bash
# 1. Change default passwords
psql -c "ALTER USER appuser WITH PASSWORD 'new_secure_password';"

# 2. Configure firewall (UFW on Ubuntu)
sudo ufw allow 22/tcp    # SSH
sudo ufw allow 80/tcp    # HTTP
sudo ufw allow 443/tcp   # HTTPS
sudo ufw enable

# 3. Disable password authentication for SSH
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# 4. Set up fail2ban
sudo apt install fail2ban
sudo systemctl enable fail2ban

# 5. Configure automatic security updates
sudo apt install unattended-upgrades
sudo dpkg-reconfigure --priority=low unattended-upgrades
```

#### Performance Optimization
```bash
# 1. Configure PostgreSQL for production
sudo nano /etc/postgresql/18/main/postgresql.conf

# Recommended settings:
# shared_buffers = 4GB  (25% of RAM)
# effective_cache_size = 12GB  (75% of RAM)
# maintenance_work_mem = 1GB
# max_connections = 200
# work_mem = 16MB

# 2. Configure Redis persistence
redis-cli CONFIG SET save "900 1 300 10 60 10000"
redis-cli CONFIG SET appendonly yes

# 3. Enable nginx gzip compression
sudo nano /etc/nginx/nginx.conf
# Add: gzip on; gzip_types text/plain text/css application/json application/javascript;
```

#### Monitoring Setup
```bash
# 1. Set up log rotation
sudo nano /etc/logrotate.d/app

# Configuration:
# /var/log/app/*.log {
#   daily
#   rotate 14
#   compress
#   delaycompress
#   notifempty
#   create 0640 appuser appuser
#   sharedscripts
#   postrotate
#     systemctl reload app
#   endscript
# }

# 2. Configure application monitoring
# See SYSTEM MONITORING section for dashboard setup

# 3. Set up health check endpoint monitoring
# Use Uptime Robot, Pingdom, or internal monitoring tool
```

#### Auto-Start Configuration
```bash
# Create systemd service file
sudo nano /etc/systemd/system/app.service
```

```ini
[Unit]
Description=Application Server
After=network.target postgresql.service redis.service

[Service]
Type=simple
User=appuser
Group=appuser
WorkingDirectory=/opt/app
Environment="NODE_ENV=production"
EnvironmentFile=/opt/app/.env
ExecStart=/usr/bin/node server.js
Restart=always
RestartSec=10
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=app

[Install]
WantedBy=multi-user.target
```

```bash
# Enable and start service
sudo systemctl daemon-reload
sudo systemctl enable app
sudo systemctl start app
sudo systemctl status app
```

### Installation Verification

#### Automated Verification Suite
```bash
# Run comprehensive verification tests
npx universal-setup verify

# Or use dedicated verification script
./scripts/verify-installation.sh
```

**Verification Tests:**

1. **Health Checks**
```yaml
Application Health:
  - GET /health returns 200 OK
  - Response time < 200ms
  - All required services running

Database Connectivity:
  - PostgreSQL connection successful
  - Can execute SELECT 1
  - All migrations applied
  - Database version correct (18.1+)

Cache Connectivity:
  - Redis connection successful
  - Can SET and GET test keys
  - Redis version correct (8.x+)
```

2. **Authentication Tests**
```yaml
User Registration:
  - POST /api/auth/register with valid data
  - User created in database
  - Password hashed correctly (bcrypt)
  - Welcome email sent (if configured)

User Login:
  - POST /api/auth/login with credentials
  - JWT token returned
  - Token validates correctly
  - Refresh token mechanism works
```

3. **API Endpoint Tests**
```yaml
Rate Limiting:
  - Verify rate limits enforced
  - Check X-RateLimit-* headers
  - Test 429 response on limit exceed

CORS Configuration:
  - Allowed origins configured
  - Preflight requests handled
  - Headers correctly set

Security Headers:
  - Strict-Transport-Security present
  - X-Content-Type-Options: nosniff
  - X-Frame-Options: DENY
  - CSP headers configured
```

4. **File Upload Tests**
```yaml
Upload Functionality:
  - POST /api/upload with file
  - File size limit enforced (default 10MB)
  - MIME type validation works
  - File stored correctly (filesystem/S3)
  - Malicious file detection active
```

5. **Security Tests**
```yaml
SQL Injection Prevention:
  - Test common SQL injection payloads
  - Verify parameterized queries used
  - No database errors exposed

XSS Prevention:
  - Test common XSS payloads
  - Verify input sanitization
  - CSP blocks inline scripts

CSRF Protection:
  - CSRF tokens required
  - Token validation enforced
  - SameSite cookie attribute set
```

### Troubleshooting Guide

#### Common Issues

**1. Port Already in Use**
```bash
# Problem: Error: listen EADDRINUSE: address already in use :::3000

# Solution 1: Find and kill process using port
lsof -i :3000
kill -9 <PID>

# Solution 2: Change application port
export PORT=3001
# Or edit .env file: PORT=3001
```

**2. Database Connection Failed**
```bash
# Problem: Error: connect ECONNREFUSED 127.0.0.1:5432

# Check PostgreSQL status
sudo systemctl status postgresql

# Check PostgreSQL logs
sudo tail -f /var/log/postgresql/postgresql-18-main.log

# Verify database exists
sudo -u postgres psql -l

# Create database if missing
sudo -u postgres createdb appdb

# Check connection string format
# DATABASE_URL=postgresql://user:password@localhost:5432/dbname
```

**3. Redis Connection Issues**
```bash
# Problem: Error: Redis connection refused

# Check Redis status
sudo systemctl status redis

# Test Redis connection
redis-cli ping  # Should return PONG

# Check Redis authentication
redis-cli -a your_password ping

# Verify REDIS_URL in .env
# REDIS_URL=redis://localhost:6379 or redis://:password@localhost:6379
```

**4. Permission Errors**
```bash
# Problem: EACCES: permission denied

# Fix file permissions
sudo chown -R $USER:$USER /path/to/app
chmod -R 755 /path/to/app

# Fix log directory permissions
sudo mkdir -p /var/log/app
sudo chown appuser:appuser /var/log/app
```

**5. SSL Certificate Issues**
```bash
# Problem: SSL certificate not valid

# For development, generate self-signed certificate
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes

# For production, use Let's Encrypt
sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com

# Auto-renewal
sudo certbot renew --dry-run
```

**6. Environment Variables Not Loaded**
```bash
# Problem: Application can't find environment variables

# Verify .env file exists
ls -la .env

# Check .env file format (no spaces around =)
# ✅ CORRECT: DATABASE_URL=value
# ❌ WRONG: DATABASE_URL = value

# Ensure dotenv is loaded in code
# require('dotenv').config();  // Must be at top of file
```

**7. Migration Errors**
```bash
# Problem: Database migration failed

# Check migration status
npx prisma migrate status

# Reset database (CAUTION: deletes all data)
npx prisma migrate reset

# Apply specific migration
npx prisma migrate deploy

# Create new migration
npx prisma migrate dev --name fix_schema
```

**8. High Memory Usage**
```bash
# Problem: Application consuming too much memory

# Check memory usage
free -h
docker stats  # For containerized apps

# Increase Node.js heap size
node --max-old-space-size=4096 server.js

# Or set in .env
NODE_OPTIONS=--max-old-space-size=4096

# Enable garbage collection logging
node --trace-gc server.js
```

---

## 🏗️ TECHNOLOGY STACK SPECIFICATION

### Current Technology Versions (as of February 2026)

#### Backend Technologies
| Technology | Version | Use Case |
|------------|---------|----------|
| **Node.js** | 25.x (Current) / 24.x (LTS) | JavaScript runtime |
| **Express** | 5.x | REST API framework |
| **FastAPI** | 0.115.x+ | Python async API framework |
| **BCrypt** | 5.1.x | Password hashing |
| **ioredis** | 5.x | Redis client |
| **Temporal Server** | ~1.28.x+ | Workflow orchestration |

#### Frontend Technologies
| Technology | Version | Use Case |
|------------|---------|----------|
| **Next.js** | 16.x (stable) | React framework |
| **React Types** | @types/react 19.x | TypeScript definitions |
| **TanStack Query** | 5.90.x+ / @tanstack/react-query | Data fetching |
| **TanStack Router** | 1.152.x | Routing |
| **Tailwind CSS** | 4.1.x | Styling framework |
| **ShadCN/ui** | CLI ~3.7.x | Component library |
| **Framer Motion** | 12.x / 12.27.x | Animations |
| **Recharts** | 3.6.x | Data visualization |
| **react-hook-form** | 7.71.x | Form management |
| **Zustand** | 5.x | State management |
| **Prism** | 1.30.x | Code syntax highlighting |

#### Database & Storage
| Technology | Version | Use Case |
|------------|---------|----------|
| **PostgreSQL** | 18.1 | Primary database |
| **Prisma Client** | @prisma/client 6.x | ORM |
| **Redis** | 8.x | Caching & sessions |
| **Valkey** | 9.x | Redis alternative |
| **MinIO** | RELEASE.2025-xx-xx (monthly) | Object storage (S3-compatible) |

#### Validation & Security
| Technology | Version | Use Case |
|------------|---------|----------|
| **Zod** | 4.3.x | Schema validation |
| **Pydantic** | 2.12.x | Python data validation |
| **HashiCorp Vault** | 1.21.x | Secrets management |

#### DevOps & CI/CD
| Technology | Version | Use Case |
|------------|---------|----------|
| **Docker** | 29.x (Engine) | Containerization |
| **Jenkins** | 2.546+ | CI/CD automation |
| **SonarQube** | 2025.6 / 2026.x | Code quality |
| **Harbor** | 2.14.x | Container registry |

#### Messaging & Queues
| Technology | Version | Use Case |
|------------|---------|----------|
| **RabbitMQ** | 4.2.x | Message broker |

#### Infrastructure & Deployment
| Technology | Version | Use Case |
|------------|---------|----------|
| **Nginx** | 1.29.x (mainline) | Reverse proxy / Load balancer |
| **Certbot** | 5.2.x | SSL/TLS certificates (Let's Encrypt) |
| **Cloudflare Workers** | N/A (platform) | Edge computing |

#### Testing
| Technology | Version | Use Case |
|------------|---------|----------|
| **Microsoft Playwright** | 1.57.x | E2E testing |

---

## 🎯 PROJECT ARCHITECTURE REQUIREMENTS

### Application Type Selection

#### Web Application Stack
```yaml
Frontend:
  Framework: Next.js 16.x
  UI Library: ShadCN/ui + Tailwind CSS 4.1.x
  State Management: Zustand 5.x
  Data Fetching: TanStack Query 5.90.x+
  Forms: react-hook-form 7.71.x
  Routing: TanStack Router 1.152.x
  Animations: Framer Motion 12.x
  Charts: Recharts 3.6.x

Backend:
  Runtime: Node.js 24.x LTS
  Framework: Express 5.x
  Database: PostgreSQL 18.1 + Prisma 6.x
  Cache: Redis 8.x / Valkey 9.x
  Validation: Zod 4.3.x
  Auth: JWT + BCrypt 5.1.x
  File Storage: MinIO (S3-compatible)
  Message Queue: RabbitMQ 4.2.x
  Workflows: Temporal 1.28.x+

Deployment:
  Containers: Docker 29.x
  Web Server: Nginx 1.29.x
  SSL: Certbot 5.2.x
  Edge: Cloudflare Workers
  Registry: Harbor 2.14.x
  CI/CD: Jenkins 2.546+
  Code Quality: SonarQube 2025.6+

Testing:
  E2E: Playwright 1.57.x
  Unit: Jest / Vitest
  Integration: Supertest
```

#### iOS/Android Mobile Stack
```yaml
Cross-Platform (React Native):
  Framework: React Native (Latest)
  Navigation: React Navigation
  State: Zustand 5.x
  UI: React Native Paper / NativeBase
  Forms: react-hook-form 7.71.x
  API: TanStack Query 5.90.x+
  Storage: AsyncStorage / MMKV

Native iOS:
  Language: Swift 5.x
  UI: SwiftUI
  Architecture: MVVM / Clean Architecture
  Networking: URLSession / Alamofire
  Storage: CoreData / Realm

Native Android:
  Language: Kotlin
  UI: Jetpack Compose
  Architecture: MVVM / Clean Architecture
  Networking: Retrofit + OkHttp
  Storage: Room / Realm

Backend (Same as Web):
  API: Express 5.x / FastAPI 0.115.x+
  Database: PostgreSQL 18.1
  Cache: Redis 8.x
  Auth: JWT + OAuth2
  Push Notifications: FCM / APNs
  Real-time: WebSocket / Socket.io
```

---

## 🏢 MULTI-TENANCY ARCHITECTURE

### Overview & Use Cases

**Multi-tenancy** is an architectural pattern where a single instance of the application serves multiple customers (tenants). Each tenant's data is isolated and remains invisible to other tenants.

**Common Use Cases:**
- B2B SaaS applications (team collaboration tools, project management, CRM)
- Enterprise applications with multiple departments
- White-label solutions for resellers
- Educational platforms with multiple schools/organizations
- Healthcare systems with multiple clinics

**When to Use Multi-Tenancy:**
- ✅ You have multiple customers with similar needs
- ✅ You want to minimize operational costs
- ✅ You need centralized updates and maintenance
- ✅ Each customer needs data isolation
- ✅ Customers have different feature/pricing tiers

**When NOT to Use Multi-Tenancy:**
- ❌ Each customer has wildly different requirements
- ❌ Extreme performance isolation needed
- ❌ Regulatory requirements mandate physical separation
- ❌ You have only one customer (single-tenant is simpler)

### Tenant Lifecycle Management

```yaml
Tenant Registration:
  1. Customer signs up → Create tenant record
  2. Provision database resources (schema/database based on tier)
  3. Initialize tenant-specific data (settings, roles, default content)
  4. Send welcome email with tenant URL
  5. Activate tenant (status: active)

Tenant Suspension:
  - Reason: Payment failure, policy violation, user request
  - Action: Set status to suspended, disable login, show suspension notice
  - Data: Retained for grace period (typically 30 days)

Tenant Cancellation:
  - Soft delete: Mark as cancelled, retain data for recovery period (30 days)
  - Hard delete: After 30 days, anonymize/delete all tenant data (GDPR compliance)
  - Export: Offer data export before final deletion

Tenant Upgrade/Downgrade:
  - Update subscription tier
  - Adjust feature flags
  - Migrate data if needed (e.g., shared schema → separate database for enterprise upgrade)
  - Update usage limits
```

### Data Isolation Strategies

#### Strategy 1: Shared Database with tenant_id Column

```yaml
Pattern: Single database, shared tables, tenant_id discriminator column
Complexity: Low
Cost: Lowest
Isolation: Application-level
Recommended For: <500 tenants, similar tenant sizes, cost-sensitive projects

Architecture:
  - Single PostgreSQL database
  - Every table includes tenant_id column (UUID)
  - Application enforces tenant filtering on all queries
  - Shared indexes include tenant_id as first column

Pros:
  - Lowest infrastructure cost
  - Simplest deployment
  - Efficient resource utilization
  - Easy cross-tenant analytics
  - Simple backup and restore

Cons:
  - Limited data isolation (application-enforced only)
  - Noisy neighbor risk (one tenant can impact others)
  - More complex queries (always filter by tenant_id)
  - Compliance concerns (data co-mingling)
  - Index bloat with many tenants
```

**Implementation Example (Prisma):**
```prisma
// schema.prisma
model User {
  id        String   @id @default(uuid())
  tenantId  String   @map("tenant_id")
  email     String
  name      String
  createdAt DateTime @default(now()) @map("created_at")

  tenant Tenant @relation(fields: [tenantId], references: [id])

  @@unique([tenantId, email])
  @@index([tenantId])
  @@map("users")
}

model Tenant {
  id        String   @id @default(uuid())
  name      String
  subdomain String   @unique
  status    String   @default("active")
  plan      String   @default("free")
  createdAt DateTime @default(now()) @map("created_at")

  users User[]

  @@map("tenants")
}
```

**Row-Level Security (PostgreSQL):**
```sql
-- Enable RLS on users table
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Create policy to enforce tenant isolation
CREATE POLICY tenant_isolation ON users
  USING (tenant_id = current_setting('app.current_tenant_id')::uuid);

-- Set tenant context at connection time
SET app.current_tenant_id = 'tenant-uuid-here';
```

**Middleware Implementation (Express):**
```typescript
// Prisma middleware for automatic tenant filtering
prisma.$use(async (params, next) => {
  const tenantId = getTenantIdFromContext(); // From request context

  if (params.model) {
    // Add tenantId to all queries
    if (params.action === 'findMany' || params.action === 'findFirst') {
      params.args.where = { ...params.args.where, tenantId };
    }
    if (params.action === 'create') {
      params.args.data = { ...params.args.data, tenantId };
    }
    if (params.action === 'update' || params.action === 'delete') {
      params.args.where = { ...params.args.where, tenantId };
    }
  }

  return next(params);
});
```

#### Strategy 2: Separate Schema Per Tenant

```yaml
Pattern: Single database, separate PostgreSQL schemas per tenant
Complexity: Medium
Cost: Medium
Isolation: Database-level
Recommended For: 50-1000 tenants, regulatory requirements, moderate isolation needs

Architecture:
  - Single PostgreSQL database
  - Public schema: Tenant registry and shared data
  - Tenant schemas: tenant_001, tenant_002, tenant_<uuid>, etc.
  - Dynamic schema switching using search_path
  - Each tenant schema contains full table structure

Pros:
  - Better data isolation (database-enforced)
  - Schema-level permissions and access control
  - Easier per-tenant backup and restore
  - Logical separation visible in database
  - Better noisy neighbor protection

Cons:
  - Schema proliferation (1000-2000 schema limit)
  - Complex migrations (must run per schema)
  - PostgreSQL catalog bloat with many schemas
  - Cross-tenant queries more difficult
  - Higher operational complexity

Limits:
  - PostgreSQL: ~1000-2000 schemas practical maximum
  - Performance degrades with >500 schemas
```

**Implementation Example:**
```typescript
// Tenant schema creation
async function provisionTenant(tenantId: string) {
  const schemaName = `tenant_${tenantId.replace(/-/g, '_')}`;

  await prisma.$executeRawUnsafe(`CREATE SCHEMA IF NOT EXISTS "${schemaName}"`);

  // Run migrations for new schema
  await prisma.$executeRawUnsafe(`
    SET search_path TO "${schemaName}";
    -- Create all tables in tenant schema
    CREATE TABLE users (...);
    CREATE TABLE projects (...);
    -- etc.
  `);

  return schemaName;
}

// Dynamic schema switching middleware
app.use(async (req, res, next) => {
  const tenantId = await resolveTenantId(req);
  const schemaName = `tenant_${tenantId.replace(/-/g, '_')}`;

  // Set PostgreSQL search_path for this connection
  await prisma.$executeRawUnsafe(`SET search_path TO "${schemaName}"`);

  req.tenantSchema = schemaName;
  next();
});
```

**Schema Migration Script:**
```bash
#!/bin/bash
# migrate-all-tenants.sh

# Get all tenant schemas
SCHEMAS=$(psql -t -c "SELECT schema_name FROM information_schema.schemata WHERE schema_name LIKE 'tenant_%'")

for SCHEMA in $SCHEMAS; do
  echo "Migrating schema: $SCHEMA"
  psql -c "SET search_path TO $SCHEMA; $(cat migration.sql)"
done
```

#### Strategy 3: Separate Database Per Tenant

```yaml
Pattern: Dedicated database per tenant (or dedicated database instance)
Complexity: High
Cost: Highest
Isolation: Complete physical separation
Recommended For: Enterprise customers, strict compliance (HIPAA, PCI-DSS), high-value tenants (>$10k MRR)

Architecture:
  - Dedicated PostgreSQL database per tenant
  - Or dedicated database instance (separate server)
  - Tenant routing layer directs requests to correct database
  - Each tenant database is independent

Pros:
  - Maximum data isolation (physical separation)
  - Per-tenant performance tuning
  - Compliance-ready (HIPAA, PCI-DSS, FedRAMP)
  - No noisy neighbor issues
  - Easy per-tenant scaling
  - Simple per-tenant backup/restore
  - Can use tenant-specific database versions

Cons:
  - Highest infrastructure cost
  - Complex connection pooling
  - Difficult cross-tenant analytics
  - Migration management overhead (per-tenant deploys)
  - Monitoring complexity

Cost Estimate:
  - Managed database (AWS RDS): ~$100-500/month per tenant
  - Suitable for enterprise tier (>$1000/month revenue per tenant)
```

**Implementation Example:**
```typescript
// Tenant database configuration
interface TenantConfig {
  id: string;
  databaseUrl: string;
  connectionPool: any;
}

const tenantDatabases = new Map<string, TenantConfig>();

// Initialize tenant-specific database connection
async function getTenantDatabase(tenantId: string) {
  if (!tenantDatabases.has(tenantId)) {
    const tenant = await prisma.tenant.findUnique({
      where: { id: tenantId },
      select: { databaseUrl: true }
    });

    const tenantPrisma = new PrismaClient({
      datasources: { db: { url: tenant.databaseUrl } }
    });

    tenantDatabases.set(tenantId, { id: tenantId, connectionPool: tenantPrisma });
  }

  return tenantDatabases.get(tenantId)!.connectionPool;
}

// Middleware for tenant database routing
app.use(async (req, res, next) => {
  const tenantId = await resolveTenantId(req);
  req.tenantDb = await getTenantDatabase(tenantId);
  next();
});

// Usage in route handlers
app.get('/api/users', async (req, res) => {
  const users = await req.tenantDb.user.findMany();
  res.json(users);
});
```

#### Strategy 4: Hybrid Approach (Tier-Based)

```yaml
Pattern: Different isolation strategies based on tenant tier
Complexity: High
Cost: Optimized
Isolation: Variable by tier
Recommended For: SaaS with multiple pricing tiers, optimize cost vs isolation

Architecture:
  Free/Starter Tier: Shared table (Strategy 1)
  Professional Tier: Separate schema (Strategy 2)
  Enterprise Tier: Separate database (Strategy 3)

Migration Path:
  - Start tenants on shared table
  - Upgrade to separate schema when reaching Professional tier
  - Upgrade to separate database for Enterprise customers

Pros:
  - Cost-optimized for each tier
  - Can offer isolation as paid feature
  - Scales with customer value
  - Flexibility for future growth

Cons:
  - Most complex to implement
  - Requires migration tooling between strategies
  - Different code paths for different tiers
  - Testing complexity
```

**Tenant Migration Script:**
```typescript
async function migrateTenantToSeparateSchema(tenantId: string) {
  // 1. Create new schema
  const schemaName = await provisionTenant(tenantId);

  // 2. Copy data from shared tables
  await prisma.$executeRawUnsafe(`
    INSERT INTO ${schemaName}.users
    SELECT * FROM public.users WHERE tenant_id = '${tenantId}';
  `);

  // 3. Update tenant record
  await prisma.tenant.update({
    where: { id: tenantId },
    data: { isolationStrategy: 'separate_schema', schemaName }
  });

  // 4. Verify data integrity
  const oldCount = await prisma.user.count({ where: { tenantId } });
  const newCount = await prisma.$queryRawUnsafe(`
    SELECT COUNT(*) FROM ${schemaName}.users
  `);

  if (oldCount !== newCount[0].count) {
    throw new Error('Data migration failed: count mismatch');
  }

  // 5. Delete from shared tables (after grace period)
  // await prisma.user.deleteMany({ where: { tenantId } });
}
```

### Tenant Identification & Resolution

**1. Subdomain-Based (Recommended for B2B)**
```
https://acme.myapp.com → tenantId = 'acme'
https://widgets-inc.myapp.com → tenantId = 'widgets-inc'

Pros: Clean URLs, professional, easy to identify
Cons: Requires wildcard DNS, SSL certificates for each subdomain
```

**2. Path-Based**
```
https://myapp.com/acme/dashboard → tenantId = 'acme'
https://myapp.com/widgets-inc/dashboard → tenantId = 'widgets-inc'

Pros: Simple to implement, single SSL certificate
Cons: Longer URLs, tenant in every route
```

**3. Header-Based (API-First)**
```
GET /api/users
X-Tenant-Id: acme-uuid-here

Pros: Works for APIs, no URL changes
Cons: Not suitable for web UI, clients must set header
```

**4. JWT Claim (Recommended - Authoritative)**
```javascript
// JWT payload includes tenantId
{
  "sub": "user-uuid",
  "tenantId": "tenant-uuid",
  "email": "user@acme.com",
  "role": "admin"
}

Pros: Secure, authoritative, works everywhere
Cons: Requires authentication for tenant resolution
```

**Implementation: Multi-Source Tenant Resolution**
```typescript
async function resolveTenantId(req: Request): Promise<string> {
  // 1. Try JWT claim (most authoritative)
  if (req.user?.tenantId) {
    return req.user.tenantId;
  }

  // 2. Try subdomain
  const subdomain = req.hostname.split('.')[0];
  if (subdomain !== 'www' && subdomain !== 'myapp') {
    const tenant = await prisma.tenant.findUnique({
      where: { subdomain },
      select: { id: true, status: true }
    });
    if (tenant) {
      if (tenant.status !== 'active') {
        throw new Error('Tenant is suspended or cancelled');
      }
      return tenant.id;
    }
  }

  // 3. Try X-Tenant-Id header (for API clients)
  if (req.headers['x-tenant-id']) {
    return req.headers['x-tenant-id'] as string;
  }

  // 4. Try path-based
  const pathMatch = req.path.match(/^\/([^/]+)\//);
  if (pathMatch) {
    const tenant = await prisma.tenant.findFirst({
      where: { subdomain: pathMatch[1] },
      select: { id: true }
    });
    if (tenant) return tenant.id;
  }

  throw new Error('Unable to resolve tenant ID');
}
```

### Tenant-Specific Customization

#### UI Theming & Branding
```yaml
Customization Options:
  - Logo (header, favicon)
  - Primary/secondary colors
  - Font family
  - Custom CSS overrides
  - White-label (remove platform branding)
  - Custom domain (custom.acme.com → CNAME to platform)

Storage:
  - Database: tenant.settings JSONB column
  - CDN: S3/MinIO for uploaded assets

Implementation:
  - React Context for theme
  - CSS variables for colors
  - Dynamic stylesheet loading
```

**Example:**
```typescript
// Theme loading
function TenantThemeProvider({ children }: { children: React.ReactNode }) {
  const { tenantId } = useTenant();
  const { data: theme } = useQuery(['tenant-theme', tenantId], () =>
    fetch(`/api/tenant/${tenantId}/theme`).then(r => r.json())
  );

  useEffect(() => {
    if (theme) {
      document.documentElement.style.setProperty('--primary-color', theme.primaryColor);
      document.documentElement.style.setProperty('--secondary-color', theme.secondaryColor);
      // Set favicon
      const link = document.querySelector("link[rel~='icon']") as HTMLLinkElement;
      if (link) link.href = theme.faviconUrl;
    }
  }, [theme]);

  return <ThemeContext.Provider value={theme}>{children}</ThemeContext.Provider>;
}
```

#### Feature Flags Per Tenant
```yaml
Use Cases:
  - Plan-based features (Professional tier gets advanced reports)
  - Beta features (enable for specific tenants)
  - Custom features (tenant-specific functionality)
  - Gradual rollout (enable features incrementally)

Storage:
  - Database: tenant_features table
  - Redis: Fast feature flag lookup

Implementation:
  - Middleware checks feature flags
  - UI conditionally renders features
  - API returns 403 for disabled features
```

**Example:**
```typescript
// Feature flag check
async function hasFeature(tenantId: string, feature: string): Promise<boolean> {
  const cacheKey = `tenant:${tenantId}:features`;

  // Check Redis cache
  let features = await redis.get(cacheKey);
  if (!features) {
    // Load from database
    const tenant = await prisma.tenant.findUnique({
      where: { id: tenantId },
      include: { features: true }
    });
    features = tenant.features.map(f => f.name);
    await redis.setex(cacheKey, 3600, JSON.stringify(features));
  } else {
    features = JSON.parse(features);
  }

  return features.includes(feature);
}

// Middleware
app.use('/api/advanced-reports', async (req, res, next) => {
  const tenantId = req.user.tenantId;
  if (!await hasFeature(tenantId, 'advanced_reports')) {
    return res.status(403).json({ error: 'Feature not available on your plan' });
  }
  next();
});
```

### Usage Tracking & Metering

**Tracking Metrics:**
```yaml
API Calls:
  - Total requests per tenant
  - Requests per endpoint
  - Requests per user

Storage:
  - File uploads (total size)
  - Database size (MB)
  - Number of records

Active Users:
  - Daily Active Users (DAU)
  - Monthly Active Users (MAU)
  - Concurrent sessions

Feature Usage:
  - Reports generated
  - Emails sent
  - API calls to specific features
```

**Implementation:**
```typescript
// Usage event tracking
async function trackUsage(tenantId: string, metric: string, value: number = 1) {
  const date = new Date().toISOString().split('T')[0]; // YYYY-MM-DD

  // Increment in Redis (real-time)
  await redis.hincrby(`usage:${tenantId}:${date}`, metric, value);

  // Aggregate to database (hourly via cron)
  // See SCHEDULED TASKS section
}

// Middleware for automatic API tracking
app.use(async (req, res, next) => {
  const tenantId = req.user?.tenantId;
  if (tenantId) {
    await trackUsage(tenantId, 'api_requests');
    await trackUsage(tenantId, `api_requests:${req.path}`);
  }
  next();
});

// Check usage limits
async function checkLimit(tenantId: string, metric: string): Promise<boolean> {
  const tenant = await prisma.tenant.findUnique({
    where: { id: tenantId },
    include: { plan: true }
  });

  const limit = tenant.plan.limits[metric]; // e.g., 1000 api_requests/month
  const usage = await getMonthlyUsage(tenantId, metric);

  if (usage >= limit) {
    // Send warning at 80%
    if (usage === Math.floor(limit * 0.8)) {
      await sendLimitWarning(tenantId, metric, usage, limit);
    }
    return false; // Limit exceeded
  }

  return true; // Within limits
}
```

### Billing & Subscription Management

**Subscription Tiers:**
```yaml
Free:
  Price: $0/month
  Users: 5
  API Calls: 1,000/month
  Storage: 1GB
  Features: Basic

Starter:
  Price: $29/month
  Users: 20
  API Calls: 10,000/month
  Storage: 10GB
  Features: Basic + Email notifications

Professional:
  Price: $99/month
  Users: 100
  API Calls: 100,000/month
  Storage: 100GB
  Features: Basic + Premium + Advanced reports + Priority support
  Isolation: Separate schema

Enterprise:
  Price: Custom
  Users: Unlimited
  API Calls: Unlimited
  Storage: Unlimited
  Features: All + Custom features + SLA + Dedicated support
  Isolation: Separate database
```

**Stripe Integration:**
```typescript
// Create customer and subscription
async function createSubscription(tenantId: string, planId: string) {
  const tenant = await prisma.tenant.findUnique({ where: { id: tenantId } });

  // Create Stripe customer
  const customer = await stripe.customers.create({
    email: tenant.email,
    metadata: { tenantId }
  });

  // Create subscription
  const subscription = await stripe.subscriptions.create({
    customer: customer.id,
    items: [{ price: planId }],
    metadata: { tenantId }
  });

  // Update tenant
  await prisma.tenant.update({
    where: { id: tenantId },
    data: {
      stripeCustomerId: customer.id,
      stripeSubscriptionId: subscription.id,
      plan: planId,
      subscriptionStatus: subscription.status
    }
  });
}

// Webhook handler for subscription updates
app.post('/webhooks/stripe', async (req, res) => {
  const event = req.body;

  switch (event.type) {
    case 'customer.subscription.updated':
      const subscription = event.data.object;
      await prisma.tenant.update({
        where: { stripeSubscriptionId: subscription.id },
        data: { subscriptionStatus: subscription.status }
      });
      break;

    case 'invoice.payment_failed':
      const invoice = event.data.object;
      const tenant = await prisma.tenant.findFirst({
        where: { stripeCustomerId: invoice.customer }
      });
      // Suspend tenant after grace period
      await sendPaymentFailedEmail(tenant);
      break;
  }

  res.json({ received: true });
});
```

### Security Considerations

**Tenant Isolation Checklist:**
- [ ] All database queries filtered by tenantId
- [ ] Row-Level Security (RLS) enabled for shared tables
- [ ] Middleware enforces tenant context
- [ ] File storage namespaced by tenantId
- [ ] Cache keys include tenantId prefix
- [ ] No cross-tenant foreign keys
- [ ] Admin endpoints verify tenant ownership
- [ ] Audit logs include tenantId

**Testing Cross-Tenant Access Prevention:**
```typescript
describe('Tenant isolation', () => {
  it('should not allow access to other tenant data', async () => {
    const tenant1Token = await loginAs('user@tenant1.com');
    const tenant2Token = await loginAs('user@tenant2.com');

    // Create resource as tenant1
    const res1 = await request(app)
      .post('/api/projects')
      .set('Authorization', `Bearer ${tenant1Token}`)
      .send({ name: 'Tenant 1 Project' });

    const projectId = res1.body.id;

    // Try to access as tenant2 (should fail)
    const res2 = await request(app)
      .get(`/api/projects/${projectId}`)
      .set('Authorization', `Bearer ${tenant2Token}`);

    expect(res2.status).toBe(404); // Not found (not 403, to avoid info leakage)
  });
});
```

### Migration from Single-Tenant to Multi-Tenant

**12-Week Migration Plan:**
```yaml
Weeks 1-2: Planning & Architecture
  - Choose isolation strategy
  - Design tenant model
  - Plan data migration approach
  - Set up development environment

Weeks 3-4: Database Schema Changes
  - Add tenant_id to all tables
  - Create tenant table
  - Set up Row-Level Security
  - Write migration scripts

Weeks 5-6: Application Code Updates
  - Implement tenant middleware
  - Update all queries with tenant filtering
  - Add tenant context to request objects
  - Implement tenant resolution logic

Weeks 7-8: Authentication & Authorization
  - Update JWT to include tenantId
  - Add tenant validation
  - Implement tenant-specific RBAC
  - Add cross-tenant access prevention

Weeks 9-10: Testing & Validation
  - Write tenant isolation tests
  - Test data migration scripts
  - Performance testing with multiple tenants
  - Security audit

Weeks 11-12: Deployment & Monitoring
  - Deploy to staging
  - Migrate existing customer data
  - Deploy to production
  - Monitor for issues
```

**Zero-Downtime Data Migration:**
```typescript
// Migrate existing single-tenant data to multi-tenant schema
async function migrateSingleTenantData() {
  // 1. Create default tenant for existing data
  const defaultTenant = await prisma.tenant.create({
    data: {
      name: 'Default Organization',
      subdomain: 'default',
      plan: 'enterprise'
    }
  });

  // 2. Update all existing records with default tenantId
  const tables = ['users', 'projects', 'tasks', 'comments'];

  for (const table of tables) {
    await prisma.$executeRawUnsafe(`
      UPDATE ${table} SET tenant_id = '${defaultTenant.id}' WHERE tenant_id IS NULL
    `);
  }

  // 3. Make tenant_id NOT NULL
  for (const table of tables) {
    await prisma.$executeRawUnsafe(`
      ALTER TABLE ${table} ALTER COLUMN tenant_id SET NOT NULL
    `);
  }

  // 4. Create indexes
  for (const table of tables) {
    await prisma.$executeRawUnsafe(`
      CREATE INDEX ${table}_tenant_id_idx ON ${table}(tenant_id)
    `);
  }
}
```

---

## 🔐 SECURITY IMPLEMENTATION (OWASP Top 10 2021 Compliance)

### A01: Broken Access Control
**Implementation:**
```yaml
Authentication:
  - JWT with configurable expiry (default: 30 minutes)
  - Refresh token mechanism
  - httpOnly, secure, sameSite: strict cookies
  - Session timeout: 30 minutes (warning at 25 minutes)

Authorization (RBAC):
  Roles:
    - Super Admin: Full system access
    - Admin: Administrative functions
    - Agent: Support/operational tasks
    - Submitter: Create and view own resources
    - Viewer: Read-only access

  Permission Matrix:
    - Create Users: Admin, Super Admin
    - Assign Tasks: Admin, Agent, Super Admin
    - View All Data: Admin, Super Admin
    - View Own Data: All roles
    - Create Resources: Submitter, Agent, Admin, Super Admin
    - Delete Resources: Admin, Super Admin
    - Manage System: Super Admin only

Account Security:
  - Account lockout: 5 failed attempts → 30 min lock
  - Progressive warnings at 3, 4, 5 attempts
  - IP tracking for suspicious activity
  - Login history audit trail

Enterprise Authentication:
  - Active Directory/LDAP integration
  - SAML 2.0 single sign-on (SSO)
  - OAuth 2.0 (Google, Microsoft, GitHub)
  - Just-In-Time (JIT) user provisioning
```

#### Active Directory / LDAP Integration

**Use Cases:**
- Enterprise customers with existing AD infrastructure
- Single sign-on with corporate credentials
- Centralized user management
- Automatic role assignment based on AD groups

**Implementation Strategy:**
```yaml
Libraries:
  - Node.js: ldapjs, passport-ldap
  - Python: python-ldap, ldap3

Configuration:
  LDAP_URL: ldap://ad.company.com:389 or ldaps://ad.company.com:636 (SSL)
  LDAP_BIND_DN: CN=AppService,OU=Services,DC=company,DC=com
  LDAP_BIND_PASSWORD: service_account_password
  LDAP_SEARCH_BASE: DC=company,DC=com
  LDAP_SEARCH_FILTER: (&(objectClass=user)(sAMAccountName={{username}}))
  LDAP_USER_ATTRIBUTES: mail,displayName,memberOf,title,department

Connection:
  - Use LDAPS (LDAP over SSL/TLS) for production
  - Connection pooling: min=2, max=10 connections
  - Connection timeout: 5 seconds
  - Reconnect on connection loss
  - Cache group memberships (TTL: 1 hour)
```

**Group-to-Role Mapping:**
```typescript
// AD group to application role mapping
const groupRoleMapping = {
  'CN=App-SuperAdmins,OU=Groups,DC=company,DC=com': 'super_admin',
  'CN=App-Admins,OU=Groups,DC=company,DC=com': 'admin',
  'CN=App-Agents,OU=Groups,DC=company,DC=com': 'agent',
  'CN=App-Users,OU=Groups,DC=company,DC=com': 'user'
};

async function mapADGroupsToRoles(memberOf: string[]): Promise<string[]> {
  const roles = memberOf
    .map(group => groupRoleMapping[group])
    .filter(role => role !== undefined);

  // Default to 'user' role if no matching groups
  return roles.length > 0 ? roles : ['user'];
}
```

**LDAP Authentication Flow:**
```typescript
import ldap from 'ldapjs';

async function authenticateWithLDAP(username: string, password: string) {
  const client = ldap.createClient({
    url: process.env.LDAP_URL!,
    timeout: 5000,
    connectTimeout: 5000
  });

  try {
    // 1. Bind with service account
    await new Promise((resolve, reject) => {
      client.bind(process.env.LDAP_BIND_DN!, process.env.LDAP_BIND_PASSWORD!, (err) => {
        if (err) reject(err);
        else resolve(true);
      });
    });

    // 2. Search for user
    const searchFilter = process.env.LDAP_SEARCH_FILTER!.replace('{{username}}', username);
    const searchResults = await new Promise<any>((resolve, reject) => {
      client.search(process.env.LDAP_SEARCH_BASE!, {
        filter: searchFilter,
        scope: 'sub',
        attributes: ['dn', 'mail', 'displayName', 'memberOf', 'title', 'department']
      }, (err, res) => {
        if (err) return reject(err);

        const entries: any[] = [];
        res.on('searchEntry', (entry) => entries.push(entry.object));
        res.on('error', reject);
        res.on('end', () => resolve(entries));
      });
    });

    if (searchResults.length === 0) {
      throw new Error('User not found in LDAP');
    }

    const userDN = searchResults[0].dn;
    const userAttributes = searchResults[0];

    // 3. Authenticate user with their credentials
    await new Promise((resolve, reject) => {
      const userClient = ldap.createClient({ url: process.env.LDAP_URL! });
      userClient.bind(userDN, password, (err) => {
        userClient.unbind();
        if (err) reject(new Error('Invalid credentials'));
        else resolve(true);
      });
    });

    // 4. Map AD groups to application roles
    const memberOf = userAttributes.memberOf || [];
    const roles = await mapADGroupsToRoles(Array.isArray(memberOf) ? memberOf : [memberOf]);

    // 5. Create or update user in local database (JIT provisioning)
    const user = await prisma.user.upsert({
      where: { email: userAttributes.mail },
      update: {
        name: userAttributes.displayName,
        ldapDN: userDN,
        department: userAttributes.department,
        title: userAttributes.title,
        lastLoginAt: new Date()
      },
      create: {
        email: userAttributes.mail,
        name: userAttributes.displayName,
        ldapDN: userDN,
        department: userAttributes.department,
        title: userAttributes.title,
        authProvider: 'ldap',
        roles: { connect: roles.map(r => ({ name: r })) }
      }
    });

    // 6. Generate JWT token
    const token = jwt.sign(
      { sub: user.id, email: user.email, roles },
      process.env.JWT_SECRET!,
      { expiresIn: '30m' }
    );

    return { user, token };

  } finally {
    client.unbind();
  }
}
```

**User Synchronization:**
```typescript
// Scheduled job to sync users from AD (run hourly)
async function syncUsersFromLDAP() {
  const client = ldap.createClient({ url: process.env.LDAP_URL! });

  try {
    await new Promise((resolve, reject) => {
      client.bind(process.env.LDAP_BIND_DN!, process.env.LDAP_BIND_PASSWORD!, (err) => {
        if (err) reject(err);
        else resolve(true);
      });
    });

    // Search for all users
    const allUsers = await new Promise<any[]>((resolve, reject) => {
      client.search(process.env.LDAP_SEARCH_BASE!, {
        filter: '(&(objectClass=user)(mail=*))',
        scope: 'sub',
        attributes: ['dn', 'mail', 'displayName', 'memberOf', 'title', 'department']
      }, (err, res) => {
        if (err) return reject(err);

        const entries: any[] = [];
        res.on('searchEntry', (entry) => entries.push(entry.object));
        res.on('error', reject);
        res.on('end', () => resolve(entries));
      });
    });

    // Sync each user
    for (const ldapUser of allUsers) {
      const roles = await mapADGroupsToRoles(
        Array.isArray(ldapUser.memberOf) ? ldapUser.memberOf : [ldapUser.memberOf]
      );

      await prisma.user.upsert({
        where: { email: ldapUser.mail },
        update: {
          name: ldapUser.displayName,
          ldapDN: ldapUser.dn,
          department: ldapUser.department,
          title: ldapUser.title,
          roles: { set: roles.map(r => ({ name: r })) }
        },
        create: {
          email: ldapUser.mail,
          name: ldapUser.displayName,
          ldapDN: ldapUser.dn,
          department: ldapUser.department,
          title: ldapUser.title,
          authProvider: 'ldap',
          roles: { connect: roles.map(r => ({ name: r })) }
        }
      });
    }

    console.log(`Synced ${allUsers.length} users from LDAP`);
  } finally {
    client.unbind();
  }
}
```

**API Endpoints:**
```yaml
POST /api/auth/ldap/login:
  Request:
    username: string
    password: string
  Response:
    user: User
    token: string
    refreshToken: string

GET /api/auth/ldap/sync (Admin only):
  Description: Trigger manual user synchronization
  Response:
    synced: number
    errors: string[]
```

**Security Best Practices:**
- ✅ Use LDAPS (SSL/TLS encryption) in production
- ✅ Store service account credentials securely (HashiCorp Vault)
- ✅ Use read-only service account with minimal permissions
- ✅ Implement connection pooling to avoid connection exhaustion
- ✅ Cache group memberships to reduce LDAP queries
- ✅ Handle nested AD groups (recursive group resolution)
- ✅ Log all authentication attempts for audit
- ✅ Implement rate limiting on LDAP authentication endpoint

#### SAML 2.0 Integration

**Use Cases:**
- Enterprise SSO with identity providers (Okta, Azure AD, OneLogin)
- Federated authentication across multiple applications
- Compliance requirements (SOC 2, ISO 27001)
- Mobile app authentication via IdP

**Implementation Strategy:**
```yaml
Libraries:
  - Node.js: passport-saml, samlify
  - Python: python-saml, python3-saml

Service Provider (SP) Configuration:
  SAML_ISSUER: https://app.company.com (Entity ID)
  SAML_ENTRY_POINT: https://idp.company.com/saml2/sso (IdP SSO URL)
  SAML_CALLBACK_URL: https://app.company.com/auth/saml/callback (ACS URL)
  SAML_LOGOUT_URL: https://app.company.com/auth/saml/logout (SLO URL)
  SAML_CERT_PATH: /path/to/idp-cert.pem (IdP public certificate)
  SAML_PRIVATE_KEY_PATH: /path/to/sp-private-key.pem (SP private key)

Identity Provider Support:
  - Okta
  - Azure AD (Microsoft Entra ID)
  - OneLogin
  - Google Workspace
  - ADFS (Active Directory Federation Services)
  - Auth0
  - Ping Identity
```

**SAML Configuration (passport-saml):**
```typescript
import passport from 'passport';
import { Strategy as SamlStrategy } from 'passport-saml';
import fs from 'fs';

passport.use(new SamlStrategy(
  {
    // Service Provider (SP) configuration
    issuer: process.env.SAML_ISSUER!,
    callbackUrl: process.env.SAML_CALLBACK_URL!,
    entryPoint: process.env.SAML_ENTRY_POINT!,
    cert: fs.readFileSync(process.env.SAML_CERT_PATH!, 'utf-8'),
    privateKey: fs.readFileSync(process.env.SAML_PRIVATE_KEY_PATH!, 'utf-8'),

    // SAML protocol settings
    identifierFormat: 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress',
    wantAssertionsSigned: true,
    wantAuthnResponseSigned: true,
    signatureAlgorithm: 'sha256',

    // Additional options
    passReqToCallback: true,
    decryptionPvk: fs.readFileSync(process.env.SAML_PRIVATE_KEY_PATH!, 'utf-8')
  },
  async (req, profile, done) => {
    try {
      // Extract user attributes from SAML assertion
      const email = profile.email || profile.nameID;
      const name = profile.displayName || profile.name || email;
      const groups = profile.groups || [];

      // Map IdP groups to application roles
      const roles = await mapIdPGroupsToRoles(groups);

      // Just-In-Time (JIT) user provisioning
      const user = await prisma.user.upsert({
        where: { email },
        update: {
          name,
          lastLoginAt: new Date(),
          samlNameId: profile.nameID,
          samlSessionIndex: profile.sessionIndex
        },
        create: {
          email,
          name,
          authProvider: 'saml',
          samlNameId: profile.nameID,
          samlSessionIndex: profile.sessionIndex,
          roles: { connect: roles.map(r => ({ name: r })) }
        }
      });

      done(null, user);
    } catch (error) {
      done(error);
    }
  }
));
```

**SAML Authentication Flow:**

1. **SP-Initiated Flow (User starts from application):**
```typescript
// Initiate SAML login
app.get('/auth/saml/login', passport.authenticate('saml', {
  failureRedirect: '/login',
  failureFlash: true
}));

// SAML callback (Assertion Consumer Service - ACS)
app.post('/auth/saml/callback',
  passport.authenticate('saml', { failureRedirect: '/login' }),
  (req, res) => {
    // Generate JWT token after successful SAML authentication
    const token = jwt.sign(
      { sub: req.user.id, email: req.user.email },
      process.env.JWT_SECRET!,
      { expiresIn: '30m' }
    );

    // Redirect to application with token
    res.redirect(`/dashboard?token=${token}`);
  }
);
```

2. **IdP-Initiated Flow (User starts from identity provider):**
```typescript
// Accept IdP-initiated SAML assertions
app.post('/auth/saml/callback',
  passport.authenticate('saml', {
    failureRedirect: '/login',
    keepSessionInfo: true
  }),
  (req, res) => {
    const token = jwt.sign(
      { sub: req.user.id, email: req.user.email },
      process.env.JWT_SECRET!,
      { expiresIn: '30m' }
    );

    // Redirect to application or RelayState URL
    const relayState = req.body.RelayState || '/dashboard';
    res.redirect(`${relayState}?token=${token}`);
  }
);
```

**Single Logout (SLO):**
```typescript
// Initiate logout
app.get('/auth/saml/logout', (req, res) => {
  const strategy = passport._strategy('saml');

  strategy.logout(req, (err, requestUrl) => {
    if (err) {
      return res.status(500).json({ error: 'Logout failed' });
    }

    // Clear local session
    req.logout(() => {
      // Redirect to IdP logout URL
      res.redirect(requestUrl);
    });
  });
});

// SLO callback (from IdP)
app.post('/auth/saml/logout/callback', (req, res) => {
  // Handle logout response from IdP
  req.logout(() => {
    res.redirect('/login?logout=success');
  });
});
```

**SAML Metadata Endpoint:**
```typescript
// Service Provider metadata (for IdP configuration)
app.get('/api/auth/saml/metadata', (req, res) => {
  const strategy = passport._strategy('saml');

  const metadata = strategy.generateServiceProviderMetadata(
    fs.readFileSync(process.env.SAML_CERT_PATH!, 'utf-8'),
    fs.readFileSync(process.env.SAML_CERT_PATH!, 'utf-8')
  );

  res.type('application/xml');
  res.send(metadata);
});
```

**Group/Role Mapping:**
```typescript
// Map IdP groups to application roles
async function mapIdPGroupsToRoles(idpGroups: string[]): Promise<string[]> {
  const roleMapping = {
    'App-SuperAdmins': 'super_admin',
    'App-Admins': 'admin',
    'App-Agents': 'agent',
    'App-Users': 'user'
  };

  const roles = idpGroups
    .map(group => roleMapping[group])
    .filter(role => role !== undefined);

  return roles.length > 0 ? roles : ['user'];
}
```

**Multi-Tenant SAML Configuration:**
```typescript
// Per-tenant SAML configuration
async function getTenantSAMLConfig(tenantId: string) {
  const tenant = await prisma.tenant.findUnique({
    where: { id: tenantId },
    select: {
      samlEnabled: true,
      samlIssuer: true,
      samlEntryPoint: true,
      samlCertificate: true
    }
  });

  if (!tenant?.samlEnabled) {
    throw new Error('SAML not configured for tenant');
  }

  return new SamlStrategy({
    issuer: tenant.samlIssuer,
    entryPoint: tenant.samlEntryPoint,
    cert: tenant.samlCertificate,
    callbackUrl: `https://app.company.com/${tenantId}/auth/saml/callback`,
    // ... other config
  });
}
```

**API Endpoints:**
```yaml
GET /api/auth/saml/metadata:
  Description: SP metadata XML for IdP configuration
  Response: application/xml

GET /auth/saml/login:
  Description: Initiate SAML authentication (SP-initiated)
  Redirects: IdP login page

POST /auth/saml/callback:
  Description: Assertion Consumer Service (ACS) endpoint
  Request: SAML assertion from IdP
  Response: Redirect to application with JWT token

GET /auth/saml/logout:
  Description: Initiate SAML single logout
  Redirects: IdP logout page

POST /auth/saml/logout/callback:
  Description: SLO callback from IdP
  Response: Redirect to login page
```

**Supported Identity Providers Setup:**

*Okta:*
```yaml
SAML_ENTRY_POINT: https://{your-domain}.okta.com/app/{app-id}/sso/saml
SAML_ISSUER: http://www.okta.com/{app-id}
Attribute Mappings:
  email: user.email
  firstName: user.firstName
  lastName: user.lastName
  groups: appuser.groups
```

*Azure AD:*
```yaml
SAML_ENTRY_POINT: https://login.microsoftonline.com/{tenant-id}/saml2
SAML_ISSUER: https://sts.windows.net/{tenant-id}/
Attribute Mappings:
  email: user.mail
  displayName: user.displayname
  groups: user.groups
```

*Google Workspace:*
```yaml
SAML_ENTRY_POINT: https://accounts.google.com/o/saml2/idp?idpid={idp-id}
SAML_ISSUER: https://accounts.google.com/o/saml2?idpid={idp-id}
Attribute Mappings:
  email: email
  firstName: firstName
  lastName: lastName
```

**Security Best Practices:**
- ✅ Validate SAML assertions (signatures, timestamps)
- ✅ Use HTTPS for all SAML endpoints
- ✅ Implement replay attack prevention (assertion caching)
- ✅ Set short assertion validity period (5 minutes)
- ✅ Verify audience restriction (Entity ID)
- ✅ Enable assertion encryption in production
- ✅ Implement Single Logout (SLO) support
- ✅ Log all SAML authentication events
- ✅ Rotate signing certificates annually
- ✅ Monitor for certificate expiration

**Troubleshooting:**
```yaml
Common Issues:
  1. Certificate mismatch:
     - Verify IdP certificate is correct and not expired
     - Check certificate format (PEM, no extra whitespace)

  2. Clock skew errors:
     - Sync server time with NTP
     - Increase NotBefore/NotOnOrAfter tolerance

  3. Signature validation failures:
     - Ensure wantAssertionsSigned matches IdP settings
     - Verify signature algorithm (SHA-256 recommended)

  4. Redirect loop:
     - Check callback URL matches IdP configuration exactly
     - Ensure RelayState is preserved

  5. IdP groups not mapped:
     - Verify group attribute name in SAML assertion
     - Check group mapping configuration
```

### A02: Cryptographic Failures
**Implementation:**
```yaml
Encryption:
  - HTTPS/TLS 1.3 enforced
  - bcrypt password hashing (12 rounds)
  - Sensitive data encrypted at rest
  - Database encryption for PII fields

Headers:
  - Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
  - X-Content-Type-Options: nosniff
  - X-Frame-Options: DENY
  - Referrer-Policy: strict-origin-when-cross-origin
  - Permissions-Policy: geolocation=(), microphone=(), camera=()
```

### A03: Injection
**Implementation:**
```yaml
SQL Injection Prevention:
  - Parameterized queries (Prisma ORM)
  - Input validation with Zod/Pydantic
  - Prepared statements only
  - No dynamic SQL construction

NoSQL Injection Prevention:
  - Schema validation for all inputs
  - Type checking with TypeScript
  - Sanitize MongoDB queries

Command Injection Prevention:
  - Whitelist allowed commands
  - Input validation
  - Avoid shell execution where possible
```

### A04: Insecure Design
**Implementation:**
```yaml
Security by Design:
  - Threat modeling during architecture phase
  - Security requirements in user stories
  - Defense in depth strategy
  - Principle of least privilege
  - Fail securely (default deny)
  - Separation of duties

Design Patterns:
  - Secure session management
  - Rate limiting architecture
  - API versioning strategy
  - Error handling without data leakage
```

### A05: Security Misconfiguration
**Implementation:**
```yaml
Hardening:
  - Remove default accounts
  - Disable directory listing
  - Custom error pages (no stack traces)
  - Minimal dependencies
  - Remove unused features
  - Regular security updates

Content Security Policy (CSP):
  default-src: 'self'
  script-src: 'self' 'unsafe-inline' 'unsafe-eval' (minimize)
  style-src: 'self' 'unsafe-inline'
  img-src: 'self' data: https:
  font-src: 'self' data:
  connect-src: 'self' https://api.domain.com
  frame-ancestors: 'none'
  base-uri: 'self'
  form-action: 'self'
  report-uri: /api/csp-report

Security Headers (15+ via Helmet.js):
  - X-DNS-Prefetch-Control: off
  - X-Download-Options: noopen
  - X-Permitted-Cross-Domain-Policies: none
  - Cross-Origin-Embedder-Policy: require-corp
  - Cross-Origin-Opener-Policy: same-origin
  - Cross-Origin-Resource-Policy: same-origin
```

### A06: Vulnerable and Outdated Components
**Implementation:**
```yaml
Dependency Management:
  - npm audit / pip audit in CI/CD
  - Automated dependency updates (Dependabot/Renovate)
  - SonarQube scanning
  - OWASP Dependency-Check
  - Regular security patches
  - Version pinning with update schedule

Monitoring:
  - Snyk integration
  - GitHub Security Advisories
  - CVE monitoring
```

### A07: Identification and Authentication Failures
**Implementation:**
```yaml
Password Policy:
  - Length: 8-128 characters
  - Complexity: Upper, lower, number, special character
  - No common passwords (check against breach database)
  - Password history (prevent reuse of last 5)
  - Secure password reset flow

Multi-Factor Authentication (MFA):
  - TOTP (Time-based One-Time Password) ready
  - Backup codes generation
  - MFA enforcement for privileged accounts
  - Admin can manage user MFA

Session Management:
  - Secure session ID generation
  - Session fixation prevention
  - Concurrent session limits
  - Force logout capability
  - Token blacklist for immediate revocation
```

### A08: Software and Data Integrity Failures
**Implementation:**
```yaml
File Upload Security:
  - MIME type validation
  - Extension whitelist: .pdf, .jpg, .png, .doc, .docx
  - File size limit: 5MB per file
  - Maximum files: 5 per upload
  - Magic byte verification
  - Virus scanning ready (ClamAV integration point)
  - Randomized filenames (UUID)
  - Separate storage domain
  - Content-Disposition: attachment headers

Code Integrity:
  - Code signing (planned)
  - Subresource Integrity (SRI) for CDN assets
  - Verified packages only
  - Git commit signing
```

### A09: Security Logging and Monitoring Failures
**Implementation:**
```yaml
Audit Logging Categories:
  Authentication Events:
    - Successful logins (user, IP, device, timestamp)
    - Failed login attempts (reason, IP, timestamp)
    - Password changes
    - MFA setup/removal
    - Account lockouts
    - Force logouts

  User Management:
    - User creation/deletion
    - Role changes
    - Permission modifications
    - Account activations/deactivations

  Security Events:
    - Suspicious activity detection
    - Rate limit violations
    - IP whitelist changes
    - Session terminations
    - CSP violations

  File Operations:
    - File uploads (user, size, type, scan result)
    - File downloads
    - File deletions

  Resource Operations:
    - Create/Read/Update/Delete operations
    - Bulk operations
    - Export operations

Log Storage:
  - Centralized logging system
  - 90-day retention minimum
  - Encrypted at rest
  - Access controls on logs
  - SIEM export ready

Monitoring:
  - Real-time alerts for critical events
  - Failed login threshold alerts
  - Unusual access patterns
  - Error rate monitoring
  - Performance degradation alerts
```

### A10: Server-Side Request Forgery (SSRF)
**Implementation:**
```yaml
SSRF Prevention:
  - URL validation and sanitization
  - Whitelist allowed domains
  - Block private IP ranges (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16)
  - Block localhost/127.0.0.1
  - Disable URL redirects in HTTP clients
  - DNS validation
  - Network segmentation
```

### Security Operations & Maintenance

#### Vulnerability Scanning Procedures

**Automated Scanning Schedule:**
```yaml
Dependency Scanning:
  Tool: npm audit, Snyk, or Dependabot
  Frequency: Daily (automated in CI/CD pipeline)
  Scope: All npm/yarn packages, Docker base images
  Action: Auto-create PRs for security updates

Container Scanning:
  Tool: Trivy, Harbor, or Snyk Container
  Frequency: On every image build
  Scope: Docker images, base layers
  Action: Block deployment if critical vulnerabilities found

SAST (Static Application Security Testing):
  Tool: SonarQube, Semgrep, or CodeQL
  Frequency: On every commit (via CI/CD)
  Scope: Source code, configuration files
  Action: Flag high-severity issues in PR review

DAST (Dynamic Application Security Testing):
  Tool: OWASP ZAP, Burp Suite
  Frequency: Weekly on staging environment
  Scope: Running application, all endpoints
  Action: Generate report, create tickets for findings

Manual Security Audits:
  Frequency: Quarterly
  Scope: Architecture review, code review, penetration testing
  Conducted by: Internal security team or external consultants
```

**npm audit Integration:**
```bash
# Run in CI/CD pipeline
npm audit --audit-level=high

# If vulnerabilities found, fail build
if [ $? -ne 0 ]; then
  echo "Security vulnerabilities found!"
  exit 1
fi

# Generate audit report
npm audit --json > security-audit.json

# Auto-fix non-breaking updates
npm audit fix

# For breaking changes, create GitHub issue
npm audit fix --dry-run --json | \
  jq -r '.advisories | to_entries[] | "Issue: \(.value.title)"'
```

**Snyk Integration:**
```yaml
# .github/workflows/security-scan.yml
name: Security Scan

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]
  schedule:
    - cron: '0 2 * * *'  # Daily at 2 AM

jobs:
  security:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Run Snyk to check for vulnerabilities
        uses: snyk/actions/node@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
        with:
          args: --severity-threshold=high --fail-on=all

      - name: Upload result to GitHub Code Scanning
        uses: github/codeql-action/upload-sarif@v2
        with:
          sarif_file: snyk.sarif
```

**OWASP ZAP Scanning:**
```bash
#!/bin/bash
# scripts/security-scan.sh

# Start OWASP ZAP in daemon mode
docker run -d --name zap -p 8080:8080 \
  owasp/zap2docker-stable zap.sh -daemon -port 8080 -host 0.0.0.0

# Wait for ZAP to start
sleep 30

# Run spider scan (discover endpoints)
curl "http://localhost:8080/JSON/spider/action/scan/?url=https://staging.myapp.com"

# Wait for spider to complete
while [ $(curl -s "http://localhost:8080/JSON/spider/view/status" | jq -r '.status') != "100" ]; do
  echo "Spider scan in progress..."
  sleep 10
done

# Run active scan (vulnerability testing)
curl "http://localhost:8080/JSON/ascan/action/scan/?url=https://staging.myapp.com"

# Wait for active scan to complete
while [ $(curl -s "http://localhost:8080/JSON/ascan/view/status" | jq -r '.status') != "100" ]; do
  echo "Active scan in progress..."
  sleep 30
done

# Generate HTML report
curl "http://localhost:8080/OTHER/core/other/htmlreport" > zap-report.html

# Generate JSON report
curl "http://localhost:8080/JSON/core/view/alerts" > zap-alerts.json

# Check for high-risk issues
HIGH_RISK=$(jq '[.alerts[] | select(.risk == "High")] | length' zap-alerts.json)

if [ "$HIGH_RISK" -gt 0 ]; then
  echo "Found $HIGH_RISK high-risk vulnerabilities!"
  exit 1
fi

# Cleanup
docker stop zap && docker rm zap
```

**Penetration Testing:**
```yaml
Annual Penetration Test:
  Scope:
    - Web application (all user roles)
    - API endpoints (authenticated and unauthenticated)
    - Authentication & authorization
    - Data validation and sanitization
    - Session management
    - File upload functionality
    - Third-party integrations

  Methodology:
    - OWASP Testing Guide
    - OWASP Top 10 verification
    - Business logic testing
    - Privilege escalation attempts
    - Data exposure testing

  Deliverables:
    - Executive summary
    - Detailed findings with CVSS scores
    - Proof-of-concept exploits
    - Remediation recommendations
    - Retest after fixes applied

  Follow-up:
    - Remediation within SLA timeframes
    - Retest to verify fixes
    - Update security documentation
```

**Bug Bounty Program:**
```yaml
Program Setup:
  Platform: HackerOne, Bugcrowd, or self-hosted
  Scope:
    In-Scope:
      - *.myapp.com (production domains)
      - api.myapp.com
      - Mobile apps (iOS, Android)

    Out-of-Scope:
      - staging.myapp.com (staging environments)
      - Third-party services
      - Social engineering
      - Physical attacks
      - DoS/DDoS attacks

  Rewards:
    Critical (RCE, SQLi, Auth bypass): $5,000 - $10,000
    High (XSS, IDOR, privilege escalation): $1,000 - $5,000
    Medium (CSRF, information disclosure): $500 - $1,000
    Low (rate limiting, minor issues): $100 - $500

  Response SLA:
    - Initial response: 2 business days
    - Triage: 5 business days
    - Resolution: Based on severity (see patch management)
```

**Vulnerability Disclosure Policy:**
```markdown
# Security Vulnerability Disclosure Policy

We take security seriously. If you discover a security vulnerability, please:

1. **Report It Privately**: Email security@myapp.com (PGP key available)
2. **Provide Details**: Include steps to reproduce, impact assessment
3. **Allow Time to Fix**: Give us 90 days before public disclosure
4. **Don't Exploit**: Don't access or modify user data

We will:
- Acknowledge your report within 2 business days
- Provide status updates every 7 days
- Credit you in our security advisory (if desired)
- Consider you for our bug bounty program

Thank you for helping keep our users safe!
```

**Remediation SLA:**
```yaml
Vulnerability Severity (CVSS Score):
  Critical (9.0-10.0):
    Response Time: 4 hours
    Patch Deployment: 24 hours
    Exceptions: None (all hands on deck)

  High (7.0-8.9):
    Response Time: 8 hours
    Patch Deployment: 7 days
    Exceptions: May extend to 14 days with risk acceptance

  Medium (4.0-6.9):
    Response Time: 24 hours
    Patch Deployment: 30 days
    Exceptions: May include in next regular release

  Low (0.1-3.9):
    Response Time: 5 business days
    Patch Deployment: 90 days
    Exceptions: May defer if risk is negligible

Emergency Patch Process:
  1. Verify vulnerability and assess impact
  2. Develop patch and test in staging
  3. Schedule emergency maintenance window
  4. Deploy patch to production
  5. Verify fix and monitor for issues
  6. Publish security advisory
  7. Update documentation
```

#### Security Patch Management

**Patch Evaluation Process:**
```yaml
Step 1: Identify Security Patches
  Sources:
    - npm security advisories
    - GitHub Dependabot alerts
    - CVE database (https://cve.mitre.org)
    - Vendor security bulletins (PostgreSQL, Redis, nginx)
    - Security mailing lists (Node.js, Docker)

  Automated Monitoring:
    - Dependabot creates PRs for vulnerable dependencies
    - Snyk monitors and alerts on new vulnerabilities
    - RSS feeds for CVE notifications

Step 2: Assess Impact & Urgency
  Evaluate:
    - CVSS score (severity rating)
    - Exploitability (is exploit public? is it being exploited?)
    - Attack vector (network, local, physical)
    - Privileges required (none, low, high)
    - User interaction required
    - Impact on confidentiality, integrity, availability

  Prioritization:
    Critical: Actively exploited, public exploit, high CVSS
    High: Public exploit, affects core functionality
    Medium: No public exploit, affects non-core functionality
    Low: Low CVSS, minimal impact

Step 3: Test in Staging Environment
  Testing Checklist:
    - [ ] Apply patch to staging environment
    - [ ] Run full test suite (unit, integration, E2E)
    - [ ] Manual testing of affected functionality
    - [ ] Performance testing (check for regressions)
    - [ ] Compatibility testing (integrations, third-party libs)
    - [ ] Verify patch actually fixes the vulnerability

  Test Duration:
    Critical: 2-4 hours (expedited)
    High: 1 day
    Medium: 2-3 days
    Low: 1 week

Step 4: Schedule Deployment Window
  Critical Patches:
    - Deploy immediately (emergency change process)
    - Notify users of brief downtime
    - Deploy during business hours (full team available)

  High Patches:
    - Deploy within SLA window (7 days)
    - Schedule during low-traffic hours (2-4 AM)
    - Notify users 24 hours in advance

  Medium/Low Patches:
    - Bundle with regular releases
    - Follow normal deployment schedule
    - Notify users in release notes

Step 5: Apply Patch & Verify
  Deployment:
    - Use blue-green or canary deployment
    - Monitor metrics closely during rollout
    - Have rollback plan ready

  Verification:
    - Verify vulnerability is fixed (rerun security scan)
    - Monitor error rates and performance
    - Check user reports for issues
    - Document patch in change log

Step 6: Document & Communicate
  Internal Documentation:
    - Update CHANGELOG.md with security fixes
    - Document patch in incident report (if applicable)
    - Update security documentation

  External Communication:
    - Publish security advisory (if user action required)
    - Update support documentation
    - Notify affected customers (if data breach)
```

**Emergency Patch Procedure (Critical Vulnerabilities):**
```bash
#!/bin/bash
# Emergency patch deployment script

# 1. Create emergency branch
git checkout -b emergency/patch-critical-vuln-$(date +%Y%m%d)

# 2. Apply patch
npm update vulnerable-package@safe-version

# 3. Run quick smoke tests
npm run test:critical

# 4. Build and deploy to staging
docker build -t myapp:emergency .
docker-compose -f docker-compose.staging.yml up -d

# 5. Quick verification in staging
./scripts/verify-patch.sh staging

# 6. Deploy to production (blue-green)
kubectl set image deployment/app app=myapp:emergency

# 7. Monitor for 15 minutes
echo "Monitoring production for issues..."
sleep 900

# 8. Check error rates
ERROR_RATE=$(curl -s http://production/metrics | grep error_rate)
if [ "$ERROR_RATE" -gt 0.01 ]; then
  echo "Error rate too high, rolling back..."
  kubectl rollout undo deployment/app
  exit 1
fi

# 9. Complete deployment
echo "Emergency patch deployed successfully"

# 10. Publish security advisory
./scripts/publish-security-advisory.sh
```

**Patch Documentation Template:**
```markdown
# Security Patch - [Vulnerability Name] - [Date]

## Summary
Brief description of the vulnerability and patch.

## Affected Versions
- Version X.Y.Z and earlier

## Vulnerability Details
- **CVE ID**: CVE-2026-XXXX
- **CVSS Score**: 9.5 (Critical)
- **Attack Vector**: Network
- **Impact**: Remote Code Execution

## Patch Information
- **Fixed in Version**: X.Y.Z+1
- **Release Date**: YYYY-MM-DD
- **GitHub PR**: #1234

## Upgrade Instructions
```bash
# For Docker deployments
docker pull myapp:X.Y.Z+1
docker-compose up -d

# For npm installations
npm install myapp@X.Y.Z+1
```

## Verification
After upgrading, verify the fix by:
1. Check application version: `curl https://myapp.com/api/version`
2. Run security scan: `npm audit`
3. Verify no vulnerable packages: `npm audit --audit-level=moderate`

## Credits
Thank you to [Researcher Name] for responsibly disclosing this vulnerability.

## Questions?
Contact security@myapp.com for any questions or concerns.
```

#### Enhanced Data Privacy Controls

**Data Classification:**
```yaml
Public:
  Description: Information intended for public access
  Examples: Marketing materials, public documentation, blog posts
  Encryption: Not required
  Access Control: No restrictions

Internal:
  Description: Information for internal use only
  Examples: Internal documentation, meeting notes, project plans
  Encryption: In transit (TLS)
  Access Control: Authenticated users only

Confidential:
  Description: Sensitive business information
  Examples: Financial data, contracts, strategic plans, user data
  Encryption: In transit (TLS) and at rest (AES-256)
  Access Control: Role-based access, audit logging

Restricted:
  Description: Highly sensitive information requiring strict controls
  Examples: Payment card data, health records, authentication credentials
  Encryption: In transit (TLS 1.3) and at rest (AES-256), database-level encryption
  Access Control: Need-to-know basis, MFA required, extensive audit logging
```

**Encryption Standards:**
```yaml
Data at Rest:
  Algorithm: AES-256-GCM
  Key Management: HashiCorp Vault or AWS KMS
  Key Rotation: Every 90 days
  Scope:
    - Database: Transparent Data Encryption (TDE) for PostgreSQL
    - File Storage: Encrypted S3 buckets or encrypted filesystem
    - Backups: Encrypted with separate keys
    - Logs: Encrypt sensitive fields before writing

Data in Transit:
  Protocol: TLS 1.3 (minimum TLS 1.2)
  Certificate: Let's Encrypt or commercial CA
  Cipher Suites: Modern, secure ciphers only (no RC4, 3DES, MD5)
  Perfect Forward Secrecy: Enabled
  HSTS: Enabled with preload
  Scope:
    - All HTTP traffic (enforce HTTPS)
    - Database connections (SSL/TLS required)
    - Redis connections (TLS enabled)
    - Internal service communication (mTLS)

Database-Level Encryption:
  PostgreSQL pgcrypto:
    - Encrypt PII fields (SSN, credit card, passport)
    - Use symmetric encryption for bulk data
    - Use asymmetric encryption for keys
    - Store encryption keys in Vault

  Example:
    CREATE EXTENSION pgcrypto;

    -- Encrypt data
    INSERT INTO users (email, ssn_encrypted)
    VALUES ('user@example.com',
            pgp_sym_encrypt('123-45-6789', 'encryption-key'));

    -- Decrypt data
    SELECT email,
           pgp_sym_decrypt(ssn_encrypted, 'encryption-key') AS ssn
    FROM users;
```

**Data Retention Policies:**
```yaml
Active Data:
  User Accounts: Indefinite (until user requests deletion)
  Application Data: Indefinite (per business requirements)
  Audit Logs: 2 years (compliance requirement)

Deleted Data:
  Soft Delete Period: 30 days (recoverable)
  Hard Delete: After 30 days (permanent deletion)
  Backup Retention: 30 days daily, 12 months monthly

Logs:
  Application Logs: 90 days
  Access Logs: 1 year
  Security Logs: 2 years
  Compliance Logs: 7 years (SOX, PCI-DSS)

Backups:
  Daily Backups: 30 days
  Weekly Backups: 3 months
  Monthly Backups: 1 year
  Annual Backups: 7 years

Automated Cleanup:
  - Daily cron job to delete expired data
  - Weekly job to archive old logs
  - Monthly job to purge old backups
```

**GDPR Compliance (Personal Data Handling):**
```yaml
Right to Access (Data Export):
  Endpoint: GET /api/user/data-export
  Format: JSON or CSV
  Contents: All personal data, activity logs
  Delivery: Download link or email
  Processing Time: Within 30 days (GDPR requirement)

Right to Erasure (Account Deletion):
  Endpoint: DELETE /api/user/account
  Process:
    1. User confirms deletion (email verification)
    2. Soft delete user account (30-day grace period)
    3. Notify user of grace period
    4. After 30 days, hard delete all personal data
    5. Anonymize logs (replace user ID with "deleted-user")
    6. Remove from backups (mark for deletion on restore)
  Exceptions: Legal hold, ongoing investigation

Right to Portability:
  Endpoint: GET /api/user/data-export?format=portable
  Format: Machine-readable JSON
  Contents: User data in structured format
  Processing Time: Immediately (up to 30 days)

Right to Rectification:
  Endpoint: PUT /api/user/profile
  Process: User can update personal information
  Verification: Email verification for email changes

Consent Management:
  - Track user consent for data processing
  - Allow users to withdraw consent
  - Granular consent (marketing, analytics, etc.)
  - Audit trail of consent changes

Data Breach Notification:
  - Detect breach within 72 hours
  - Notify supervisory authority within 72 hours
  - Notify affected users without undue delay
  - Document breach in incident register
```

**Data Anonymization for Analytics:**
```typescript
// Anonymize user data for analytics
function anonymizeUserData(user: User): AnonymizedUser {
  return {
    userId: hashUserId(user.id),  // One-way hash
    ageRange: getAgeRange(user.birthDate),  // 18-24, 25-34, etc.
    country: user.country,  // Keep country for geo analytics
    signupDate: truncateDate(user.createdAt, 'month'),  // Month precision only
    // Remove: name, email, phone, address
  };
}

// Use anonymized data for analytics
const analyticsData = users.map(anonymizeUserData);
await sendToAnalytics(analyticsData);
```

**Privacy by Design Checklist:**
```yaml
Data Minimization:
  - [ ] Collect only necessary personal data
  - [ ] No excessive data collection
  - [ ] Clear purpose for each data point
  - [ ] Regular review of collected data

Purpose Limitation:
  - [ ] Data used only for stated purpose
  - [ ] No secondary use without consent
  - [ ] Clear privacy policy
  - [ ] User informed of data usage

Storage Limitation:
  - [ ] Data retained only as long as necessary
  - [ ] Automated deletion of expired data
  - [ ] Clear retention periods
  - [ ] Regular data audits

Security:
  - [ ] Encryption at rest and in transit
  - [ ] Access controls implemented
  - [ ] Regular security audits
  - [ ] Incident response plan

Transparency:
  - [ ] Clear privacy policy
  - [ ] Data processing notices
  - [ ] User rights documented
  - [ ] Contact information provided

User Rights:
  - [ ] Access (data export)
  - [ ] Rectification (data update)
  - [ ] Erasure (account deletion)
  - [ ] Portability (data download)
  - [ ] Object (opt-out of processing)
```

---

## 🛡️ RATE LIMITING CONFIGURATION

### Multi-Tier Rate Limiting
```yaml
Authentication Endpoints:
  Login: 5 attempts per 15 minutes per IP
  Registration: 3 attempts per 1 hour per IP
  Password Reset: 3 attempts per 1 hour per email
  MFA Verification: 5 attempts per 15 minutes per session

General API:
  Authenticated: 100 requests per 15 minutes per user
  Unauthenticated: 20 requests per 15 minutes per IP

Resource-Intensive Endpoints:
  File Upload: 10 uploads per 1 hour per user
  Export/Reports: 5 requests per 1 hour per user
  Search: 30 requests per 1 minute per user

Admin Operations:
  User Management: 50 requests per 15 minutes per admin
  System Configuration: 20 requests per 15 minutes per admin

WebSocket Connections:
  Max Connections: 5 per user
  Message Rate: 100 messages per minute per connection

Implementation:
  - Redis-based rate limiting
  - IP + User ID tracking
  - X-RateLimit-* headers in responses
  - 429 Too Many Requests with Retry-After header
  - Progressive delays on repeated violations
```

---

## ⚡ SCALABILITY & PERFORMANCE OPTIMIZATION

### Horizontal Scaling Strategy

**Stateless Application Design:**
```yaml
Principles:
  - No local state stored on application servers
  - Session data in Redis (shared across instances)
  - File uploads to centralized storage (S3/MinIO)
  - No server affinity required
  - Identical application servers

Benefits:
  - Easy scale-out (add more servers)
  - Zero-downtime deployments
  - Fault tolerance (server failure)
  - Load distribution
```

**Scaling Triggers:**
```yaml
Auto-Scaling Rules:
  Scale Up (add instances):
    - CPU usage > 70% for 5 minutes
    - Memory usage > 80% for 5 minutes
    - Request queue depth > 100
    - Average response time > 500ms

  Scale Down (remove instances):
    - CPU usage < 30% for 10 minutes
    - Memory usage < 50% for 10 minutes
    - Request queue depth < 20
    - Minimum instances: 2 (high availability)

  Cooldown Period: 5 minutes (prevent flapping)
```

**Session Management:**
```typescript
// Redis-backed sessions (shared across instances)
import session from 'express-session';
import RedisStore from 'connect-redis';
import { createClient } from 'redis';

const redisClient = createClient({
  url: process.env.REDIS_URL,
  socket: {
    reconnectStrategy: (retries) => Math.min(retries * 50, 500)
  }
});

app.use(session({
  store: new RedisStore({ client: redisClient }),
  secret: process.env.SESSION_SECRET!,
  resave: false,
  saveUninitialized: false,
  cookie: {
    secure: true,
    httpOnly: true,
    maxAge: 1800000 // 30 minutes
  }
}));
```

**Sticky Sessions vs Session Replication:**
```yaml
Sticky Sessions (IP Hash):
  Pros: Simple, no session replication needed
  Cons: Uneven load distribution, problematic with failures

Session Replication (Redis):
  Pros: Even load distribution, fault-tolerant
  Cons: Slightly higher latency, Redis dependency
  Recommended: Use Redis for production
```

### Load Balancing

**Nginx Load Balancer Configuration:**
```nginx
# /etc/nginx/nginx.conf
upstream app_servers {
  # Load balancing algorithm
  least_conn;  # Route to server with fewest connections

  # Application servers
  server app1.internal:3000 weight=1 max_fails=3 fail_timeout=30s;
  server app2.internal:3000 weight=1 max_fails=3 fail_timeout=30s;
  server app3.internal:3000 weight=1 max_fails=3 fail_timeout=30s;

  # Health check
  keepalive 32;
}

server {
  listen 80;
  server_name app.company.com;

  # Redirect HTTP to HTTPS
  return 301 https://$server_name$request_uri;
}

server {
  listen 443 ssl http2;
  server_name app.company.com;

  # SSL configuration
  ssl_certificate /etc/ssl/certs/app.company.com.crt;
  ssl_certificate_key /etc/ssl/private/app.company.com.key;
  ssl_protocols TLSv1.3;
  ssl_prefer_server_ciphers on;

  # Security headers
  add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
  add_header X-Frame-Options "DENY" always;
  add_header X-Content-Type-Options "nosniff" always;

  # Gzip compression
  gzip on;
  gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
  gzip_min_length 1000;

  # Proxy configuration
  location / {
    proxy_pass http://app_servers;
    proxy_http_version 1.1;

    # Headers for backend
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;

    # WebSocket support
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";

    # Timeouts
    proxy_connect_timeout 60s;
    proxy_send_timeout 60s;
    proxy_read_timeout 60s;

    # Buffering
    proxy_buffering on;
    proxy_buffer_size 4k;
    proxy_buffers 8 4k;
  }

  # Health check endpoint (bypass load balancing)
  location /health {
    proxy_pass http://app_servers/health;
    access_log off;
  }

  # Static assets (cache)
  location ~* \.(jpg|jpeg|png|gif|ico|css|js|svg|woff|woff2)$ {
    proxy_pass http://app_servers;
    expires 1y;
    add_header Cache-Control "public, immutable";
  }
}
```

**Load Balancing Algorithms:**
```yaml
Round Robin (default):
  - Requests distributed evenly in rotation
  - Simple, predictable
  - Use when: All servers have equal capacity

Least Connections (least_conn):
  - Routes to server with fewest active connections
  - Better for long-lived connections
  - Use when: Requests have variable duration

IP Hash (ip_hash):
  - Routes based on client IP (sticky sessions)
  - Same client always goes to same server
  - Use when: Session affinity required (not recommended)

Weighted Load Balancing:
  - Servers assigned weights based on capacity
  - More powerful servers get more traffic
  - Use when: Heterogeneous server specs
```

**Health Check Endpoints:**
```typescript
// Comprehensive health check
app.get('/health', async (req, res) => {
  const health = {
    status: 'ok',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    checks: {}
  };

  // Database check
  try {
    await prisma.$queryRaw`SELECT 1`;
    health.checks.database = 'ok';
  } catch (error) {
    health.checks.database = 'error';
    health.status = 'degraded';
  }

  // Redis check
  try {
    await redis.ping();
    health.checks.redis = 'ok';
  } catch (error) {
    health.checks.redis = 'error';
    health.status = 'degraded';
  }

  // Memory check
  const memUsage = process.memoryUsage();
  health.checks.memory = {
    heapUsed: Math.round(memUsage.heapUsed / 1024 / 1024) + 'MB',
    heapTotal: Math.round(memUsage.heapTotal / 1024 / 1024) + 'MB',
    status: memUsage.heapUsed / memUsage.heapTotal < 0.9 ? 'ok' : 'warning'
  };

  res.status(health.status === 'ok' ? 200 : 503).json(health);
});

// Readiness check (K8s-style)
app.get('/ready', async (req, res) => {
  // Check if app is ready to serve traffic
  const ready = await checkDatabaseConnection() && await checkRedisConnection();
  res.status(ready ? 200 : 503).json({ ready });
});
```

**Circuit Breaker Pattern:**
```typescript
import CircuitBreaker from 'opossum';

// Wrap external API calls in circuit breaker
const options = {
  timeout: 3000, // 3 seconds
  errorThresholdPercentage: 50, // Open circuit if 50% of requests fail
  resetTimeout: 30000 // Try again after 30 seconds
};

const breaker = new CircuitBreaker(externalAPICall, options);

breaker.on('open', () => console.log('Circuit breaker opened'));
breaker.on('halfOpen', () => console.log('Circuit breaker half-open'));
breaker.on('close', () => console.log('Circuit breaker closed'));

// Use circuit breaker
app.get('/api/external-data', async (req, res) => {
  try {
    const data = await breaker.fire(req.params);
    res.json(data);
  } catch (error) {
    // Fallback when circuit is open
    res.status(503).json({ error: 'Service temporarily unavailable' });
  }
});
```

**Graceful Shutdown:**
```typescript
// Handle shutdown signals
let server;

async function gracefulShutdown(signal) {
  console.log(`Received ${signal}, shutting down gracefully...`);

  // Stop accepting new connections
  server.close(() => {
    console.log('HTTP server closed');
  });

  // Close database connections
  await prisma.$disconnect();

  // Close Redis connections
  await redis.quit();

  // Exit after timeout
  setTimeout(() => {
    console.error('Forcing shutdown after timeout');
    process.exit(1);
  }, 10000); // 10 second timeout
}

process.on('SIGTERM', () => gracefulShutdown('SIGTERM'));
process.on('SIGINT', () => gracefulShutdown('SIGINT'));

server = app.listen(PORT);
```

### Database Optimization

**Query Optimization Techniques:**
```yaml
1. Use EXPLAIN ANALYZE for slow queries:
   - Identify sequential scans (should be index scans)
   - Check rows returned vs rows scanned
   - Look for expensive operations (sorts, joins)

2. Avoid N+1 Queries:
   Bad:
     const users = await prisma.user.findMany();
     for (const user of users) {
       const posts = await prisma.post.findMany({ where: { userId: user.id } });
     }

   Good:
     const users = await prisma.user.findMany({
       include: { posts: true }  // Single query with JOIN
     });

3. Limit Result Sets:
   - Always use LIMIT/OFFSET for pagination
   - Default page size: 20-50 items
   - Maximum page size: 100 items

4. Select Only Required Columns:
   - Use Prisma select to fetch specific fields
   - Avoid SELECT * in production queries

5. Use Database Indexes Strategically:
   - Index foreign keys
   - Index frequently queried columns
   - Composite indexes for multi-column queries
   - Avoid over-indexing (slows writes)
```

**Connection Pooling:**
```typescript
// Prisma connection pool configuration
// prisma/schema.prisma
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

generator client {
  provider = "prisma-client-js"
  previewFeatures = ["metrics"]
}

// Connection pool settings in DATABASE_URL
// postgresql://user:password@localhost:5432/dbname?connection_limit=50&pool_timeout=2
```

**Connection Pool Sizing:**
```yaml
Development:
  min: 2 connections
  max: 10 connections

Production:
  Formula: (CPU cores * 2) + effective_spindle_count
  Example (4 CPU cores): (4 * 2) + 1 = 9 connections per instance

  Recommended:
    min: 2-5 connections
    max: 20-50 connections per application instance
    idle_timeout: 30 seconds
    connection_timeout: 2 seconds

Multi-Instance:
  Total connections = max_per_instance * number_of_instances
  PostgreSQL max_connections: Set to total + 20% buffer
  Example: 3 instances * 50 connections = 150 → set max_connections=180
```

**Read Replicas:**
```typescript
// Separate connection for read-only queries
const readReplica = new PrismaClient({
  datasources: {
    db: {
      url: process.env.DATABASE_READ_REPLICA_URL
    }
  }
});

// Route read queries to replica
async function getUsers() {
  return readReplica.user.findMany(); // Read from replica
}

// Route writes to primary
async function createUser(data) {
  return prisma.user.create({ data }); // Write to primary
}
```

**Database Partitioning:**
```sql
-- Partition by tenant_id (multi-tenancy)
CREATE TABLE users (
  id UUID PRIMARY KEY,
  tenant_id UUID NOT NULL,
  email VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
) PARTITION BY LIST (tenant_id);

-- Create partitions for each tenant
CREATE TABLE users_tenant_001 PARTITION OF users FOR VALUES IN ('tenant-uuid-001');
CREATE TABLE users_tenant_002 PARTITION OF users FOR VALUES IN ('tenant-uuid-002');

-- Partition by date range (time-series data)
CREATE TABLE logs (
  id BIGSERIAL,
  message TEXT,
  created_at TIMESTAMP NOT NULL
) PARTITION BY RANGE (created_at);

CREATE TABLE logs_2026_01 PARTITION OF logs
  FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');

CREATE TABLE logs_2026_02 PARTITION OF logs
  FOR VALUES FROM ('2026-02-01') TO ('2026-03-01');
```

**Vacuum and Analyze Automation:**
```sql
-- Enable autovacuum (default in PostgreSQL)
-- /etc/postgresql/18/main/postgresql.conf
autovacuum = on
autovacuum_max_workers = 3
autovacuum_naptime = 1min

-- Manual vacuum for heavily updated tables
VACUUM ANALYZE users;
VACUUM ANALYZE sessions;

-- Scheduled full vacuum (weekly, low-traffic period)
VACUUM FULL ANALYZE;
```

**Index Maintenance:**
```sql
-- Find missing indexes
SELECT
  schemaname,
  tablename,
  attname,
  n_distinct,
  correlation
FROM pg_stats
WHERE schemaname = 'public'
  AND n_distinct > 100
  AND correlation < 0.1;

-- Find unused indexes (candidates for removal)
SELECT
  schemaname,
  tablename,
  indexname,
  idx_scan,
  pg_size_pretty(pg_relation_size(indexrelid)) AS index_size
FROM pg_stat_user_indexes
WHERE idx_scan = 0
  AND indexrelname NOT LIKE 'pg_%'
ORDER BY pg_relation_size(indexrelid) DESC;

-- Rebuild bloated indexes
REINDEX INDEX CONCURRENTLY index_name;
```

### Caching Mechanisms

**Multi-Level Caching Strategy:**
```yaml
Level 1: Application Cache (In-Memory)
  - Storage: Node.js Map, LRU cache
  - TTL: 1-5 minutes
  - Size: 100-1000 entries
  - Use: Frequently accessed data, configuration

Level 2: Redis Cache (Shared)
  - Storage: Redis
  - TTL: 5-60 minutes
  - Size: Gigabytes
  - Use: Session data, user data, API responses

Level 3: CDN Cache (Edge)
  - Storage: Cloudflare, AWS CloudFront
  - TTL: 1-24 hours
  - Size: Unlimited
  - Use: Static assets, public API responses
```

**Application-Level Caching (LRU):**
```typescript
import LRU from 'lru-cache';

const cache = new LRU({
  max: 500, // Maximum items
  maxSize: 50 * 1024 * 1024, // 50MB
  ttl: 1000 * 60 * 5, // 5 minutes
  sizeCalculation: (value) => JSON.stringify(value).length
});

// Cache middleware
function cacheMiddleware(ttl = 300) {
  return (req, res, next) => {
    const key = `${req.method}:${req.originalUrl}`;
    const cached = cache.get(key);

    if (cached) {
      return res.json(cached);
    }

    const originalJson = res.json.bind(res);
    res.json = (body) => {
      cache.set(key, body, { ttl: ttl * 1000 });
      return originalJson(body);
    };

    next();
  };
}

// Usage
app.get('/api/users', cacheMiddleware(60), async (req, res) => {
  const users = await prisma.user.findMany();
  res.json(users);
});
```

**Redis Caching:**
```typescript
// Cache-aside pattern (lazy loading)
async function getUser(userId: string) {
  const cacheKey = `user:${userId}`;

  // 1. Try to get from cache
  const cached = await redis.get(cacheKey);
  if (cached) {
    return JSON.parse(cached);
  }

  // 2. Cache miss - fetch from database
  const user = await prisma.user.findUnique({ where: { id: userId } });

  // 3. Store in cache
  if (user) {
    await redis.setex(cacheKey, 300, JSON.stringify(user)); // 5 minutes TTL
  }

  return user;
}

// Write-through pattern (update cache on write)
async function updateUser(userId: string, data: any) {
  const cacheKey = `user:${userId}`;

  // 1. Update database
  const user = await prisma.user.update({
    where: { id: userId },
    data
  });

  // 2. Update cache
  await redis.setex(cacheKey, 300, JSON.stringify(user));

  return user;
}
```

**Cache Invalidation Patterns:**
```typescript
// 1. Time-based expiration (TTL)
await redis.setex('key', 300, 'value'); // Expires in 5 minutes

// 2. Event-based invalidation
async function deleteUser(userId: string) {
  // Delete from database
  await prisma.user.delete({ where: { id: userId } });

  // Invalidate cache
  await redis.del(`user:${userId}`);

  // Invalidate related caches
  await redis.del(`user:${userId}:posts`);
  await redis.del(`users:list`); // Invalidate list cache
}

// 3. Tag-based invalidation (cache groups)
async function invalidateTag(tag: string) {
  const keys = await redis.keys(`*:tag:${tag}`);
  if (keys.length > 0) {
    await redis.del(...keys);
  }
}

// Usage: Cache with tags
await redis.setex(`user:${userId}:tag:users`, 300, JSON.stringify(user));
await invalidateTag('users'); // Invalidates all user caches
```

**Redis Configuration for Scale:**
```yaml
# redis.conf
maxmemory 2gb
maxmemory-policy allkeys-lru  # Evict least recently used keys

# Persistence (optional for cache)
save ""  # Disable RDB snapshots for pure cache
appendonly yes  # Enable AOF for durability

# Replication (high availability)
replicaof master-redis 6379
replica-read-only yes

# Cluster mode (sharding)
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
```

**CDN Caching (Cloudflare Example):**
```typescript
// Set cache headers for CDN
app.get('/api/public/posts', (req, res) => {
  // Cache for 1 hour on CDN, revalidate
  res.set('Cache-Control', 'public, max-age=3600, s-maxage=3600, stale-while-revalidate=86400');

  const posts = await prisma.post.findMany({ where: { published: true } });
  res.json(posts);
});

// Bypass cache for authenticated requests
app.get('/api/private/posts', (req, res) => {
  res.set('Cache-Control', 'private, no-cache, no-store, must-revalidate');

  const posts = await prisma.post.findMany({ where: { userId: req.user.id } });
  res.json(posts);
});
```

### Performance Monitoring

**Application Performance Monitoring (APM):**
```typescript
// Prometheus metrics
import promClient from 'prom-client';

const register = new promClient.Registry();

// Default system metrics
promClient.collectDefaultMetrics({ register });

// Custom metrics
const httpRequestDuration = new promClient.Histogram({
  name: 'http_request_duration_seconds',
  help: 'Duration of HTTP requests in seconds',
  labelNames: ['method', 'route', 'status_code'],
  buckets: [0.1, 0.5, 1, 2, 5]
});

const httpRequestTotal = new promClient.Counter({
  name: 'http_requests_total',
  help: 'Total number of HTTP requests',
  labelNames: ['method', 'route', 'status_code']
});

register.registerMetric(httpRequestDuration);
register.registerMetric(httpRequestTotal);

// Metrics middleware
app.use((req, res, next) => {
  const start = Date.now();

  res.on('finish', () => {
    const duration = (Date.now() - start) / 1000;
    const route = req.route?.path || req.path;

    httpRequestDuration.labels(req.method, route, res.statusCode.toString()).observe(duration);
    httpRequestTotal.labels(req.method, route, res.statusCode.toString()).inc();
  });

  next();
});

// Metrics endpoint
app.get('/metrics', async (req, res) => {
  res.set('Content-Type', register.contentType);
  res.send(await register.metrics());
});
```

**Key Performance Indicators (KPIs):**
```yaml
Response Time:
  P50 (Median): <200ms (target)
  P95: <500ms (target)
  P99: <1000ms (target)
  P99.9: <2000ms (acceptable)

Throughput:
  Target: 1000+ requests/second per instance
  Baseline: Measure under normal load
  Peak: Measure under 2x normal load

Error Rate:
  Target: <0.1% (1 error per 1000 requests)
  Critical Threshold: >1% (alert immediately)

Availability:
  Target: 99.9% uptime (8.76 hours downtime/year)
  SLA: 99.5% minimum
```

**Database Performance Metrics:**
```sql
-- Query execution time
SELECT
  query,
  calls,
  total_time / 1000 AS total_seconds,
  mean_time / 1000 AS mean_seconds,
  max_time / 1000 AS max_seconds
FROM pg_stat_statements
ORDER BY mean_time DESC
LIMIT 10;

-- Connection pool utilization
SELECT
  state,
  COUNT(*) as connections
FROM pg_stat_activity
GROUP BY state;

-- Index hit rate (should be >99%)
SELECT
  sum(idx_blks_hit) / nullif(sum(idx_blks_hit + idx_blks_read), 0) * 100 AS index_hit_rate
FROM pg_statio_user_indexes;

-- Cache hit rate (should be >99%)
SELECT
  sum(heap_blks_hit) / nullif(sum(heap_blks_hit + heap_blks_read), 0) * 100 AS cache_hit_rate
FROM pg_statio_user_tables;
```

**Resource Utilization:**
```yaml
CPU Usage:
  Normal: 30-50%
  Peak: 60-70%
  Critical: >80% (scale up)

Memory Usage:
  Normal: 50-70%
  Peak: 70-80%
  Critical: >90% (scale up, investigate leaks)

Disk I/O:
  Monitor: IOPS, read/write throughput
  SSD: 10,000+ IOPS
  HDD: 100-200 IOPS

Network Bandwidth:
  Monitor: Ingress/egress traffic
  Alert: >80% of capacity
```

### Performance Benchmarking

**Load Testing with k6:**
```javascript
// load-test.js
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '2m', target: 100 },  // Ramp up to 100 users
    { duration: '5m', target: 100 },  // Stay at 100 users
    { duration: '2m', target: 200 },  // Ramp up to 200 users
    { duration: '5m', target: 200 },  // Stay at 200 users
    { duration: '2m', target: 0 },    // Ramp down to 0 users
  ],
  thresholds: {
    http_req_duration: ['p(95)<500', 'p(99)<1000'], // 95% < 500ms, 99% < 1s
    http_req_failed: ['rate<0.01'], // Error rate < 1%
  },
};

export default function () {
  // Test login
  const loginRes = http.post('https://app.company.com/api/auth/login', {
    email: 'test@example.com',
    password: 'password123'
  });

  check(loginRes, {
    'login successful': (r) => r.status === 200,
    'token received': (r) => r.json('token') !== undefined
  });

  const token = loginRes.json('token');

  // Test API endpoint
  const params = {
    headers: { 'Authorization': `Bearer ${token}` }
  };

  const res = http.get('https://app.company.com/api/users', params);

  check(res, {
    'status is 200': (r) => r.status === 200,
    'response time < 500ms': (r) => r.timings.duration < 500
  });

  sleep(1);
}

// Run: k6 run load-test.js
```

**Database Benchmarking (pgbench):**
```bash
# Initialize test database
pgbench -i -s 50 testdb  # 50x scale factor (50 million rows)

# Run benchmark
pgbench -c 10 -j 2 -t 1000 testdb
# -c 10: 10 concurrent clients
# -j 2: 2 worker threads
# -t 1000: 1000 transactions per client

# Custom SQL benchmark
pgbench -c 10 -t 100 -f custom-queries.sql testdb
```

**Cache Performance Testing:**
```typescript
// Benchmark cache hit rate
async function benchmarkCache(iterations = 10000) {
  let hits = 0;
  let misses = 0;

  const keys = Array.from({ length: 100 }, (_, i) => `key-${i}`);

  for (let i = 0; i < iterations; i++) {
    const key = keys[Math.floor(Math.random() * keys.length)];
    const cached = await redis.get(key);

    if (cached) {
      hits++;
    } else {
      misses++;
      await redis.setex(key, 60, 'value');
    }
  }

  const hitRate = (hits / (hits + misses)) * 100;
  console.log(`Cache hit rate: ${hitRate.toFixed(2)}%`);
  console.log(`Hits: ${hits}, Misses: ${misses}`);
}
```

---

## 📊 SYSTEM MONITORING & OBSERVABILITY

### Required Dashboards

#### 1. System Health Dashboard
```yaml
Metrics:
  - CPU Load Average (1m, 5m, 15m)
  - Memory Usage (Used/Total, %)
  - Disk Usage (Used/Total, %)
  - Network I/O
  - Database Connections (Active/Total)
  - Cache Hit Rate
  - System Uptime

Alerts:
  - CPU > 80% for 5 minutes
  - Memory > 90%
  - Disk > 85%
  - Database connections > 80% of max
```

#### 2. API Performance Dashboard
```yaml
Metrics:
  - Total Requests (time window)
  - Average Response Time
  - Error Rate (%)
  - Response Time Percentiles (P50, P95, P99)
  - Requests per Endpoint
  - Slowest Endpoints
  - Most Common Errors

Time Windows:
  - Last Hour
  - Last 6 Hours
  - Last 24 Hours
  - Last 3 Days
  - Last Week

Tables:
  - Top API Endpoints (method, requests, avg time, error rate)
  - Top Errors (error, count, status code, last occurrence)
  - Slowest Endpoints (endpoint, avg time, max time)
```

#### 3. Security Dashboard
```yaml
Overview Cards:
  - Active Sessions Count
  - Locked Accounts Count
  - Suspicious IPs (3+ failed attempts)
  - Failed Logins Today

Security Metrics:
  - Login Activity by Country (with failed attempts)
  - Most Suspicious IPs (with risk level: Low/Medium/High/Critical)
  - Top Failed Login Reasons
  - Account Lockout Events

Session Management:
  - Active Sessions List (user, IP, device, browser, created, last activity)
  - Force Logout Capability
  - Session Termination Audit Trail

Account Security:
  - Locked Accounts Table (user, email, failed attempts, locked until)
  - Unlock Account Functionality
  - IP Whitelist Management

Risk Scoring:
  - Low: 3-5 failed attempts
  - Medium: 6-10 failed attempts
  - High: 11-20 failed attempts
  - Critical: 20+ failed attempts
```

#### 4. Business Intelligence Dashboard
```yaml
Time Ranges:
  - Last 7 days
  - Last 30 days
  - Last 90 days
  - Last year

Performance Analytics:
  - Priority Distribution (Critical/High/Medium/Low)
  - Department Performance (tickets, avg resolution time)
  - Category Analysis (resolution rate, avg time, satisfaction)

Agent Performance:
  - Assigned vs Resolved Tickets
  - Average Resolution Time
  - Customer Satisfaction Rating
  - Performance Score (resolution rate %)

User Engagement:
  - Feature Usage Statistics
  - Most Active Users (logins, active days)
  - Login Trends
  - User Activity Heatmap

Category Insights:
  - Top Performing Categories
  - Fastest Resolution Categories
  - Categories Needing Improvement
  - Performance Levels: Outstanding (≥90%), Excellent (≥80%), Good (≥60%), Average (≥40%), Needs Improvement (<40%)
```

#### 5. Database Health Dashboard
```yaml
Metrics:
  - Total Database Size
  - Largest Tables (name, size)
  - Most Used Indexes (name, read count)
  - Active Queries
  - Long-Running Queries
  - Connection Pool Status
  - Query Performance Statistics

Maintenance:
  - Backup Status
  - Last Backup Timestamp
  - Backup Size
  - Restore Points Available
```

### OpenTelemetry Integration (Distributed Tracing & Observability)

OpenTelemetry is the industry-standard open-source observability framework for 2026, providing vendor-neutral instrumentation for metrics, logs, and distributed traces across microservices.

**Why OpenTelemetry:**
- De facto standard adopted by major cloud providers and APM vendors
- Vendor-neutral: Switch between Jaeger, Datadog, New Relic, Grafana without code changes
- Auto-instrumentation for popular frameworks (Express, Prisma, Redis, PostgreSQL)
- Unified telemetry pipeline for metrics, logs, and traces
- Faster MTTR (Mean Time To Resolution) by 40-60% with distributed tracing

#### Installation

```bash
# Install OpenTelemetry SDK and auto-instrumentation
npm install --save @opentelemetry/sdk-node \
  @opentelemetry/auto-instrumentations-node \
  @opentelemetry/exporter-trace-otlp-http \
  @opentelemetry/exporter-metrics-otlp-http \
  @opentelemetry/resources \
  @opentelemetry/semantic-conventions
```

#### Configuration

**1. Create OpenTelemetry Instrumentation File**

```typescript
// src/instrumentation.ts
import { NodeSDK } from '@opentelemetry/sdk-node';
import { getNodeAutoInstrumentations } from '@opentelemetry/auto-instrumentations-node';
import { OTLPTraceExporter } from '@opentelemetry/exporter-trace-otlp-http';
import { OTLPMetricExporter } from '@opentelemetry/exporter-metrics-otlp-http';
import { PeriodicExportingMetricReader } from '@opentelemetry/sdk-metrics';
import { Resource } from '@opentelemetry/resources';
import {
  SEMRESATTRS_SERVICE_NAME,
  SEMRESATTRS_SERVICE_VERSION,
  SEMRESATTRS_DEPLOYMENT_ENVIRONMENT,
} from '@opentelemetry/semantic-conventions';

// Configure resource attributes
const resource = new Resource({
  [SEMRESATTRS_SERVICE_NAME]: process.env.OTEL_SERVICE_NAME || 'your-app',
  [SEMRESATTRS_SERVICE_VERSION]: process.env.APP_VERSION || '1.0.0',
  [SEMRESATTRS_DEPLOYMENT_ENVIRONMENT]: process.env.NODE_ENV || 'development',
});

// Configure trace exporter
const traceExporter = new OTLPTraceExporter({
  url: process.env.OTEL_EXPORTER_OTLP_ENDPOINT || 'http://localhost:4318/v1/traces',
  headers: {
    'Authorization': `Bearer ${process.env.OTEL_EXPORTER_TOKEN || ''}`,
  },
});

// Configure metrics exporter
const metricExporter = new OTLPMetricExporter({
  url: process.env.OTEL_EXPORTER_OTLP_METRICS_ENDPOINT || 'http://localhost:4318/v1/metrics',
});

const metricReader = new PeriodicExportingMetricReader({
  exporter: metricExporter,
  exportIntervalMillis: 60000, // Export every 60 seconds
});

// Initialize OpenTelemetry SDK
const sdk = new NodeSDK({
  resource,
  traceExporter,
  metricReader,
  instrumentations: [
    getNodeAutoInstrumentations({
      // Automatic instrumentation for common libraries
      '@opentelemetry/instrumentation-http': {
        enabled: true,
      },
      '@opentelemetry/instrumentation-express': {
        enabled: true,
      },
      '@opentelemetry/instrumentation-pg': {
        enabled: true,
        enhancedDatabaseReporting: true,
      },
      '@opentelemetry/instrumentation-redis-4': {
        enabled: true,
      },
      '@opentelemetry/instrumentation-fs': {
        enabled: false, // Disable for performance
      },
    }),
  ],
});

// Start the SDK
sdk.start();

// Graceful shutdown
process.on('SIGTERM', () => {
  sdk
    .shutdown()
    .then(() => console.log('OpenTelemetry terminated'))
    .catch((error) => console.error('Error terminating OpenTelemetry', error))
    .finally(() => process.exit(0));
});

export default sdk;
```

**2. Bootstrap OpenTelemetry in Application**

```typescript
// src/server.ts or src/index.ts
// IMPORTANT: Import instrumentation BEFORE any other imports
import './instrumentation';

import express from 'express';
import { trace, context, SpanStatusCode } from '@opentelemetry/api';

const app = express();

// Your application code...
app.get('/api/users/:id', async (req, res) => {
  // Get current span for custom attributes
  const span = trace.getActiveSpan();

  try {
    const userId = req.params.id;

    // Add custom attributes to span
    span?.setAttribute('user.id', userId);
    span?.setAttribute('http.route', '/api/users/:id');

    // Your business logic (auto-instrumented)
    const user = await prisma.user.findUnique({
      where: { id: userId },
    });

    if (!user) {
      span?.setStatus({ code: SpanStatusCode.ERROR, message: 'User not found' });
      return res.status(404).json({ error: 'User not found' });
    }

    span?.setAttribute('user.email', user.email);
    span?.setStatus({ code: SpanStatusCode.OK });

    res.json(user);
  } catch (error) {
    // Record exception in trace
    span?.recordException(error as Error);
    span?.setStatus({ code: SpanStatusCode.ERROR, message: (error as Error).message });

    res.status(500).json({ error: 'Internal server error' });
  }
});
```

**3. Custom Spans for Business Logic**

```typescript
import { trace } from '@opentelemetry/api';

const tracer = trace.getTracer('business-logic', '1.0.0');

export async function processOrder(orderId: string) {
  // Create custom span
  return await tracer.startActiveSpan('processOrder', async (span) => {
    try {
      span.setAttribute('order.id', orderId);

      // Step 1: Validate order
      await tracer.startActiveSpan('validateOrder', async (validateSpan) => {
        // Validation logic
        validateSpan.end();
      });

      // Step 2: Process payment
      await tracer.startActiveSpan('processPayment', async (paymentSpan) => {
        paymentSpan.setAttribute('payment.method', 'stripe');
        // Payment logic
        paymentSpan.end();
      });

      // Step 3: Update inventory
      await tracer.startActiveSpan('updateInventory', async (inventorySpan) => {
        // Inventory logic
        inventorySpan.end();
      });

      span.setStatus({ code: SpanStatusCode.OK });
      return { success: true };

    } catch (error) {
      span.recordException(error as Error);
      span.setStatus({ code: SpanStatusCode.ERROR });
      throw error;
    } finally {
      span.end();
    }
  });
}
```

#### Environment Variables

```env
# OpenTelemetry Configuration
OTEL_SERVICE_NAME=your-app-name
OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4318/v1/traces
OTEL_EXPORTER_OTLP_METRICS_ENDPOINT=http://localhost:4318/v1/metrics
OTEL_EXPORTER_TOKEN=your-observability-platform-token

# Sampling Configuration
OTEL_TRACES_SAMPLER=parentbased_traceidratio
OTEL_TRACES_SAMPLER_ARG=0.1  # Sample 10% of traces (adjust based on traffic)

# Log Level
OTEL_LOG_LEVEL=info  # debug, info, warn, error

# Application Metadata
APP_VERSION=1.0.0
NODE_ENV=production
```

#### Observability Stack Setup (Docker Compose)

```yaml
# docker-compose.observability.yml
version: '3.8'

services:
  # Jaeger - Distributed Tracing UI
  jaeger:
    image: jaegertracing/all-in-one:1.51
    environment:
      - COLLECTOR_OTLP_ENABLED=true
    ports:
      - "16686:16686"  # Jaeger UI
      - "4317:4317"    # OTLP gRPC receiver
      - "4318:4318"    # OTLP HTTP receiver

  # Prometheus - Metrics Storage
  prometheus:
    image: prom/prometheus:v2.48.0
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--storage.tsdb.path=/prometheus'
    volumes:
      - ./prometheus/prometheus.yml:/etc/prometheus/prometheus.yml
      - prometheus-data:/prometheus
    ports:
      - "9090:9090"

  # Grafana - Visualization Dashboard
  grafana:
    image: grafana/grafana:10.2.0
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin
      - GF_USERS_ALLOW_SIGN_UP=false
    volumes:
      - ./grafana/datasources.yml:/etc/grafana/provisioning/datasources/datasources.yml
      - ./grafana/dashboards:/etc/grafana/provisioning/dashboards
      - grafana-data:/var/lib/grafana
    ports:
      - "3001:3000"
    depends_on:
      - prometheus
      - jaeger

volumes:
  prometheus-data:
  grafana-data:
```

**Prometheus Configuration:**
```yaml
# prometheus/prometheus.yml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'app'
    static_configs:
      - targets: ['app:3000']  # Your application metrics endpoint
```

**Grafana Datasources:**
```yaml
# grafana/datasources.yml
apiVersion: 1

datasources:
  - name: Prometheus
    type: prometheus
    access: proxy
    url: http://prometheus:9090
    isDefault: true

  - name: Jaeger
    type: jaeger
    access: proxy
    url: http://jaeger:16686
```

#### Key Metrics to Monitor

**Automatically Collected:**
```yaml
HTTP Metrics:
  - http.server.duration (response time)
  - http.server.request.size
  - http.server.response.size
  - http.server.active_requests

Database Metrics:
  - db.client.connections.usage (active connections)
  - db.client.connections.max
  - db.client.operation.duration (query time)

Redis Metrics:
  - redis.client.operation.duration
  - redis.client.connections.usage

Process Metrics:
  - process.cpu.utilization
  - process.memory.usage
  - process.runtime.nodejs.heap.size
```

**Custom Business Metrics:**
```typescript
import { metrics } from '@opentelemetry/api';

const meter = metrics.getMeter('business-metrics', '1.0.0');

// Counter: Total orders created
const orderCounter = meter.createCounter('orders.created', {
  description: 'Total number of orders created',
});

orderCounter.add(1, {
  'order.status': 'pending',
  'payment.method': 'stripe',
});

// Histogram: Order processing time
const orderProcessingTime = meter.createHistogram('order.processing.duration', {
  description: 'Time to process an order in seconds',
  unit: 's',
});

orderProcessingTime.record(1.234, {
  'order.type': 'standard',
});

// UpDownCounter: Active users
const activeUsers = meter.createUpDownCounter('users.active', {
  description: 'Number of currently active users',
});

activeUsers.add(1);  // User logged in
activeUsers.add(-1); // User logged out
```

#### Alerting Rules (Prometheus)

```yaml
# prometheus/alerts.yml
groups:
  - name: application_alerts
    interval: 30s
    rules:
      - alert: HighErrorRate
        expr: |
          sum(rate(http_server_duration_count{http_status_code=~"5.."}[5m]))
          /
          sum(rate(http_server_duration_count[5m])) > 0.05
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: "High error rate detected"
          description: "Error rate is {{ $value | humanizePercentage }}"

      - alert: HighResponseTime
        expr: |
          histogram_quantile(0.95,
            sum(rate(http_server_duration_bucket[5m])) by (le)
          ) > 1.0
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: "High response time detected"
          description: "P95 response time is {{ $value }}s"

      - alert: DatabaseConnectionPoolExhausted
        expr: db_client_connections_usage > 45
        for: 2m
        labels:
          severity: critical
        annotations:
          summary: "Database connection pool near limit"
          description: "Active connections: {{ $value }} (limit: 50)"
```

#### Grafana Dashboard Queries

**Response Time P95:**
```promql
histogram_quantile(0.95,
  sum(rate(http_server_duration_bucket[5m])) by (le, http_route)
)
```

**Request Rate by Endpoint:**
```promql
sum(rate(http_server_duration_count[5m])) by (http_route, http_method)
```

**Error Rate Percentage:**
```promql
sum(rate(http_server_duration_count{http_status_code=~"5.."}[5m]))
/
sum(rate(http_server_duration_count[5m])) * 100
```

**Database Query Duration:**
```promql
histogram_quantile(0.95,
  sum(rate(db_client_operation_duration_bucket[5m])) by (le, db_operation)
)
```

#### Best Practices

**1. Sampling Strategy:**
- Development: 100% sampling (OTEL_TRACES_SAMPLER_ARG=1.0)
- Staging: 50% sampling (OTEL_TRACES_SAMPLER_ARG=0.5)
- Production: 10% sampling for high traffic (OTEL_TRACES_SAMPLER_ARG=0.1)
- Always sample error traces (parentbased_traceidratio ensures error traces are kept)

**2. Span Attributes:**
- Add business context: user.id, order.id, tenant.id
- Include request metadata: http.route, http.method
- Tag critical operations: payment.method, cache.hit
- Keep attribute count reasonable (<20 per span)

**3. Performance Impact:**
- OpenTelemetry overhead: <5% CPU, <50MB memory
- Use async exporters to avoid blocking requests
- Batch exports for efficiency
- Monitor exporter queue length

**4. Security:**
- Never log sensitive data (passwords, tokens, credit cards)
- Sanitize user input in span attributes
- Use TLS for exporter endpoints
- Rotate OTEL_EXPORTER_TOKEN regularly

**5. Multi-Service Tracing:**
- Propagate trace context in HTTP headers (automatic)
- Use same OTEL_SERVICE_NAME across instances
- Different service names for microservices
- Maintain consistent trace IDs across service boundaries

#### Integration with Existing Monitoring

**Combine with System Monitoring:**
```typescript
// Add OpenTelemetry metrics to existing health endpoint
app.get('/health', async (req, res) => {
  const span = trace.getActiveSpan();

  const health = {
    status: 'healthy',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),

    // Add OpenTelemetry context
    trace: {
      traceId: span?.spanContext().traceId,
      spanId: span?.spanContext().spanId,
    },

    // Existing checks
    database: await checkDatabaseHealth(),
    redis: await checkRedisHealth(),
  };

  res.json(health);
});
```

#### Troubleshooting

**No traces appearing in Jaeger:**
1. Check OTEL_EXPORTER_OTLP_ENDPOINT is correct
2. Verify Jaeger is running: `curl http://localhost:4318`
3. Check application logs for OpenTelemetry errors
4. Ensure sampling rate is not 0
5. Test with a simple curl: `curl http://localhost:3000/api/health`

**High memory usage:**
1. Reduce sampling rate (OTEL_TRACES_SAMPLER_ARG)
2. Decrease export interval (exportIntervalMillis)
3. Disable unused instrumentations
4. Check for span leaks (spans not properly ended)

**Missing database/Redis traces:**
1. Ensure instrumentation packages are installed
2. Import instrumentation.ts BEFORE other imports
3. Check library versions are compatible
4. Enable debug logging: OTEL_LOG_LEVEL=debug

#### Cloud Provider Integrations

**AWS X-Ray:**
```typescript
import { AWSXRayPropagator } from '@opentelemetry/propagator-aws-xray';
import { AwsXRayIdGenerator } from '@opentelemetry/id-generator-aws-xray';

const sdk = new NodeSDK({
  textMapPropagator: new AWSXRayPropagator(),
  idGenerator: new AwsXRayIdGenerator(),
  // ... rest of config
});
```

**Google Cloud Trace:**
```typescript
import { TraceExporter } from '@google-cloud/opentelemetry-cloud-trace-exporter';

const traceExporter = new TraceExporter();
```

**Azure Monitor:**
```typescript
import { AzureMonitorTraceExporter } from '@azure/monitor-opentelemetry-exporter';

const traceExporter = new AzureMonitorTraceExporter({
  connectionString: process.env.APPLICATIONINSIGHTS_CONNECTION_STRING,
});
```

#### Resources

**Official Documentation:**
- OpenTelemetry Docs: https://opentelemetry.io/docs/
- Node.js SDK: https://opentelemetry.io/docs/instrumentation/js/
- Semantic Conventions: https://opentelemetry.io/docs/specs/semconv/

**Observability Tools:**
- Jaeger: https://www.jaegertracing.io/
- Grafana: https://grafana.com/
- Prometheus: https://prometheus.io/
- Datadog: https://www.datadoghq.com/
- New Relic: https://newrelic.com/
- Honeycomb: https://www.honeycomb.io/

---

## 💾 BACKUP & DISASTER RECOVERY

### Backup Strategy
```yaml
Database Backups:
  Frequency:
    - Full Backup: Daily at 2 AM
    - Incremental: Every 6 hours
    - Transaction Log: Continuous

  Storage Locations:
    - Local: /var/backups/database
    - Remote: MinIO/S3 bucket
    - Offsite: Cloud provider (AWS S3, Google Cloud Storage)

  Retention Policy:
    - Daily backups: 7 days
    - Weekly backups: 4 weeks
    - Monthly backups: 12 months
    - Yearly backups: 5 years

File Storage Backups:
  - User uploads: Daily to MinIO
  - System files: Weekly
  - Configuration: On change + daily

Backup Manager Features:
  - Create Manual Backup
  - Schedule Automatic Backups
  - Verify Backup Integrity
  - Download Backup File
  - Restore from Backup (with confirmation)
  - List All Backups (with size, timestamp, type)

Disaster Recovery:
  - RPO (Recovery Point Objective): 1 hour
  - RTO (Recovery Time Objective): 4 hours
  - Regular DR drills: Quarterly
  - Documented recovery procedures
  - Tested restore processes
```

---

## 🔍 COMPLIANCE REQUIREMENTS

### GDPR (General Data Protection Regulation)
```yaml
Data Subject Rights:
  - Right to Access: User data export API
  - Right to Rectification: User profile edit
  - Right to Erasure: Account deletion/deactivation (with audit trail)
  - Right to Data Portability: JSON/CSV export
  - Right to Restrict Processing: Account deactivation
  - Right to Object: Opt-out mechanisms

Data Protection:
  - Encryption at rest (AES-256)
  - Encryption in transit (TLS 1.3)
  - Data minimization (collect only necessary data)
  - Purpose limitation (clear data usage policies)
  - Storage limitation (defined retention periods)

Privacy Features:
  - Privacy Policy (clear, accessible)
  - Cookie Consent Management
  - Data Processing Agreements
  - Privacy by Design
  - Data Protection Impact Assessments (DPIA)

Breach Response:
  - Incident detection and logging
  - 72-hour breach notification procedure
  - User notification process
  - Documentation and reporting
```

### ISO 27001 (Information Security Management)
```yaml
Security Controls (14 Domains):

A.5 - Information Security Policies:
  - Written security policies
  - Regular policy reviews
  - Management approval

A.6 - Organization of Information Security:
  - Defined security roles
  - Separation of duties
  - Contact with authorities

A.7 - Human Resource Security:
  - Security awareness training
  - Background checks (where applicable)
  - Confidentiality agreements

A.8 - Asset Management:
  - Asset inventory
  - Information classification
  - Media handling procedures

A.9 - Access Control:
  - Access control policy
  - User access management (RBAC)
  - User responsibilities
  - System and application access control

A.10 - Cryptography:
  - Cryptographic controls
  - Key management

A.11 - Physical and Environmental Security:
  - Secure areas (data center access)
  - Equipment security
  - Environmental controls

A.12 - Operations Security:
  - Operational procedures
  - Change management
  - Capacity management
  - Malware protection
  - Backup
  - Logging and monitoring

A.13 - Communications Security:
  - Network security management
  - Information transfer policies

A.14 - System Acquisition, Development, and Maintenance:
  - Security requirements analysis
  - Secure development lifecycle
  - Security in development and support processes

A.15 - Supplier Relationships:
  - Information security in supplier relationships
  - Supplier service delivery management

A.16 - Information Security Incident Management:
  - Incident management responsibilities
  - Incident response procedures
  - Learning from incidents

A.17 - Information Security Aspects of Business Continuity:
  - Planning information security continuity
  - Information security continuity procedures
  - Verify, review, and evaluate

A.18 - Compliance:
  - Legal and contractual requirements
  - Information security reviews

Audit Readiness:
  - Documentation of all controls
  - Evidence collection
  - Regular internal audits
  - Management reviews
```

### PCI-DSS (Payment Card Industry Data Security Standard)
```yaml
12 Requirements:

1. Install and maintain firewall configuration:
   - Network segmentation
   - Firewall rules documentation
   - Regular rule reviews

2. Do not use vendor-supplied defaults:
   - Change default passwords
   - Remove unnecessary default accounts
   - Disable unnecessary services

3. Protect stored cardholder data:
   - Minimize data storage
   - Encrypt stored data (AES-256)
   - Secure deletion of old data
   - Note: Recommend tokenization via payment gateway (Stripe, PayPal)

4. Encrypt transmission of cardholder data:
   - TLS 1.3 for public networks
   - Never send via email/messaging
   - Use payment gateway API only

5. Protect all systems against malware:
   - Antivirus software
   - Regular updates
   - Active malware protection

6. Develop and maintain secure systems:
   - Patch management
   - Security patch priority process
   - Change control procedures

7. Restrict access to cardholder data:
   - Need-to-know basis
   - RBAC implementation
   - Least privilege principle

8. Identify and authenticate access:
   - Unique IDs for all users
   - Strong authentication (MFA)
   - Session management

9. Restrict physical access:
   - Physical access controls
   - Visitor logs
   - Media destruction procedures

10. Track and monitor all access:
    - Audit trails for all access
    - Daily log reviews
    - Secure log storage (90 days minimum)

11. Regularly test security systems:
    - Vulnerability scans (quarterly)
    - Penetration testing (annually)
    - IDS/IPS monitoring

12. Maintain information security policy:
    - Published security policy
    - Annual risk assessment
    - Security awareness program

Implementation Note:
  - Use PCI-compliant payment gateway (Stripe, Square, PayPal)
  - Avoid storing card data directly
  - Use tokenization for recurring payments
  - Implement PCI SAQ (Self-Assessment Questionnaire)
```

### SOC 2 Type II (Service Organization Control)
```yaml
Trust Service Criteria:

Security (Required):
  - Access controls (RBAC, MFA)
  - Logical and physical access restrictions
  - System monitoring
  - Change management
  - Risk mitigation

Availability (Optional):
  - System uptime monitoring
  - Incident response procedures
  - Backup and recovery
  - Business continuity planning

Processing Integrity (Optional):
  - Data validation
  - Error handling
  - Quality assurance processes

Confidentiality (Optional):
  - Data encryption
  - Secure data transmission
  - Access restrictions
  - Data classification

Privacy (Optional):
  - Notice to data subjects
  - Choice and consent
  - Collection limitations
  - Use, retention, disposal
  - Access rights
  - Disclosure to third parties
  - Quality and monitoring

Audit Requirements:
  - 6-12 month audit period
  - Independent auditor
  - Control testing evidence
  - Continuous monitoring
```

### SOX (Sarbanes-Oxley Act)
```yaml
Applicable Sections:

Section 302 - Corporate Responsibility:
  - CEO/CFO certification of financial reports
  - Internal controls over financial reporting
  - Disclosure controls and procedures

Section 404 - Management Assessment:
  - Annual assessment of internal controls
  - Auditor attestation
  - Documentation of controls

Section 409 - Real-Time Disclosures:
  - Timely disclosure of material changes
  - Rapid reporting requirements

IT General Controls (ITGC):
  - Change management procedures
  - Access control management
  - Computer operations
  - Program development
  - Backup and recovery

Application Controls:
  - Input controls (validation)
  - Processing controls (calculations, logic)
  - Output controls (reports, reconciliation)

Audit Trail Requirements:
  - Financial transaction logging
  - User activity tracking
  - Change logs for financial systems
  - Retention: 7 years minimum

Segregation of Duties:
  - Separate authorization, recording, custody
  - Prevent single-person fraud
  - Regular access reviews
```

### NIST Cybersecurity Framework
```yaml
Five Core Functions:

1. Identify:
   - Asset Management
   - Business Environment
   - Governance
   - Risk Assessment
   - Risk Management Strategy
   - Supply Chain Risk Management

2. Protect:
   - Identity Management and Access Control
   - Awareness and Training
   - Data Security
   - Information Protection Processes
   - Protective Technology

3. Detect:
   - Anomalies and Events
   - Security Continuous Monitoring
   - Detection Processes

4. Respond:
   - Response Planning
   - Communications
   - Analysis
   - Mitigation
   - Improvements

5. Recover:
   - Recovery Planning
   - Improvements
   - Communications

Implementation Tiers:
  - Tier 1: Partial
  - Tier 2: Risk Informed
  - Tier 3: Repeatable
  - Tier 4: Adaptive

Target: Tier 3 (Repeatable)
```

---

## 📱 MOBILE-SPECIFIC REQUIREMENTS

### iOS Application
```yaml
Security:
  - Keychain for sensitive data
  - App Transport Security (ATS)
  - Certificate pinning
  - Jailbreak detection
  - Touch ID / Face ID integration

Data Storage:
  - CoreData for local database
  - UserDefaults for preferences
  - Keychain for tokens/secrets

Push Notifications:
  - APNs integration
  - Notification permissions
  - Deep linking

App Store:
  - Privacy Policy URL
  - Terms of Service
  - App Icon (all sizes)
  - Screenshots
  - Description

Required Info.plist Keys:
  - NSCameraUsageDescription
  - NSPhotoLibraryUsageDescription
  - NSLocationWhenInUseUsageDescription
  - NSFaceIDUsageDescription
```

### Android Application
```yaml
Security:
  - EncryptedSharedPreferences
  - SafetyNet Attestation
  - Root detection
  - Certificate pinning
  - Biometric authentication

Data Storage:
  - Room Database
  - SharedPreferences (encrypted)
  - Keystore for secrets

Push Notifications:
  - FCM integration
  - Notification channels
  - Deep linking

Google Play:
  - Privacy Policy URL
  - Terms of Service
  - App Icon (adaptive)
  - Screenshots
  - Feature Graphic
  - Description

Required Permissions:
  - INTERNET
  - ACCESS_NETWORK_STATE
  - CAMERA (if needed)
  - READ_EXTERNAL_STORAGE (if needed)
  - WRITE_EXTERNAL_STORAGE (if needed)
```

---

## 🚀 DEPLOYMENT ARCHITECTURE

### Cloudflare Integration
```yaml
DNS Management:
  - A records for main domain
  - CNAME records for subdomains
  - MX records for email
  - TXT records for verification (SPF, DKIM, DMARC)

Cloudflare Tunnels:
  - Zero Trust tunnel setup
  - Private network access
  - No public IP exposure
  - Automatic HTTPS

Access Policies:
  - Email-based authentication
  - IP restrictions
  - Geo-blocking rules
  - WAF custom rules

WAF Rules:
  - OWASP Core Ruleset
  - Rate limiting
  - Bot management
  - DDoS protection

Workers:
  - Edge functions
  - API routing
  - Response transformation
  - A/B testing

Page Rules:
  - Cache settings
  - Redirects
  - Security levels

SSL/TLS:
  - Full (strict) mode
  - Automatic HTTPS Rewrites
  - Minimum TLS 1.3
  - HSTS enabled
```

### Docker Deployment
```yaml
Services:
  web:
    image: nginx:1.29-alpine
    ports: ["80:80", "443:443"]
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
      - ./ssl:/etc/nginx/ssl
    depends_on: [app]

  app:
    build: ./backend
    environment:
      - NODE_ENV=production
      - DATABASE_URL=${DATABASE_URL}
      - REDIS_URL=${REDIS_URL}
    depends_on: [db, redis]

  db:
    image: postgres:18.1-alpine
    environment:
      - POSTGRES_DB=${DB_NAME}
      - POSTGRES_USER=${DB_USER}
      - POSTGRES_PASSWORD=${DB_PASSWORD}
    volumes:
      - postgres_data:/var/lib/postgresql/data

  redis:
    image: redis:8-alpine
    command: redis-server --requirepass ${REDIS_PASSWORD}
    volumes:
      - redis_data:/data

  minio:
    image: minio/minio:latest
    command: server /data --console-address ":9001"
    environment:
      - MINIO_ROOT_USER=${MINIO_ACCESS_KEY}
      - MINIO_ROOT_PASSWORD=${MINIO_SECRET_KEY}
    volumes:
      - minio_data:/data

volumes:
  postgres_data:
  redis_data:
  minio_data:
```

### Kubernetes Deployment

Production-ready Kubernetes manifests with Kustomize overlays for multi-environment deployments (development, staging, production).

#### Quick Start

```bash
# Deploy to development environment
kubectl apply -k kubernetes/overlays/development

# Deploy to production environment
kubectl apply -k kubernetes/overlays/production

# Verify deployment
kubectl get all -n myapp-prod
kubectl logs -f deployment/prod-app -n myapp-prod
```

#### Architecture Overview

```yaml
Directory Structure:
  kubernetes/
    base/                     # Base manifests (environment-agnostic)
      - namespace.yaml       # Namespace definition
      - configmap.yaml       # Non-sensitive configuration
      - secret.yaml          # Secret template
      - deployment.yaml      # Application deployment
      - service.yaml         # Service definitions
      - ingress.yaml         # Ingress routing
      - hpa.yaml             # Horizontal Pod Autoscaler
      - rbac.yaml            # RBAC configuration
      - pdb.yaml             # PodDisruptionBudget & quotas

    overlays/                # Environment-specific overlays
      development/           # Dev environment (1 replica, debug mode)
      staging/               # Staging environment (2 replicas)
      production/            # Production (3-10 replicas, anti-affinity)

Key Features:
  - Zero-downtime rolling updates
  - Auto-scaling (CPU/memory based)
  - Health checks (liveness, readiness, startup probes)
  - Resource limits and requests
  - Network policies for pod isolation
  - RBAC with minimal permissions
  - Pod security (non-root, read-only filesystem)
  - Automated SSL with cert-manager
  - Multi-environment with Kustomize overlays
```

#### Deployment Manifest

```yaml
# kubernetes/base/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app
  namespace: myapp
  labels:
    app.kubernetes.io/name: myapp
    app.kubernetes.io/version: "1.0.0"
spec:
  replicas: 3

  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0  # Zero-downtime

  selector:
    matchLabels:
      app.kubernetes.io/name: myapp

  template:
    metadata:
      labels:
        app.kubernetes.io/name: myapp
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/port: "3000"

    spec:
      serviceAccountName: app-service-account

      # Security context
      securityContext:
        runAsNonRoot: true
        runAsUser: 1000
        fsGroup: 1000

      # Init containers
      initContainers:
        - name: wait-for-postgres
          image: busybox:1.36
          command: ['sh', '-c', 'until nc -z postgres-service 5432; do sleep 2; done']

        - name: run-migrations
          image: your-registry/your-app:latest
          command: ['npx', 'prisma', 'migrate', 'deploy']
          envFrom:
            - configMapRef:
                name: app-config
            - secretRef:
                name: app-secrets

      # Main container
      containers:
        - name: app
          image: your-registry/your-app:latest
          imagePullPolicy: Always

          ports:
            - name: http
              containerPort: 3000

          envFrom:
            - configMapRef:
                name: app-config
            - secretRef:
                name: app-secrets

          # Resource limits
          resources:
            requests:
              cpu: "250m"
              memory: "512Mi"
            limits:
              cpu: "1000m"
              memory: "1Gi"

          # Health checks
          livenessProbe:
            httpGet:
              path: /health
              port: 3000
            initialDelaySeconds: 30
            periodSeconds: 10
            failureThreshold: 3

          readinessProbe:
            httpGet:
              path: /ready
              port: 3000
            initialDelaySeconds: 10
            periodSeconds: 5
            failureThreshold: 3

          startupProbe:
            httpGet:
              path: /health
              port: 3000
            failureThreshold: 30
            periodSeconds: 10

          # Security
          securityContext:
            allowPrivilegeEscalation: false
            readOnlyRootFilesystem: true
            runAsNonRoot: true
            capabilities:
              drop: ["ALL"]
```

#### Service & Ingress

```yaml
# ClusterIP Service (internal)
apiVersion: v1
kind: Service
metadata:
  name: app-service
  namespace: myapp
spec:
  type: ClusterIP
  selector:
    app.kubernetes.io/name: myapp
  ports:
    - port: 80
      targetPort: 3000

---
# Ingress with automatic SSL
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: app-ingress
  namespace: myapp
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/rate-limit: "100"
spec:
  tls:
    - hosts:
        - yourdomain.com
      secretName: app-tls-secret
  rules:
    - host: yourdomain.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: app-service
                port:
                  number: 80
```

#### Horizontal Pod Autoscaler

```yaml
# kubernetes/base/hpa.yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: app-hpa
  namespace: myapp
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: app

  minReplicas: 3
  maxReplicas: 10

  behavior:
    scaleDown:
      stabilizationWindowSeconds: 300
      policies:
        - type: Percent
          value: 50
          periodSeconds: 60
    scaleUp:
      stabilizationWindowSeconds: 0
      policies:
        - type: Pods
          value: 2
          periodSeconds: 60

  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 70

    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: 80
```

#### Kustomize Overlays

```yaml
# kubernetes/overlays/production/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../../base

namespace: myapp-prod
namePrefix: prod-

commonLabels:
  environment: production

# Patches for production
patchesStrategicMerge:
  - deployment-patch.yaml

# Image override
images:
  - name: your-registry/your-app
    newTag: v1.0.0

# ConfigMap overrides
configMapGenerator:
  - name: app-config
    behavior: merge
    literals:
      - NODE_ENV=production
      - OTEL_TRACES_SAMPLER_ARG=0.1

replicas:
  - name: app
    count: 3
```

#### Secret Management

```bash
# Method 1: kubectl create secret
kubectl create secret generic app-secrets \
  --namespace=myapp \
  --from-literal=DATABASE_URL="postgresql://..." \
  --from-literal=JWT_SECRET="$(openssl rand -base64 32)"

# Method 2: Sealed Secrets (encrypted in git)
kubectl apply -f https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.24.0/controller.yaml
kubeseal --format=yaml < secret.yaml > sealed-secret.yaml

# Method 3: External Secrets Operator (AWS, Vault, etc.)
helm install external-secrets external-secrets/external-secrets
kubectl apply -f external-secret.yaml
```

#### RBAC Configuration

```yaml
# kubernetes/base/rbac.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: app-service-account
  namespace: myapp

---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: app-role
  namespace: myapp
rules:
  - apiGroups: [""]
    resources: ["configmaps", "services", "pods"]
    verbs: ["get", "list", "watch"]
  - apiGroups: [""]
    resources: ["events"]
    verbs: ["create", "patch"]

---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: app-role-binding
  namespace: myapp
subjects:
  - kind: ServiceAccount
    name: app-service-account
roleRef:
  kind: Role
  name: app-role
  apiGroup: rbac.authorization.k8s.io
```

#### Network Policies

```yaml
# kubernetes/base/rbac.yaml (network policies section)
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: app-network-policy
  namespace: myapp
spec:
  podSelector:
    matchLabels:
      app.kubernetes.io/name: myapp

  policyTypes:
    - Ingress
    - Egress

  ingress:
    - from:
        - namespaceSelector:
            matchLabels:
              name: ingress-nginx
      ports:
        - protocol: TCP
          port: 3000

  egress:
    # Allow DNS
    - to:
        - namespaceSelector:
            matchLabels:
              name: kube-system
      ports:
        - protocol: UDP
          port: 53

    # Allow PostgreSQL
    - to:
        - podSelector:
            matchLabels:
              app: postgres
      ports:
        - protocol: TCP
          port: 5432

    # Allow Redis
    - to:
        - podSelector:
            matchLabels:
              app: redis
      ports:
        - protocol: TCP
          port: 6379

    # Allow HTTPS (external APIs)
    - ports:
        - protocol: TCP
          port: 443
```

#### Prerequisites Installation

```bash
# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl && sudo mv kubectl /usr/local/bin/

# Install Metrics Server (for HPA)
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Install Nginx Ingress Controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.4/deploy/static/provider/cloud/deploy.yaml

# Install Cert-Manager (for SSL)
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.2/cert-manager.yaml

# Verify installations
kubectl get pods -n kube-system
kubectl get pods -n ingress-nginx
kubectl get pods -n cert-manager
```

#### Deployment Steps

```bash
# 1. Create namespace
kubectl create namespace myapp-prod

# 2. Create secrets
kubectl create secret generic app-secrets \
  --namespace=myapp-prod \
  --from-literal=DATABASE_URL="postgresql://..." \
  --from-literal=JWT_SECRET="$(openssl rand -base64 32)" \
  --from-literal=SESSION_SECRET="$(openssl rand -base64 32)"

# 3. Deploy application
kubectl apply -k kubernetes/overlays/production

# 4. Verify deployment
kubectl get all -n myapp-prod
kubectl rollout status deployment/prod-app -n myapp-prod

# 5. Check pod health
kubectl get pods -n myapp-prod -o wide
kubectl top pods -n myapp-prod

# 6. View logs
kubectl logs -f deployment/prod-app -n myapp-prod

# 7. Check HPA status
kubectl get hpa -n myapp-prod
```

#### Monitoring & Troubleshooting

```bash
# Check pod status
kubectl get pods -n myapp-prod
kubectl describe pod <pod-name> -n myapp-prod

# View logs
kubectl logs <pod-name> -n myapp-prod --tail=100 -f
kubectl logs <pod-name> -n myapp-prod --previous  # Previous crashed container

# Check events
kubectl get events -n myapp-prod --sort-by='.lastTimestamp'

# Test health endpoints
kubectl exec -it <pod-name> -n myapp-prod -- curl localhost:3000/health

# Port forward for local testing
kubectl port-forward service/app-service 8080:80 -n myapp-prod

# Check resource usage
kubectl top pods -n myapp-prod
kubectl top nodes

# Scale manually (HPA will override)
kubectl scale deployment/prod-app --replicas=5 -n myapp-prod

# Restart deployment
kubectl rollout restart deployment/prod-app -n myapp-prod

# Rollback deployment
kubectl rollout undo deployment/prod-app -n myapp-prod
```

#### Cloud Provider Deployment

**Amazon EKS:**
```bash
# Create cluster
eksctl create cluster --name myapp --region us-east-1 --nodes 3

# Install AWS Load Balancer Controller
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  --set clusterName=myapp
```

**Google GKE:**
```bash
# Create cluster
gcloud container clusters create myapp --num-nodes=3 --region=us-central1

# Get credentials
gcloud container clusters get-credentials myapp --region=us-central1
```

**Azure AKS:**
```bash
# Create cluster
az aks create --resource-group myapp-rg --name myapp --node-count 3

# Get credentials
az aks get-credentials --resource-group myapp-rg --name myapp
```

**Local Development (Minikube):**
```bash
# Install and start Minikube
minikube start --cpus=4 --memory=8192

# Enable addons
minikube addons enable ingress
minikube addons enable metrics-server

# Deploy
kubectl apply -k kubernetes/overlays/development

# Access via tunnel
minikube tunnel
```

#### Advanced Features

**Blue-Green Deployment:**
```bash
# Deploy new version
kubectl apply -k kubernetes/overlays/production -l version=v2.0.0

# Switch traffic
kubectl patch service app-service -p '{"spec":{"selector":{"version":"v2.0.0"}}}'
```

**Canary Deployment (with Flagger):**
```bash
# Install Flagger
helm install flagger flagger/flagger --namespace ingress-nginx

# Create Canary resource
kubectl apply -f canary.yaml  # Automated progressive traffic shifting
```

See `/kubernetes/README.md` for complete documentation.

### Infrastructure as Code (Terraform)

Production-ready Terraform configurations for deploying complete cloud infrastructure on AWS (with patterns for GCP and Azure).

#### Quick Start

```bash
# Navigate to infrastructure directory
cd infrastructure

# Initialize Terraform
terraform init

# Configure variables
cp environments/production/terraform.tfvars.example terraform.tfvars
vim terraform.tfvars  # Edit with your values

# Plan and apply
terraform plan
terraform apply

# View outputs
terraform output
```

#### Infrastructure Components

```yaml
Resources Created:
  - VPC with public/private subnets (Multi-AZ)
  - RDS PostgreSQL with automated backups
  - ElastiCache Redis with encryption
  - ECS Fargate for serverless containers
  - Application Load Balancer with SSL/TLS
  - S3 buckets with versioning
  - CloudWatch monitoring and alarms
  - IAM roles with least-privilege access
  - Route53 DNS management
  - ACM SSL/TLS certificates
  - Secrets Manager for secure secrets

Features:
  - Multi-environment support (dev, staging, production)
  - Remote state management (S3 + DynamoDB)
  - Auto-scaling based on CPU/memory
  - Automated backups and disaster recovery
  - Encryption at rest and in transit
  - VPC Flow Logs for network monitoring
  - Cost optimization with environment-specific sizing
```

#### Main Configuration

```hcl
# infrastructure/main.tf
terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # S3 backend for remote state
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "production/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"

  project_name       = var.project_name
  environment        = var.environment
  vpc_cidr           = "10.0.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
  enable_nat_gateway = true
}

# RDS PostgreSQL Module
module "database" {
  source = "./modules/rds"

  identifier        = "${var.project_name}-${var.environment}-db"
  engine            = "postgres"
  engine_version    = "18.1"
  instance_class    = "db.t3.medium"
  allocated_storage = 100

  database_name = var.db_name
  username      = var.db_username
  password      = var.db_password

  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = [module.vpc.database_security_group_id]

  backup_retention_period = 30
  multi_az                = true
  deletion_protection     = true
  storage_encrypted       = true
}

# ElastiCache Redis Module
module "cache" {
  source = "./modules/elasticache"

  cluster_id  = "${var.project_name}-${var.environment}-cache"
  engine      = "redis"
  node_type   = "cache.t3.medium"
  num_nodes   = 3

  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = [module.vpc.cache_security_group_id]

  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  auth_token                 = var.redis_auth_token
  automatic_failover_enabled = true
}

# ECS Fargate Module
module "ecs" {
  source = "./modules/ecs"

  cluster_name = "${var.project_name}-${var.environment}-cluster"
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnet_ids

  container_image = var.container_image
  container_port  = 3000
  task_cpu        = 1024
  task_memory     = 2048

  desired_count = 3
  min_capacity  = 2
  max_capacity  = 10

  target_group_arn = module.alb.target_group_arn
}

# Application Load Balancer Module
module "alb" {
  source = "./modules/alb"

  name            = "${var.project_name}-${var.environment}-alb"
  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnet_ids
  security_groups = [module.vpc.alb_security_group_id]

  certificate_arn   = module.acm.certificate_arn
  health_check_path = "/health"
}
```

#### Environment-Specific Configurations

```hcl
# environments/production/terraform.tfvars
project_name = "myapp"
environment  = "production"
aws_region   = "us-east-1"

# VPC Configuration
vpc_cidr           = "10.0.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnets    = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]

# RDS - Production sizing
postgres_version            = "18.1"
db_instance_class           = "db.t3.medium"
db_allocated_storage        = 100
db_backup_retention_period  = 30

# Redis - Production sizing
redis_node_type = "cache.t3.medium"
redis_num_nodes = 3

# ECS - Production scaling
ecs_task_cpu      = 1024
ecs_task_memory   = 2048
ecs_desired_count = 3
ecs_min_capacity  = 2
ecs_max_capacity  = 10

# Domain
app_domain = "myapp.com"
```

```hcl
# environments/dev/terraform.tfvars
project_name = "myapp"
environment  = "dev"
aws_region   = "us-east-1"

# VPC - Minimal for dev
vpc_cidr           = "10.2.0.0/16"
availability_zones = ["us-east-1a"]
public_subnets     = ["10.2.1.0/24"]
private_subnets    = ["10.2.10.0/24"]

# RDS - Minimal for dev
db_instance_class          = "db.t3.micro"
db_allocated_storage       = 20
db_backup_retention_period = 1

# Redis - Minimal for dev
redis_node_type = "cache.t3.micro"
redis_num_nodes = 1

# ECS - Minimal for dev
ecs_task_cpu      = 256
ecs_task_memory   = 512
ecs_desired_count = 1
ecs_min_capacity  = 1
ecs_max_capacity  = 2
```

#### Key Modules

**VPC Module:**
```hcl
# Creates complete networking infrastructure
- Multi-AZ public/private subnets
- Internet Gateway for public access
- NAT Gateways for private subnet internet access
- Security Groups (ALB, App, Database, Cache)
- VPC Flow Logs for monitoring
```

**RDS Module:**
```hcl
# PostgreSQL database with high availability
- Multi-AZ deployment (production)
- Automated daily backups (30-day retention)
- Encryption at rest (AES-256)
- Performance Insights enabled
- CloudWatch Logs integration
- Automated minor version upgrades
```

**ElastiCache Module:**
```hcl
# Redis cluster with encryption
- Cluster mode with sharding
- Encryption at rest and in transit
- Automatic failover (Multi-AZ)
- Auth token authentication
- Automated backups
```

**ECS Module:**
```hcl
# Serverless container orchestration
- ECS Fargate (no EC2 instances)
- Auto-scaling (CPU/memory based)
- Integration with ALB
- CloudWatch Logs
- Secrets Manager integration
- IAM task roles
```

#### Deployment Workflow

```bash
# 1. Initialize Terraform
terraform init

# 2. Select workspace (environment)
terraform workspace new production
terraform workspace select production

# 3. Validate configuration
terraform validate
terraform fmt -check

# 4. Plan deployment
terraform plan -out=tfplan

# 5. Review plan
terraform show tfplan

# 6. Apply configuration
terraform apply tfplan

# 7. Verify deployment
terraform output
aws ecs describe-clusters --clusters myapp-production-cluster

# 8. Access application
curl https://$(terraform output -raw app_domain)
```

#### State Management

```bash
# Create S3 bucket for state
aws s3 mb s3://your-terraform-state-bucket --region us-east-1

# Enable versioning
aws s3api put-bucket-versioning \
  --bucket your-terraform-state-bucket \
  --versioning-configuration Status=Enabled

# Enable encryption
aws s3api put-bucket-encryption \
  --bucket your-terraform-state-bucket \
  --server-side-encryption-configuration \
  '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'

# Create DynamoDB table for state locking
aws dynamodb create-table \
  --table-name terraform-state-lock \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST
```

#### Disaster Recovery

```bash
# Backup RDS manually before major changes
aws rds create-db-snapshot \
  --db-instance-identifier myapp-production-db \
  --db-snapshot-identifier myapp-db-backup-$(date +%Y%m%d)

# Restore from snapshot
aws rds restore-db-instance-from-db-snapshot \
  --db-instance-identifier myapp-db-restored \
  --db-snapshot-identifier myapp-db-backup-20260201

# Recreate infrastructure from Terraform
terraform init
terraform apply -auto-approve
```

#### Multi-Cloud Support

**Google Cloud Platform (GCP):**
```hcl
provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

# Equivalent resources:
# VPC → Google VPC
# RDS → Cloud SQL
# ElastiCache → Memorystore
# ECS → Cloud Run / GKE
# ALB → Cloud Load Balancing
# S3 → Cloud Storage
```

**Microsoft Azure:**
```hcl
provider "azurerm" {
  features {}
}

# Equivalent resources:
# VPC → Virtual Network
# RDS → Azure Database for PostgreSQL
# ElastiCache → Azure Cache for Redis
# ECS → Azure Container Instances / AKS
# ALB → Application Gateway
# S3 → Blob Storage
```

#### Cost Optimization

```yaml
Development ($50-75/month):
  - db.t3.micro ($15/month)
  - cache.t3.micro ($12/month)
  - Single AZ
  - 1-day backup retention
  - Minimal ECS tasks

Production ($300-500/month):
  - db.t3.medium ($60/month)
  - cache.t3.medium ($50/month)
  - Multi-AZ deployment
  - 30-day backup retention
  - Auto-scaling ECS tasks

Savings Strategies:
  - Use Reserved Instances (40-60% savings)
  - Enable auto-scaling (pay for actual usage)
  - Use S3 Intelligent-Tiering
  - Review CloudWatch retention periods
  - Enable cost allocation tags
```

See `/infrastructure/README.md` for complete documentation.

### CI/CD Pipeline (Jenkins)
```groovy
pipeline {
  agent any
  
  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/org/repo.git'
      }
    }
    
    stage('Install Dependencies') {
      steps {
        sh 'npm ci'
      }
    }
    
    stage('Lint & Format') {
      steps {
        sh 'npm run lint'
        sh 'npm run format:check'
      }
    }
    
    stage('Security Scan') {
      parallel {
        stage('Dependencies') {
          steps {
            sh 'npm audit --audit-level=moderate'
          }
        }
        stage('Code Quality') {
          steps {
            withSonarQubeEnv('SonarQube') {
              sh 'npm run sonar'
            }
          }
        }
      }
    }
    
    stage('Test') {
      parallel {
        stage('Unit Tests') {
          steps {
            sh 'npm run test:unit'
          }
        }
        stage('Integration Tests') {
          steps {
            sh 'npm run test:integration'
          }
        }
      }
    }
    
    stage('Build') {
      steps {
        sh 'npm run build'
        sh 'docker build -t myapp:${BUILD_NUMBER} .'
      }
    }
    
    stage('E2E Tests') {
      steps {
        sh 'npx playwright test'
      }
    }
    
    stage('Push to Registry') {
      steps {
        sh 'docker tag myapp:${BUILD_NUMBER} harbor.domain.com/myapp:${BUILD_NUMBER}'
        sh 'docker push harbor.domain.com/myapp:${BUILD_NUMBER}'
      }
    }
    
    stage('Deploy to Production') {
      when {
        branch 'main'
      }
      steps {
        sh 'docker-compose -f docker-compose.prod.yml up -d'
      }
    }
  }
  
  post {
    always {
      junit 'test-results/**/*.xml'
      publishHTML target: [reportDir: 'coverage', reportFiles: 'index.html', reportName: 'Coverage Report']
    }
    success {
      slackSend color: 'good', message: "Build ${BUILD_NUMBER} succeeded"
    }
    failure {
      slackSend color: 'danger', message: "Build ${BUILD_NUMBER} failed"
    }
  }
}
```

---

## 🔄 UPGRADE & MIGRATION TOOLS

### Version Upgrade Procedures

**Semantic Versioning Strategy:**
```yaml
Version Format: MAJOR.MINOR.PATCH (e.g., 2.5.3)

MAJOR (Breaking Changes):
  - Database schema changes that aren't backward compatible
  - API endpoint removals or signature changes
  - Configuration file format changes
  - Minimum dependency version bumps
  - Example: 1.9.5 → 2.0.0

MINOR (New Features):
  - New API endpoints
  - New features (backward compatible)
  - Database schema additions (backward compatible)
  - New optional configuration parameters
  - Example: 2.0.1 → 2.1.0

PATCH (Bug Fixes):
  - Bug fixes
  - Security patches
  - Performance improvements
  - Documentation updates
  - Example: 2.1.0 → 2.1.1
```

**Pre-Upgrade Checklist:**
```yaml
1. Review Release Notes:
   - Read CHANGELOG.md for breaking changes
   - Check migration guide for version-specific steps
   - Identify features being deprecated
   - Review new features and configuration options

2. Backup Everything:
   - Database backup (pg_dump)
   - Configuration files (.env, nginx.conf)
   - Uploaded files (if stored locally)
   - SSL certificates
   - Custom modifications

3. Test in Staging:
   - Deploy to staging environment first
   - Run full test suite
   - Test critical user workflows
   - Verify integrations (LDAP, SAML, payment gateway)
   - Load test with production-like data

4. Schedule Maintenance Window:
   - Notify users in advance (email, in-app banner)
   - Choose low-traffic time (typically 2-4 AM)
   - Allocate 2x expected upgrade time
   - Prepare rollback plan

5. Verify Prerequisites:
   - Check Node.js version compatibility
   - Check PostgreSQL version compatibility
   - Review new environment variables required
   - Ensure sufficient disk space (2x current usage)
```

**Upgrade Process (Zero-Downtime):**

*Method 1: Blue-Green Deployment*
```bash
#!/bin/bash
# Blue-Green upgrade script

# Current (blue) environment
BLUE_ENV="production"
GREEN_ENV="production-next"

# 1. Deploy new version to green environment
echo "Deploying version $NEW_VERSION to green environment..."
docker-compose -f docker-compose.green.yml up -d

# 2. Wait for green to be healthy
echo "Waiting for green environment to be healthy..."
for i in {1..30}; do
  if curl -f http://green.internal:3000/health; then
    echo "Green environment is healthy"
    break
  fi
  sleep 10
done

# 3. Run database migrations (backward compatible)
echo "Running database migrations..."
docker exec green-app npx prisma migrate deploy

# 4. Smoke test new version
echo "Running smoke tests..."
./scripts/smoke-test.sh http://green.internal:3000

if [ $? -ne 0 ]; then
  echo "Smoke tests failed, aborting upgrade"
  docker-compose -f docker-compose.green.yml down
  exit 1
fi

# 5. Switch traffic to green (via load balancer)
echo "Switching traffic to green environment..."
# Update nginx upstream or load balancer configuration
sed -i 's/blue.internal/green.internal/' /etc/nginx/conf.d/upstream.conf
nginx -s reload

# 6. Monitor for issues (5 minutes)
echo "Monitoring for issues..."
sleep 300

# Check error rate
ERROR_RATE=$(curl -s http://green.internal:3000/metrics | grep http_errors | awk '{print $2}')
if (( $(echo "$ERROR_RATE > 0.01" | bc -l) )); then
  echo "Error rate too high, rolling back..."
  sed -i 's/green.internal/blue.internal/' /etc/nginx/conf.d/upstream.conf
  nginx -s reload
  exit 1
fi

# 7. Shutdown blue environment
echo "Upgrade successful, shutting down blue environment..."
docker-compose -f docker-compose.blue.yml down

echo "Upgrade complete!"
```

*Method 2: Rolling Upgrade (Kubernetes)*
```yaml
# deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1        # Max 1 extra pod during update
      maxUnavailable: 0  # Keep all pods available
  template:
    spec:
      containers:
      - name: app
        image: myapp:2.0.0
        readinessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 10
          periodSeconds: 5
        livenessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 30
          periodSeconds: 10
```

```bash
# Apply rolling update
kubectl set image deployment/app app=myapp:2.0.0

# Monitor rollout
kubectl rollout status deployment/app

# Rollback if needed
kubectl rollout undo deployment/app
```

**Rollback Procedures:**
```yaml
Automated Rollback Triggers:
  - Error rate > 1% for 5 minutes
  - P95 response time > 2x baseline
  - Health check failures > 20%
  - Database connection errors

Manual Rollback Steps:
  1. Switch load balancer to previous version
  2. Verify old version is healthy
  3. Rollback database migrations (if possible)
  4. Clear Redis cache
  5. Monitor for stability
  6. Investigate root cause

Database Migration Rollback:
  - Each migration has corresponding down migration
  - Test rollback in staging first
  - Some migrations can't be rolled back (data loss)
  - Always backup before running migrations
```

**Database Migration Rollback Example:**
```typescript
// migrations/001_add_user_status.ts
export async function up(prisma: PrismaClient) {
  await prisma.$executeRaw`
    ALTER TABLE users ADD COLUMN status VARCHAR(20) DEFAULT 'active';
  `;
}

export async function down(prisma: PrismaClient) {
  await prisma.$executeRaw`
    ALTER TABLE users DROP COLUMN status;
  `;
}

// Rollback command
// npx prisma migrate resolve --rolled-back migration_name
```

### Database Migration Strategies

**Backward-Compatible Migrations:**
```yaml
Safe Migration Patterns:
  1. Add new columns (with defaults):
     ✅ ALTER TABLE users ADD COLUMN status VARCHAR(20) DEFAULT 'active';
     ✅ Old code continues working (ignores new column)

  2. Add new tables:
     ✅ CREATE TABLE notifications (...);
     ✅ Old code not affected

  3. Add indexes:
     ✅ CREATE INDEX idx_users_email ON users(email);
     ✅ Improves performance, no breaking changes

  4. Expand column size:
     ✅ ALTER TABLE users ALTER COLUMN name TYPE VARCHAR(200);
     ✅ Old code continues working

Unsafe Migration Patterns (Require Multi-Phase):
  ❌ Rename columns (breaks old code)
  ❌ Remove columns (breaks old code)
  ❌ Change column type (incompatible data)
  ❌ Add NOT NULL columns (without defaults)
  ❌ Add foreign key constraints (may fail on existing data)
```

**Multi-Phase Migration for Breaking Changes:**
```yaml
Phase 1: Add new column alongside old (backward compatible):
  - Deploy code that writes to both old and new columns
  - Old code still reads from old column
  - Run for 1-2 weeks to ensure stability

Phase 2: Migrate data (background job):
  - Copy data from old column to new column
  - Validate data integrity
  - Keep both columns in sync

Phase 3: Switch reads to new column:
  - Deploy code that reads from new column
  - Old column still updated for safety
  - Monitor for issues

Phase 4: Remove old column:
  - Deploy code that only uses new column
  - Drop old column from database
```

**Example: Renaming Column (3-Phase Migration):**
```typescript
// Phase 1: Add new column
// migration: 001_add_full_name.ts
await prisma.$executeRaw`
  ALTER TABLE users ADD COLUMN full_name VARCHAR(255);
  UPDATE users SET full_name = name WHERE full_name IS NULL;
`;

// Code update: Write to both columns
await prisma.user.update({
  where: { id },
  data: {
    name: fullName,      // Old column
    fullName: fullName   // New column
  }
});

// Phase 2: Backfill data (background job)
// Ensure all rows have full_name populated
await prisma.$executeRaw`
  UPDATE users SET full_name = name WHERE full_name IS NULL;
`;

// Phase 3: Switch reads to new column
// Code update: Read from full_name
const user = await prisma.user.findUnique({
  where: { id },
  select: { id: true, fullName: true }  // Use new column
});

// Phase 4: Remove old column
// migration: 002_remove_name.ts
await prisma.$executeRaw`
  ALTER TABLE users DROP COLUMN name;
`;
```

**Data Migration Scripts:**
```typescript
// Large dataset migrations (chunked processing)
async function migrateUserData() {
  const batchSize = 1000;
  let offset = 0;
  let processedCount = 0;

  while (true) {
    const users = await prisma.user.findMany({
      take: batchSize,
      skip: offset,
      where: { migratedAt: null }
    });

    if (users.length === 0) break;

    // Process batch
    for (const user of users) {
      await migrateUserRecord(user);
    }

    processedCount += users.length;
    console.log(`Migrated ${processedCount} users...`);

    // Progress tracking
    await redis.set('migration:users:progress', processedCount);

    offset += batchSize;

    // Small delay to avoid overwhelming database
    await new Promise(resolve => setTimeout(resolve, 100));
  }

  console.log(`Migration complete: ${processedCount} users migrated`);
}

// Validation & verification
async function validateMigration() {
  const oldCount = await prisma.$queryRaw`SELECT COUNT(*) FROM users`;
  const newCount = await prisma.$queryRaw`SELECT COUNT(*) FROM user_profiles`;

  if (oldCount !== newCount) {
    throw new Error(`Count mismatch: ${oldCount} vs ${newCount}`);
  }

  // Data integrity checks
  const inconsistencies = await prisma.$queryRaw`
    SELECT u.id FROM users u
    LEFT JOIN user_profiles up ON u.id = up.user_id
    WHERE up.id IS NULL
  `;

  if (inconsistencies.length > 0) {
    throw new Error(`Found ${inconsistencies.length} inconsistencies`);
  }

  console.log('Migration validation passed!');
}
```

**Migration Testing:**
```yaml
Test Against Production-Like Data:
  1. Take production database dump (anonymized)
  2. Restore to staging database
  3. Run migrations on staging
  4. Verify data integrity
  5. Test application against migrated data
  6. Measure migration duration

Performance Impact Assessment:
  - Measure migration execution time
  - Check for table locks (avoid on large tables)
  - Monitor database CPU/memory during migration
  - Use CONCURRENTLY for indexes (PostgreSQL)

Rollback Testing:
  - Test down migrations on staging
  - Verify data is restored correctly
  - Document any data loss scenarios
```

### Zero-Downtime Deployment

**Feature Flags for Gradual Rollout:**
```typescript
// Feature flag service
class FeatureFlags {
  async isEnabled(flag: string, userId?: string): Promise<boolean> {
    // Check Redis cache first
    const cached = await redis.get(`feature:${flag}:${userId || 'global'}`);
    if (cached !== null) return cached === 'true';

    // Load from database
    const feature = await prisma.featureFlag.findUnique({
      where: { name: flag }
    });

    if (!feature) return false;

    // Global rollout percentage
    if (feature.rolloutPercentage < 100) {
      const hash = userId ? hashCode(userId) : 0;
      const enabled = (hash % 100) < feature.rolloutPercentage;
      await redis.setex(`feature:${flag}:${userId || 'global'}`, 300, enabled.toString());
      return enabled;
    }

    return feature.enabled;
  }
}

// Usage in code
if (await featureFlags.isEnabled('new-dashboard', req.user.id)) {
  // Use new dashboard
  return renderNewDashboard();
} else {
  // Use old dashboard
  return renderOldDashboard();
}

// Gradual rollout: 5% → 25% → 50% → 100%
await prisma.featureFlag.update({
  where: { name: 'new-dashboard' },
  data: { rolloutPercentage: 25 }
});
```

**Canary Deployment:**
```yaml
Canary Strategy:
  1. Deploy new version to 5% of servers
  2. Monitor metrics for 15 minutes:
     - Error rate
     - Response time (P95, P99)
     - Resource usage
     - User feedback
  3. If metrics are good, increase to 25%
  4. Continue gradual rollout: 50% → 75% → 100%
  5. Automated rollback if error rate increases

Monitoring During Canary:
  - Compare new vs old version metrics
  - Alert if new version has >2x error rate
  - Alert if P95 latency increases >20%
  - Monitor custom business metrics
```

**Health Check Requirements:**
```typescript
// Comprehensive health check for zero-downtime
app.get('/health', async (req, res) => {
  const health = {
    status: 'ok',
    version: process.env.APP_VERSION,
    timestamp: new Date().toISOString(),
    checks: {
      database: 'checking',
      redis: 'checking',
      migrations: 'checking',
      disk: 'checking'
    }
  };

  try {
    // Database check
    await prisma.$queryRaw`SELECT 1`;
    health.checks.database = 'ok';
  } catch (error) {
    health.checks.database = 'error';
    health.status = 'degraded';
  }

  try {
    // Redis check
    await redis.ping();
    health.checks.redis = 'ok';
  } catch (error) {
    health.checks.redis = 'error';
    health.status = 'degraded';
  }

  try {
    // Verify migrations are up to date
    const pendingMigrations = await prisma.$queryRaw`
      SELECT * FROM _prisma_migrations WHERE finished_at IS NULL
    `;
    health.checks.migrations = pendingMigrations.length === 0 ? 'ok' : 'pending';
  } catch (error) {
    health.checks.migrations = 'error';
  }

  // Disk space check
  const diskUsage = await checkDiskUsage();
  health.checks.disk = diskUsage < 90 ? 'ok' : 'warning';

  const statusCode = health.status === 'ok' ? 200 : 503;
  res.status(statusCode).json(health);
});

// Readiness check (for load balancer)
app.get('/ready', async (req, res) => {
  // Only return 200 if app is ready to serve traffic
  const ready =
    await checkDatabaseConnection() &&
    await checkRedisConnection() &&
    await checkMigrationsComplete();

  res.status(ready ? 200 : 503).json({ ready });
});
```

**Database Connection Draining:**
```typescript
// Graceful shutdown with connection draining
let isShuttingDown = false;

process.on('SIGTERM', async () => {
  console.log('SIGTERM received, starting graceful shutdown...');
  isShuttingDown = true;

  // Stop accepting new requests
  server.close(() => {
    console.log('HTTP server closed');
  });

  // Wait for in-flight requests to complete (max 30 seconds)
  await new Promise(resolve => setTimeout(resolve, 30000));

  // Close database connections
  await prisma.$disconnect();
  console.log('Database connections closed');

  // Close Redis connections
  await redis.quit();
  console.log('Redis connections closed');

  process.exit(0);
});

// Middleware to reject requests during shutdown
app.use((req, res, next) => {
  if (isShuttingDown) {
    res.status(503).json({ error: 'Server is shutting down' });
  } else {
    next();
  }
});
```

### Configuration Backup & Restore

**Automated Configuration Backup:**
```bash
#!/bin/bash
# backup-config.sh

BACKUP_DIR="/var/backups/app-config"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/config_$TIMESTAMP.tar.gz"

mkdir -p $BACKUP_DIR

# Backup configuration files
tar -czf $BACKUP_FILE \
  .env \
  .env.production \
  /etc/nginx/sites-available/app.conf \
  /etc/ssl/certs/app.* \
  prisma/schema.prisma \
  docker-compose.yml \
  docker-compose.prod.yml

# Encrypt backup (optional)
gpg --encrypt --recipient admin@company.com $BACKUP_FILE

# Upload to S3
aws s3 cp $BACKUP_FILE.gpg s3://company-backups/config/

# Retain only last 30 days
find $BACKUP_DIR -name "config_*.tar.gz" -mtime +30 -delete

echo "Configuration backup completed: $BACKUP_FILE"
```

**Configuration Restore:**
```bash
#!/bin/bash
# restore-config.sh

BACKUP_FILE=$1

if [ -z "$BACKUP_FILE" ]; then
  echo "Usage: ./restore-config.sh <backup-file>"
  exit 1
fi

# Decrypt backup
gpg --decrypt $BACKUP_FILE > /tmp/config.tar.gz

# Extract to temporary directory
mkdir -p /tmp/config-restore
tar -xzf /tmp/config.tar.gz -C /tmp/config-restore

# Validate configuration files
echo "Validating configuration files..."
node -c /tmp/config-restore/.env || { echo ".env validation failed"; exit 1; }
nginx -t -c /tmp/config-restore/nginx.conf || { echo "nginx config validation failed"; exit 1; }

# Backup current configuration
./backup-config.sh

# Restore configuration
echo "Restoring configuration..."
cp /tmp/config-restore/.env .env
cp /tmp/config-restore/nginx.conf /etc/nginx/sites-available/app.conf
# ... copy other files

# Restart services
systemctl reload nginx
systemctl restart app

echo "Configuration restored successfully"
```

**Secrets Rotation:**
```yaml
JWT Secret Rotation (with grace period):
  1. Generate new JWT secret
  2. Add to environment as JWT_SECRET_NEW
  3. Update code to validate both old and new secrets
  4. Deploy application (accepts both secrets)
  5. Wait 24 hours (or max token TTL)
  6. Remove old secret, rename new secret to JWT_SECRET
  7. Deploy application

Database Password Rotation:
  1. Create new database user with same permissions
  2. Update DATABASE_URL to use new credentials
  3. Deploy application (rolling restart)
  4. Verify all instances use new credentials
  5. Remove old database user
  6. Update backup scripts with new credentials

API Key Rotation:
  - Rotate every 90 days
  - Notify integrations 2 weeks before expiry
  - Provide 2-week overlap period (both keys work)
  - Revoke old key after grace period

Automated Rotation Schedule:
  - JWT secrets: Every 6 months
  - Database passwords: Every 90 days
  - API keys: Every 90 days
  - SSL certificates: Auto-renew 30 days before expiry (Let's Encrypt)
  - Service account credentials: Every year
```

**Configuration Validation:**
```typescript
// Validate configuration before starting app
import { z } from 'zod';

const envSchema = z.object({
  NODE_ENV: z.enum(['development', 'production', 'test']),
  PORT: z.string().regex(/^\d+$/).transform(Number),
  DATABASE_URL: z.string().url(),
  REDIS_URL: z.string().url(),
  JWT_SECRET: z.string().min(32),
  SMTP_HOST: z.string().optional(),
  SMTP_PORT: z.string().regex(/^\d+$/).optional(),
  // ... other required env vars
});

try {
  const config = envSchema.parse(process.env);
  console.log('Configuration validated successfully');
} catch (error) {
  console.error('Configuration validation failed:', error);
  process.exit(1);
}
```

---

## 📝 REQUIRED DOCUMENTATION FILES

Generate comprehensive, professional Markdown files for GitHub repository:

### 1. README.md
```yaml
Contents:
  - Project title and badges (build, coverage, license, version)
  - Project description and purpose
  - Key features (bullet list)
  - Tech stack overview
  - Screenshots (if applicable)
  - Quick start guide
  - Documentation links
  - Contributing guidelines link
  - License information
  - Support/Contact information
```

### 2. TODO.md
```yaml
Contents:
  - Pending features (categorized by priority)
  - Known bugs (with severity levels)
  - Improvements and enhancements
  - Technical debt items
  - Future roadmap
  - Status indicators (✅ 🟡 ❌)
```

### 3. INSTALLATION.md
```yaml
Contents:
  - Prerequisites (Node.js, PostgreSQL, Redis, etc.)
  - Environment setup
  - Database setup and migrations
  - Configuration file examples
  - Step-by-step installation
  - Troubleshooting common issues
  - Development vs Production setup
```

### 4. API.md
```yaml
Contents:
  - API overview and base URL
  - Authentication methods (JWT, API keys)
  - Endpoint reference (grouped by resource)
  - Request/Response examples (with curl, JavaScript)
  - Error codes and meanings
  - Rate limiting information
  - Pagination details
  - Filtering and sorting
  - WebSocket endpoints (if applicable)
```

### 5. CONTRIBUTING.md
```yaml
Contents:
  - How to contribute
  - Code of conduct
  - Development workflow
  - Branch naming conventions
  - Commit message format (Conventional Commits)
  - Pull request process
  - Code style guide (Prettier, ESLint)
  - Testing requirements
  - Review process
```

### 6. CHANGELOG.md
```yaml
Format: Keep a Changelog
Contents:
  - [Unreleased] section
  - Version history (newest first)
  - Categories per version:
    - Added (new features)
    - Changed (changes in existing functionality)
    - Deprecated (soon-to-be removed features)
    - Removed (removed features)
    - Fixed (bug fixes)
    - Security (security fixes)
  - Release dates
  - Links to compare versions
```

### 7. LICENSE.md
```yaml
Options:
  - MIT License (most common for open source)
  - Apache 2.0
  - GPL v3
  - Proprietary (custom license)

Include:
  - Full license text
  - Copyright notice
  - Year and copyright holder
```

### 8. SECURITY.md
```yaml
Contents:
  - Security policy overview
  - Supported versions
  - How to report a vulnerability
  - Disclosure policy
  - Security contact email
  - PGP key (if applicable)
  - Bug bounty information (if applicable)
  - Security best practices for users
```

### 9. DEPLOYMENT.md
```yaml
Contents:
  - Deployment architecture overview
  - Prerequisites for production
  - Server requirements
  - Docker deployment guide
  - Cloudflare configuration:
    - DNS setup using Cloudflare API
    - Tunnel creation and management
    - Access policy configuration
    - WAF rules setup
  - Nginx configuration
  - SSL certificate setup (Certbot)
  - Environment variables
  - Database migration in production
  - Monitoring setup
  - Backup configuration
  - Rollback procedures
  - Health checks
```

### 10. TESTING.md
```yaml
Contents:
  - Testing strategy overview
  - Test types:
    - Unit tests (Jest/Vitest)
    - Integration tests
    - E2E tests (Playwright)
    - Performance tests
    - Security tests
  - Running tests locally
  - CI/CD testing
  - Code coverage requirements
  - Test data management
  - Mocking and fixtures
  - Writing new tests
```

### 11. TROUBLESHOOTING.md
```yaml
Contents:
  - Common issues and solutions (by category)
  - Installation problems
  - Database connection issues
  - Authentication errors
  - Performance issues
  - Deployment problems
  - Error code reference
  - Debug mode instructions
  - Log file locations
  - How to get help
```

### 12. CLAUDE.md
```yaml
Contents:
  - Overview of Claude AI usage in project
  - Code generation tasks performed
  - Prompts used for specific features
  - AI-assisted refactoring
  - Documentation generation
  - Test case generation
  - Security review assistance
  - Performance optimization suggestions
  - Best practices learned
```

### 13. CLAUDE_ARCHIVE.md
```yaml
Contents:
  - Historical record of Claude interactions
  - Major features developed with Claude
  - Archived prompts (organized by date)
  - Lessons learned
  - Evolution of AI usage in project
  - Prompt templates for common tasks
```

### 14. Compliance-GDPR.md
```yaml
Contents:
  - GDPR overview and applicability
  - Data subject rights implementation
  - Lawful basis for processing
  - Data protection measures
  - Privacy by design features
  - Data retention policies
  - Breach notification procedures
  - DPO contact information (if applicable)
  - User data export/deletion
  - Cookie policy
  - Compliance checklist
```

### 15. Compliance-ISO27001.md
```yaml
Contents:
  - ISO 27001 overview
  - Applicable controls (14 domains)
  - ISMS (Information Security Management System) scope
  - Risk assessment methodology
  - Statement of Applicability
  - Control implementation status
  - Audit preparation checklist
  - Evidence documentation
  - Non-conformities and corrective actions
```

### 16. Compliance-PCI-DSS.md
```yaml
Contents:
  - PCI-DSS overview and applicability
  - 12 requirements breakdown
  - SAQ (Self-Assessment Questionnaire) type
  - Cardholder data flow
  - Payment gateway integration
  - Tokenization strategy
  - Scope reduction measures
  - Quarterly scan requirements
  - Annual assessment process
  - Compensating controls (if any)
```

### 17. Compliance-SOX.md
```yaml
Contents:
  - SOX overview and applicability
  - Applicable sections (302, 404, 409)
  - IT General Controls (ITGC)
  - Application controls
  - Financial system audit trails
  - Change management process
  - Access control documentation
  - Segregation of duties matrix
  - Testing and evidence
```

### 18. Compliance-Master-Roadmap.md
```yaml
Contents:
  - Overall compliance strategy
  - Timeline for each standard
  - Current compliance status
  - Gap analysis
  - Remediation plans
  - Resource requirements
  - Milestones and deadlines
  - Dependencies between standards
  - Continuous compliance monitoring
  - Annual review schedule
```

### 19. Security-Audit-Plan.md
```yaml
Contents:
  - Audit scope and objectives
  - OWASP Top 10 2021 compliance review
  - Testing methodology
  - Tools and techniques
  - Vulnerability scanning schedule
  - Penetration testing plan
  - Code review process
  - Configuration review
  - Access control audit
  - Reporting and remediation
  - Follow-up procedures
```

### 20. Phase7-Test-Report.md (Template)
```yaml
Contents:
  - Test phase overview
  - Test environment details
  - Test cases executed
  - Results summary (pass/fail statistics)
  - Defects found (by severity)
  - Performance metrics
  - Security findings
  - Recommendations
  - Sign-off section
```

---

## 🎨 UI/UX REQUIREMENTS

### Design System
```yaml
Typography:
  - Primary Font: Inter / SF Pro (system fonts)
  - Monospace Font: JetBrains Mono / Fira Code
  - Font Sizes: 12px, 14px, 16px, 18px, 24px, 32px, 48px

Color Palette:
  Primary: #3B82F6 (blue)
  Success: #10B981 (green)
  Warning: #F59E0B (amber)
  Error: #EF4444 (red)
  Info: #06B6D4 (cyan)
  Neutral: #6B7280 (gray)

Components:
  - Use ShadCN/ui for consistency
  - Custom components in /components/ui
  - Accessibility (WCAG 2.1 AA)
  - Dark mode support

Responsive Breakpoints:
  - Mobile: < 640px
  - Tablet: 640px - 1024px
  - Desktop: > 1024px
```

### User Experience
```yaml
Performance:
  - First Contentful Paint (FCP): < 1.8s
  - Largest Contentful Paint (LCP): < 2.5s
  - Time to Interactive (TTI): < 3.8s
  - Cumulative Layout Shift (CLS): < 0.1

Accessibility:
  - Keyboard navigation
  - Screen reader support
  - ARIA labels
  - Focus indicators
  - Skip navigation links
  - Alt text for images

Error Handling:
  - User-friendly error messages
  - Validation feedback
  - Loading states
  - Empty states
  - Network error handling
```

---

## 🚀 APPLICATION FEATURES & CAPABILITIES

### A. Notification System Architecture

**Multi-Channel Notifications:**
```yaml
Supported Channels:
  1. Email: Transactional and marketing emails (SMTP, SendGrid, AWS SES)
  2. In-App: Real-time notifications via WebSocket
  3. SMS: Text messages via Twilio, AWS SNS
  4. Push Notifications: Mobile (FCM for Android, APNs for iOS)
  5. Webhooks: External system integration

Use Cases:
  - User actions: Registration, password reset, profile updates
  - System events: Backup completed, error occurred
  - Business events: New order, payment received, subscription expiring
  - Scheduled: Daily digest, weekly reports
```

**Notification Preferences:**
```prisma
// schema.prisma
model NotificationPreference {
  id        String   @id @default(uuid())
  userId    String   @map("user_id")
  channel   String   // email, sms, push, in_app
  category  String   // security, updates, marketing, reminders
  enabled   Boolean  @default(true)
  createdAt DateTime @default(now()) @map("created_at")

  user User @relation(fields: [userId], references: [id], onDelete: Cascade)

  @@unique([userId, channel, category])
  @@index([userId])
  @@map("notification_preferences")
}

model Notification {
  id          String    @id @default(uuid())
  userId      String    @map("user_id")
  type        String    // notification type
  channel     String    // email, sms, push, in_app
  title       String
  message     String    @db.Text
  data        Json?     // Additional data
  read        Boolean   @default(false)
  readAt      DateTime? @map("read_at")
  deliveredAt DateTime? @map("delivered_at")
  failedAt    DateTime? @map("failed_at")
  error       String?   @db.Text
  createdAt   DateTime  @default(now()) @map("created_at")

  user User @relation(fields: [userId], references: [id], onDelete: Cascade)

  @@index([userId, createdAt])
  @@index([userId, read])
  @@map("notifications")
}
```

**Notification Queue (Bull):**
```typescript
import Bull from 'bull';
import nodemailer from 'nodemailer';
import twilio from 'twilio';

// Create notification queue
const notificationQueue = new Bull('notifications', process.env.REDIS_URL!);

// Email processor
notificationQueue.process('email', async (job) => {
  const { to, subject, html, attachments } = job.data;

  const transporter = nodemailer.createTransport({
    host: process.env.SMTP_HOST,
    port: parseInt(process.env.SMTP_PORT!),
    secure: true,
    auth: {
      user: process.env.SMTP_USER,
      pass: process.env.SMTP_PASSWORD
    }
  });

  await transporter.sendMail({
    from: process.env.FROM_EMAIL,
    to,
    subject,
    html,
    attachments
  });

  return { delivered: true, to, subject };
});

// SMS processor
notificationQueue.process('sms', async (job) => {
  const { to, message } = job.data;

  const twilioClient = twilio(
    process.env.TWILIO_ACCOUNT_SID,
    process.env.TWILIO_AUTH_TOKEN
  );

  await twilioClient.messages.create({
    body: message,
    from: process.env.TWILIO_PHONE_NUMBER,
    to
  });

  return { delivered: true, to };
});

// In-app notification processor
notificationQueue.process('in-app', async (job) => {
  const { userId, title, message, data } = job.data;

  // Save to database
  const notification = await prisma.notification.create({
    data: {
      userId,
      type: data.type,
      channel: 'in_app',
      title,
      message,
      data,
      deliveredAt: new Date()
    }
  });

  // Send via WebSocket (if user is online)
  const io = getSocketIOInstance();
  io.to(`user:${userId}`).emit('notification', notification);

  return { delivered: true, userId };
});

// Add notifications to queue
export async function sendNotification(channel: string, data: any) {
  await notificationQueue.add(channel, data, {
    attempts: 3,
    backoff: {
      type: 'exponential',
      delay: 2000
    },
    removeOnComplete: true,
    removeOnFail: false
  });
}
```

**Notification Templates:**
```typescript
// Template engine (Handlebars)
import Handlebars from 'handlebars';
import fs from 'fs';

const templates = {
  'welcome-email': fs.readFileSync('./templates/welcome-email.hbs', 'utf-8'),
  'password-reset': fs.readFileSync('./templates/password-reset.hbs', 'utf-8'),
  'invoice-paid': fs.readFileSync('./templates/invoice-paid.hbs', 'utf-8')
};

function renderTemplate(templateName: string, data: any): string {
  const template = Handlebars.compile(templates[templateName]);
  return template(data);
}

// Usage
async function sendWelcomeEmail(user: User) {
  const html = renderTemplate('welcome-email', {
    name: user.name,
    email: user.email,
    loginUrl: `${process.env.APP_URL}/login`
  });

  await sendNotification('email', {
    to: user.email,
    subject: 'Welcome to Our Application!',
    html
  });
}
```

**Delivery Retry Logic:**
```typescript
// Configure job retry
notificationQueue.on('failed', async (job, err) => {
  console.error(`Notification ${job.id} failed:`, err.message);

  // Save failure to database
  if (job.data.notificationId) {
    await prisma.notification.update({
      where: { id: job.data.notificationId },
      data: {
        failedAt: new Date(),
        error: err.message
      }
    });
  }

  // Alert admin after 3 failures
  if (job.attemptsMade >= 3) {
    await alertAdmin(`Notification delivery failed after 3 attempts: ${job.id}`);
  }
});

// Exponential backoff: 2s, 4s, 8s
const retryStrategy = {
  attempts: 3,
  backoff: {
    type: 'exponential',
    delay: 2000
  }
};
```

**Webhook Notifications:**
```typescript
// Send webhook notifications to external systems
async function sendWebhook(url: string, event: string, data: any) {
  const payload = {
    event,
    timestamp: new Date().toISOString(),
    data
  };

  // Generate HMAC signature for security
  const signature = crypto
    .createHmac('sha256', process.env.WEBHOOK_SECRET!)
    .update(JSON.stringify(payload))
    .digest('hex');

  await fetch(url, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-Webhook-Signature': signature
    },
    body: JSON.stringify(payload)
  });
}

// Usage: Notify external CRM when user registers
await sendWebhook(
  'https://crm.company.com/webhooks/user-created',
  'user.created',
  { userId: user.id, email: user.email }
);
```

### B. Internationalization (i18n) System

**Framework Setup:**
```yaml
Backend: i18next 24.x
Frontend: react-i18next 16.x

Supported Locales:
  - en: English (default)
  - es: Spanish
  - fr: French
  - de: German
  - ja: Japanese
  - zh: Chinese (Simplified)
  - ar: Arabic (RTL support)

Features:
  - Dynamic locale switching
  - Namespace organization
  - Pluralization rules
  - Date/time formatting
  - Number/currency formatting
  - RTL (Right-to-Left) layout support
```

**Translation File Structure:**
```
/locales
  /en
    common.json         # Common translations (buttons, labels)
    auth.json           # Authentication flow
    errors.json         # Error messages
    dashboard.json      # Dashboard UI
    emails.json         # Email templates
  /es
    common.json
    auth.json
    errors.json
    dashboard.json
    emails.json
  /fr
    ... (same structure)
```

**i18next Configuration (Backend):**
```typescript
import i18next from 'i18next';
import Backend from 'i18next-fs-backend';
import middleware from 'i18next-http-middleware';

i18next
  .use(Backend)
  .use(middleware.LanguageDetector)
  .init({
    fallbackLng: 'en',
    supportedLngs: ['en', 'es', 'fr', 'de', 'ja', 'zh', 'ar'],
    ns: ['common', 'auth', 'errors', 'dashboard'],
    defaultNS: 'common',
    backend: {
      loadPath: './locales/{{lng}}/{{ns}}.json'
    },
    detection: {
      order: ['querystring', 'cookie', 'header'],
      caches: ['cookie'],
      lookupQuerystring: 'lang',
      lookupCookie: 'i18next',
      lookupHeader: 'accept-language'
    },
    interpolation: {
      escapeValue: false
    }
  });

app.use(middleware.handle(i18next));

// Usage in routes
app.get('/api/welcome', (req, res) => {
  res.json({
    message: req.t('common:welcome', { name: req.user.name })
  });
});
```

**react-i18next Configuration (Frontend):**
```typescript
import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import Backend from 'i18next-http-backend';
import LanguageDetector from 'i18next-browser-languagedetector';

i18n
  .use(Backend)
  .use(LanguageDetector)
  .use(initReactI18next)
  .init({
    fallbackLng: 'en',
    supportedLngs: ['en', 'es', 'fr', 'de', 'ja', 'zh', 'ar'],
    ns: ['common', 'auth', 'errors', 'dashboard'],
    defaultNS: 'common',
    backend: {
      loadPath: '/locales/{{lng}}/{{ns}}.json'
    },
    interpolation: {
      escapeValue: false
    }
  });

// Usage in React components
import { useTranslation } from 'react-i18next';

function WelcomeComponent() {
  const { t, i18n } = useTranslation();

  return (
    <div>
      <h1>{t('common:welcome')}</h1>
      <button onClick={() => i18n.changeLanguage('es')}>
        {t('common:change_language')}
      </button>
    </div>
  );
}
```

**Translation Files Example:**
```json
// locales/en/common.json
{
  "welcome": "Welcome, {{name}}!",
  "login": "Log In",
  "logout": "Log Out",
  "save": "Save",
  "cancel": "Cancel",
  "delete": "Delete",
  "confirm_delete": "Are you sure you want to delete this item?",
  "items_count": "{{count}} item",
  "items_count_plural": "{{count}} items"
}

// locales/es/common.json
{
  "welcome": "¡Bienvenido, {{name}}!",
  "login": "Iniciar Sesión",
  "logout": "Cerrar Sesión",
  "save": "Guardar",
  "cancel": "Cancelar",
  "delete": "Eliminar",
  "confirm_delete": "¿Está seguro de que desea eliminar este elemento?",
  "items_count": "{{count}} elemento",
  "items_count_plural": "{{count}} elementos"
}
```

**RTL (Right-to-Left) Support:**
```typescript
// Detect RTL languages
const rtlLanguages = ['ar', 'he', 'fa', 'ur'];

useEffect(() => {
  const isRTL = rtlLanguages.includes(i18n.language);
  document.documentElement.dir = isRTL ? 'rtl' : 'ltr';
  document.documentElement.lang = i18n.language;
}, [i18n.language]);

// CSS for RTL
// styles.css
html[dir="rtl"] {
  text-align: right;
}

html[dir="rtl"] .margin-left {
  margin-left: 0;
  margin-right: 1rem;
}
```

**Date/Time Formatting:**
```typescript
import { format } from 'date-fns';
import { enUS, es, fr, de, ja, zhCN, ar } from 'date-fns/locale';

const locales = { en: enUS, es, fr, de, ja, zh: zhCN, ar };

function formatDate(date: Date, locale: string) {
  return format(date, 'PPP', { locale: locales[locale] });
}

// Or use Intl API
const dateFormatter = new Intl.DateTimeFormat(i18n.language, {
  year: 'numeric',
  month: 'long',
  day: 'numeric'
});

dateFormatter.format(new Date()); // "February 2, 2026" (en) or "2 de febrero de 2026" (es)
```

**Number & Currency Formatting:**
```typescript
// Number formatting
const numberFormatter = new Intl.NumberFormat(i18n.language);
numberFormatter.format(1234567.89); // "1,234,567.89" (en) or "1.234.567,89" (de)

// Currency formatting
const currencyFormatter = new Intl.NumberFormat(i18n.language, {
  style: 'currency',
  currency: 'USD'
});
currencyFormatter.format(1234.56); // "$1,234.56" (en) or "1.234,56 $" (es)
```

**Translation Workflow:**
```yaml
1. Development:
   - Developers add translation keys in code
   - Extract keys using i18next-parser
   - Generate translation files

2. Translation:
   - Upload translation files to Crowdin/Lokalise
   - Professional translators translate
   - Community contributions (optional)

3. Integration:
   - Download translated files
   - Commit to repository
   - Deploy with application

Tools:
  - Crowdin: Professional translation platform
  - Lokalise: Localization management
  - i18next-parser: Extract translation keys from code
```

### C. Scheduled Tasks & Background Jobs

**Job Scheduling Frameworks:**
```yaml
Simple Schedules:
  - node-cron: 6.x
  - Usage: Simple recurring tasks
  - Syntax: Cron expressions (0 2 * * * = daily at 2 AM)

Complex Workflows:
  - Bull: 4.x (Redis-based queues)
  - Usage: Job queues, retry logic, priorities
  - Features: Progress tracking, job lifecycle events

Advanced Orchestration:
  - Temporal: ~1.28.x (already in tech stack)
  - Usage: Long-running workflows, saga patterns
  - Features: Durable execution, workflow versioning
```

**Common Scheduled Tasks:**
```typescript
import cron from 'node-cron';

// 1. Daily database backup (2 AM)
cron.schedule('0 2 * * *', async () => {
  console.log('Running daily database backup...');
  await backupDatabase();
});

// 2. Hourly usage aggregation
cron.schedule('0 * * * *', async () => {
  console.log('Aggregating hourly usage statistics...');
  await aggregateUsageStatistics();
});

// 3. Weekly report generation (Mondays at 9 AM)
cron.schedule('0 9 * * 1', async () => {
  console.log('Generating weekly reports...');
  await generateWeeklyReports();
});

// 4. Monthly invoice generation (1st of month at midnight)
cron.schedule('0 0 1 * *', async () => {
  console.log('Generating monthly invoices...');
  await generateMonthlyInvoices();
});

// 5. Email digest sending (daily at 8 AM)
cron.schedule('0 8 * * *', async () => {
  console.log('Sending daily email digests...');
  await sendDailyDigests();
});

// 6. Cleanup old logs (daily at 3 AM, retention: 90 days)
cron.schedule('0 3 * * *', async () => {
  console.log('Cleaning up old logs...');
  const cutoffDate = new Date();
  cutoffDate.setDate(cutoffDate.getDate() - 90);

  await prisma.log.deleteMany({
    where: { createdAt: { lt: cutoffDate } }
  });
});

// 7. Session cleanup (hourly)
cron.schedule('0 * * * *', async () => {
  console.log('Cleaning up expired sessions...');
  await redis.scan(0, 'MATCH', 'sess:*', async (keys) => {
    for (const key of keys) {
      const ttl = await redis.ttl(key);
      if (ttl === -1) await redis.del(key); // No expiry set, delete
    }
  });
});
```

**Job Monitoring Dashboard:**
```typescript
// Job status tracking
interface JobStatus {
  id: string;
  name: string;
  status: 'active' | 'completed' | 'failed' | 'delayed';
  progress: number;
  startedAt: Date;
  completedAt?: Date;
  executionTime?: number;
  error?: string;
}

// Get job statistics
app.get('/api/admin/jobs/stats', async (req, res) => {
  const queue = getJobQueue('notifications');

  const [
    activeCount,
    completedCount,
    failedCount,
    delayedCount
  ] = await Promise.all([
    queue.getActiveCount(),
    queue.getCompletedCount(),
    queue.getFailedCount(),
    queue.getDelayedCount()
  ]);

  res.json({
    active: activeCount,
    completed: completedCount,
    failed: failedCount,
    delayed: delayedCount
  });
});

// Get job history
app.get('/api/admin/jobs/history', async (req, res) => {
  const queue = getJobQueue('notifications');
  const jobs = await queue.getJobs(['completed', 'failed'], 0, 100);

  res.json(jobs.map(job => ({
    id: job.id,
    name: job.name,
    status: await job.getState(),
    progress: job.progress(),
    timestamp: job.timestamp,
    finishedOn: job.finishedOn,
    failedReason: job.failedReason
  })));
});
```

**Error Handling & Retries:**
```typescript
import Bull from 'bull';

const jobQueue = new Bull('background-jobs', process.env.REDIS_URL!);

// Configure retry behavior
jobQueue.process('send-report', async (job) => {
  try {
    await sendReport(job.data.userId, job.data.reportType);
    return { success: true };
  } catch (error) {
    // Log error
    console.error(`Job ${job.id} failed:`, error);

    // Throw to trigger retry
    throw error;
  }
});

// Add job with retry configuration
await jobQueue.add('send-report',
  { userId: '123', reportType: 'weekly' },
  {
    attempts: 5,
    backoff: {
      type: 'exponential',
      delay: 1000 // 1s, 2s, 4s, 8s, 16s
    },
    removeOnComplete: true,
    removeOnFail: false
  }
);

// Dead letter queue for persistent failures
jobQueue.on('failed', async (job, err) => {
  if (job.attemptsMade >= job.opts.attempts) {
    // Move to dead letter queue
    const dlq = new Bull('dead-letter-queue', process.env.REDIS_URL!);
    await dlq.add('failed-job', {
      originalJob: job.data,
      error: err.message,
      attempts: job.attemptsMade
    });
  }
});
```

**Job Priority Levels:**
```typescript
enum JobPriority {
  CRITICAL = 1,  // Process immediately
  HIGH = 5,      // Process soon
  NORMAL = 10,   // Default
  LOW = 15       // Process when idle
}

// Add jobs with priority
await jobQueue.add('critical-task', data, { priority: JobPriority.CRITICAL });
await jobQueue.add('low-priority-task', data, { priority: JobPriority.LOW });

// Process high-priority jobs first
jobQueue.process('*', async (job) => {
  console.log(`Processing job ${job.name} with priority ${job.opts.priority}`);
  // Process job
});
```

### D. Customization Framework

**Plugin Architecture:**
```yaml
Plugin System:
  - Discovery: Auto-detect plugins in /plugins directory
  - Lifecycle: install → enable → disable → uninstall
  - API Versioning: v1, v2 (breaking changes)
  - Isolation: Plugins run in separate contexts

Plugin Structure:
  /plugins
    /my-plugin
      package.json       # Plugin metadata
      index.js           # Entry point
      routes.js          # Custom API endpoints
      hooks.js           # Lifecycle hooks
      config.schema.json # Configuration schema
```

**Plugin API:**
```typescript
// Plugin interface
interface Plugin {
  name: string;
  version: string;
  description: string;
  author: string;

  // Lifecycle hooks
  install?: () => Promise<void>;
  enable?: () => Promise<void>;
  disable?: () => Promise<void>;
  uninstall?: () => Promise<void>;

  // API extensions
  routes?: Express.Router;
  middleware?: Express.RequestHandler[];

  // Event hooks
  hooks?: {
    beforeUserCreate?: (user: any) => Promise<any>;
    afterUserCreate?: (user: any) => Promise<void>;
    beforeProjectSave?: (project: any) => Promise<any>;
    afterProjectSave?: (project: any) => Promise<void>;
  };
}

// Plugin loader
class PluginManager {
  private plugins: Map<string, Plugin> = new Map();

  async loadPlugins() {
    const pluginDirs = await fs.readdir('./plugins');

    for (const dir of pluginDirs) {
      const pluginPath = `./plugins/${dir}`;
      const plugin: Plugin = require(`${pluginPath}/index.js`);

      this.plugins.set(plugin.name, plugin);
      console.log(`Loaded plugin: ${plugin.name} v${plugin.version}`);
    }
  }

  async enablePlugin(name: string) {
    const plugin = this.plugins.get(name);
    if (!plugin) throw new Error(`Plugin ${name} not found`);

    if (plugin.enable) await plugin.enable();

    // Register routes
    if (plugin.routes) {
      app.use(`/api/plugins/${name}`, plugin.routes);
    }

    // Register middleware
    if (plugin.middleware) {
      plugin.middleware.forEach(mw => app.use(mw));
    }

    console.log(`Enabled plugin: ${name}`);
  }
}
```

**API Extensibility:**
```typescript
// Allow plugins to add custom API endpoints
const pluginRouter = Express.Router();

pluginRouter.get('/custom-report', async (req, res) => {
  const data = await generateCustomReport(req.query);
  res.json(data);
});

// Event hooks for plugins
class EventEmitter {
  private hooks: Map<string, Function[]> = new Map();

  on(event: string, handler: Function) {
    if (!this.hooks.has(event)) {
      this.hooks.set(event, []);
    }
    this.hooks.get(event)!.push(handler);
  }

  async emit(event: string, ...args: any[]) {
    const handlers = this.hooks.get(event) || [];
    for (const handler of handlers) {
      await handler(...args);
    }
  }
}

const eventBus = new EventEmitter();

// Plugin can subscribe to events
eventBus.on('user.created', async (user) => {
  console.log(`Plugin received user.created event for ${user.email}`);
  // Custom plugin logic
});

// Application emits events
async function createUser(data: any) {
  const user = await prisma.user.create({ data });
  await eventBus.emit('user.created', user);
  return user;
}
```

---

## 🧪 TESTING STRATEGY

### Test Coverage Requirements
```yaml
Unit Tests:
  - Minimum Coverage: 80%
  - Focus: Business logic, utilities, helpers
  - Framework: Jest / Vitest
  - Mocking: Mock external dependencies

Integration Tests:
  - Minimum Coverage: 60%
  - Focus: API endpoints, database operations
  - Framework: Supertest
  - Database: Test database or Docker container

E2E Tests:
  - Critical User Flows: 100%
  - Framework: Playwright 1.57.x
  - Browsers: Chromium, Firefox, WebKit
  - Scenarios:
    - User registration and login
    - Core feature workflows
    - Payment flows (if applicable)
    - Admin operations

Performance Tests:
  - Load testing: JMeter / k6
  - Stress testing
  - Spike testing
  - Endurance testing

Security Tests:
  - OWASP ZAP scanning
  - Dependency vulnerability checks
  - Penetration testing (annual)
  - Code security analysis (SonarQube)
```

---

## 📦 PROJECT STRUCTURE

### Backend Structure
```
backend/
├── src/
│   ├── controllers/       # Request handlers
│   ├── services/          # Business logic
│   ├── models/            # Database models (Prisma)
│   ├── routes/            # API routes
│   ├── middleware/        # Custom middleware
│   ├── utils/             # Utility functions
│   ├── config/            # Configuration
│   ├── validators/        # Input validation (Zod)
│   ├── types/             # TypeScript types
│   └── index.ts           # Entry point
├── prisma/
│   ├── schema.prisma      # Database schema
│   └── migrations/        # Database migrations
├── tests/
│   ├── unit/
│   ├── integration/
│   └── e2e/
├── .env.example
├── .gitignore
├── package.json
├── tsconfig.json
└── Dockerfile
```

### Frontend Structure
```
frontend/
├── src/
│   ├── app/               # Next.js app directory
│   │   ├── (auth)/       # Auth routes
│   │   ├── (dashboard)/  # Dashboard routes
│   │   └── api/          # API routes
│   ├── components/
│   │   ├── ui/           # ShadCN components
│   │   ├── forms/
│   │   ├── layouts/
│   │   └── shared/
│   ├── lib/
│   │   ├── api.ts        # API client
│   │   ├── auth.ts       # Auth utilities
│   │   └── utils.ts      # Utilities
│   ├── hooks/            # Custom React hooks
│   ├── stores/           # Zustand stores
│   ├── types/            # TypeScript types
│   └── styles/           # Global styles
├── public/
│   ├── images/
│   └── fonts/
├── tests/
│   └── e2e/              # Playwright tests
├── .env.example
├── next.config.js
├── tailwind.config.js
├── tsconfig.json
└── package.json
```

---

## 🔧 DEVELOPMENT WORKFLOW

### Git Workflow
```yaml
Branches:
  - main: Production-ready code
  - develop: Integration branch
  - feature/*: New features
  - bugfix/*: Bug fixes
  - hotfix/*: Production hotfixes
  - release/*: Release preparation

Commit Message Format (Conventional Commits):
  - feat: New feature
  - fix: Bug fix
  - docs: Documentation
  - style: Code style (formatting)
  - refactor: Code refactoring
  - test: Tests
  - chore: Maintenance
  - perf: Performance improvements
  - ci: CI/CD changes

Example: "feat(auth): implement MFA with TOTP"

Pull Request Process:
  1. Create feature branch from develop
  2. Make changes and commit
  3. Push to remote
  4. Create PR to develop
  5. Request code review
  6. Address feedback
  7. Pass CI checks
  8. Merge when approved
```

### Code Review Checklist
```yaml
Functionality:
  - [ ] Code works as intended
  - [ ] Edge cases handled
  - [ ] Error handling implemented

Code Quality:
  - [ ] Follows style guide
  - [ ] No code duplication
  - [ ] Proper naming conventions
  - [ ] Comments where necessary
  - [ ] No console.log in production

Security:
  - [ ] Input validation
  - [ ] No hardcoded secrets
  - [ ] Authentication/authorization
  - [ ] SQL injection prevention
  - [ ] XSS prevention

Testing:
  - [ ] Unit tests written
  - [ ] Tests pass
  - [ ] Adequate coverage

Performance:
  - [ ] No N+1 queries
  - [ ] Proper indexing
  - [ ] Efficient algorithms
  - [ ] Resource cleanup

Documentation:
  - [ ] API documented
  - [ ] README updated (if needed)
  - [ ] Comments for complex logic
```

---

## 🚦 ENVIRONMENT VARIABLES TEMPLATE

### Backend (.env)
```env
# Application
NODE_ENV=development
PORT=3000
APP_URL=http://localhost:3000
FRONTEND_URL=http://localhost:3001

# Database
DATABASE_URL=postgresql://user:password@localhost:5432/dbname
DB_POOL_MIN=2
DB_POOL_MAX=10

# Redis
REDIS_URL=redis://localhost:6379
REDIS_PASSWORD=your-redis-password

# JWT
JWT_SECRET=your-super-secret-jwt-key-change-this
JWT_EXPIRY=30m
JWT_REFRESH_EXPIRY=7d

# Session
SESSION_SECRET=your-session-secret
SESSION_TIMEOUT=1800000

# Bcrypt
BCRYPT_ROUNDS=12

# Rate Limiting
RATE_LIMIT_WINDOW_MS=900000
RATE_LIMIT_MAX_REQUESTS=100

# File Upload
MAX_FILE_SIZE=5242880
ALLOWED_FILE_TYPES=.pdf,.jpg,.jpeg,.png
MAX_FILES_PER_UPLOAD=5

# MinIO / S3
MINIO_ENDPOINT=http://localhost:9000
MINIO_PORT=9000
MINIO_ACCESS_KEY=minioadmin
MINIO_SECRET_KEY=minioadmin
MINIO_BUCKET=uploads
MINIO_USE_SSL=false

# Email (SMTP)
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_SECURE=false
SMTP_USER=your-email@gmail.com
SMTP_PASS=your-app-password
EMAIL_FROM=noreply@yourapp.com

# Email (IMAP for Email-to-Ticket)
IMAP_HOST=imap.gmail.com
IMAP_PORT=993
IMAP_USER=support@yourapp.com
IMAP_PASS=your-app-password
IMAP_TLS=true

# OAuth (if applicable)
GOOGLE_CLIENT_ID=your-google-client-id
GOOGLE_CLIENT_SECRET=your-google-client-secret
GITHUB_CLIENT_ID=your-github-client-id
GITHUB_CLIENT_SECRET=your-github-client-secret

# Cloudflare
CLOUDFLARE_API_KEY=your-cloudflare-api-key
CLOUDFLARE_ACCOUNT_ID=your-account-id
CLOUDFLARE_ZONE_ID=your-zone-id

# Monitoring
SENTRY_DSN=your-sentry-dsn
LOG_LEVEL=info

# Feature Flags
ENABLE_MFA=true
ENABLE_EMAIL_TO_TICKET=true
ENABLE_SLA=true
ENABLE_SURVEYS=true

# Temporal
TEMPORAL_ADDRESS=localhost:7233
TEMPORAL_NAMESPACE=default

# RabbitMQ
RABBITMQ_URL=amqp://guest:guest@localhost:5672

# HashiCorp Vault
VAULT_ADDR=http://localhost:8200
VAULT_TOKEN=your-vault-token

# LDAP/Active Directory Integration
LDAP_ENABLED=false
LDAP_URL=ldap://ad.company.com:389
LDAP_BIND_DN=CN=AppService,OU=Services,DC=company,DC=com
LDAP_BIND_PASSWORD=your-ldap-bind-password
LDAP_SEARCH_BASE=DC=company,DC=com
LDAP_SEARCH_FILTER=(sAMAccountName={{username}})
LDAP_GROUP_SEARCH_BASE=OU=Groups,DC=company,DC=com
LDAP_USER_SEARCH_BASE=OU=Users,DC=company,DC=com
LDAP_SYNC_INTERVAL=3600000

# SAML 2.0 Integration
SAML_ENABLED=false
SAML_ISSUER=https://app.company.com
SAML_ENTRY_POINT=https://idp.company.com/saml2/sso
SAML_CALLBACK_URL=https://app.company.com/auth/saml/callback
SAML_LOGOUT_URL=https://idp.company.com/saml2/logout
SAML_LOGOUT_CALLBACK_URL=https://app.company.com/auth/saml/logout/callback
SAML_CERT_PATH=/path/to/idp-cert.pem
SAML_PRIVATE_KEY_PATH=/path/to/sp-private-key.pem
SAML_WANT_ASSERTIONS_SIGNED=true
SAML_WANT_RESPONSE_SIGNED=true
SAML_SIGNATURE_ALGORITHM=sha256

# Multi-Tenancy Configuration
TENANCY_MODEL=shared_table
TENANT_IDENTIFICATION=subdomain
DEFAULT_TENANT_PLAN=free
ENABLE_TENANT_SIGNUP=true
TENANT_SUBDOMAIN_PATTERN=^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$
TENANT_USAGE_TRACKING=true
TENANT_BILLING_ENABLED=false

# Internationalization (i18n)
DEFAULT_LOCALE=en
SUPPORTED_LOCALES=en,es,fr,de,ja,zh,ar
FALLBACK_LOCALE=en
ENABLE_RTL_SUPPORT=true
TRANSLATION_CACHE_TTL=3600000
AUTO_DETECT_LOCALE=true

# Notification System
ENABLE_EMAIL_NOTIFICATIONS=true
ENABLE_IN_APP_NOTIFICATIONS=true
ENABLE_SMS_NOTIFICATIONS=false
ENABLE_PUSH_NOTIFICATIONS=false
ENABLE_WEBHOOK_NOTIFICATIONS=false

# SMS Notifications (Twilio)
TWILIO_ACCOUNT_SID=your-twilio-account-sid
TWILIO_AUTH_TOKEN=your-twilio-auth-token
TWILIO_PHONE_NUMBER=+1234567890
TWILIO_VERIFY_SERVICE_SID=your-verify-service-sid

# Push Notifications (Firebase Cloud Messaging)
FCM_SERVER_KEY=your-fcm-server-key
FCM_SENDER_ID=your-fcm-sender-id
APNS_KEY_ID=your-apns-key-id
APNS_TEAM_ID=your-apns-team-id
APNS_BUNDLE_ID=com.yourapp.mobile

# Webhook Notifications
WEBHOOK_RETRY_ATTEMPTS=3
WEBHOOK_TIMEOUT_MS=5000
WEBHOOK_SIGNATURE_SECRET=your-webhook-signature-secret

# Scheduled Jobs & Background Tasks
ENABLE_SCHEDULED_JOBS=true
BACKUP_SCHEDULE=0 2 * * *
USAGE_AGGREGATION_SCHEDULE=0 * * * *
REPORT_GENERATION_SCHEDULE=0 8 * * 1
CLEANUP_SCHEDULE=0 3 * * *
LOG_RETENTION_DAYS=90
INVOICE_GENERATION_SCHEDULE=0 9 1 * *

# Job Queue Configuration
QUEUE_CONCURRENCY=5
QUEUE_MAX_RETRIES=5
QUEUE_RETRY_DELAY=60000
QUEUE_BACKOFF_TYPE=exponential
ENABLE_JOB_DASHBOARD=true

# Performance & Scalability
ENABLE_CACHING=true
CACHE_TTL=300
ENABLE_QUERY_CACHING=true
CONNECTION_POOL_SIZE=50
MAX_CONCURRENT_REQUESTS=1000
ENABLE_COMPRESSION=true
COMPRESSION_THRESHOLD=1024

# Load Balancing
LOAD_BALANCER_ALGORITHM=round_robin
HEALTH_CHECK_INTERVAL=30000
HEALTH_CHECK_TIMEOUT=5000
ENABLE_STICKY_SESSIONS=false
SESSION_AFFINITY_COOKIE=SERVERID

# Zero-Downtime Deployment
DEPLOYMENT_STRATEGY=blue_green
CANARY_ROLLOUT_PERCENTAGE=5
FEATURE_FLAG_REFRESH_INTERVAL=60000
GRACEFUL_SHUTDOWN_TIMEOUT=30000
CONNECTION_DRAIN_TIMEOUT=10000

# Security Operations
VULNERABILITY_SCAN_SCHEDULE=0 4 * * *
ENABLE_AUTO_PATCHING=false
PATCH_APPROVAL_REQUIRED=true
SECURITY_ALERT_EMAIL=security@yourapp.com
ENABLE_SECURITY_HEADERS=true
CSP_REPORT_URI=/api/csp-report

# Compliance & Audit
ENABLE_AUDIT_LOGGING=true
AUDIT_LOG_RETENTION_DAYS=365
PII_ENCRYPTION_ENABLED=true
DATA_RETENTION_DAYS=2555
ENABLE_GDPR_MODE=true
GDPR_DPO_EMAIL=dpo@yourapp.com

# OpenTelemetry (Distributed Tracing & Observability)
OTEL_SERVICE_NAME=your-app-name
OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4318/v1/traces
OTEL_EXPORTER_OTLP_METRICS_ENDPOINT=http://localhost:4318/v1/metrics
OTEL_EXPORTER_TOKEN=
OTEL_TRACES_SAMPLER=parentbased_traceidratio
OTEL_TRACES_SAMPLER_ARG=0.1
OTEL_LOG_LEVEL=info
APP_VERSION=1.0.0
```

---

## 📊 SUCCESS METRICS & KPIs

### Technical Metrics
```yaml
Performance:
  - API Response Time: < 200ms (p95)
  - Database Query Time: < 50ms (p95)
  - Page Load Time: < 3s
  - Uptime: > 99.9%

Security:
  - Zero high-severity vulnerabilities
  - Security scan frequency: Weekly
  - Incident response time: < 1 hour
  - Patch deployment time: < 24 hours

Quality:
  - Code Coverage: > 80%
  - Bug Escape Rate: < 5%
  - Technical Debt Ratio: < 10%
  - Code Review Coverage: 100%

Deployment:
  - Deployment Frequency: Daily
  - Lead Time for Changes: < 1 day
  - Mean Time to Recovery (MTTR): < 1 hour
  - Change Failure Rate: < 5%
```

### Business Metrics
```yaml
User Engagement:
  - Daily Active Users (DAU)
  - Monthly Active Users (MAU)
  - User Retention Rate
  - Session Duration

Operations:
  - Support Ticket Volume
  - Average Resolution Time
  - First Response Time
  - Customer Satisfaction (CSAT)

Growth:
  - User Sign-ups
  - Feature Adoption Rate
  - Churn Rate
  - Net Promoter Score (NPS)
```

---

## 🎯 PROMPT USAGE INSTRUCTIONS

### How to Use This Prompt

1. **For New Projects:**
   ```
   Copy sections relevant to your project type (web/mobile)
   Customize technology choices based on requirements
   Adjust security/compliance based on industry
   Modify file structure as needed
   ```

2. **Provide to Claude:**
   ```
   "Using the Universal Project Prompt, create a [web/mobile] application with:
   - [List key features]
   - [Compliance requirements]
   - [Special considerations]
   
   Generate the full project structure, documentation, and implementation plan."
   ```

3. **Iterative Development:**
   ```
   "Based on the Universal Project Prompt, implement [specific feature]
   following the security guidelines and architecture patterns."
   ```

4. **Documentation Generation:**
   ```
   "Using the documentation templates in the Universal Project Prompt,
   generate [specific .md file] for my project which [brief description]."
   ```

### Customization Points
```yaml
Always Customize:
  - Project name and description
  - Domain and URLs
  - Company/organization name
  - Contact information
  - Specific feature requirements
  - Compliance requirements (select applicable)
  - Technology choices (from provided versions)

Optional Customization:
  - Rate limiting values
  - File upload restrictions
  - Session timeout values
  - Backup retention periods
  - Role names and permissions
  - UI color scheme
```

---

## 📞 SUPPORT & RESOURCES

### Official Documentation Links
```yaml
Technologies:
  - Next.js: https://nextjs.org/docs
  - Prisma: https://www.prisma.io/docs
  - TanStack Query: https://tanstack.com/query/latest
  - ShadCN/ui: https://ui.shadcn.com
  - Playwright: https://playwright.dev

Security & Compliance:
  - OWASP: https://owasp.org/www-project-top-ten/
  - GDPR: https://gdpr.eu
  - PCI-DSS: https://www.pcisecuritystandards.org
  - ISO 27001: https://www.iso.org/isoiec-27001-information-security.html
  - NIST CSF: https://www.nist.gov/cyberframework

Cloud Platforms:
  - Cloudflare: https://developers.cloudflare.com
  - Docker: https://docs.docker.com
  - MinIO: https://min.io/docs/minio/linux/index.html
```

---

## ✅ PRE-LAUNCH CHECKLIST

### Security Review
- [ ] All OWASP Top 10 2021 controls implemented
- [ ] Security headers configured (15+ via Helmet.js)
- [ ] Rate limiting on all endpoints
- [ ] Input validation everywhere
- [ ] Secrets in environment variables (not code)
- [ ] SSL/TLS configured (minimum TLS 1.3)
- [ ] CORS properly configured
- [ ] CSP policy active with reporting
- [ ] No exposed API keys or tokens
- [ ] Database parameterized queries only
- [ ] File upload security implemented
- [ ] Account lockout working
- [ ] Session management secure
- [ ] Audit logging comprehensive
- [ ] Security scan completed (no high-severity issues)

### Performance Review
- [ ] Database indexes optimized
- [ ] N+1 queries eliminated
- [ ] Caching strategy implemented
- [ ] CDN configured for static assets
- [ ] Image optimization
- [ ] Code splitting implemented
- [ ] Lazy loading where appropriate
- [ ] Performance metrics monitored
- [ ] Load testing completed

### Compliance Review
- [ ] Privacy policy published
- [ ] Terms of service published
- [ ] Cookie consent (GDPR)
- [ ] Data retention policies defined
- [ ] Backup strategy tested
- [ ] Incident response plan documented
- [ ] Applicable compliance documentation complete
- [ ] Audit trails functioning

### DevOps Review
- [ ] CI/CD pipeline functional
- [ ] Automated testing in pipeline
- [ ] Deployment automation tested
- [ ] Rollback procedure tested
- [ ] Monitoring and alerting configured
- [ ] Log aggregation working
- [ ] Backup automation tested
- [ ] Health checks configured
- [ ] Auto-scaling configured (if applicable)

### Documentation Review
- [ ] README.md complete
- [ ] API documentation complete
- [ ] Installation guide tested
- [ ] Deployment guide verified
- [ ] Troubleshooting guide populated
- [ ] Contributing guide published
- [ ] All compliance docs finalized
- [ ] Change log up to date

### User Experience Review
- [ ] Mobile responsive
- [ ] Accessibility tested (WCAG 2.1 AA)
- [ ] Browser compatibility verified
- [ ] Error messages user-friendly
- [ ] Loading states implemented
- [ ] Empty states designed
- [ ] Success feedback clear
- [ ] Help documentation available

---

## 🎓 BEST PRACTICES SUMMARY

### Code Quality
1. **Follow SOLID principles**
2. **Write self-documenting code**
3. **Keep functions small and focused**
4. **Use meaningful variable names**
5. **Avoid premature optimization**
6. **Write tests first (TDD when appropriate)**
7. **Refactor regularly**
8. **Document complex logic**

### Security
1. **Never trust user input**
2. **Validate on server side always**
3. **Use parameterized queries**
4. **Keep dependencies updated**
5. **Follow principle of least privilege**
6. **Fail securely**
7. **Log security events**
8. **Regular security reviews**

### Performance
1. **Optimize database queries**
2. **Use caching strategically**
3. **Implement pagination**
4. **Lazy load resources**
5. **Monitor performance metrics**
6. **Profile before optimizing**
7. **Use CDN for static assets**
8. **Compress responses**

### Deployment
1. **Automate everything**
2. **Use environment variables**
3. **Implement health checks**
4. **Test rollback procedures**
5. **Monitor production actively**
6. **Have incident response plan**
7. **Regular backups**
8. **Document runbooks**

---

## 📅 MAINTENANCE SCHEDULE

### Daily
- [ ] Monitor error logs
- [ ] Check system health dashboard
- [ ] Review security alerts
- [ ] Verify backups completed

### Weekly
- [ ] Dependency security scan
- [ ] Performance review
- [ ] Database maintenance
- [ ] Review support tickets

### Monthly
- [ ] Dependency updates
- [ ] Security patch review
- [ ] Performance optimization
- [ ] Capacity planning
- [ ] Access control review

### Quarterly
- [ ] Comprehensive security audit
- [ ] Disaster recovery drill
- [ ] Compliance review
- [ ] Architecture review
- [ ] Third-party audit (if required)

### Annually
- [ ] Penetration testing
- [ ] Full compliance audit
- [ ] Technology stack review
- [ ] Disaster recovery plan update
- [ ] Security policy review

---

## 🔄 VERSION HISTORY

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | Feb 01, 2026 | Initial universal prompt creation |
| 1.1 | TBD | Updates based on technology version changes |

---

## 📄 LICENSE

This prompt template is provided as-is for project development purposes. Customize as needed for your specific requirements.

---

**End of Universal Project Prompt v2.0**

*This prompt synthesizes best practices from enterprise security, compliance frameworks, modern development workflows, and real-world application architecture. Use it as a comprehensive guide for building production-ready web and mobile applications.*
