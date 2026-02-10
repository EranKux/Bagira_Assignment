variable "name" {
  description = "Name of the ALB"
  type        = string
}

variable "internal" {
  description = "Whether the ALB is internal"
  type        = bool
  default     = false
}

variable "security_groups" {
  description = "List of security group IDs"
  type        = list(string)
  default     = []
}

variable "subnets" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection on the ALB"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "target_group_name" {
  description = "Name of the target group"
  type        = string
}

variable "target_group_port" {
  description = "Port for the target group"
  type        = number
}

variable "target_group_protocol" {
  description = "Protocol for the target group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the target group"
  type        = string
}

variable "target_type" {
  description = "Target type for the target group (instance, ip, lambda)"
  type        = string
  default     = "ip"
}

variable "health_check_path" {
  description = "Health check path"
  type        = string
  default     = "/"
}

variable "health_check_protocol" {
  description = "Health check protocol"
  type        = string
  default     = "HTTP"
}

variable "health_check_matcher" {
  description = "Health check matcher"
  type        = string
  default     = "200-399"
}

variable "health_check_interval" {
  description = "Health check interval in seconds"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Health check timeout in seconds"
  type        = number
  default     = 5
}

variable "health_check_healthy_threshold" {
  description = "Number of successful health checks before considering healthy"
  type        = number
  default     = 2
}

variable "health_check_unhealthy_threshold" {
  description = "Number of failed health checks before considering unhealthy"
  type        = number
  default     = 2
}

variable "listener_port" {
  description = "Listener port"
  type        = number
}

variable "listener_protocol" {
  description = "Listener protocol"
  type        = string
}
