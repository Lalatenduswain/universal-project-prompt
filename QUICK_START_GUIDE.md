# 🚀 QUICK START GUIDE
## Using the Universal Project Prompt

### 📋 3-Step Quick Start

#### Step 1: Choose Your Stack
```
Select application type:
├── Web Application (Full Stack)
│   ├── Frontend: Next.js + ShadCN + Tailwind
│   ├── Backend: Node.js + Express + Prisma
│   └── Database: PostgreSQL + Redis
│
├── Mobile Application (React Native)
│   ├── Cross-platform: React Native
│   ├── iOS Native: Swift + SwiftUI
│   └── Android Native: Kotlin + Jetpack Compose
│
└── Hybrid (Web + Mobile)
    └── Shared Backend API + Multiple Frontends
```

#### Step 2: Define Requirements
```yaml
Project Basics:
  - Name: [Your App Name]
  - Type: [Web / Mobile / Both]
  - Industry: [Healthcare / Finance / E-commerce / SaaS / etc.]

Core Features:
  - Authentication: Yes/No
  - File Uploads: Yes/No
  - Real-time: Yes/No
  - Payments: Yes/No
  - Admin Dashboard: Yes/No

Compliance Needs:
  - GDPR: Yes/No
  - PCI-DSS: Yes/No
  - ISO 27001: Yes/No
  - SOC 2: Yes/No
  - HIPAA: Yes/No
```

#### Step 3: Generate with Claude
```
"Using the Universal Project Prompt, create a [TYPE] application:

Project Name: [NAME]
Description: [BRIEF DESCRIPTION]

Features:
- [Feature 1]
- [Feature 2]
- [Feature 3]

Compliance: [GDPR, PCI-DSS, etc.]

Please generate:
1. Complete project structure
2. All documentation files (README, API, SECURITY, etc.)
3. Implementation with OWASP Top 10 2021 security
4. Deployment configuration for Cloudflare + Docker + Nginx"
```

---

## 🎯 Common Use Cases

### Use Case 1: Multi-Tenant SaaS Web Application
```
"Create a multi-tenant SaaS application using the Universal Project Prompt:

Stack: Next.js 16.x + Express 5.x + PostgreSQL 18.1 + Redis 8.x

Multi-Tenancy:
- Isolation: Shared table with tenant_id (Row-Level Security)
- Identification: Subdomain-based (acme.myapp.com)
- Customization: Per-tenant themes, features, workflows
- Billing: Stripe subscription + usage-based metering

Features:
- User authentication with JWT + SSO (SAML, LDAP optional)
- RBAC (Super Admin, Tenant Admin, Manager, User)
- Subscription management with tiered plans (Free, Pro, Enterprise)
- File uploads with per-tenant storage limits
- Multi-channel notifications (Email, In-app, SMS)
- Admin dashboard with usage analytics
- API with per-tenant rate limiting
- Internationalization (7 locales)

Security: OWASP Top 10 2021 compliant, JWT auth, bcrypt passwords,
         tenant isolation, cross-tenant access prevention
Compliance: GDPR, SOC 2, ISO 27001
Deployment: Docker + Cloudflare + Nginx, horizontal scaling ready

Generate:
1. Complete codebase structure
2. All 28 documentation files
3. Multi-tenant database schema
4. Tenant provisioning workflow
5. Usage tracking & billing integration"
```

### Use Case 2: Mobile Banking App
```
"Create a secure mobile banking application:

Stack: React Native + Express 5.x + PostgreSQL 18.1
Features: User authentication with MFA, account management, 
         transaction history, biometric login, push notifications
Security: OWASP Mobile Top 10, certificate pinning, jailbreak detection
Compliance: PCI-DSS, SOC 2, GDPR
Platform: iOS + Android

Generate security-focused architecture and compliance docs."
```

### Use Case 3: E-commerce Platform
```
"Build an e-commerce platform:

Stack: Next.js 16.x + Express 5.x + PostgreSQL 18.1 + MinIO
Features: Product catalog, shopping cart, payment integration (Stripe),
         order management, inventory tracking, admin dashboard
Security: PCI-DSS compliant (tokenization), OWASP Top 10
Compliance: GDPR, PCI-DSS
Deployment: Cloudflare Workers + Docker

Focus on payment security and scalability."
```

### Use Case 4: Healthcare Portal
```
"Create a healthcare patient portal:

Stack: Next.js 16.x + Express 5.x + PostgreSQL 18.1
Features: Patient records, appointment scheduling, secure messaging,
         document upload (medical records), telehealth integration
Security: End-to-end encryption, OWASP Top 10, audit logging
Compliance: HIPAA, GDPR, ISO 27001
Deployment: Self-hosted Docker (compliance requirements)

Generate HIPAA compliance documentation and security controls."
```

---

## 🔧 Customization Templates

