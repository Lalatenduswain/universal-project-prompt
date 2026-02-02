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
