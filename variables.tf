variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string

  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "environment must be one of: dev, stage, prod."
  }
}

variable "name" {
  description = "Instance name"
  type        = string
}

variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number

  default = 1

  validation {
    condition     = var.instance_count > 0
    error_message = "instance_count must be greater than zero."
  }
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "security_group_ids" {
  description = "Security Group IDs"
  type        = list(string)
}

variable "instance_profile_name" {
  description = "IAM Instance Profile Name"
  type        = string
}

variable "user_data" {
  description = "User data script"

  type    = string
  default = null
}

variable "root_volume_size" {
  description = "Root EBS volume size"

  type    = number
  default = 20
}

variable "tags" {
  description = "Additional tags"

  type    = map(string)
  default = {}
}