### Template 1: Feature-Rich Web App
```markdown
Project: [NAME]
Type: Web Application

Technology Stack:
- Frontend: Next.js 16.x, ShadCN/ui, Tailwind CSS 4.1.x
- Backend: Node.js 24.x LTS, Express 5.x
- Database: PostgreSQL 18.1 with Prisma 6.x
- Cache: Redis 8.x
- Storage: MinIO (S3-compatible)
- Queue: RabbitMQ 4.2.x

Core Features:
✅ User Authentication (JWT + bcrypt)
✅ Role-Based Access Control (Admin, Agent, User)
✅ Real-time Updates (WebSocket)
✅ File Upload (5MB limit, virus scanning)
✅ Admin Dashboard (analytics, user management)
✅ API Documentation (OpenAPI/Swagger)
✅ Email Notifications (SMTP)
✅ Audit Logging

Security (OWASP Top 10 2021):
✅ Account lockout (5 attempts = 30 min lock)
✅ Rate limiting (multi-tier)
✅ CSP + 15+ security headers
✅ Input validation (Zod)
✅ SQL injection prevention (Prisma ORM)
✅ XSS prevention (sanitization)
✅ CSRF protection

Compliance:
✅ GDPR (data export, right to erasure)
✅ ISO 27001 (audit-ready)
✅ SOC 2 (security controls)

Deployment:
✅ Docker 29.x containers
✅ Nginx 1.29.x reverse proxy
✅ Cloudflare (DNS, WAF, Tunnels)
✅ SSL/TLS (Certbot 5.2.x)
✅ CI/CD (Jenkins 2.546+)
✅ Auto-restart after reboot

Generate complete project with all 20 documentation files.
```

### Template 2: Mobile App (iOS + Android)
```markdown
Project: [NAME]
Type: Mobile Application (Cross-platform)

Technology Stack:
- Framework: React Native (Latest)
- Backend: Express 5.x + PostgreSQL 18.1
- State: Zustand 5.x
- API: TanStack Query 5.90.x+
- Forms: react-hook-form 7.71.x
- Navigation: React Navigation
- Push: FCM + APNs

Features:
✅ User Authentication (OAuth2 + JWT)
✅ Biometric Login (Touch ID / Face ID / Fingerprint)
✅ Offline Mode (local storage + sync)
✅ Push Notifications
✅ File Upload (camera + gallery)
✅ Real-time Chat
✅ Deep Linking

Security:
✅ Certificate Pinning
✅ Jailbreak/Root Detection
✅ Keychain/Keystore for secrets
✅ Encrypted local storage
✅ OWASP Mobile Top 10 compliant

Compliance:
✅ GDPR
✅ App Store Requirements
✅ Play Store Requirements

Platforms:
✅ iOS (Swift interop if needed)
✅ Android (Kotlin interop if needed)

Generate mobile-specific architecture and store submission guides.
```

### Template 3: Minimal API Backend
```markdown
Project: [NAME] API
Type: Backend API Only

Technology Stack:
- Runtime: Node.js 24.x LTS
- Framework: Express 5.x
- Database: PostgreSQL 18.1 + Prisma 6.x
- Cache: Redis 8.x
- Validation: Zod 4.3.x

Features:
✅ RESTful API
✅ JWT Authentication
✅ API Key Management
✅ Rate Limiting
✅ Request Validation
✅ Error Handling
✅ Logging
✅ OpenAPI Documentation

Security:
✅ OWASP API Security Top 10
✅ Input validation
✅ SQL injection prevention
✅ Rate limiting
✅ CORS configuration

Documentation Needed:
- API.md (comprehensive)
- README.md
- INSTALLATION.md
- DEPLOYMENT.md
- SECURITY.md
- TESTING.md

Skip frontend-specific docs.
```

---

## 📝 Documentation Generation Commands

### Generate All Documentation
```
"Using the Universal Project Prompt, generate all 28 documentation files
for my [TYPE] project: [BRIEF DESCRIPTION]

Core Documentation:
1. README.md
2. TODO.md
3. INSTALLATION.md
4. API.md
5. CONTRIBUTING.md
6. CHANGELOG.md
7. LICENSE.md
8. SECURITY.md
9. DEPLOYMENT.md
10. TESTING.md
11. TROUBLESHOOTING.md
12. CLAUDE.md
13. CLAUDE_ARCHIVE.md

Enterprise Features:
14. MULTI_TENANCY.md
15. UPGRADE_GUIDE.md
16. AUTHENTICATION_PROVIDERS.md (LDAP, SAML)
17. NOTIFICATIONS.md
18. INTERNATIONALIZATION.md
19. SCHEDULED_JOBS.md
20. PERFORMANCE_OPTIMIZATION.md

Compliance:
21. Compliance-GDPR.md
22. Compliance-ISO27001.md
23. Compliance-PCI-DSS.md
24. Compliance-SOC2.md
25. Compliance-SOX.md
26. Compliance-NIST.md
27. Compliance-Master-Roadmap.md

Security:
28. Security-Audit-Plan.md

Use latest tech versions (as of Feb 2026) and include real examples."
```

### Generate Specific Documentation
```
# Just Security Docs
"Generate SECURITY.md and Security-Audit-Plan.md for my project 
following OWASP Top 10 2021 guidelines"

# Just Compliance Docs
"Generate all Compliance-*.md files for GDPR + PCI-DSS requirements"

# Just Deployment Docs
"Generate DEPLOYMENT.md with Cloudflare + Docker + Nginx configuration"

# Just API Docs
"Generate API.md with comprehensive endpoint documentation, 
authentication, and code examples in JavaScript and cURL"
```

---

## 🔐 Security Configuration Quick Reference

