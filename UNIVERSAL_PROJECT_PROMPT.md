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
