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

  # Port 8080 is required for webpage
  ingress {
    description = "webpage"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 3000 is required for grafana
  ingress {
    description = "grafana"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 5000 is required for color_app
  ingress {
    description = "color_app"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 9090 is required for prometheus
  ingress {
    description = "prometheus"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 3100 is required for loki
  ingress {
    description = "loki"
    from_port   = 3100
    to_port     = 3100
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

resource "aws_key_pair" "key_pub" {
  key_name   = "key_aws"
  public_key = file("~/.ssh/devOps_key.pub")
}

# STEP4 : CREATE INSTANCE
resource "aws_instance" "my-ec2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key_pub.key_name
  vpc_security_group_ids = [aws_security_group.my-sg.id]

  root_block_device {
    volume_size = var.volume_size
  }

  tags = {
    Name = var.server_name
  }

  # ESTABLISHING SSH CONNECTION WITH EC2
  connection {
    type        = "ssh"
    private_key = file("~/.ssh/devOps_key")
    user        = "ubuntu"
    host        = self.public_ip
  }

  # Copy Config files
  provisioner "file" {
    source      = "./source/"
    destination = "/tmp"
  }

  # USING REMOTE-EXEC PROVISIONER TO INSTALL 
  provisioner "remote-exec" {
    inline = [
      # Run setup
      # Ref: https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec#script
      "sudo chmod +x /tmp/Install_tools.sh",
      "sudo /tmp/Install_tools.sh",
    ]
  }
}