### Essential Security Checklist
```yaml
Copy this for every project:

Authentication:
  - [ ] JWT with 30-min expiry
  - [ ] Refresh token mechanism
  - [ ] httpOnly cookies
  - [ ] bcrypt 12 rounds
  - [ ] Account lockout (5 attempts)

Authorization:
  - [ ] RBAC implemented
  - [ ] Permission matrix defined
  - [ ] Least privilege principle

Rate Limiting:
  - [ ] Auth endpoints: 5/15min
  - [ ] General API: 100/15min
  - [ ] File upload: 10/hour

Headers (via Helmet.js):
  - [ ] HSTS (1 year)
  - [ ] X-Frame-Options: DENY
  - [ ] X-Content-Type-Options: nosniff
  - [ ] CSP configured
  - [ ] Referrer-Policy

Input Validation:
  - [ ] Zod schemas for all inputs
  - [ ] Server-side validation
  - [ ] Sanitization

Database:
  - [ ] Prisma ORM (parameterized)
  - [ ] No raw SQL
  - [ ] Proper indexes

File Upload:
  - [ ] MIME validation
  - [ ] Size limit: 5MB
  - [ ] Extension whitelist
  - [ ] Virus scanning ready

Logging:
  - [ ] All auth events
  - [ ] Failed attempts
  - [ ] Security events
  - [ ] Audit trail
```

---

## 🎨 Frontend Quick Setup

### ShadCN/ui + Tailwind CSS 4.1.x
```bash
# 1. Initialize Next.js 16.x
npx create-next-app@latest my-app --typescript --tailwind --app

# 2. Install ShadCN/ui
npx shadcn@latest init

# 3. Add components
npx shadcn@latest add button
npx shadcn@latest add card
npx shadcn@latest add form
npx shadcn@latest add input
npx shadcn@latest add table
npx shadcn@latest add dialog

# 4. Install additional dependencies
npm install @tanstack/react-query@5.90.19
npm install zustand@5.0.1
npm install react-hook-form@7.71.0
npm install zod@4.3.0
npm install framer-motion@12.27.0
npm install recharts@3.6.0
```

---

## 🗄️ Backend Quick Setup

### Express + Prisma + PostgreSQL
```bash
# 1. Initialize Node.js project
npm init -y

# 2. Install dependencies
npm install express@5.0.0
npm install @prisma/client@6.0.0
npm install bcrypt@5.1.0
npm install jsonwebtoken
npm install ioredis@5.4.1
npm install zod@4.3.0
npm install helmet
npm install cors
npm install express-rate-limit

# 3. Install dev dependencies
npm install -D typescript @types/node @types/express
npm install -D ts-node nodemon
npm install -D prisma@6.0.0

# 4. Initialize Prisma
npx prisma init

# 5. Initialize TypeScript
npx tsc --init
```

---

## 🐳 Docker Quick Start

### docker-compose.yml Template
```yaml
version: '3.8'

services:
  # PostgreSQL 18.1
  postgres:
    image: postgres:18.1-alpine
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: admin
      POSTGRES_PASSWORD: changeme
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

  # Redis 8.x
  redis:
    image: redis:8-alpine
    command: redis-server --requirepass changeme
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data

  # MinIO
  minio:
    image: minio/minio:latest
    command: server /data --console-address ":9001"
    environment:
      MINIO_ROOT_USER: minioadmin
      MINIO_ROOT_PASSWORD: minioadmin
    ports:
      - "9000:9000"
      - "9001:9001"
    volumes:
      - minio_data:/data

volumes:
  postgres_data:
  redis_data:
  minio_data:
```

---

## 📊 Monitoring Setup Quick Guide

### Essential Endpoints to Create
```typescript
// Health Check
GET /health
Response: { status: 'ok', timestamp: '2026-02-01T...' }

// API Metrics
GET /api/metrics
Response: { requests: 1000, avgTime: 150, errors: 5 }

// Security Dashboard
GET /api/security/overview
Response: { activeSessions: 50, lockedAccounts: 2, suspiciousIPs: 5 }

// System Stats
GET /api/system/stats
Response: { cpu: 45, memory: 60, uptime: 86400 }
```

---

## ✅ Pre-Launch Checklist (Condensed)

```
Security:
  ✅ OWASP Top 10 controls
  ✅ Rate limiting active
  ✅ SSL/TLS configured
  ✅ Secrets in env vars
  ✅ Security scan passed

Performance:
  ✅ Load testing done
  ✅ Caching configured
  ✅ Database optimized
  ✅ CDN setup

Compliance:
  ✅ Privacy policy
  ✅ Terms of service
  ✅ Cookie consent
  ✅ Audit logging

DevOps:
  ✅ CI/CD working
  ✅ Backups automated
  ✅ Monitoring active
  ✅ Rollback tested

Documentation:
  ✅ README complete
  ✅ API documented
  ✅ Deployment guide
  ✅ Troubleshooting guide
```

---

## 🎓 Best Practices Reminder

**Always:**
- ✅ Validate all inputs (server-side)
- ✅ Use parameterized queries
- ✅ Keep dependencies updated
- ✅ Log security events
- ✅ Test before deploy
- ✅ Use environment variables
- ✅ Implement rate limiting
- ✅ Enable HTTPS/TLS

**Never:**
- ❌ Trust user input
- ❌ Hardcode secrets
- ❌ Use raw SQL
- ❌ Expose stack traces
- ❌ Skip authentication
- ❌ Ignore security warnings
- ❌ Deploy without testing
- ❌ Store passwords in plain text

---

## 🔧 Installation Quick Start

### Option 1: Automated Installation (Recommended)
```bash
# Clone the generated project
cd your-project

# Run automated setup
./scripts/check-prerequisites.sh
./scripts/setup-dev.sh

# Verify installation
npm run verify
```

### Option 2: Manual Installation
```bash
# Install dependencies
npm install

# Create .env file
cp .env.example .env
# Edit .env with your values

# Setup database
createdb your_app_dev
npx prisma migrate dev --name init
npx prisma generate

# Start development server
npm run dev
```

