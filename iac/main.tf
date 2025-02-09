terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.67.0"
    }
  }
}

provider "aws" {
  region = var.region_name
}

# STEP1: CREATE SG
resource "aws_security_group" "my-sg" {
  name        = "SLB-SERVER-SG"
  description = "SLB Server Ports"

  # Port 22 is required for SSH Access
  ingress {
    description = "SSH Port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 80 is required for HTTP
  ingress {
    description = "HTTP Port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # Port 9090 is required for Prometheus
  ingress {
    description = "Prometheus Port"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 8080 is required for webpage
  ingress {
    description = "webpage"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 9000 is required for Grafana
  ingress {
    description = "Grafana"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Define outbound rules to allow all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# STEP2: CREATE  aws_iam_role resource
resource "aws_iam_role" "cloud_role" {
  name               = "cloud_iam_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# aws_iam_instance_profile resource
resource "aws_iam_instance_profile" "cloud_iam_instance_profile" {
  name = "cloud_iam_instance_profile"
  role = aws_iam_role.cloud_role.name
}

# aws_iam_role_policy resource
resource "aws_iam_role_policy_attachment" "cloud_iam_role_policy" {
  role   = aws_iam_role.cloud_role.id
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_key_pair" "key" {
  key_name   = "key_aws"
  public_key = file("~/.ssh/devOps_key.pub")
}

# STEP4 : CREATE INSTANCE
resource "aws_instance" "my-ec2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.my-sg.id]

  iam_instance_profile = aws_iam_instance_profile.cloud_iam_instance_profile.name
  user_data            = templatefile("./Install_tools.sh", {})

  root_block_device {
    volume_size = var.volume_size
  }

  tags = {
    Name = var.server_name
  }
}