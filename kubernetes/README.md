# Kubernetes Deployment Manifests

Production-ready Kubernetes manifests for deploying your application to any Kubernetes cluster (EKS, GKE, AKS, on-premises).

## Table of Contents

- [Quick Start](#quick-start)
- [Prerequisites](#prerequisites)
- [Directory Structure](#directory-structure)
- [Deployment Guide](#deployment-guide)
- [Configuration](#configuration)
- [Monitoring & Observability](#monitoring--observability)
- [Security](#security)
- [Scaling](#scaling)
- [Troubleshooting](#troubleshooting)
- [Cloud Provider Specific Guides](#cloud-provider-specific-guides)

## Quick Start

```bash
# 1. Install prerequisites
kubectl version --client
kustomize version

# 2. Create namespace and secrets
kubectl create namespace myapp
kubectl create secret generic app-secrets \
  --namespace=myapp \
  --from-literal=DATABASE_URL="postgresql://user:pass@host:5432/db" \
  --from-literal=JWT_SECRET="your-32-char-secret-here" \
  --from-literal=SESSION_SECRET="your-session-secret"

# 3. Deploy to development
kubectl apply -k kubernetes/overlays/development

# 4. Verify deployment
kubectl get pods -n myapp-dev
kubectl logs -f deployment/dev-app -n myapp-dev

# 5. Access application
kubectl port-forward service/dev-app-service 8080:80 -n myapp-dev
# Open http://localhost:8080
```

## Prerequisites

### Required Tools

- **kubectl** 1.28+ - Kubernetes command-line tool
  ```bash
  # Install kubectl
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x kubectl
  sudo mv kubectl /usr/local/bin/
  ```

- **kustomize** 5.0+ - Kubernetes configuration management (optional, kubectl has built-in support)
  ```bash
  # Install kustomize
  curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
  sudo mv kustomize /usr/local/bin/
  ```

- **helm** 3.12+ - Package manager for Kubernetes (for dependencies)
  ```bash
  # Install Helm
  curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
  ```

### Cluster Requirements

- Kubernetes 1.28+ cluster
- Metrics Server (for HPA)
- Ingress Controller (Nginx recommended)
- Cert-Manager (for automatic SSL)
- Storage provisioner (for persistent volumes)

### Install Cluster Components

```bash
# 1. Install Metrics Server (for HPA)
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# 2. Install Nginx Ingress Controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.4/deploy/static/provider/cloud/deploy.yaml

# 3. Install Cert-Manager (for SSL certificates)
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.2/cert-manager.yaml

# 4. Verify installations
kubectl get pods -n kube-system
kubectl get pods -n ingress-nginx
kubectl get pods -n cert-manager
```

## Directory Structure

```
kubernetes/
├── base/                          # Base manifests (environment-agnostic)
│   ├── namespace.yaml            # Namespace definition
│   ├── configmap.yaml            # Non-sensitive configuration
│   ├── secret.yaml               # Secret template (DO NOT commit actual secrets)
│   ├── deployment.yaml           # Application deployment
│   ├── service.yaml              # Service definitions (ClusterIP, LoadBalancer)
│   ├── ingress.yaml              # Ingress routing rules
│   ├── hpa.yaml                  # Horizontal Pod Autoscaler
│   ├── rbac.yaml                 # RBAC (ServiceAccount, Role, RoleBinding)
│   ├── pdb.yaml                  # PodDisruptionBudget, ResourceQuota, LimitRange
│   └── kustomization.yaml        # Kustomize base configuration
│
├── overlays/                      # Environment-specific overlays
│   ├── development/              # Development environment
│   │   ├── kustomization.yaml   # Dev-specific overrides
│   │   ├── deployment-patch.yaml # Lower resources, faster startup
│   │   └── hpa-patch.yaml       # Minimal scaling
│   │
│   ├── staging/                  # Staging environment
│   │   ├── kustomization.yaml   # Staging-specific overrides
│   │   ├── deployment-patch.yaml # Moderate resources
│   │   └── hpa-patch.yaml       # Moderate scaling
│   │
│   └── production/               # Production environment
│       ├── kustomization.yaml   # Production overrides
│       ├── deployment-patch.yaml # Full resources, anti-affinity
│       └── hpa-patch.yaml       # Aggressive scaling
│
└── README.md                     # This file
```

## Deployment Guide

### Step 1: Configure Container Registry

Update `kustomization.yaml` in each overlay to point to your container registry:

```yaml
# kubernetes/overlays/production/kustomization.yaml
images:
  - name: your-registry/your-app
    newName: ghcr.io/yourorg/yourapp  # Or docker.io, gcr.io, etc.
    newTag: v1.0.0
```

### Step 2: Create Secrets

**Option 1: From Literal Values (Quick Testing)**

```bash
kubectl create secret generic app-secrets \
  --namespace=myapp \
  --from-literal=DATABASE_URL="postgresql://user:pass@host:5432/db" \
  --from-literal=JWT_SECRET="$(openssl rand -base64 32)" \
  --from-literal=SESSION_SECRET="$(openssl rand -base64 32)" \
  --from-literal=SMTP_PASSWORD="your-smtp-password"
```

**Option 2: From Files (Recommended for Production)**

```bash
# Create secret files (DO NOT commit these)
echo -n "postgresql://..." > /tmp/database-url
echo -n "$(openssl rand -base64 32)" > /tmp/jwt-secret

# Create secret from files
kubectl create secret generic app-secrets \
  --namespace=myapp \
  --from-file=DATABASE_URL=/tmp/database-url \
  --from-file=JWT_SECRET=/tmp/jwt-secret

# Clean up secret files
rm /tmp/database-url /tmp/jwt-secret
```

**Option 3: Using Sealed Secrets (Encrypted in Git)**

```bash
# Install Sealed Secrets controller
kubectl apply -f https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.24.0/controller.yaml

# Create secret YAML
cat <<EOF > secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secrets
  namespace: myapp
stringData:
  DATABASE_URL: "postgresql://..."
EOF

# Encrypt secret
kubeseal --format=yaml < secret.yaml > sealed-secret.yaml

# Commit sealed-secret.yaml to git (safe to commit)
kubectl apply -f sealed-secret.yaml
```

**Option 4: Using External Secrets Operator (AWS, Vault, etc.)**

```bash
# Install External Secrets Operator
helm repo add external-secrets https://charts.external-secrets.io
helm install external-secrets external-secrets/external-secrets -n external-secrets-system --create-namespace

# Create SecretStore (AWS Secrets Manager example)
kubectl apply -f - <<EOF
apiVersion: external-secrets.io/v1beta1
kind: SecretStore
metadata:
  name: aws-secrets
  namespace: myapp
spec:
  provider:
    aws:
      service: SecretsManager
      region: us-east-1
EOF

# Create ExternalSecret
kubectl apply -f - <<EOF
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: app-secrets
  namespace: myapp
spec:
  refreshInterval: 1h
  secretStoreRef:
    name: aws-secrets
    kind: SecretStore
  target:
    name: app-secrets
  data:
    - secretKey: DATABASE_URL
      remoteRef:
        key: myapp/database-url
    - secretKey: JWT_SECRET
      remoteRef:
        key: myapp/jwt-secret
EOF
```

### Step 3: Deploy Application

**Development Environment:**

```bash
# Deploy
kubectl apply -k kubernetes/overlays/development

# Verify
kubectl get all -n myapp-dev
kubectl logs -f deployment/dev-app -n myapp-dev

# Port forward to access locally
kubectl port-forward service/dev-app-service 8080:80 -n myapp-dev
```

**Staging Environment:**

```bash
# Deploy
kubectl apply -k kubernetes/overlays/staging

# Verify
kubectl get all -n myapp-staging
kubectl describe pod -l app.kubernetes.io/name=myapp -n myapp-staging
```

**Production Environment:**

```bash
# Deploy
kubectl apply -k kubernetes/overlays/production

# Verify
kubectl get all -n myapp-prod
kubectl rollout status deployment/prod-app -n myapp-prod

# Check pod health
kubectl get pods -n myapp-prod -o wide
kubectl top pods -n myapp-prod
```

### Step 4: Configure Ingress & SSL

Update `ingress.yaml` with your domain:

```yaml
# kubernetes/base/ingress.yaml
spec:
  tls:
    - hosts:
        - yourdomain.com
        - www.yourdomain.com
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

Cert-Manager will automatically provision SSL certificates from Let's Encrypt.

```bash
# Check certificate status
kubectl get certificate -n myapp
kubectl describe certificate app-tls-secret -n myapp

# Check ingress
kubectl get ingress -n myapp
```

## Configuration

### Environment Variables

Edit `configmap.yaml` for non-sensitive configuration:

```yaml
# kubernetes/base/configmap.yaml
data:
  NODE_ENV: "production"
  PORT: "3000"
  LOG_LEVEL: "info"
  # Add your variables here
```

For secrets, use `kubectl create secret` (see [Step 2](#step-2-create-secrets)).

### Resource Limits

Adjust resource limits in overlay patches:

```yaml
# kubernetes/overlays/production/deployment-patch.yaml
containers:
  - name: app
    resources:
      requests:
        cpu: "500m"       # Increase for higher performance
        memory: "1Gi"
      limits:
        cpu: "2000m"
        memory: "2Gi"
```

### Scaling Configuration

Edit HPA settings for auto-scaling:

```yaml
# kubernetes/base/hpa.yaml
spec:
  minReplicas: 3
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          averageUtilization: 70  # Scale at 70% CPU
```

## Monitoring & Observability

### Health Checks

The application exposes health check endpoints:

- `/health` - Liveness probe (restart pod if fails)
- `/ready` - Readiness probe (remove from service if fails)

```bash
# Test health endpoints
kubectl exec -it deployment/app -n myapp -- curl localhost:3000/health
kubectl exec -it deployment/app -n myapp -- curl localhost:3000/ready
```

### Logs

```bash
# View logs from all pods
kubectl logs -l app.kubernetes.io/name=myapp -n myapp --tail=100 -f

# View logs from specific pod
kubectl logs pod/app-xxxx -n myapp -f

# View logs from previous crashed container
kubectl logs pod/app-xxxx -n myapp --previous
```

### Metrics

```bash
# Pod resource usage
kubectl top pods -n myapp

# Node resource usage
kubectl top nodes

# HPA status
kubectl get hpa -n myapp
kubectl describe hpa app-hpa -n myapp
```

### Prometheus & Grafana

Pods are annotated for Prometheus scraping:

```yaml
annotations:
  prometheus.io/scrape: "true"
  prometheus.io/port: "3000"
  prometheus.io/path: "/metrics"
```

Install Prometheus stack:

```bash
# Install Prometheus Operator
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/kube-prometheus-stack \
  --namespace observability \
  --create-namespace

# Access Grafana
kubectl port-forward service/prometheus-grafana 3000:80 -n observability
# Login: admin / prom-operator
```

### Distributed Tracing

OpenTelemetry traces are exported to Jaeger:

```bash
# Install Jaeger Operator
kubectl create namespace observability
kubectl apply -f https://github.com/jaegertracing/jaeger-operator/releases/download/v1.51.0/jaeger-operator.yaml -n observability

# Create Jaeger instance
kubectl apply -f - <<EOF
apiVersion: jaegertracing.io/v1
kind: Jaeger
metadata:
  name: jaeger
  namespace: observability
spec:
  strategy: production
  storage:
    type: elasticsearch
EOF

# Access Jaeger UI
kubectl port-forward service/jaeger-query 16686:16686 -n observability
```

## Security

### RBAC

The deployment uses a dedicated ServiceAccount with minimal permissions:

- Read ConfigMaps, Services, Pods
- Create Events
- No Secret access (secrets are mounted as environment variables)

### Network Policies

Network policies restrict pod traffic:

- Ingress: Only from Ingress Controller and same namespace
- Egress: Only to PostgreSQL, Redis, DNS, HTTPS, SMTP, OpenTelemetry

```bash
# Verify network policies
kubectl get networkpolicy -n myapp
kubectl describe networkpolicy app-network-policy -n myapp
```

### Pod Security

Pods run with security best practices:

- Non-root user (UID 1000)
- Read-only root filesystem
- No privilege escalation
- Dropped all capabilities
- Seccomp profile enabled

### Secrets Management

**Best Practices:**

1. Never commit secrets to git
2. Use Sealed Secrets or External Secrets Operator for production
3. Rotate secrets regularly (90-day rotation recommended)
4. Use different secrets per environment

```bash
# Rotate JWT secret
kubectl create secret generic app-secrets \
  --namespace=myapp \
  --from-literal=JWT_SECRET="$(openssl rand -base64 32)" \
  --dry-run=client -o yaml | kubectl apply -f -

# Restart pods to pick up new secret
kubectl rollout restart deployment/app -n myapp
```

## Scaling

### Manual Scaling

```bash
# Scale to 5 replicas
kubectl scale deployment/app --replicas=5 -n myapp

# Verify
kubectl get pods -n myapp
```

### Auto-Scaling (HPA)

HPA automatically scales based on CPU/memory:

```bash
# Check HPA status
kubectl get hpa -n myapp

# Example output:
# NAME      REFERENCE        TARGETS   MINPODS   MAXPODS   REPLICAS
# app-hpa   Deployment/app   45%/70%   3         10        3
```

### Vertical Pod Autoscaler (Optional)

VPA automatically adjusts resource requests:

```bash
# Install VPA
git clone https://github.com/kubernetes/autoscaler.git
cd autoscaler/vertical-pod-autoscaler
./hack/vpa-up.sh

# Apply VPA (see pdb.yaml for example)
kubectl apply -f kubernetes/base/pdb.yaml
```

## Troubleshooting

### Pod Not Starting

```bash
# Check pod status
kubectl get pods -n myapp

# Describe pod for events
kubectl describe pod app-xxxx -n myapp

# Check logs
kubectl logs app-xxxx -n myapp

# Check previous crashed container
kubectl logs app-xxxx -n myapp --previous

# Common issues:
# 1. ImagePullBackOff - Check image name/tag, registry auth
# 2. CrashLoopBackOff - Check logs for application errors
# 3. Pending - Check resource availability, node selectors
```

### Health Check Failures

```bash
# Test health endpoints
kubectl exec -it pod/app-xxxx -n myapp -- curl localhost:3000/health
kubectl exec -it pod/app-xxxx -n myapp -- curl localhost:3000/ready

# Check liveness probe
kubectl describe pod app-xxxx -n myapp | grep -A 5 Liveness

# Adjust probe timings if startup is slow
# Edit deployment.yaml: initialDelaySeconds, timeoutSeconds
```

### Database Connection Issues

```bash
# Test database connectivity
kubectl exec -it pod/app-xxxx -n myapp -- sh
> nc -zv postgres-service.myapp.svc.cluster.local 5432

# Check DATABASE_URL secret
kubectl get secret app-secrets -n myapp -o jsonpath='{.data.DATABASE_URL}' | base64 -d

# Check network policy allows database access
kubectl describe networkpolicy app-network-policy -n myapp
```

### Ingress Not Working

```bash
# Check ingress status
kubectl get ingress -n myapp
kubectl describe ingress app-ingress -n myapp

# Check Ingress Controller logs
kubectl logs -n ingress-nginx -l app.kubernetes.io/component=controller

# Check SSL certificate
kubectl get certificate -n myapp
kubectl describe certificate app-tls-secret -n myapp

# Test without Ingress
kubectl port-forward service/app-service 8080:80 -n myapp
curl http://localhost:8080
```

### High Memory Usage

```bash
# Check pod memory usage
kubectl top pods -n myapp

# Increase memory limit
# Edit kubernetes/overlays/production/deployment-patch.yaml
# resources.limits.memory: "2Gi"

# Apply changes
kubectl apply -k kubernetes/overlays/production
```

## Cloud Provider Specific Guides

### Amazon EKS

```bash
# Create EKS cluster
eksctl create cluster \
  --name myapp-cluster \
  --region us-east-1 \
  --nodes 3 \
  --node-type t3.medium

# Install AWS Load Balancer Controller
helm repo add eks https://aws.github.io/eks-charts
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=myapp-cluster

# Use ALB for Ingress
# Add annotation to ingress.yaml:
# kubernetes.io/ingress.class: alb
# alb.ingress.kubernetes.io/scheme: internet-facing
```

### Google GKE

```bash
# Create GKE cluster
gcloud container clusters create myapp-cluster \
  --num-nodes=3 \
  --machine-type=n1-standard-2 \
  --region=us-central1

# Get credentials
gcloud container clusters get-credentials myapp-cluster --region=us-central1

# GKE has built-in Ingress (no need for Nginx)
# Remove kubernetes.io/ingress.class annotation
```

### Azure AKS

```bash
# Create AKS cluster
az aks create \
  --resource-group myapp-rg \
  --name myapp-cluster \
  --node-count 3 \
  --node-vm-size Standard_D2s_v3 \
  --enable-managed-identity

# Get credentials
az aks get-credentials --resource-group myapp-rg --name myapp-cluster

# Install Application Gateway Ingress Controller (optional)
# Or use Nginx Ingress Controller (recommended)
```

### Local Development (Minikube/Kind)

```bash
# Install Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Start cluster
minikube start --cpus=4 --memory=8192

# Enable Ingress addon
minikube addons enable ingress
minikube addons enable metrics-server

# Deploy application
kubectl apply -k kubernetes/overlays/development

# Access via Minikube tunnel
minikube tunnel

# OR use Kind (Kubernetes in Docker)
kind create cluster --config - <<EOF
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
EOF
```

## Advanced Topics

### Blue-Green Deployment

```bash
# Deploy new version (green)
kubectl apply -k kubernetes/overlays/production --prune -l version=v2.0.0

# Test green deployment
kubectl port-forward service/app-service-v2 8080:80 -n myapp

# Switch traffic (update Service selector)
kubectl patch service app-service -n myapp -p '{"spec":{"selector":{"version":"v2.0.0"}}}'

# Rollback if needed
kubectl patch service app-service -n myapp -p '{"spec":{"selector":{"version":"v1.0.0"}}}'
```

### Canary Deployment

Use a service mesh (Istio, Linkerd) or Flagger for automated canary deployments:

```bash
# Install Flagger
helm repo add flagger https://flagger.app
helm install flagger flagger/flagger \
  --namespace ingress-nginx \
  --set meshProvider=nginx

# Create Canary resource
kubectl apply -f - <<EOF
apiVersion: flagger.app/v1beta1
kind: Canary
metadata:
  name: app
  namespace: myapp
spec:
  targetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: app
  progressDeadlineSeconds: 60
  service:
    port: 80
  analysis:
    interval: 1m
    threshold: 5
    maxWeight: 50
    stepWeight: 10
    metrics:
    - name: request-success-rate
      thresholdRange:
        min: 99
      interval: 1m
EOF
```

## Resources

- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Kustomize Documentation](https://kustomize.io/)
- [Kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- [Production Best Practices](https://kubernetes.io/docs/concepts/configuration/overview/)
- [Security Best Practices](https://kubernetes.io/docs/concepts/security/security-checklist/)

## Support

For issues or questions:
- Check troubleshooting section above
- Review Kubernetes events: `kubectl get events -n myapp --sort-by='.lastTimestamp'`
- Check pod logs: `kubectl logs -l app.kubernetes.io/name=myapp -n myapp`
- Describe resources: `kubectl describe deployment/app -n myapp`
