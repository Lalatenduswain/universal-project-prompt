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

### Use Case 1: SaaS Web Application
```
"Create a multi-tenant SaaS application using the Universal Project Prompt:

Stack: Next.js 16.x + Express 5.x + PostgreSQL 18.1
Features: User authentication, RBAC (Admin/User), subscription management, 
         file uploads, admin dashboard, API with rate limiting
Security: OWASP Top 10 2021 compliant, JWT auth, bcrypt passwords
Compliance: GDPR, SOC 2
Deployment: Docker + Cloudflare + Nginx

Generate complete documentation and codebase structure."
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
"Using the Universal Project Prompt, generate all 20 documentation files 
for my [TYPE] project: [BRIEF DESCRIPTION]

Required files:
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
14. Compliance-GDPR.md
15. Compliance-ISO27001.md
16. Compliance-PCI-DSS.md
17. Compliance-SOX.md
18. Compliance-Master-Roadmap.md
19. Security-Audit-Plan.md
20. Phase7-Test-Report.md

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