### Prerequisite Checklist
```yaml
System Requirements:
  - CPU: 4+ cores
  - RAM: 8GB+
  - Disk: 50GB+ SSD

Required Software:
  - Node.js 24.x or 25.x
  - PostgreSQL 18.1+
  - Redis 8.x+
  - Docker 29.x+ (optional but recommended)

Port Availability:
  - 3000 (application)
  - 5432 (PostgreSQL)
  - 6379 (Redis)
```

---

## 🏢 Multi-Tenancy Decision Matrix

### Choose Your Isolation Strategy

**Shared Table (tenant_id column)**
```yaml
Best For:
  - < 500 tenants
  - Tenants of similar size
  - SaaS with standard features
  - Cost-sensitive deployments

Pros:
  - Lowest cost
  - Simple deployment
  - Efficient resource usage
  - Easy cross-tenant analytics

Cons:
  - Limited isolation
  - Noisy neighbor risk
  - Harder compliance (some regulations)

Implementation Complexity: Low
Monthly Cost: $50-200 (single database)
```

**Separate Schema (tenant_001, tenant_002)**
```yaml
Best For:
  - 50-1000 tenants
  - Regulatory requirements
  - B2B SaaS with custom needs
  - Medium tenant isolation

Pros:
  - Better isolation
  - Schema-level permissions
  - Easier backup/restore per tenant
  - Simpler migrations than separate DB

Cons:
  - Schema proliferation (max ~1000-2000)
  - Complex schema switching
  - Catalog bloat

Implementation Complexity: Medium
Monthly Cost: $200-500 (single database, multiple schemas)
```

**Separate Database (dedicated instance)**
```yaml
Best For:
  - Enterprise customers (>$10k MRR)
  - Strict compliance (HIPAA, PCI-DSS Level 1)
  - High-value customers
  - Geographic data residency

Pros:
  - Complete physical isolation
  - Per-tenant performance tuning
  - Compliance-ready
  - Custom backup schedules

Cons:
  - Highest cost
  - Management overhead
  - Difficult cross-tenant analytics

Implementation Complexity: High
Monthly Cost: $50-500 per tenant
```

### Quick Start: Multi-Tenant SaaS
```
"Create a multi-tenant SaaS application using the Universal Project Prompt:

Tenancy Strategy: Shared table with tenant_id
Tenant Identification: Subdomain (acme.myapp.com)

Features:
- Tenant signup & provisioning
- Subdomain-based routing
- Per-tenant customization (logo, colors, features)
- Usage tracking (API calls, storage, active users)
- Billing integration with Stripe (subscription + usage-based)
- Tenant admin dashboard

Security:
- Row-Level Security (PostgreSQL RLS)
- Tenant isolation enforcement middleware
- Cross-tenant access prevention tests

Generate:
1. Multi-tenant Prisma schema with tenant_id
2. Tenant resolution middleware
3. Usage tracking implementation
4. Billing integration code
5. MULTI_TENANCY.md guide"
```

---

## 🔑 Enterprise Authentication Quick Start

### LDAP/Active Directory Integration
```
"Add LDAP/Active Directory authentication to my application:

LDAP Configuration:
- URL: ldap://ad.company.com:389
- Search Base: DC=company,DC=com
- Group Mapping: AD groups → RBAC roles

Features:
- SSO with domain credentials
- Automated user provisioning
- Group synchronization (hourly)
- Fallback to local auth
- Admin can disable LDAP per user

Generate:
1. LDAP authentication middleware (ldapjs + passport-ldap)
2. Group-to-role mapping configuration
3. User sync job
4. AUTHENTICATION_PROVIDERS.md guide
5. Troubleshooting guide"
```

### SAML 2.0 SSO Integration
```
"Add SAML 2.0 SSO to my application:

Identity Providers: Okta, Azure AD, Google Workspace

Features:
- SP-initiated and IdP-initiated login
- Just-In-Time (JIT) user provisioning
- Single Logout (SLO)
- Multi-IdP support (per tenant)
- SAML metadata endpoint

Generate:
1. SAML configuration with passport-saml
2. Metadata generation endpoint
3. JIT provisioning logic
4. Multi-IdP tenant mapping
5. SAML testing guide"
```

---

## 📈 Scalability Quick Reference

### Horizontal Scaling Setup
```yaml
Prerequisites:
  - Stateless application (no server-side sessions)
  - Redis for session storage
  - Shared file storage (MinIO/S3)

Load Balancer (Nginx):
  Algorithm: least_conn
  Health Check: /health endpoint every 30s
  Instances: Start with 3 app servers

Auto-Scaling Triggers:
  - CPU > 70% for 5 minutes → Scale up
  - CPU < 30% for 10 minutes → Scale down
  - Min instances: 2
  - Max instances: 10
```

### Performance Optimization Checklist
```yaml
Database:
  - [ ] Connection pooling (min: 2, max: 50)
  - [ ] Indexes on foreign keys and query filters
  - [ ] EXPLAIN ANALYZE on slow queries (>50ms)
  - [ ] Prisma query batching enabled
  - [ ] Read replicas for analytics

Caching:
  - [ ] Redis caching for frequently accessed data
  - [ ] Cache TTL: 5 minutes (standard), 1 hour (static)
  - [ ] CDN for static assets (24-hour TTL)
  - [ ] Browser caching headers configured

API:
  - [ ] Response compression (gzip, 1KB threshold)
  - [ ] API pagination (max 100 items per page)
  - [ ] N+1 query prevention
  - [ ] Background jobs for heavy operations
```

