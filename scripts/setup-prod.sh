#!/bin/bash
#
# Production Environment Setup Script
# Secure setup for production deployments
#

set -e

echo "========================================="
echo "  Production Environment Setup"
echo "========================================="
echo ""

# Require root for production setup
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root for production setup"
    echo "Please run: sudo $0"
    exit 1
fi

# Check prerequisites
echo "Checking prerequisites..."
bash ./scripts/check-prerequisites.sh || exit 1

echo ""
echo "=== Step 1: Security Hardening ==="
echo ""

# Configure firewall
echo "Configuring firewall (UFW)..."
ufw --force enable
ufw allow 22/tcp   # SSH
ufw allow 80/tcp   # HTTP
ufw allow 443/tcp  # HTTPS
ufw reload
echo "✓ Firewall configured"

# Disable password authentication for SSH
echo "Hardening SSH configuration..."
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart sshd
echo "✓ SSH hardened"

# Install fail2ban
if ! command -v fail2ban-client &> /dev/null; then
    echo "Installing fail2ban..."
    apt-get update
    apt-get install -y fail2ban
    systemctl enable fail2ban
    systemctl start fail2ban
    echo "✓ fail2ban installed"
fi

# Configure automatic security updates
echo "Configuring automatic security updates..."
apt-get install -y unattended-upgrades
dpkg-reconfigure -plow unattended-upgrades
echo "✓ Automatic updates configured"

echo ""
echo "=== Step 2: Application User Setup ==="
echo ""

# Create application user
if ! id -u appuser > /dev/null 2>&1; then
    echo "Creating application user..."
    useradd -r -s /bin/false appuser
    echo "✓ User 'appuser' created"
else
    echo "User 'appuser' already exists"
fi

# Create application directory
APP_DIR="/opt/app"
mkdir -p $APP_DIR
chown appuser:appuser $APP_DIR
echo "✓ Application directory created: $APP_DIR"

echo ""
echo "=== Step 3: Environment Configuration ==="
echo ""

# Create production .env file
if [ ! -f "$APP_DIR/.env" ]; then
    echo "Creating production .env file..."
    echo "Please enter the following values:"

    read -p "Database URL: " DATABASE_URL
    read -p "Redis URL: " REDIS_URL
    read -sp "JWT Secret (min 32 chars): " JWT_SECRET
    echo ""
    read -sp "Session Secret: " SESSION_SECRET
    echo ""

    cat > $APP_DIR/.env << EOF
# Production Environment Configuration

NODE_ENV=production
PORT=3000

# Database
DATABASE_URL=$DATABASE_URL

# Redis
REDIS_URL=$REDIS_URL

# Secrets
JWT_SECRET=$JWT_SECRET
SESSION_SECRET=$SESSION_SECRET

# Email
SMTP_HOST=
SMTP_PORT=587
SMTP_USER=
SMTP_PASSWORD=
FROM_EMAIL=noreply@yourdomain.com

# Feature Flags
ENABLE_EMAIL_NOTIFICATIONS=true
ENABLE_SMS_NOTIFICATIONS=false
EOF

    # Secure .env file
    chmod 600 $APP_DIR/.env
    chown appuser:appuser $APP_DIR/.env
    echo "✓ Production .env file created"
else
    echo ".env file already exists at $APP_DIR/.env"
fi

echo ""
echo "=== Step 4: Database Setup ==="
echo ""

echo "Setting up production database..."
echo "Please ensure PostgreSQL is installed and running"
echo "Run migrations manually after deployment:"
echo "  cd $APP_DIR && sudo -u appuser npx prisma migrate deploy"

echo ""
echo "=== Step 5: SSL/TLS Configuration ==="
echo ""

# Install Certbot for Let's Encrypt
if ! command -v certbot &> /dev/null; then
    echo "Installing Certbot..."
    apt-get install -y certbot python3-certbot-nginx
    echo "✓ Certbot installed"
fi

echo "To obtain SSL certificate, run:"
echo "  sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com"

echo ""
echo "=== Step 6: Systemd Service Setup ==="
echo ""

# Create systemd service file
cat > /etc/systemd/system/app.service << 'EOF'
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
EOF

# Reload systemd
systemctl daemon-reload
echo "✓ Systemd service created"

echo ""
echo "=== Step 7: Log Rotation Setup ==="
echo ""

# Configure log rotation
cat > /etc/logrotate.d/app << 'EOF'
/var/log/app/*.log {
    daily
    rotate 14
    compress
    delaycompress
    notifempty
    create 0640 appuser appuser
    sharedscripts
    postrotate
        systemctl reload app
    endscript
}
EOF

echo "✓ Log rotation configured"

echo ""
echo "=== Step 8: Monitoring Setup ==="
echo ""

# Create monitoring directory
mkdir -p /var/log/app
chown appuser:appuser /var/log/app
chmod 750 /var/log/app
echo "✓ Monitoring directory created"

echo ""
echo "========================================="
echo "  Production Setup Complete!"
echo "========================================="
echo ""
echo "Next steps:"
echo "  1. Deploy your application code to: $APP_DIR"
echo "  2. Install dependencies: cd $APP_DIR && npm ci --production"
echo "  3. Run database migrations: npx prisma migrate deploy"
echo "  4. Start the service: systemctl start app"
echo "  5. Enable auto-start: systemctl enable app"
echo "  6. Check status: systemctl status app"
echo ""
echo "SSL Certificate:"
echo "  sudo certbot --nginx -d yourdomain.com"
echo ""
echo "Important files:"
echo "  Application: $APP_DIR"
echo "  Environment: $APP_DIR/.env"
echo "  Service: /etc/systemd/system/app.service"
echo "  Logs: /var/log/app/"
echo ""
echo "Security reminders:"
echo "  - Change default passwords"
echo "  - Review firewall rules"
echo "  - Set up monitoring and alerting"
echo "  - Configure backup strategy"
echo ""
