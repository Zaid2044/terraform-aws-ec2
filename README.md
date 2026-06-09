# terraform-aws-ec2
# Terraform AWS EC2 Module

Reusable Terraform module for provisioning AWS EC2 instances with IAM integration, security groups, encrypted storage, and IMDSv2 enforcement.

## Features

* Single or Multiple EC2 Instances
* Configurable Instance Count
* IAM Instance Profile Support
* Security Group Integration
* User Data Support
* Encrypted Root EBS Volume
* IMDSv2 Enforcement
* Consistent Tagging Strategy
* Semantic Versioning Support

## Requirements

| Name         | Version  |
| ------------ | -------- |
| Terraform    | >= 1.8.0 |
| AWS Provider | ~> 6.0   |

## Architecture

```text
EC2 Instance
│
├── IAM Instance Profile
├── Security Groups
├── User Data
├── Encrypted Root Volume
└── IMDSv2
```

## Usage

```hcl
module "ec2" {
  source = "git::https://github.com/Zaid2044/terraform-aws-ec2.git?ref=v1.0.0"

  project     = "platform"
  environment = "dev"

  name = "web"

  instance_count = 2

  ami_id        = "ami-xxxxxxxx"
  instance_type = "t3.micro"

  subnet_id = module.vpc.private_app_subnet_ids["a"]

  security_group_ids = [
    module.web_sg.security_group_id
  ]

  instance_profile_name = module.ec2_role.instance_profile_name

  root_volume_size = 20
}
```

## Inputs

| Name                  | Type         |
| --------------------- | ------------ |
| project               | string       |
| environment           | string       |
| name                  | string       |
| instance_count        | number       |
| ami_id                | string       |
| instance_type         | string       |
| subnet_id             | string       |
| security_group_ids    | list(string) |
| instance_profile_name | string       |
| user_data             | string       |
| root_volume_size      | number       |
| tags                  | map(string)  |

## Outputs

| Name          |
| ------------- |
| instance_ids  |
| instance_arns |
| private_ips   |
| public_ips    |

## Security Features

### IMDSv2 Enforcement

The module enforces Instance Metadata Service Version 2.

### Encrypted Root Volume

Root EBS volumes are encrypted by default.

### IAM-Based Access

Designed to be used with:

* AWS Systems Manager
* Session Manager
* IAM Roles

Instead of:

* SSH
* Port 22
* Long-lived key pairs

## Validation

The module is validated using:

* terraform fmt
* terraform validate
* Example deployment testing

## Repository Structure

```text
terraform-aws-ec2
├── examples
│   └── basic
├── .github
│   └── workflows
├── main.tf
├── variables.tf
├── outputs.tf
├── locals.tf
├── versions.tf
└── README.md
```

## Versioning

This module follows Semantic Versioning.

Examples:

* v1.0.0
* v1.1.0
* v2.0.0

## Future Enhancements

* Launch Templates
* Auto Scaling Groups
* Spot Instances
* EBS Attachments
* Multi-AZ Deployments
* EC2 Instance Connect
