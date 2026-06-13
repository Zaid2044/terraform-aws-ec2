locals {
  name_prefix = "${var.project}-${var.environment}"

  common_tags = merge(
    {
      Project     = var.project
      Environment = var.environment
      ManagedBy   = "Terraform"
      Module      = "ec2"
    },
    var.tags
  )

  instance_name = "${local.name_prefix}-${var.instance_name}"

  security_group_name = "${local.name_prefix}-${var.instance_name}-sg"
}