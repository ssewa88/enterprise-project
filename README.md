# Enterprise DevOps Platform on AWS

## High-Level Overview

This project demonstrates how to build a modern, enterprise-style DevOps platform on AWS using Infrastructure as Code (IaC), Kubernetes, GitOps, CI/CD, Monitoring, and Deployment Automation.

The goal was not simply to deploy an application, but to build a reusable platform capable of provisioning infrastructure, deploying applications, monitoring workloads, and supporting multiple environments using industry best practices.

---

# Project Objectives

The project was designed to achieve the following goals:

* Provision AWS infrastructure using Terraform
* Store Terraform state remotely in S3
* Prevent concurrent Terraform modifications using DynamoDB locking
* Create reusable Terraform modules
* Containerize applications using Docker
* Store container images in Amazon ECR
* Deploy applications to Amazon EKS
* Package Kubernetes resources using Helm
* Automate CI/CD pipelines
* Implement GitOps workflows using Argo CD
* Monitor applications and infrastructure using Prometheus and Grafana
* Implement Blue/Green deployment strategies
* Support multiple environments (Dev and Staging)

---

# Architecture Overview

```text
Developer
    ↓
GitHub
    ↓
GitHub Actions (CI)
    ↓
Amazon ECR
    ↓
Argo CD (GitOps)
    ↓
Amazon EKS
    ↓
Helm Deployment
    ↓
Application

Observability Layer
├── Prometheus
└── Grafana

Infrastructure Layer
├── Terraform Bootstrap
├── S3 Remote State
├── DynamoDB Locking
├── Terraform Modules
├── Dev Environment
└── Staging Environment
```

---

# Phase 1: Terraform Bootstrap

## Problem

Terraform requires an S3 bucket and DynamoDB table before remote state can be used.

However, Terraform cannot store its state in resources that do not yet exist.

## Solution

Created a separate Bootstrap layer to provision:

```text
S3 Bucket
DynamoDB Lock Table
```

before deploying the rest of the infrastructure.

## Outcome

Terraform could safely store and lock state remotely.

---

# Phase 2: Remote State Management

## Services Used

* Amazon S3
* Amazon DynamoDB

## Purpose

Store Terraform state remotely and prevent multiple engineers from modifying infrastructure simultaneously.

## Benefits

```text
State durability
Collaboration
Versioning
State locking
Disaster recovery
```

---

# Phase 3: Terraform Module Design

## Problem

Copying Terraform code across environments creates duplication and maintenance challenges.

## Solution

Created reusable modules for:

```text
VPC
EKS
ECR
```

## Benefits

```text
Write once
Reuse everywhere
Reduce duplication
Improve consistency
```

---

# Phase 4: Amazon ECR

## Purpose

Store Docker container images.

## Flow

```text
Build Image
↓
Push to ECR
↓
Pull from EKS
```

## Outcome

Created centralized image storage for Kubernetes deployments.

---

# Phase 5: Amazon EKS

## Purpose

Run containerized applications on Kubernetes.

## Resources Created

```text
VPC
Public Subnets
Private Subnets
Internet Gateway
NAT Gateway
EKS Cluster
Managed Node Group
Security Groups
IAM Roles
```

## Benefits

```text
Scalability
High Availability
Container Orchestration
Self-Healing
```

---

# Phase 6: Helm

## Purpose

Package Kubernetes resources into reusable templates.

## Components Managed

```text
Deployment
Service
ConfigMaps
Autoscaling
Service Accounts
```

## Benefits

```text
Version control
Consistency
Reusability
Simplified deployments
```

---

# Phase 7: Application Deployment

## Application

Node.js containerized application.

## Deployment Flow

```text
Docker
↓
ECR
↓
Helm
↓
EKS
```

## Outcome

Successfully deployed application to Kubernetes using Helm charts.

---

# Phase 8: Jenkins CI/CD Pipeline

## Purpose

Automate application delivery.

## Pipeline Flow

```text
GitHub
↓
Jenkins
↓
Build Docker Image
↓
Push to ECR
↓
Deploy to EKS
```

## Lessons Learned

Resolved issues involving:

```text
Docker permissions
Missing Helm binaries
Kubeconfig access
IAM permissions
Pipeline debugging
```

---

# Phase 9: Monitoring with Prometheus

## Purpose

