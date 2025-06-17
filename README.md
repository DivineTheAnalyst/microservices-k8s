<!-- <p align="center">
<img src="/src/frontend/static/icons/Hipster_HeroLogoMaroon.svg" width="300" alt="Online Boutique" />
</p> -->

# Online Boutique Microservices on AWS EKS

![Architecture](https://img.shields.io/badge/Architecture-Microservices-blue)
![Platform](https://img.shields.io/badge/Platform-AWS%20EKS-orange)
![Deployment](https://img.shields.io/badge/Deployment-Helm-green)
![Security](https://img.shields.io/badge/Security-External%20Secrets-red)

**Online Boutique** is a cloud-native microservices demo application deployed on **AWS EKS** using modern DevOps practices. This project demonstrates how to deploy a production-ready e-commerce application with 11 microservices using **Helm Charts**, **External Secrets Operator**, and **NGINX Ingress Controller**.

> **🔧 Custom Implementation**: This is a complete re-implementation of Google's microservices demo. All original Helm charts, Dockerfiles, and Kubernetes manifests were removed and rebuilt from scratch to demonstrate enterprise-grade deployment patterns, security best practices, and AWS-native integrations.

## 🌟 What Makes This Different

- **Built from Scratch**: Complete custom Helm charts with production-ready configurations
- **AWS-Native**: Leverages AWS Secrets Manager, EKS, and ELB integrations
- **Security-First**: External Secrets Operator, security headers, and rate limiting
- **Production-Ready**: Resource limits, health checks, and horizontal pod autoscaling
- **Enterprise Patterns**: Proper secret management and ingress configuration

## 🏗️ Architecture Overview

This implementation transforms Google's microservices demo into a production-ready AWS EKS deployment with enterprise-grade security and operational practices.

[![Architecture Diagram](/docs/img/architecture-diagram.png)](/docs/img/architecture-diagram.png)

### 🔧 Technology Stack

- **Container Orchestration**: AWS EKS (Kubernetes 1.28+)
- **Package Management**: Helm 3.x
- **Secret Management**: AWS Secrets Manager + External Secrets Operator
- **Ingress Controller**: NGINX Ingress Controller
- **Service Mesh**: gRPC communication between services
- **Infrastructure**: AWS (EKS, Secrets Manager, ELB)

## 🎯 Key Features

- ✅ **Production-Ready Deployment** with Helm Charts
- ✅ **Secure Secret Management** using AWS Secrets Manager
- ✅ **External Secrets Operator** for automated secret synchronization
- ✅ **NGINX Ingress** with security headers and rate limiting
- ✅ **Multi-language Microservices** (Go, C#, Node.js, Python, Java)
- ✅ **Horizontal Pod Autoscaling** configuration
- ✅ **Production-grade Security** headers and policies

## 🏪 Microservices Architecture

| Service | Language | Description | Port |
|---------|----------|-------------|------|
| **Frontend** | Go | Web UI and user session management | 8080 |
| **Cart Service** | C# | Shopping cart management with Redis | 7070 |
| **Product Catalog** | Go | Product inventory and search | 3550 |
| **Currency Service** | Node.js | Real-time currency conversion | 7000 |
| **Payment Service** | Node.js | Payment processing (mock) | 3002 |
| **Shipping Service** | Go | Shipping cost calculation | 8081 |
| **Email Service** | Python | Order confirmation emails | 5001 |
| **Checkout Service** | Go | Order orchestration | 5050 |
| **Recommendation** | Python | ML-based product recommendations | 5002 |
| **Ad Service** | Java | Contextual advertisements | 9555 |
| **Shopping Assistant** | Go | AI-powered shopping assistant | 8005 |

## 🚀 Quick Start

### Prerequisites

- AWS CLI configured with appropriate permissions
- kubectl installed and configured
- Helm 3.x installed
- eksctl installed

### 1. Clone the Repository

```bash
git clone https://github.com/DivineTheAnalyst/microservices-k8s.git
cd microservices-k8s
```

### 2. Create EKS Cluster

```bash
# Create EKS cluster
eksctl create cluster \
  --name ije-cluster \
  --region us-east-1 \
  --nodes 3 \
  --nodes-min 2 \
  --nodes-max 4 \
  --node-type t3.medium \
  --managed

# Verify cluster access
kubectl get nodes
```

### 3. Install External Secrets Operator

```bash
# Install External Secrets Operator
helm repo add external-secrets https://charts.external-secrets.io
helm install external-secrets external-secrets/external-secrets -n external-secrets-system --create-namespace
```

### 4. Configure AWS Secrets Manager

```bash
# Create secret in AWS Secrets Manager
aws secretsmanager create-secret \
  --name microservices/services \
  --secret-string '{
    "PRODUCT_CATALOG_SERVICE_ADDR":"productcatalogservice:3550",
    "CURRENCY_SERVICE_ADDR":"currencyservice:7000",
    "CART_SERVICE_ADDR":"cartservice:7070",
    "RECOMMENDATION_SERVICE_ADDR":"recommendationservice:5002",
    "SHIPPING_SERVICE_ADDR":"shippingservice:8081",
    "CHECKOUT_SERVICE_ADDR":"checkoutservice:5050",
    "AD_SERVICE_ADDR":"adservice:9555",
    "PAYMENT_SERVICE_ADDR":"paymentservice:3002",
    "EMAIL_SERVICE_ADDR":"emailservice:5001",
    "SHOPPING_ASSISTANT_SERVICE_ADDR":"shoppingassistantservice:8005",
    "REDIS_HOST":"redis:6379"
  }' \
  --region us-east-1
```

### 5. Deploy Application with Helm

```bash
# Create namespace
kubectl create namespace online-boutique

# Deploy application
helm install online-boutique ./helm-charts/my-online-boutique/ --namespace online-boutique

# Verify deployment
kubectl get pods -n online-boutique
```

### 6. Install NGINX Ingress Controller

```bash
# Install NGINX Ingress
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/aws/deploy.yaml

# Apply ingress configuration
kubectl apply -f k8s-manifests/ingress.yaml
```

### 7. Access the Application

```bash
# Get external IP
kubectl get service ingress-nginx-controller -n ingress-nginx

# Access application
curl http://<EXTERNAL-IP>
```

## 📁 Project Structure

```
microservices-k8s/
├── helm-charts/
│   └── my-online-boutique/
│       ├── Chart.yaml
│       ├── values.yaml
│       └── templates/
│           ├── deployments/
│           ├── services/
│           ├── external-secrets.yaml
│           └── hpa.yaml
├── k8s-manifests/
|   ├── deployments
|   ├── external-secrets
|   ├── HPA
|   ├── RBAC
|   ├── secrets
│   ├── ingress.yaml
│   ├── ClusterIssuer.yaml
│   └── secretstore.yaml
├── src/
│   ├── frontend/
│   ├── cartservice/
│   └── [other microservices]
└── docs/
    └── img/
```

## 🔒 Security Features

- **External Secrets Operator**: Automated secret synchronization from AWS Secrets Manager
- **NGINX Security Headers**: XSS protection, content type options, frame options
- **Rate Limiting**: 100 requests total, 10 RPS per client
- **Resource Limits**: CPU and memory constraints for all services
- **Network Policies**: Controlled inter-service communication

## 📊 Monitoring & Observability

- **Health Checks**: Liveness and readiness probes for all services
- **Horizontal Pod Autoscaling**: Automatic scaling based on CPU utilization
- **Ingress Monitoring**: Request logging and metrics
- **Resource Monitoring**: CPU, memory, and network usage tracking

## 🛠️ Development

### Local Development

```bash
# Port forward to frontend service
kubectl port-forward -n online-boutique svc/frontend 8080:8080

# Access application locally
open http://localhost:8080
```

### Update Configuration

```bash
# Update Helm values
helm upgrade online-boutique ./helm-charts/my-online-boutique/ --namespace online-boutique

# Update secrets in AWS Secrets Manager
aws secretsmanager update-secret --secret-id microservices/services --secret-string '{...}'
```

## 🚨 Troubleshooting

### Common Issues

**External Secrets not syncing:**
```bash
kubectl describe externalsecret -n online-boutique
kubectl logs -n external-secrets-system -l app.kubernetes.io/name=external-secrets
```

**Pods in CreateContainerConfigError:**
```bash
# Check if secrets exist
kubectl get secrets -n online-boutique
kubectl describe pod <pod-name> -n online-boutique
```

**Ingress not working:**
```bash
kubectl describe ingress app-ingress
kubectl get endpoints -n online-boutique
```

## 📈 Scaling

### Horizontal Pod Autoscaling

```bash
# Check HPA status
kubectl get hpa -n online-boutique

# Manually scale deployment
kubectl scale deployment frontend-deployment --replicas=3 -n online-boutique
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Original Google Cloud microservices demo
- AWS EKS documentation
- External Secrets Operator community
- NGINX Ingress Controller maintainers

## 📞 Support

For questions and support:
- 📧 Email: dnkwocha14@gmail.com
- 💬 GitHub Issues: [Create an issue](https://github.com/DivineTheAnalyst/microservices-k8s/issues)

---

⭐ **Star this repository if you found it helpful!**
