variable "project" {
  description = "Project name used for resource naming and tagging"
  type        = string

  validation {
    condition     = length(trimspace(var.project)) > 0
    error_message = "Project name cannot be empty."
  }
}

variable "environment" {
  description = "Deployment environment"
  type        = string

  validation {
    condition     = contains(["dev", "stage", "prod"], lower(var.environment))
    error_message = "Environment must be one of: dev, stage, prod."
  }
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "vpc_id" {
  description = "VPC ID where the instance will be deployed"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the instance will be deployed"
  type        = string
}

variable "key_name" {
  description = "Existing AWS Key Pair name"
  type        = string
}

variable "instance_profile_name" {
  description = "IAM Instance Profile name to attach to EC2"
  type        = string
  default     = null
}

variable "associate_public_ip_address" {
  description = "Associate a public IP address to the instance"
  type        = bool
  default     = true
}

variable "root_volume_size" {
  description = "Root EBS volume size in GB"
  type        = number
  default     = 20

  validation {
    condition     = var.root_volume_size >= 8
    error_message = "Root volume size must be at least 8 GB."
  }
}

variable "root_volume_type" {
  description = "Root EBS volume type"
  type        = string
  default     = "gp3"
}

variable "ingress_rules" {
  description = "List of ingress security group rules"

  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))

  default = []
}

variable "egress_rules" {
  description = "List of egress security group rules"

  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))

  default = [
    {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "tags" {
  description = "Additional tags applied to resources"
  type        = map(string)
  default     = {}
}