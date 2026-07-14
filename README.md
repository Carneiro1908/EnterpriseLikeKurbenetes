# EnterpriseLikeK8s / Antigravity Finance

This repository brings together a personal finance application in dashboard form, with a FastAPI backend, static frontend, relational database, observability with Prometheus/Grafana, and infrastructure ready for Kubernetes and AWS using Terraform/Terragrunt.

The project was designed as a practical reference for an "enterprise-like" environment, focused on:

- A robust REST API for financial transaction management
- A simple and responsive web interface
- Local persistence or PostgreSQL-backed persistence
- Metrics for monitoring
- Deployment with Docker, Kubernetes, and infrastructure as code

---

## Overview

The application allows you to record income and expenses, view financial statistics, track savings goals, and consult service metrics. It can run locally for development or be deployed in containerized and cloud-native environments.

The project is composed of:

- Backend: FastAPI + SQLAlchemy
- Database: SQLite by default, PostgreSQL optionally
- Frontend: Static HTML/CSS/JavaScript
- Observability: Prometheus + Grafana
- Deployment: Docker Compose, Kubernetes, and Terraform/Terragrunt

---

## Features

- Register, list, and remove transactions
- Categorize between income and expense
- Calculate net balance and expenses by category
- Manage savings goals
- Health endpoint for availability validation
- Metrics endpoint for Prometheus integration
- Web interface for quick interaction

---

## Architecture

The project structure follows a clear separation between application, infrastructure, and observability:

```text
app/                  # Backend, static frontend, and runtime configuration
manifests/           # Kubernetes manifests
terraform/           # Terraform/Terragrunt for AWS provisioning
```

Main flow:

1. The user accesses the web interface.
2. The application sends requests to the FastAPI backend.
3. The backend persists data in SQLite (local) or PostgreSQL (external).
4. The /metrics endpoint exposes metrics to Prometheus.
5. Grafana consumes this data for dashboards.

---

## Repository structure

```text
.
├── app/
│   ├── database.py
│   ├── docker-compose.yml
│   ├── Dockerfile
│   ├── requirements.txt
│   ├── server.py
│   ├── test_api.py
│   └── public/
│       ├── app.js
│       ├── index.html
│       └── styles.css
├── manifests/
│   ├── deployment.yaml
│   └── service.yaml
└── terraform/
    ├── bootstrap/
    └── infrastructure/
```

### Description of the main files

- app/server.py: FastAPI application, API routes, and frontend serving
- app/database.py: models, database initialization, and CRUD operations
- app/public/: static frontend in HTML/CSS/JavaScript
- app/docker-compose.yml: local execution with PostgreSQL, FastAPI, Prometheus, and Grafana
- manifests/: Kubernetes templates for deployment and service
- terraform/: infrastructure as code for AWS using Terraform/Terragrunt

---

## Requirements

Before running the project, make sure you have installed:

- Python 3.10+
- pip
- Docker and Docker Compose (for container-based execution)
- Kubernetes (optional, for local cluster testing with kubectl)
- Terraform and Terragrunt (optional, for infrastructure provisioning)

---

## Running locally

### 1. Create a virtual environment

```bash
cd app
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

### 2. Run the application

```bash
python server.py
```

The application will be available at:

- http://localhost:8000
- http://localhost:8000/healthz
- http://localhost:8000/metrics

### 3. Database

By default, the project uses SQLite stored locally in the finance.db file inside the app folder.

To use PostgreSQL, define the environment variable:

```bash
export DATABASE_URL="postgresql://username:password@host:5432/database_name"
```

If the variable is not set, the system will use SQLite automatically.

---

## Running with Docker Compose

From the app folder:

```bash
cd app
docker compose up --build
```

Services provided:

- Web application: http://localhost:8000
- PostgreSQL: localhost:5432
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000

Default Grafana credentials:

- Username: admin
- Password: admin

---

## Running with Kubernetes

The manifests in manifests/ can be used for deployment in a Kubernetes cluster.

```bash
kubectl apply -f manifests/deployment.yaml
kubectl apply -f manifests/service.yaml
```

Important notes:

- The deployment uses an AWS ECR image as an example.
- The service exposes the application via a LoadBalancer.
- In a real environment, you should adjust the image, namespace, secrets, and network settings.

---

## Infrastructure with Terraform/Terragrunt

The terraform folder contains structures to provision resources in AWS.

### Structure

- terraform/bootstrap: initial resources such as S3, DynamoDB, IAM, and OIDC
- terraform/infrastructure/global: shared resources for the environment
- terraform/infrastructure/envs/: dev, staging, and prod environments with VPC and EKS modules

### Example workflow

```bash
cd terraform/infrastructure/envs/dev
terragrunt run-all plan
terragrunt run-all apply
```

The configuration can be adjusted according to your AWS account, region, and security needs.

---

## API endpoints

### Health

- GET /healthz

Returns the application status.

### Metrics

- GET /metrics

Displays metrics in Prometheus format.

### Transactions

- GET /api/transactions
- POST /api/transactions
- DELETE /api/transactions

GET parameters:

- search: filter by description
- type: all, income, or expense
- category: category name

Example POST payload:

```json
{
  "description": "Monthly shopping",
  "amount": 125.50,
  "type": "expense",
  "category": "Food",
  "date": "2026-06-29"
}
```

### Statistics

- GET /api/stats

Returns:

- total_income
- total_expense
- net_balance
- categories
- db_type
- db_scope

### Savings goals

- GET /api/goals
- POST /api/goals

---

## Testing

The project includes an integration test script to validate the main endpoints.

```bash
cd app
python test_api.py
```

The tests verify:

- web interface loading
- transaction listing
- transaction creation
- statistics calculation
- metrics endpoint
- transaction deletion

---

## Observability

The application exposes HTTP metrics through Prometheus. The Docker Compose stack includes:

- Prometheus for metric collection
- Grafana for visualization and dashboards

The main metrics include:

- total HTTP requests
- request latency
- status codes by endpoint

---

## Security and best practices

Some best practices already applied in the project:

- use of environment variables for configuration
- input validation with Pydantic
- CORS enabled for development
- health checks for orchestration and load balancing
- containerization with dedicated images

For production environments, it is recommended to:

- change default credentials
- configure secrets for databases and external services
- enable Grafana authentication
- use TLS and more restrictive network policies

---

## Contributing

Contributions are welcome. To collaborate:

1. Fork the project
2. Create a branch for your change
3. Make the changes and test locally
4. Open a pull request describing what was changed

---

## License

This project is licensed under the MIT License, a free and permissive license that allows use, copying, modification, merging, publication, distribution, and commercial use, provided that the copyright notice and this license are preserved.

See the LICENSE file for more details.
