terraform {
  required_version = ">= 1.8.0"
}

provider "aws" {
  region = "ap-south-1"
}

module "ec2" {
  source = "../../"

  project     = "platform"
  environment = "dev"

  name = "web"

  instance_count = 2

  ami_id        = "ami-1234567890abcdef0"
  instance_type = "t3.micro"

  subnet_id = "subnet-12345678"

  security_group_ids = [
    "sg-12345678"
  ]

  instance_profile_name = "platform-dev-ec2-profile"

  root_volume_size = 20

  user_data = <<-EOF
#!/bin/bash
echo "hello world" > /tmp/hello.txt
EOF
}