### Quick Start: Add Horizontal Scaling
```
"Add horizontal scaling to my application using the Universal Project Prompt:

Current: Single server
Target: 3+ app servers behind load balancer

Requirements:
- Convert to stateless (Redis sessions)
- Nginx load balancer configuration
- Health check endpoint
- Graceful shutdown handling
- Auto-scaling documentation

Generate:
1. Redis session configuration
2. Nginx upstream configuration
3. Health check implementation
4. docker-compose.scale.yml (3 replicas)
5. PERFORMANCE_OPTIMIZATION.md guide"
```

---

## 🔄 Upgrade Procedures Quick Reference

### Zero-Downtime Deployment Process
```yaml
Blue-Green Deployment:
  1. Deploy new version to "green" environment
  2. Run database migrations (backward-compatible)
  3. Health check green environment
  4. Switch load balancer to green
  5. Monitor for 15 minutes
  6. Keep blue as rollback

Canary Deployment:
  1. Deploy to 5% of servers
  2. Monitor error rates for 1 hour
  3. If stable, deploy to 25%
  4. Monitor for 2 hours
  5. Deploy to 100%
  6. Automatic rollback if error rate > 1%
```

### Database Migration Strategy
```yaml
Backward-Compatible Migrations:
  ✅ Add new columns (with defaults)
  ✅ Add new tables
  ✅ Add indexes (concurrent mode)

  ❌ Avoid in single migration:
    - Remove columns (2-phase migration)
    - Change column types (2-phase migration)
    - Remove tables (2-phase migration)

Multi-Phase Migration (Breaking Changes):
  Phase 1: Add new column/table, dual-write
  Deploy: Application writes to both old and new
  Phase 2: Migrate data, verify
  Deploy: Application reads from new
  Phase 3: Remove old column/table
```

### Quick Start: Setup Zero-Downtime Deployment
```
"Setup zero-downtime deployment for my application:

Strategy: Blue-green deployment
Infrastructure: Docker containers + Nginx

Requirements:
- Health check endpoint (/health, /ready)
- Graceful shutdown (30s timeout)
- Database migration rollback scripts
- Deployment automation script

Generate:
1. Health check implementation
2. Graceful shutdown handling
3. Blue-green deployment script
4. Rollback procedures
5. UPGRADE_GUIDE.md documentation"
```

---

## 🌍 Internationalization Quick Start

### Add Multi-Language Support
```
"Add internationalization (i18n) to my application:

Locales: English (en), Spanish (es), French (fr), German (de)
RTL Support: Add Arabic (ar)

Features:
- Auto-detect user locale (Accept-Language, browser)
- User preference override
- Translation management (Crowdin integration)
- Date/time formatting per locale
- Number/currency formatting
- RTL layout support

Generate:
1. i18next configuration (backend + frontend)
2. Translation file structure (/locales/en/common.json)
3. Locale detection middleware
4. Translation helper functions
5. INTERNATIONALIZATION.md guide"
```

---

## 🔔 Notifications Quick Start

### Multi-Channel Notification System
```
"Add notification system to my application:

Channels:
- Email (transactional via SMTP)
- In-app notifications (real-time via WebSocket)
- SMS (Twilio)
- Push notifications (Firebase Cloud Messaging)

Features:
- User notification preferences per channel
- Notification templates (per type)
- Delivery queue with retry logic
- Notification history
- Read receipts
- Batch notifications

Generate:
1. Notification queue (Bull + Redis)
2. Multi-channel delivery handlers
3. Template management
4. User preferences API
5. NOTIFICATIONS.md guide"
```

---

## 🔍 OpenTelemetry Observability Quick Start

### Add Distributed Tracing (Industry Standard 2026)
```
"Add OpenTelemetry distributed tracing to my application:

Stack: Node.js + Express + Prisma + Redis

Features:
- Auto-instrumentation for Express, Prisma, PostgreSQL, Redis
- Custom spans for business logic (order processing, payments)
- Distributed tracing across microservices
- Vendor-neutral (works with Jaeger, Datadog, New Relic, Grafana)
- Prometheus metrics export
- Grafana dashboards with alerting

Observability Stack:
- Jaeger for distributed tracing UI
- Prometheus for metrics storage
- Grafana for visualization
- Docker Compose setup for local development

Environment Configuration:
- Sampling: 10% in production, 100% in development
- OTLP exporter to localhost:4318
- Custom business metrics (orders, payments, active users)

Alerting Rules:
- High error rate (>5% for 5 minutes)
- High response time (P95 >1 second)
- Database connection pool exhausted (>45 connections)
- Low cache hit rate (<70%)

Generate:
1. OpenTelemetry instrumentation setup (src/instrumentation.ts)
2. Docker Compose observability stack
3. Prometheus configuration with alerting rules
4. Grafana datasources and dashboards
5. Custom spans for critical business flows
6. Environment variables configuration
7. Integration with existing /health endpoint
8. Troubleshooting guide"
```

### Quick Setup Steps
```bash
# 1. Install OpenTelemetry packages
npm install --save @opentelemetry/sdk-node \
  @opentelemetry/auto-instrumentations-node \
  @opentelemetry/exporter-trace-otlp-http \
  @opentelemetry/exporter-metrics-otlp-http

# 2. Create instrumentation.ts (before all other imports)
# See UNIVERSAL_PROJECT_PROMPT.md for complete setup

# 3. Add environment variables to .env
OTEL_SERVICE_NAME=your-app
OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4318/v1/traces
OTEL_TRACES_SAMPLER=parentbased_traceidratio
OTEL_TRACES_SAMPLER_ARG=1.0  # 100% for development

# 4. Start observability stack
docker-compose -f docker-compose.observability.yml up -d

# 5. Access dashboards
# Jaeger UI: http://localhost:16686
# Prometheus: http://localhost:9090
# Grafana: http://localhost:3001 (admin/admin)

# 6. Generate test traffic
curl http://localhost:3000/api/health

# 7. View traces in Jaeger
# Filter by service name and see distributed traces
```

