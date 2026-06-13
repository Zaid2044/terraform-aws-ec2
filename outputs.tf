output "instance_id" {
  description = "EC2 Instance ID"

  value = aws_instance.this.id
}

output "instance_arn" {
  description = "EC2 Instance ARN"

  value = aws_instance.this.arn
}

output "instance_private_ip" {
  description = "Private IP address"

  value = aws_instance.this.private_ip
}

output "instance_public_ip" {
  description = "Public IP address"

  value = aws_instance.this.public_ip
}

output "instance_state" {
  description = "Current instance state"

  value = aws_instance.this.instance_state
}

output "security_group_id" {
  description = "Security Group ID"

  value = aws_security_group.this.id
}

output "security_group_arn" {
  description = "Security Group ARN"

  value = aws_security_group.this.arn
}

output "key_name" {
  description = "Key Pair used by the instance"

  value = var.key_name
}