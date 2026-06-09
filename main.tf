resource "aws_instance" "this" {
  count = var.instance_count

  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id = var.subnet_id

  vpc_security_group_ids = var.security_group_ids

  iam_instance_profile = var.instance_profile_name

  user_data = var.user_data

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    encrypted   = true
    volume_size = var.root_volume_size
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-${var.name}-${count.index + 1}"
    }
  )
}

