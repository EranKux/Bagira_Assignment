provider "aws" {
  region = var.region
}

module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
  vpc_name             = var.vpc_name
  environment          = var.environment
}

module "alb" {
  source                     = "./modules/alb"
  name                       = var.alb_name
  internal                   = var.alb_internal
  security_groups            = [module.vpc.alb_default_sg_id]
  subnets                    = module.vpc.public_subnet_ids
  enable_deletion_protection = var.alb_enable_deletion_protection
  tags                       = var.alb_tags
  target_group_name                = var.alb_target_group_name
  target_group_port                = var.alb_target_group_port
  target_group_protocol            = var.alb_target_group_protocol
  vpc_id                           = module.vpc.vpc_id
  target_type                      = var.alb_target_type
  health_check_path                = var.alb_health_check_path
  health_check_protocol            = var.alb_health_check_protocol
  health_check_matcher             = var.alb_health_check_matcher
  health_check_interval            = var.alb_health_check_interval
  health_check_timeout             = var.alb_health_check_timeout
  health_check_healthy_threshold   = var.alb_health_check_healthy_threshold
  health_check_unhealthy_threshold = var.alb_health_check_unhealthy_threshold
  listener_port                    = var.alb_listener_port
  listener_protocol                = var.alb_listener_protocol
}

resource "aws_s3_bucket" "telemetry" {
  bucket = var.telemetry_bucket_name
  force_destroy = true
  tags = {
    Name        = var.telemetry_bucket_name
    Environment = var.environment
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "telemetry" {
  bucket = aws_s3_bucket.telemetry.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_secretsmanager_secret" "ingestion_secret" {
  name = var.ingestion_secret_name
  description = "Secret for ingestion service credentials or API keys."
  tags = {
    Environment = var.environment
  }
}

resource "aws_iam_role" "ingestion_service" {
  name = var.ingestion_service_role_name
  assume_role_policy = data.aws_iam_policy_document.ingestion_service_assume_role.json
  tags = {
    Environment = var.environment
  }
}

data "aws_iam_policy_document" "ingestion_service_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = [var.ingestion_service_principal]
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "ingestion_secret_access" {
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue"
    ]
    resources = [aws_secretsmanager_secret.ingestion_secret.arn]
  }
}

resource "aws_iam_policy" "ingestion_secret_access" {
  name   = "IngestionSecretAccessPolicy"
  policy = data.aws_iam_policy_document.ingestion_secret_access.json
}

resource "aws_iam_role_policy_attachment" "ingestion_secret_access" {
  role       = aws_iam_role.ingestion_service.name
  policy_arn = aws_iam_policy.ingestion_secret_access.arn
}

data "aws_iam_policy_document" "ingestion_s3_access" {
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject"
    ]
    resources = ["${aws_s3_bucket.telemetry.arn}/*"]
  }
}

resource "aws_iam_policy" "ingestion_s3_access" {
  name   = "IngestionS3AccessPolicy"
  policy = data.aws_iam_policy_document.ingestion_s3_access.json
}

resource "aws_iam_role_policy_attachment" "ingestion_s3_access" {
  role       = aws_iam_role.ingestion_service.name
  policy_arn = aws_iam_policy.ingestion_s3_access.arn
}