### Benefits
```yaml
Faster Troubleshooting:
  - 40-60% faster MTTR (Mean Time To Resolution)
  - Trace requests across microservices in seconds
  - Identify bottlenecks with span timing

Vendor Flexibility:
  - Start with Jaeger (free, open-source)
  - Switch to Datadog, New Relic, or Grafana Cloud later
  - No code changes required, just change exporter

Production Ready:
  - <5% CPU overhead, <50MB memory
  - Configurable sampling (10% in production)
  - Automatic error trace capture
  - Cloud provider integrations (AWS X-Ray, Google Cloud Trace)

Industry Standard:
  - De facto observability standard for 2026
  - Adopted by all major APM vendors
  - CNCF graduated project
```

## Kubernetes Deployment Quick Start

Deploy your application to any Kubernetes cluster (EKS, GKE, AKS, on-premises) with production-ready manifests.

### 1. Prerequisites

```bash
# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl && sudo mv kubectl /usr/local/bin/

# Install cluster components
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.4/deploy/static/provider/cloud/deploy.yaml
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.2/cert-manager.yaml
```

### 2. Configure and Deploy

```bash
# Create namespace
kubectl create namespace myapp-prod

# Create secrets securely
kubectl create secret generic app-secrets \
  --namespace=myapp-prod \
  --from-literal=DATABASE_URL="postgresql://user:pass@host:5432/db" \
  --from-literal=JWT_SECRET="$(openssl rand -base64 32)" \
  --from-literal=SESSION_SECRET="$(openssl rand -base64 32)"

# Deploy to production
kubectl apply -k kubernetes/overlays/production

# Verify deployment
kubectl get all -n myapp-prod
kubectl logs -f deployment/prod-app -n myapp-prod
```

### 3. Monitor and Scale

```bash
# Check pod health and resource usage
kubectl get pods -n myapp-prod
kubectl top pods -n myapp-prod

# View HPA status (auto-scaling)
kubectl get hpa -n myapp-prod

# Manual scaling (if needed)
kubectl scale deployment/prod-app --replicas=5 -n myapp-prod

# View logs
kubectl logs -l app.kubernetes.io/name=myapp -n myapp-prod --tail=100 -f
```

### Key Features

```yaml
Architecture:
  - Base manifests + Kustomize overlays (dev, staging, prod)
  - Zero-downtime rolling updates
  - Auto-scaling (3-10 replicas based on CPU/memory)
  - Health checks (liveness, readiness, startup probes)

Security:
  - Non-root containers with read-only filesystem
  - Network policies (restrict pod traffic)
  - RBAC with minimal permissions
  - Automated SSL with cert-manager (Let's Encrypt)
  - Secret management (kubectl, Sealed Secrets, External Secrets)

Deployment Strategies:
  - Rolling updates (default)
  - Blue-green deployment
  - Canary deployment (with Flagger)

Cloud Providers:
  - Amazon EKS
  - Google GKE
  - Azure AKS
  - Local development (Minikube/Kind)
```

### Troubleshooting

```bash
# Pod not starting
kubectl describe pod <pod-name> -n myapp-prod
kubectl logs <pod-name> -n myapp-prod --previous

# Database connection issues
kubectl exec -it <pod-name> -n myapp-prod -- nc -zv postgres-service 5432

# Test without Ingress
kubectl port-forward service/app-service 8080:80 -n myapp-prod
curl http://localhost:8080

# Check Ingress and SSL
kubectl get ingress -n myapp-prod
kubectl get certificate -n myapp-prod
```

See `/kubernetes/README.md` for complete documentation and advanced configurations.

## Terraform Infrastructure as Code Quick Start

Deploy complete cloud infrastructure on AWS (with GCP/Azure patterns) using Terraform.

### 1. Prerequisites

```bash
# Install Terraform
curl -fsSL https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip -o terraform.zip
unzip terraform.zip && sudo mv terraform /usr/local/bin/
terraform version

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip && sudo ./aws/install
aws --version

# Configure AWS credentials
aws configure
```

### 2. Initialize and Deploy

```bash
# Navigate to infrastructure directory
cd infrastructure

# Initialize Terraform
terraform init

# Copy and configure variables
cp environments/production/terraform.tfvars.example terraform.tfvars
vim terraform.tfvars  # Edit with your values

# Validate configuration
terraform validate
terraform fmt

# Plan deployment
terraform plan -out=tfplan

# Apply configuration
terraform apply tfplan

# View outputs
terraform output
```

### 3. Infrastructure Created

```yaml
AWS Resources:
  - VPC (10.0.0.0/16) with 3 AZs
  - Public subnets (3) for ALB
  - Private subnets (3) for ECS, RDS, Redis
  - Internet Gateway + NAT Gateways (3)
  - Application Load Balancer with SSL/TLS
  - ECS Fargate cluster (auto-scaling 2-10 tasks)
  - RDS PostgreSQL (Multi-AZ, encrypted, automated backups)
  - ElastiCache Redis (cluster mode, encrypted)
  - S3 buckets with versioning
  - Route53 DNS management
  - ACM SSL certificates
  - IAM roles with least-privilege
  - CloudWatch monitoring and alarms
  - Secrets Manager for secure secrets

Security Features:
  - Encryption at rest and in transit
  - Multi-AZ high availability
  - VPC Flow Logs for network monitoring
  - Security groups with least-privilege
  - Automated backups (30 days production)
  - Secrets stored in Secrets Manager
```

