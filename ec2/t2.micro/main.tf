terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"

  key_name = aws_key_pair.app_server_key.key_name

  tags = {
    Name = "AppServer"
  }

  security_groups = [aws_security_group.allow_ssh.name, "default"]
}

resource "aws_key_pair" "app_server_key" {
  key_name   = "AppServerKey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCujEsnebk4Tt9nZXDwcvm3Tgb+2BosfIK7BzyXEEDd7WXueIgkgUFPbGfgH4S8jQqznvNvwwn8zCac4LQ/vvnXnWH4kEB7o/jn6LuPURdqs+1OEuOmcsv7mZwCb8utm4jYrJCVNEy/gI/ReGo0bheBEuOZ5sXf8uEDPcZS2Qz+flxi/hFLaD3Ry43lFLCEKcb6vn6wXBZ0HOzBOtRPhASYGhtZwY2a/AeXTd9LYmjuzzN/8mDaOQhxc3WuFHKRrGFu7TgDQbdCVdvbOqTy8Tqj4W176bQBm4RaEg+uQeEdQKEE2G1AXfF4zYtO4KNiJk4Xk4/39+6+AWFzX6s3QDAPvUbcgDo4Bv3eJnF0oCn6yzy5p4bTsgc0T1uvrNK03gw/snoz+ndk+s/LdDhFaxypnzBn4UralD4fk/0I6Je8+cU4PPd9T0bor6kgVNYZI+NOrYLmNLLpYOGCurJfolvnR5UdWyo+JFxCDEV5G6A09R81ZdL/nP67y4WxGX/4Ueak3LnbnmRFcMkNvivRveIWdCIyZDJt27lFFq1RL2exf30t+3Sa9jhkpBmluH2Jgp1VabF4a+gm/tKneMdnCMKcW5v/mfR5I/FLQXdeepTZAmcXf7vX6qRxSYwMopJ3WAZU3bPFtIDTk6hlMqdJmJhdeDdVvFF5fpXZ/Znz8CVPjw== spaghettiwews@outlook.com"

  tags = {
    "Name" = "AppServerKey"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "AllowSSH"
  description = "Allow SSH inboud traffic from custom IP"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["41.79.132.234/32"]
  }
}