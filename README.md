# 🚀 Universal Project Prompt

> **The Complete Enterprise-Grade Template for Modern Web & Mobile Applications**

A comprehensive, production-ready prompt template that guides AI assistants (like Claude) to generate secure, compliant, and scalable applications with complete documentation.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-2.0-blue.svg)](https://github.com/yourusername/universal-project-prompt)
[![Last Updated](https://img.shields.io/badge/updated-February%202026-green.svg)](https://github.com/yourusername/universal-project-prompt)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

---

## 📋 Table of Contents

- [Overview](#-overview)
- [What's Included](#-whats-included)
- [Quick Start](#-quick-start)
- [Features](#-features)
- [Technology Stack](#-technology-stack)
- [Security & Compliance](#-security--compliance)
- [Use Cases](#-use-cases)
- [Documentation](#-documentation)
- [Examples](#-examples)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🎯 Overview

The **Universal Project Prompt** is a meticulously crafted template that synthesizes years of enterprise development best practices, security frameworks, and compliance requirements into a single, reusable prompt. 

### What Problem Does This Solve?

When starting a new project, developers typically spend days or weeks:
- ✅ Setting up project structure
- ✅ Configuring security measures
- ✅ Writing documentation (README, API docs, security policies)
- ✅ Implementing compliance requirements (GDPR, PCI-DSS, ISO 27001)
- ✅ Setting up CI/CD pipelines
- ✅ Configuring deployment infrastructure

**This prompt eliminates 80% of that work** by providing a comprehensive template that AI assistants can use to generate production-ready code, architecture, and documentation in minutes.

### Who Is This For?

- 👨‍💻 **Full-Stack Developers** building modern web applications
- 📱 **Mobile Developers** creating iOS/Android apps
- 🏢 **Enterprise Teams** requiring security and compliance
- 🚀 **Startups** needing to move fast with best practices
- 🎓 **Students & Learners** understanding professional development workflows
- 🤖 **AI-Assisted Development** teams using Claude, GPT, or other LLMs

---

## 📦 What's Included

This repository contains **two essential files**:

### 1. `UNIVERSAL_PROJECT_PROMPT.md` (~110KB)
The complete master prompt containing:

- ✅ **Latest Technology Versions** (as of February 2026)
  - Node.js 25.x/24.x LTS, Express 5.x, Next.js 16.x
  - PostgreSQL 18.1, Redis 8.x, Docker 29.x
  - React Native, Swift 5.x, Kotlin (Mobile)
  
- ✅ **Full-Stack Architecture Templates**
  - Web Application Stack
  - Mobile Application Stack (iOS/Android/Cross-platform)
  - API-Only Backend Stack
  
- ✅ **Complete Security Implementation (OWASP Top 10 2021)**
  - A01: Broken Access Control (RBAC, JWT, Session Management)
  - A02: Cryptographic Failures (HTTPS, bcrypt, Headers)
  - A03: Injection Prevention (Parameterized queries, Validation)
  - A04: Insecure Design (Threat modeling, Security by design)
  - A05: Security Misconfiguration (15+ Headers, CSP, HSTS)
  - A06: Vulnerable Components (Dependency scanning, Updates)
  - A07: Identity Failures (Account lockout, MFA ready)
  - A08: Software Integrity (File validation, Code signing)
  - A09: Logging Failures (Comprehensive audit logging)
  - A10: SSRF Prevention (Input validation, URL filtering)
  
- ✅ **Compliance Documentation Templates**
  - GDPR (General Data Protection Regulation)
  - ISO 27001 (Information Security Management)
  - PCI-DSS (Payment Card Industry Data Security)
  - SOC 2 Type II (Service Organization Control)
  - SOX (Sarbanes-Oxley Act)
  - NIST Cybersecurity Framework
  - HIPAA (Healthcare - optional)
  
- ✅ **28 Professional Documentation Files**
  - README.md, INSTALLATION.md, API.md
  - SECURITY.md, DEPLOYMENT.md, TESTING.md
  - CONTRIBUTING.md, CHANGELOG.md, LICENSE.md
  - TROUBLESHOOTING.md, CLAUDE.md
  - MULTI_TENANCY.md, UPGRADE_GUIDE.md
  - AUTHENTICATION_PROVIDERS.md (LDAP, SAML)
  - NOTIFICATIONS.md, INTERNATIONALIZATION.md
  - SCHEDULED_JOBS.md, PERFORMANCE_OPTIMIZATION.md
  - All Compliance-*.md files
  - Security-Audit-Plan.md
  - Phase7-Test-Report.md (template)
  
- ✅ **Production Deployment Guides**
  - Cloudflare (DNS, WAF, Tunnels, Workers)
  - Docker 29.x containerization
  - Kubernetes (K8s) manifests with Kustomize overlays
  - Nginx 1.29.x configuration
  - Jenkins 2.546+ CI/CD pipelines
  - Auto-start after server reboot
  
- ✅ **Monitoring & Observability**
  - System Health Dashboard
  - API Performance Metrics
  - Security Command Center
  - Business Intelligence Dashboard
  - Database Health Monitoring

### 2. `QUICK_START_GUIDE.md` (14KB)
Your fast-track implementation guide:

- ⚡ **3-Step Quick Start** process
- 🎯 **Common Use Cases** with ready-to-use prompts
- 🔧 **Customization Templates** for different project types
- 📝 **Documentation Generation Commands**
- 🔐 **Security Configuration Quick Reference**
- 🎨 **Frontend/Backend Setup Commands**
- 🐳 **Docker Quick Start**
- ✅ **Pre-Launch Checklist**

---

## ⚡ Quick Start

### Option 1: Generate a Complete Web Application

Copy this prompt and paste it to Claude (or your AI assistant):

```
Using the Universal Project Prompt, create a SaaS web application:

Project Name: TaskFlow
Description: Team collaboration and project management platform

Stack: Next.js 16.x + Express 5.x + PostgreSQL 18.1 + Redis 8.x

Features:
- User authentication with JWT
- Role-based access control (Admin, Manager, Member)
- Real-time notifications
- File uploads (documents, images)
- Admin dashboard with analytics
- RESTful API with rate limiting

Security: OWASP Top 10 2021 compliant
Compliance: GDPR, SOC 2
Deployment: Docker + Cloudflare + Nginx

Generate:
1. Complete project structure
2. All 20 documentation files
3. Security implementation
4. Deployment configuration
```

### Option 2: Generate a Mobile Application

```
Using the Universal Project Prompt, create a mobile banking application:

Project Name: SecureBank Mobile
Platform: iOS + Android (React Native)

Stack: React Native + Express 5.x + PostgreSQL 18.1

Features:
- Biometric authentication (Face ID, Touch ID, Fingerprint)
- Account management
- Transaction history
- Push notifications
- Offline mode with sync

Security: OWASP Mobile Top 10, Certificate pinning, Root/Jailbreak detection
Compliance: PCI-DSS, GDPR, SOC 2
Deployment: AWS + CloudFront + Docker

Generate mobile-specific architecture and compliance documentation.
```

### Option 3: Generate API Backend Only

```
Using the Universal Project Prompt, create a REST API backend:

Project Name: Analytics API
Type: Backend API Only

Stack: Express 5.x + PostgreSQL 18.1 + Redis 8.x

Features:
- JWT authentication
- API key management
- Rate limiting (100 req/15min)
- Data analytics endpoints
- Export functionality (CSV, JSON)
- Webhook support

Security: OWASP API Security Top 10
Documentation: OpenAPI/Swagger specs

Generate API-focused documentation (skip frontend docs).
```

---

## ✨ Features

### 🏗️ Architecture Support

- **Web Applications**: Full-stack Next.js + Express + PostgreSQL
- **Mobile Apps**: React Native (cross-platform), Native iOS (Swift), Native Android (Kotlin)
- **API Backends**: Express 5.x or FastAPI 0.115.x+
- **Microservices**: Docker containers + Message queues (RabbitMQ 4.2.x)
- **Real-time**: WebSocket, Socket.io support
- **Background Jobs**: Temporal 1.28.x+ workflow orchestration
- **Multi-Tenancy**: 3 isolation strategies (shared table, separate schema, separate database)
- **Enterprise SSO**: Active Directory/LDAP and SAML 2.0 integration
- **Internationalization**: 7 locales with RTL support (en, es, fr, de, ja, zh, ar)
- **Automated Setup**: Installation wizard with prerequisite checking
- **Scalability**: Horizontal scaling, load balancing, multi-level caching

### 🔐 Security Features

**Authentication & Authorization:**
- JWT with 30-minute expiry + refresh tokens
- bcrypt password hashing (12 rounds)
- Account lockout (5 failed attempts = 30-minute lock)
- Multi-Factor Authentication (MFA) ready
- Role-Based Access Control (RBAC) with permission matrix
- Session management (30-min timeout)

**Rate Limiting (Multi-Tier):**
- Authentication: 5 requests / 15 minutes
- Registration: 3 requests / 1 hour
- General API: 100 requests / 15 minutes
- File Upload: 10 uploads / 1 hour
- IP + User ID tracking

**Security Headers (15+ via Helmet.js):**
- Strict-Transport-Security (HSTS)
- X-Frame-Options: DENY
- X-Content-Type-Options: nosniff
- Content-Security-Policy (CSP) with reporting
- Referrer-Policy, Permissions-Policy, and more

**File Upload Security:**
- MIME type validation
- Extension whitelist (.pdf, .jpg, .png, .docx)
- File size limits (5MB default)
- Magic byte verification
- Virus scanning ready (ClamAV integration)
- Randomized filenames (UUID)

**Audit Logging:**
- Authentication events (login, logout, failures)
- User management operations
- Security events (lockouts, suspicious activity)
- File operations (upload, download, delete)
- Resource operations (CRUD)
- 90-day minimum retention

### 📊 Monitoring Dashboards

**System Health Dashboard:**
- CPU Load Average (1m, 5m, 15m)
- Memory Usage (%, used/total)
- Disk Usage
- Database Connections (active/max)
- Cache Hit Rate
- System Uptime

**API Performance Dashboard:**
- Total Requests
- Average Response Time
- Error Rate (%)
- Response Time Percentiles (P50, P95, P99)
- Top Endpoints (with method, requests, avg time)
- Slowest Endpoints
- Most Common Errors

**Security Command Center:**
- Active Sessions (with force logout)
- Locked Accounts
- Suspicious IPs (risk scoring: Low/Medium/High/Critical)
- Failed Login Attempts
- Login Activity by Country
- Session Management

**Business Intelligence:**
- Performance Analytics (priority distribution, department performance)
- Agent Performance Metrics
- User Engagement Statistics
- Category Analysis
- Resolution Time Tracking
- Customer Satisfaction Scores

**OpenTelemetry Observability:**
- Industry-standard distributed tracing (2026)
- Vendor-neutral telemetry (Jaeger, Datadog, New Relic, Grafana)
- Auto-instrumentation (Express, Prisma, Redis, PostgreSQL)
- Unified metrics, logs, and traces pipeline
- 40-60% faster MTTR with distributed tracing
- Custom business metrics and alerting
- Production-ready Docker Compose stack

### 🏢 Enterprise Features

**Multi-Tenancy Architecture:**
- 3 data isolation strategies (shared table, separate schema, separate database)
- Tenant identification (subdomain, header, JWT, path-based)
- Tenant-specific customization (themes, features, workflows)
- Usage tracking & metering (API calls, storage, active users)
- Billing integration (Stripe subscription + usage-based)
- Per-tenant resource limits & enforcement

**Enterprise Authentication:**
- Active Directory/LDAP integration (ldapjs, passport-ldap)
- SAML 2.0 SSO (Okta, Azure AD, OneLogin, Google Workspace, ADFS)
- Group-to-role mapping & synchronization
- Just-In-Time (JIT) user provisioning
- Single Logout (SLO) support

**Notification System:**
- Multi-channel delivery (Email, In-app, SMS, Push, Webhooks)
- Template management per notification type
- User notification preferences
- Delivery queue with retry logic (Bull + Redis)
- Notification history & read receipts

**Scheduled Jobs & Background Tasks:**
- Job scheduling (node-cron, Bull, Temporal)
- Common tasks (backups, usage aggregation, reports, cleanup)
- Job monitoring dashboard (active, completed, failed)
- Exponential backoff retry logic
- Dead letter queue for persistent failures

**Internationalization (i18n):**
- 7 supported locales (en, es, fr, de, ja, zh, ar)
- RTL (Right-to-Left) support for Arabic & Hebrew
- Translation workflow with Crowdin/Lokalise
- Auto-detection (user preference, Accept-Language header, browser locale)
- Date/time/currency formatting (Intl API)

### 🌍 Compliance Coverage

**GDPR (General Data Protection Regulation):**
- Right to Access (data export API)
- Right to Rectification (profile editing)
- Right to Erasure (account deletion with audit trail)
- Right to Data Portability (JSON/CSV export)
- Encryption at rest (AES-256) and in transit (TLS 1.3)
- Privacy by Design
- 72-hour breach notification procedures

**ISO 27001 (Information Security Management):**
- 14 Security Control Domains
- Access Control (RBAC, least privilege)
- Cryptography (key management)
- Operations Security (change management, backups)
- Incident Management (response procedures)
- Audit-ready documentation

**PCI-DSS (Payment Card Industry):**
- 12 Requirements coverage
- Recommendation: Use tokenization via payment gateway (Stripe, PayPal)
- Encryption requirements
- Network segmentation
- Access restrictions
- Quarterly vulnerability scans

**SOC 2 Type II:**
- Security (required): Access controls, monitoring, change management
- Availability (optional): Uptime monitoring, incident response
- Confidentiality (optional): Data encryption, secure transmission
- 6-12 month audit period support

**SOX (Sarbanes-Oxley):**
- IT General Controls (ITGC)
- Change management procedures
- Segregation of duties
- Financial transaction logging
- 7-year retention

**NIST Cybersecurity Framework:**
- Identify (asset management, risk assessment)
- Protect (access control, data security)
- Detect (continuous monitoring)
- Respond (incident response)
- Recover (recovery planning)

### 🚀 DevOps & Deployment

**CI/CD Pipeline (Jenkins 2.546+):**
- Automated testing (unit, integration, E2E)
- Code quality analysis (SonarQube 2025.6+)
- Security scanning (npm audit, dependency check)
- Docker image building
- Container registry push (Harbor 2.14.x)
- Automated deployment

**Docker Deployment:**
- Multi-container setup (app, database, cache, storage)
- Docker 29.x Engine
- docker-compose.yml templates
- Environment variable management
- Volume management
- Health checks

**Cloudflare Integration:**
- DNS management (A, CNAME, MX, TXT records)
- Cloudflare Tunnels (Zero Trust, no public IP)
- WAF (Web Application Firewall) rules
- DDoS protection
- Edge Workers
- SSL/TLS (Full strict mode, minimum TLS 1.3)

**Nginx Configuration:**
- Nginx 1.29.x (mainline)
- Reverse proxy setup
- Load balancing
- SSL/TLS termination
- Rate limiting
- Security headers

**Backup & Disaster Recovery:**
- Daily full backups
- 6-hour incremental backups
- Local + Remote storage (MinIO/S3)
- Automated backup verification
- Restore procedures
- RPO: 1 hour, RTO: 4 hours

**Scalability & Performance:**
- Horizontal scaling (stateless application design)
- Load balancing (Nginx, HAProxy with health checks)
- Multi-level caching (LRU, Redis, CDN)
- Database optimization (connection pooling, read replicas, partitioning)
- Query optimization (EXPLAIN ANALYZE, indexes, N+1 prevention)
- Auto-scaling triggers (CPU >70%, Memory >80%)

**Zero-Downtime Deployment:**
- Blue-green deployment strategy
- Canary deployment (gradual rollout 5% → 25% → 50% → 100%)
- Rolling updates with health checks
- Feature flags for gradual rollout
- Database migration strategies (backward-compatible)
- Graceful shutdown & connection draining

**Upgrade & Migration Tools:**
- Automated prerequisite checking (system requirements, dependencies)
- Version upgrade procedures (semantic versioning)
- Database migration scripts (Prisma, chunked data migrations)
- Configuration backup & restore
- Secrets rotation (JWT, database passwords, API keys)
- Rollback procedures

---

## 🛠️ Technology Stack

### Latest Versions (as of February 2026)

#### Backend
| Technology | Version | Purpose |
|------------|---------|---------|
| Node.js | 25.x (Current) / 24.x (LTS) | JavaScript runtime |
| Express | 5.x | Web framework |
| FastAPI | 0.115.x+ | Python async framework |
| PostgreSQL | 18.1 | Primary database |
| Prisma | 6.x | ORM |
| Redis | 8.x | Cache & sessions |
| Valkey | 9.x | Redis alternative |
| BCrypt | 5.1.x | Password hashing |
| ioredis | 5.x | Redis client |
| Zod | 4.3.x | Schema validation |

#### Frontend
| Technology | Version | Purpose |
|------------|---------|---------|
| Next.js | 16.x (stable) | React framework |
| React Types | @types/react 19.x | TypeScript definitions |
| TanStack Query | 5.90.x+ | Data fetching |
| TanStack Router | 1.152.x | Routing |
| Tailwind CSS | 4.1.x | Styling framework |
| ShadCN/ui | CLI ~3.7.x | Component library |
| Framer Motion | 12.x / 12.27.x | Animations |
| Recharts | 3.6.x | Data visualization |
| react-hook-form | 7.71.x | Form management |
| Zustand | 5.x | State management |
| Prism | 1.30.x | Code highlighting |

#### Mobile
| Technology | Version | Purpose |
|------------|---------|---------|
| React Native | Latest | Cross-platform |
| Swift | 5.x | iOS native |
| Kotlin | Latest | Android native |

#### DevOps & Infrastructure
| Technology | Version | Purpose |
|------------|---------|---------|
| Docker | 29.x | Containerization |
| Nginx | 1.29.x (mainline) | Web server |
| Certbot | 5.2.x | SSL certificates |
| Jenkins | 2.546+ | CI/CD |
| SonarQube | 2025.6 / 2026.x | Code quality |
| Harbor | 2.14.x | Container registry |
| Playwright | 1.57.x | E2E testing |

#### Storage & Messaging
| Technology | Version | Purpose |
|------------|---------|---------|
| MinIO | RELEASE.2025-xx-xx | Object storage (S3) |
| RabbitMQ | 4.2.x | Message broker |
| Temporal | 1.28.x+ | Workflow engine |
| HashiCorp Vault | 1.21.x | Secrets management |

---

## 🎯 Use Cases

### 1. SaaS Web Application
**Example:** Project Management Platform
- Multi-tenant architecture
- User authentication & RBAC
- Subscription management
- File uploads & storage
- Admin dashboard
- API with rate limiting

**Compliance:** GDPR, SOC 2  
**Timeline:** 2-4 weeks to MVP with this prompt

### 2. Mobile Banking App
**Example:** Secure Banking Application
- Biometric authentication
- Transaction management
- Push notifications
- Offline mode with sync
- Certificate pinning

**Compliance:** PCI-DSS, GDPR, SOC 2  
**Timeline:** 3-6 weeks to MVP

### 3. E-commerce Platform
**Example:** Online Store
- Product catalog
- Shopping cart
- Payment integration (Stripe)
- Order management
- Inventory tracking

**Compliance:** PCI-DSS (tokenization), GDPR  
**Timeline:** 4-8 weeks to MVP

### 4. Healthcare Portal
**Example:** Patient Management System
- Patient records (encrypted)
- Appointment scheduling
- Secure messaging
- Document uploads
- Telehealth integration

**Compliance:** HIPAA, GDPR, ISO 27001  
**Timeline:** 6-12 weeks to MVP

### 5. API-as-a-Service
**Example:** Analytics API
- RESTful endpoints
- API key management
- Rate limiting
- Data aggregation
- Webhook support

**Compliance:** SOC 2, GDPR  
**Timeline:** 1-2 weeks to MVP

---

## 📚 Documentation

### Available Templates

All documentation files are generated in professional Markdown format:

1. **README.md** - Project overview, quick start, features
2. **TODO.md** - Pending tasks, bugs, improvements, roadmap
3. **INSTALLATION.md** - Step-by-step setup guide
4. **API.md** - Complete API reference with examples
5. **CONTRIBUTING.md** - Contribution guidelines, code style
6. **CHANGELOG.md** - Version history (Keep a Changelog format)
7. **LICENSE.md** - MIT License (or custom)
8. **SECURITY.md** - Vulnerability reporting policy
9. **DEPLOYMENT.md** - Production deployment guide
10. **TESTING.md** - Testing strategy (unit, integration, E2E)
11. **TROUBLESHOOTING.md** - Common issues and solutions
12. **CLAUDE.md** - How Claude AI was used in the project
13. **CLAUDE_ARCHIVE.md** - Archive of Claude interactions
14. **Compliance-GDPR.md** - GDPR compliance guide
15. **Compliance-ISO27001.md** - ISO 27001 compliance guide
16. **Compliance-PCI-DSS.md** - PCI-DSS compliance guide
17. **Compliance-SOX.md** - SOX compliance guide
18. **Compliance-Master-Roadmap.md** - Overall compliance strategy
19. **Security-Audit-Plan.md** - Security audit procedures
20. **Phase7-Test-Report.md** - Test report template

---

## 💡 Examples

### Example 1: Generate Security Documentation

```
Using the Universal Project Prompt, generate comprehensive security documentation:

- SECURITY.md (vulnerability reporting)
- Security-Audit-Plan.md (OWASP Top 10 2021 compliance)
- Include rate limiting details
- Include file upload security
- Include audit logging categories
- Include incident response procedures
```

### Example 2: Generate Compliance Package

```
Using the Universal Project Prompt, generate GDPR + PCI-DSS compliance documentation:

Project: E-commerce Platform
Data Types: Customer PII, Payment information (tokenized)
Processing: EU customers, Payment via Stripe

Generate:
- Compliance-GDPR.md (full implementation guide)
- Compliance-PCI-DSS.md (SAQ requirements)
- Data flow diagrams
- Privacy policy requirements
- Breach notification procedures
```

### Example 3: Generate Deployment Configuration

```
Using the Universal Project Prompt, create production deployment setup:

Infrastructure:
- Cloudflare (DNS, WAF, Tunnels)
- Docker 29.x containers
- Nginx 1.29.x
- PostgreSQL 18.1
- Redis 8.x
- MinIO object storage

Generate:
- DEPLOYMENT.md with step-by-step guide
- docker-compose.yml
- nginx.conf template
- Cloudflare configuration steps (DNS, Tunnel, Access policies)
- SSL/TLS setup (Certbot)
- Auto-restart configuration
```

### Example 4: Mobile App Architecture

```
Using the Universal Project Prompt, design a mobile app architecture:

App: Fitness Tracker
Platform: iOS + Android (React Native)

Features:
- User authentication (OAuth2 + Biometric)
- Workout tracking (offline-first)
- Progress charts
- Social features (follow, share)
- Push notifications
- File uploads (photos)

Security:
- Certificate pinning
- Encrypted local storage
- Jailbreak/Root detection

Generate architecture, security implementation, and App Store/Play Store requirements.
```

---

## 🔄 How It Works

### The Process

1. **You Define Requirements**
   - Choose application type (web/mobile/API)
   - List core features
   - Specify compliance needs
   - Select technologies

2. **Use the Universal Prompt**
   - Copy relevant sections
   - Customize for your project
   - Provide to AI assistant (Claude, GPT, etc.)

3. **AI Generates Complete Project**
   - Project structure
   - Code implementation
   - All documentation files
   - Security measures
   - Compliance documentation
   - Deployment configuration

4. **You Review & Customize**
   - Review generated code
   - Customize business logic
   - Adjust styling/branding
   - Fine-tune configurations

5. **Deploy to Production**
   - Follow deployment guide
   - Run security scans
   - Configure monitoring
   - Launch! 🚀

---

## 🤝 Contributing

We welcome contributions! Here's how you can help:

### Ways to Contribute

- 📝 **Documentation**: Improve existing docs, add examples
- 🐛 **Bug Reports**: Report issues with templates
- 💡 **Feature Requests**: Suggest new features or improvements
- 🔧 **Technology Updates**: Keep versions current
- 📋 **Compliance Updates**: Update compliance requirements
- 🌍 **Translations**: Translate to other languages

### Contribution Process

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Make your changes
4. Commit with clear message (`git commit -m 'Add AmazingFeature'`)
5. Push to the branch (`git push origin feature/AmazingFeature`)
6. Open a Pull Request

### Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on what is best for the community
- Show empathy towards other community members

---

## 📜 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

### MIT License Summary

```
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software.
```

**TL;DR:** You can use, modify, and distribute this prompt freely. Attribution is appreciated but not required.

---

## 🙏 Acknowledgments

This Universal Project Prompt synthesizes best practices from:

- **OWASP** - Web & Mobile security standards
- **ISO/IEC** - International security standards
- **NIST** - Cybersecurity framework
- **PCI Security Standards Council** - Payment security
- **GDPR** - Privacy regulations
- **Enterprise Development Teams** - Real-world patterns
- **Open Source Community** - Collective wisdom

Special thanks to the AI-assisted development community for pioneering new ways to build software efficiently.

---

## 📞 Support & Contact

### Get Help

- 📖 **Documentation**: Read [QUICK_START_GUIDE.md](QUICK_START_GUIDE.md)
- 💬 **Discussions**: GitHub Discussions (coming soon)
- 🐛 **Issues**: [GitHub Issues](https://github.com/yourusername/universal-project-prompt/issues)
- 📧 **Email**: swain@lalatendu.info

### Stay Updated

- ⭐ **Star this repo** to stay notified of updates
- 👀 **Watch** for new releases
- 🔔 **Follow** for announcements

---

## 🗺️ Roadmap

### Version 2.1 (Q2 2026)
- [x] Kubernetes deployment configuration (Added in v2.0.1)
- [x] OpenTelemetry distributed tracing (Added in v2.0.1)
- [ ] GraphQL API template
- [ ] Terraform infrastructure-as-code
- [ ] Additional compliance: CCPA, LGPD
- [ ] Machine Learning integration templates

### Version 2.2 (Q3 2026)
- [ ] Microservices architecture template
- [ ] Event-driven architecture patterns
- [ ] Serverless deployment options
- [ ] Multi-cloud deployment guides
- [ ] Advanced monitoring (Prometheus, Grafana)

### Version 3.0 (Q4 2026)
- [ ] AI/ML model deployment
- [ ] Blockchain integration templates
- [ ] Web3 application support
- [ ] Advanced security (Zero Trust Architecture)
- [ ] Automated compliance reporting

---

## 📊 Stats

- **Total Lines**: 21,200+
- **Documentation Files**: 28 templates
- **Compliance Standards**: 6+ (GDPR, ISO 27001, PCI-DSS, SOC 2, SOX, NIST)
- **Security Controls**: 150+ specific implementations
- **Technology Versions**: 40+ latest versions tracked
- **Use Cases Covered**: Web, Mobile, API, Hybrid, Multi-Tenant SaaS
- **Languages Supported**: JavaScript/TypeScript, Python, Swift, Kotlin
- **Enterprise Features**: Multi-tenancy, LDAP/SAML SSO, i18n (7 locales), Notifications
- **Template Size**: ~110KB comprehensive guide

---

## ⚡ Quick Links

| Resource | Description |
|----------|-------------|
| [📖 Universal Prompt](UNIVERSAL_PROJECT_PROMPT.md) | Complete master prompt (~110KB) |
| [⚡ Quick Start Guide](QUICK_START_GUIDE.md) | Fast-track implementation (14KB) |
| [🔧 Installation Guide](UNIVERSAL_PROJECT_PROMPT.md#-installation--setup) | Automated setup, prerequisites, verification |
| [🏢 Multi-Tenancy Guide](UNIVERSAL_PROJECT_PROMPT.md#-multi-tenancy-architecture) | 3 isolation strategies, billing, customization |
| [🔐 Security Guide](UNIVERSAL_PROJECT_PROMPT.md#-security-implementation-owasp-top-10-2021-compliance) | OWASP Top 10 2021 compliance |
| [🔑 Enterprise Auth](UNIVERSAL_PROJECT_PROMPT.md#enterprise-authentication-integrations) | LDAP, SAML SSO, group mapping |
| [📋 Compliance](UNIVERSAL_PROJECT_PROMPT.md#-compliance-requirements) | GDPR, ISO, PCI-DSS, SOC 2, SOX |
| [🚀 Deployment](UNIVERSAL_PROJECT_PROMPT.md#-deployment-architecture) | Production deployment guides |
| [📈 Scalability](UNIVERSAL_PROJECT_PROMPT.md#-scalability--performance-optimization) | Horizontal scaling, load balancing, caching |
| [🔄 Upgrade Guide](UNIVERSAL_PROJECT_PROMPT.md#-upgrade--migration-tools) | Zero-downtime deployment, migrations |
| [🌍 Internationalization](UNIVERSAL_PROJECT_PROMPT.md#internationalization-i18n-system) | i18n, 7 locales, RTL support |
| [🔔 Notifications](UNIVERSAL_PROJECT_PROMPT.md#notification-system-architecture) | Multi-channel notifications (Email, SMS, Push) |
| [🧪 Testing](UNIVERSAL_PROJECT_PROMPT.md#-testing-strategy) | Testing best practices |

---

## 🎓 Learn More

### Resources

- [OWASP Top 10 2021](https://owasp.org/www-project-top-ten/)
- [GDPR Official Guide](https://gdpr.eu/)
- [PCI-DSS Documentation](https://www.pcisecuritystandards.org/)
- [ISO 27001 Overview](https://www.iso.org/isoiec-27001-information-security.html)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)

### Tutorials

1. [Building Your First SaaS with the Universal Prompt](#) (Coming soon)
2. [Mobile App Security Best Practices](#) (Coming soon)
3. [Achieving SOC 2 Compliance](#) (Coming soon)
4. [Deploying with Cloudflare + Docker](#) (Coming soon)

---

<div align="center">

### Made with ❤️ by developers, for developers

**Star ⭐ this repo if you find it useful!**

[Report Bug](https://github.com/yourusername/universal-project-prompt/issues) · 
[Request Feature](https://github.com/yourusername/universal-project-prompt/issues) · 
[Documentation](UNIVERSAL_PROJECT_PROMPT.md) · 
[Quick Start](QUICK_START_GUIDE.md)

---

**Last Updated:** February 01, 2026 | **Version:** 2.0 | **License:** MIT

</div>