### Environment Sizing

```yaml
Development ($50-75/month):
  VPC: Single AZ
  RDS: db.t3.micro, 20GB, 1-day backups
  Redis: cache.t3.micro, single node
  ECS: 256 CPU, 512 MB memory, 1 task

Staging ($150-200/month):
  VPC: 2 AZs
  RDS: db.t3.small, 50GB, 7-day backups
  Redis: cache.t3.small, single node
  ECS: 512 CPU, 1GB memory, 2 tasks

Production ($300-500/month):
  VPC: 3 AZs with NAT Gateways
  RDS: db.t3.medium, 100GB, Multi-AZ, 30-day backups
  Redis: cache.t3.medium, 3 nodes, Multi-AZ
  ECS: 1024 CPU, 2GB memory, 3-10 tasks (auto-scaling)

Savings:
  - Reserved Instances: 40-60% savings
  - Auto-scaling: Pay for actual usage
```

### State Management

```bash
# Create S3 backend for remote state
aws s3 mb s3://your-terraform-state-bucket
aws s3api put-bucket-versioning --bucket your-terraform-state-bucket \
  --versioning-configuration Status=Enabled

# Enable encryption
aws s3api put-bucket-encryption --bucket your-terraform-state-bucket \
  --server-side-encryption-configuration \
  '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'

# Create DynamoDB table for state locking
aws dynamodb create-table --table-name terraform-state-lock \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST
```

### Common Operations

```bash
# View current state
terraform show

# List all resources
terraform state list

# View specific output
terraform output alb_dns_name
terraform output database_endpoint

# Update infrastructure
terraform plan
terraform apply

# Destroy infrastructure (use with caution!)
terraform destroy

# Switch environments
terraform workspace new staging
terraform workspace select production
```

### Troubleshooting

```bash
# Validate configuration
terraform validate

# Format code
terraform fmt -recursive

# Enable debug logging
export TF_LOG=DEBUG
terraform apply

# Import existing resource
terraform import module.vpc.aws_vpc.main vpc-12345678

# Refresh state
terraform refresh

# Unlock state (if locked)
terraform force-unlock <lock-id>
```

See `/infrastructure/README.md` for complete documentation, module details, and multi-cloud patterns.

## AI/ML Integration Quick Start

Add AI-powered features to your application with OpenAI, Anthropic Claude, and vector databases.

### 1. Install AI/ML Dependencies

```bash
# Install AI SDKs
npm install openai @anthropic-ai/sdk

# Install vector database clients (choose one)
npm install @pinecone-database/pinecone
# OR
npm install weaviate-ts-client

# Install dependencies
npm install ioredis zod
```

### 2. Configure Environment Variables

```bash
# Add to .env file

# OpenAI Configuration
OPENAI_API_KEY=sk-...
OPENAI_MODEL=gpt-4-turbo-preview
OPENAI_EMBEDDING_MODEL=text-embedding-3-small
AI_MAX_TOKENS=1000
AI_TEMPERATURE=0.7

# Anthropic Claude Configuration
ANTHROPIC_API_KEY=sk-ant-...

# Vector Database - Pinecone
PINECONE_API_KEY=...
PINECONE_INDEX_NAME=your-index

# AI Rate Limiting
AI_RATE_LIMIT_REQUESTS=10      # Per user per hour
AI_RATE_LIMIT_WINDOW=3600

# AI Cost Controls
AI_MAX_COST_PER_USER_DAILY=5.00
```

### 3. Implement AI Services

**Basic Content Generation:**
```typescript
// src/services/ai/openai.service.ts
import OpenAI from 'openai';

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

export async function generateContent(prompt: string) {
  const response = await openai.chat.completions.create({
    model: 'gpt-4-turbo-preview',
    messages: [
      {
        role: 'system',
        content: 'You are a helpful content generation assistant.',
      },
      {
        role: 'user',
        content: prompt,
      },
    ],
    temperature: 0.7,
    max_tokens: 1000,
  });

  return response.choices[0].message.content;
}
```

**Semantic Search:**
```typescript
// src/services/search/vector-search.service.ts
import { Pinecone } from '@pinecone-database/pinecone';
import OpenAI from 'openai';

const pinecone = new Pinecone({
  apiKey: process.env.PINECONE_API_KEY!,
});

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

export async function semanticSearch(query: string, topK: number = 5) {
  // Generate embedding for query
  const embedding = await openai.embeddings.create({
    model: 'text-embedding-3-small',
    input: query,
  });

  // Search vector database
  const index = pinecone.Index(process.env.PINECONE_INDEX_NAME!);
  const results = await index.query({
    vector: embedding.data[0].embedding,
    topK,
    includeMetadata: true,
  });

  return results.matches.map((match) => ({
    id: match.id,
    score: match.score,
    content: match.metadata?.content,
  }));
}
```

### 4. Add API Endpoints

```typescript
// src/routes/ai.routes.ts
import express from 'express';
import { generateContent } from '../services/ai/openai.service';
import { authMiddleware } from '../middleware/auth.middleware';

const router = express.Router();

router.post('/generate', authMiddleware, async (req, res) => {
  try {
    const { prompt } = req.body;

    if (!prompt) {
      return res.status(400).json({ error: 'Prompt is required' });
    }

    const content = await generateContent(prompt);

    res.json({ content });
  } catch (error) {
    console.error('AI generation error:', error);
    res.status(500).json({ error: 'AI generation failed' });
  }
});

export default router;

// Add to app.ts
import aiRoutes from './routes/ai.routes';
app.use('/api/ai', aiRoutes);
```

