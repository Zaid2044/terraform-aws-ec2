output "instance_ids" {
  description = "EC2 instance IDs"

  value = aws_instance.this[*].id
}

output "instance_arns" {
  description = "EC2 instance ARNs"

  value = aws_instance.this[*].arn
}

output "private_ips" {
  description = "Private IP addresses"

  value = aws_instance.this[*].private_ip
}

output "public_ips" {
  description = "Public IP addresses"

  value = aws_instance.this[*].public_ip
}