Collect cluster and application metrics.

## Metrics Collected

```text
CPU Utilization
Memory Usage
Node Metrics
Pod Metrics
Cluster Health
```

## Benefits

```text
Performance visibility
Capacity planning
Troubleshooting
```

---

# Phase 10: Visualization with Grafana

## Purpose

Visualize Prometheus metrics through dashboards.

## Dashboards

```text
Cluster Health
CPU Usage
Memory Usage
Node Utilization
Pod Performance
```

## Outcome

Built real-time observability into the platform.

---

# Phase 11: GitOps with Argo CD

## Purpose

Automate deployments using Git as the source of truth.

## Flow

```text
GitHub
↓
Argo CD
↓
Kubernetes
```

## Benefits

```text
Automated synchronization
Version-controlled deployments
Easy rollback
Reduced manual work
```

## Key Concept

```text
GitHub becomes the desired state.
Argo CD continuously reconciles the cluster.
```

---

# Phase 12: GitHub Actions CI Pipeline

## Purpose

Replace manual builds with automated image creation.

## Flow

```text
Git Push
↓
GitHub Actions
↓
Docker Build
↓
Push to ECR
↓
Update Deployment
```

## Benefits

```text
Automation
Consistency
Reduced deployment errors
Faster delivery
```

---

# Phase 13: Blue/Green Deployment Strategy

## Purpose

Deploy new versions without impacting users.

## Components

```text
Active Service
Preview Service
Argo Rollouts
```

## Flow

```text
Blue = Current Stable Version

Green = New Version
```

### Deployment Process

```text
Deploy Green
↓
Validate Green
↓
Promote Green
↓
Traffic Switch
```

## Benefits

```text
Near-zero downtime
Safe deployments
Fast rollback
Controlled releases
```

---

# Phase 14: Multi-Environment Infrastructure

## Environments Created

```text
Dev
Staging
```

## Why?

Separate environments allow infrastructure and application changes to be validated before broader rollout.

## Staging Components

```text
staging-enterprise-vpc
staging-enterprise-eks
staging-hello-app
staging Terraform state
```

## Benefits

```text
Environment isolation
Safer testing
Infrastructure promotion
Reduced risk
```

---

# Source Control Strategy

## Branches

```text
main
staging
```

## Purpose

Support environment separation and GitOps workflows.

```text
main     → primary environment
staging  → staging environment
```

---

# Monitoring and Observability

## Prometheus

Responsible for:

```text
Collecting metrics
Monitoring workloads
Tracking cluster health
```

## Grafana

Responsible for:

```text
Visualizing metrics
Building dashboards
Detecting trends
Identifying performance issues
```

---

# Security Practices

Implemented:

```text
IAM Roles
Least Privilege Access
Private Subnets
Terraform State Locking
Remote State Encryption
Security Groups
```

---

# Key Lessons Learned

## Infrastructure as Code

Infrastructure should be repeatable, version-controlled, and automated.

## Terraform Modules

Reusable infrastructure reduces duplication and improves maintainability.

## GitOps

Git should become the single source of truth for deployments.

## Kubernetes

Applications should be self-healing and scalable.

## Monitoring

You cannot reliably operate systems you cannot observe.

## Blue/Green Deployments

Production changes should be validated before receiving live traffic.

## Environment Separation

Testing should occur in isolated environments before broader rollout.

---

# Tools Used

## Cloud

```text
AWS
```

## Infrastructure as Code

```text
Terraform
```

## Containers

```text
Docker
Amazon ECR
```

## Container Orchestration

```text
Amazon EKS
Kubernetes
Helm
```

## CI/CD

```text
Jenkins
GitHub Actions
```

## GitOps

```text
Argo CD
```

## Monitoring

```text
Prometheus
Grafana
```

## Deployment Strategies

```text
Argo Rollouts
Blue/Green Deployments
```

---

# Final Outcome

Built a complete enterprise-style cloud platform capable of:

```text
Provisioning Infrastructure
Managing Kubernetes Clusters
Automating Deployments
Implementing GitOps
Monitoring Applications
Supporting Multiple Environments
Performing Blue/Green Releases
```

The project demonstrates the full lifecycle of modern cloud-native application delivery and incorporates many of the same practices used by Platform Engineering, DevOps, and Cloud Engineering teams in production environments.
