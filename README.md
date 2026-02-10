# Bagira

A Terraform proof-of-concept for provisioning AWS infrastructure to support a telemetry ingestion platform.

## Architecture Overview

This project deploys the following AWS resources:

| Component | Description |
|-----------|-------------|
| **VPC** | Virtual Private Cloud with public and private subnets across 3 availability zones |
| **ALB** | Application Load Balancer for telemetry ingestion endpoints |
| **S3 Bucket** | Telemetry data storage bucket with server-side encryption |
| **Secrets Manager** | Secret for ingestion service credentials/API keys |
| **IAM Role** | Service role for the ingestion service with Secrets Manager access |

## Project Structure

```
proof_of_concept/
├── main.tf              # Root module orchestrating all resources
├── variables.tf         # Input variable definitions
├── terraform.tfvars     # Environment-specific variable values
├── backend.tf           # S3 remote state configuration
├── bootstrap_backend.tf # S3 bucket and DynamoDB table for state management
├── versions.tf          # Terraform and provider version constraints
└── modules/
    ├── vpc/             # VPC, subnets, NAT gateway, security groups
    └── alb/             # Application Load Balancer and target group
```

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) >= 1.0
- AWS CLI configured with appropriate credentials
- AWS account with permissions to create VPC, ALB, S3, Secrets Manager, and IAM resources

## What is the Bootstrap Stage?

The bootstrap stage is the initial setup required to enable remote state management for Terraform. 
It provisions the necessary backend resources: an S3 bucket for storing the Terraform state file and a DynamoDB table for state locking and consistency. 
This ensures that your infrastructure state is safely stored and can be shared across your team, preventing conflicts and enabling collaboration.

You only need to run the bootstrap stage once, before deploying the main infrastructure.

## Bootstrap (State Backend) Setup

1. Change directory:
```sh
cd proof_of_concept
```
2. Initialize without backend:
```sh
terraform init -backend=false
```
3. Apply bootstrap resources:
```sh
terraform apply -target=aws_s3_bucket.tf_state -target=aws_dynamodb_table.tf_lock
```

4. **Uncomment the S3 backend block in `backend.tf`:**
    - Edit `backend.tf` and uncomment the `backend "s3" { ... }` block so Terraform will use remote state.

5. Re-initialize with the backend:
```sh
terraform init -reconfigure
```
This will migrate your state to the S3 backend and enable remote state management.

## Main Infrastructure Deployment

1. Initialize:
```sh
terraform init
```
2. Plan:
```sh
terraform plan
```
3. Apply:
```sh
terraform apply
```
4. Destroy (when needed):
```sh
terraform destroy
```

## Configuration

Key variables can be customized in `terraform.tfvars`:

| Variable | Default | Description |
|----------|---------|-------------|
| `region` | `eu-west-1` | AWS region |
| `environment` | `Bagira` | Environment tag |
| `vpc_cidr` | `10.1.0.0/16` | VPC CIDR block |
| `alb_name` | `Bagira-telemetry-alb` | ALB name |

See [variables.tf](proof_of_concept/variables.tf) for all available configuration options.
