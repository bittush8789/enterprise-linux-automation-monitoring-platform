# Enterprise Linux Server Automation & Monitoring Platform

![Build Status](https://img.shields.io/github/actions/workflow/status/username/repo/ci-cd.yml?branch=main)
![Python Version](https://img.shields.io/badge/python-3.12-blue.svg)
![Terraform Version](https://img.shields.io/badge/terraform-%3E%3D1.5.0-623CE4.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![Docker](https://img.shields.io/badge/docker-ready-blue.svg)

A complete production-grade Enterprise Linux Server Automation & Monitoring Platform from scratch.

## Architecture

This platform consists of:
- **AWS Infrastructure:** Provisioned using Terraform.
- **Configuration Management:** Server hardening and package installation via Ansible.
- **Monitoring Stack:** Prometheus, Grafana, Loki, Alertmanager (Dockerized).
- **Core API:** FastAPI backend for managing users, servers, metrics, and alerts.
- **Automation Scripts:** Bash scripts for backups and cleanup.
- **CI/CD:** GitHub Actions for linting, security scanning (Trivy, Bandit), and testing.

## Prerequisites

- AWS CLI configured
- Terraform installed
- Ansible installed
- Docker & Docker Compose installed

## Setup Instructions

1. **Deploy Infrastructure**
   ```bash
   cd terraform
   terraform init
   terraform apply
   ```

2. **Configure Servers**
   ```bash
   cd ansible
   ansible-playbook -i inventory/hosts.ini playbook.yml
   ```

3. **Deploy Monitoring**
   ```bash
   cd monitoring
   docker-compose up -d
   ```

4. **Run API Service**
   ```bash
   cd api
   pip install -r requirements.txt
   uvicorn main:app --host 0.0.0.0 --port 8000
   ```
