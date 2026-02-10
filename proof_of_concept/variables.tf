variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "environment" {
  description = "Environment tag for resources (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
  default     = "my_vpc"
}

variable "alb_name" {
  description = "Name of the ALB"
  type        = string
  default     = "telemetry-alb"
}

variable "alb_internal" {
  description = "Whether the ALB is internal"
  type        = bool
  default     = false
}

variable "alb_security_groups" {
  description = "List of security group IDs for the ALB"
  type        = list(string)
  default     = []
}

variable "alb_enable_deletion_protection" {
  description = "Enable deletion protection on the ALB"
  type        = bool
  default     = false
}

variable "alb_tags" {
  description = "Tags to apply to the ALB and related resources"
  type        = map(string)
  default     = { Name = "telemetry-alb" }
}

variable "alb_target_group_name" {
  description = "Name of the target group"
  type        = string
  default     = "telemetry-tg"
}

variable "alb_target_group_port" {
  description = "Port for the target group"
  type        = number
  default     = 80
}

variable "alb_target_group_protocol" {
  description = "Protocol for the target group"
  type        = string
  default     = "HTTP"
}

variable "alb_target_type" {
  description = "Target type for the target group (instance, ip, lambda)"
  type        = string
  default     = "ip"
}

variable "alb_health_check_path" {
  description = "Health check path"
  type        = string
  default     = "/"
}

variable "alb_health_check_protocol" {
  description = "Health check protocol"
  type        = string
  default     = "HTTP"
}

variable "alb_health_check_matcher" {
  description = "Health check matcher"
  type        = string
  default     = "200-399"
}

variable "alb_health_check_interval" {
  description = "Health check interval in seconds"
  type        = number
  default     = 30
}

variable "alb_health_check_timeout" {
  description = "Health check timeout in seconds"
  type        = number
  default     = 5
}

variable "alb_health_check_healthy_threshold" {
  description = "Number of successful health checks before considering healthy"
  type        = number
  default     = 2
}

variable "alb_health_check_unhealthy_threshold" {
  description = "Number of failed health checks before considering unhealthy"
  type        = number
  default     = 2
}

variable "alb_listener_port" {
  description = "Listener port"
  type        = number
  default     = 80
}

variable "alb_listener_protocol" {
  description = "Listener protocol"
  type        = string
  default     = "HTTP"
}

variable "telemetry_bucket_name" {
  description = "Name of the S3 bucket for telemetry data storage"
  type        = string
  default     = "bagira-telemetry-bucket"
}

variable "ingestion_secret_name" {
  description = "Name of the secret for the ingestion service."
  type        = string
  default     = "ingestion-service-secret"
}

variable "ingestion_service_role_name" {
  description = "Name of the IAM role for the ingestion service."
  type        = string
  default     = "ingestion-service-role"
}

variable "ingestion_service_principal" {
  description = "Principal (service) that will assume the ingestion service role (e.g., ecs-tasks.amazonaws.com, ec2.amazonaws.com, lambda.amazonaws.com)."
  type        = string
  default     = "ec2.amazonaws.com"
}
