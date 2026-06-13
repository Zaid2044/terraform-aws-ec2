resource "aws_security_group" "this" {
  name        = local.security_group_name
  description = "Security group for ${local.instance_name}"
  vpc_id      = var.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = local.security_group_name
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each = {
    for idx, rule in var.ingress_rules :
    idx => rule
  }

  security_group_id = aws_security_group.this.id

  description = each.value.description

  ip_protocol = each.value.protocol

  from_port = each.value.from_port
  to_port   = each.value.to_port

  cidr_ipv4 = length(each.value.cidr_blocks) > 0 ? each.value.cidr_blocks[0] : null
}

resource "aws_vpc_security_group_egress_rule" "this" {
  for_each = {
    for idx, rule in var.egress_rules :
    idx => rule
  }

  security_group_id = aws_security_group.this.id

  description = each.value.description

  ip_protocol = each.value.protocol

  from_port = each.value.from_port
  to_port   = each.value.to_port

  cidr_ipv4 = length(each.value.cidr_blocks) > 0 ? each.value.cidr_blocks[0] : null
}

resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address

  vpc_security_group_ids = [
    aws_security_group.this.id
  ]

  iam_instance_profile = var.instance_profile_name

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type

    tags = merge(
      local.common_tags,
      {
        Name = "${local.instance_name}-root-volume"
      }
    )
  }

  tags = merge(
    local.common_tags,
    {
      Name = local.instance_name
    }
  )
}