### 5. Implement Rate Limiting

```typescript
// src/middleware/ai-rate-limit.middleware.ts
import { Request, Response, NextFunction } from 'express';
import Redis from 'ioredis';

const redis = new Redis(process.env.REDIS_URL!);

export async function aiRateLimitMiddleware(
  req: Request,
  res: Response,
  next: NextFunction
) {
  const userId = req.user?.id;
  const key = `ai:rate_limit:${userId}`;
  const limit = 10; // requests per hour

  const current = await redis.incr(key);

  if (current === 1) {
    await redis.expire(key, 3600); // 1 hour
  }

  if (current > limit) {
    return res.status(429).json({
      error: 'AI usage limit exceeded',
      limit,
      reset: await redis.ttl(key),
    });
  }

  next();
}
```

### AI/ML Use Cases

```yaml
Content Generation:
  - Blog posts and articles
  - Product descriptions
  - Email templates
  - Social media content

Semantic Search:
  - Knowledge base search
  - Document similarity
  - Recommendation systems

RAG (Retrieval-Augmented Generation):
  - Q&A chatbots with custom data
  - Customer support automation
  - Technical documentation assistant

Text Analysis:
  - Sentiment analysis
  - Content moderation
  - Key point extraction
  - Summarization

Code Assistance:
  - Code generation
  - Code explanation
  - Bug detection
  - Code review suggestions

Image Generation:
  - Product mockups
  - Marketing images
  - UI/UX prototypes
  - Creative assets
```

### Cost Management

```yaml
Pricing (as of 2026):
  GPT-4 Turbo:
    Input: $0.01 per 1K tokens
    Output: $0.03 per 1K tokens

  GPT-3.5 Turbo:
    Input: $0.0005 per 1K tokens
    Output: $0.0015 per 1K tokens

  Embeddings (text-embedding-3-small):
    $0.00002 per 1K tokens

  Claude 3.5 Sonnet:
    Input: $0.003 per 1K tokens
    Output: $0.015 per 1K tokens

Cost Controls:
  - Set per-user daily limits ($5 default)
  - Track usage per organization
  - Alert at 80% of budget
  - Auto-disable at 100% of budget
  - Monitor via CloudWatch metrics
```

### Security Best Practices

```yaml
Input Validation:
  - Limit prompt length (max 4000 chars)
  - Sanitize user inputs
  - Block malicious prompts
  - Content moderation on inputs

Data Privacy:
  - Never send PII to AI APIs
  - Anonymize data before processing
  - Log prompts/responses securely
  - Allow opt-out of AI features

API Key Management:
  - Store keys in environment variables
  - Rotate keys every 90 days
  - Use separate keys per environment
  - Monitor for key leaks

Rate Limiting:
  - 10 requests/hour per user (free tier)
  - 100 requests/hour (pro tier)
  - 1000 requests/hour (enterprise)
  - Graduated limits based on plan
```

### Database Schema for AI Usage

```prisma
model AIUsage {
  id            String   @id @default(uuid())
  userId        String   @map("user_id")
  provider      String   // openai, anthropic
  operation     String   // generate, embed, search
  model         String   // gpt-4, claude-3
  inputTokens   Int      @map("input_tokens")
  outputTokens  Int      @map("output_tokens")
  totalTokens   Int      @map("total_tokens")
  estimatedCost Float    @map("estimated_cost")
  timestamp     DateTime @default(now())

  user User @relation(fields: [userId], references: [id], onDelete: Cascade)

  @@index([userId, timestamp])
  @@map("ai_usage")
}
```

### Testing AI Integrations

```bash
# Test content generation
curl -X POST http://localhost:3000/api/ai/generate \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"prompt": "Write a blog post about AI in 2026"}'

# Test semantic search
curl -X POST http://localhost:3000/api/ai/search \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"query": "How do I integrate AI?"}'

# Get usage statistics
curl http://localhost:3000/api/ai/usage?days=30 \
  -H "Authorization: Bearer $TOKEN"
```

See `UNIVERSAL_PROJECT_PROMPT.md` section "E. AI/ML Integration Patterns" for complete implementations including RAG, cost tracking, streaming responses, and monitoring.

---

## 📞 Need Help?

### Common Questions

**Q: Which compliance do I need?**
```
E-commerce/Payments → PCI-DSS (required)
EU customers → GDPR (required)
Healthcare → HIPAA (required)
Enterprise SaaS → SOC 2 (common requirement)
Government → ISO 27001 (often required)
Financial reporting → SOX (if publicly traded)
```

**Q: Which tech stack for my app?**
```
Web SaaS → Next.js + Express + PostgreSQL
Mobile → React Native (cross-platform) or Native (best performance)
API Only → Express or FastAPI
Real-time → Add WebSocket/Socket.io
File Heavy → Add MinIO/S3
Background Jobs → Add RabbitMQ + Temporal
```

**Q: How to start with the prompt?**
```
1. Copy relevant sections to new file
2. Customize project name, features, compliance
3. Paste to Claude with "Using this prompt, create..."
4. Claude generates structure + docs
5. Iterate on specific components
```

---

**Last Updated:** February 01, 2026  
**Prompt Version:** 2.0  
**Compatibility:** Web Apps, Mobile Apps, APIs
