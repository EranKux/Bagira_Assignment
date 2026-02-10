

# ============================================================================
# General Settings
# -----------------------------------------------------------------------------
# These variables define the general deployment environment and AWS region.
region = "eu-west-1"
environment = "Bagira"

# ============================================================================
# Networking Variables
# -----------------------------------------------------------------------------
# VPC and subnet configuration for the Bagira environment.
vpc_cidr = "10.1.0.0/16"
public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
private_subnet_cidrs = ["10.1.10.0/24", "10.1.20.0/24", "10.1.30.0/24"]
azs = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
vpc_name = "Bagira_vpc"

# ============================================================================
# ALB (Application Load Balancer) Variables
# -----------------------------------------------------------------------------
# Configuration for the Application Load Balancer and its target group.
alb_name = "Bagira-telemetry-alb"
alb_internal = false
alb_security_groups = []
alb_enable_deletion_protection = false
alb_tags = { Name = "Bagira-telemetry-alb" }
alb_target_group_name = "Bagira-telemetry-tg"
alb_target_group_port = 80
alb_target_group_protocol = "HTTP"
alb_target_type = "ip"
alb_health_check_path = "/"
alb_health_check_protocol = "HTTP"
alb_health_check_matcher = "200-399"
alb_health_check_interval = 30
alb_health_check_timeout = 5
alb_health_check_healthy_threshold = 2
alb_health_check_unhealthy_threshold = 2
alb_listener_port = 80
alb_listener_protocol = "HTTP"

# ============================================================================
# Security & Secrets Variables
# -----------------------------------------------------------------------------
# Secrets and IAM role configuration for ingestion service.
ingestion_secret_name = "bagira-secret"
ingestion_service_role_name = "bagira-ingestion-role"
ingestion_service_principal = "ec2.amazonaws.com"
