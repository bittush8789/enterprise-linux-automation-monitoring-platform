# High Level Design (HLD)

## Overview

The Enterprise Linux Server Automation & Monitoring Platform simplifies the administration and observability of multiple Linux servers.

## Components

1. **Infrastructure as Code (IaC):** Terraform defines the AWS footprint.
2. **Control Plane:** The App & Monitoring node hosts the API, Ansible orchestrator, and Monitoring tools.
3. **Target Nodes:** Managed Linux instances running Node Exporter.
4. **Backup Storage:** AWS S3 buckets securely store system and application backups.

## Data Flow

- **Metrics Collection:** Prometheus scrapes Node Exporter on target nodes every 15s.
- **Log Aggregation:** Promtail (on target nodes) pushes logs to Loki (on Control Plane).
- **Automation:** FastAPI triggers Ansible playbooks or Bash scripts via SSH to perform actions (User management, Backup).
- **Storage:** PostgeSQL stores persistent relational data (users, server inventory).
