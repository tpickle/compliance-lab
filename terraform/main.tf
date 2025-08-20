# ------------------------------------------------------
# Terraform configuration for Compliance Lab
# Provisions 4 AWS EC2 instances, one per compliance framework
# ------------------------------------------------------

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Define AWS provider (region comes from variables.tf)
provider "aws" {
  region = var.region
}

# List of compliance frameworks to provision VMs for
locals {
  frameworks = ["nist", "cis", "pci", "hipaa"]
}

# EC2 instance resource, one per framework
resource "aws_instance" "vm" {
  for_each      = toset(local.frameworks)   # Create 4 instances (nist, cis, pci, hipaa)
  ami           = var.ami_id                # Ubuntu AMI (user must provide)
  instance_type = var.instance_type         # Instance size (default t3.small)

  tags = {
    Name       = "compliance-${each.key}"   # Example: compliance-nist
    framework  = each.key                   # Tag = nist/cis/pci/hipaa
    managed-by = "terraform"
  }

  # Attach SSM profile (so we can connect without SSH keys)
  iam_instance_profile   = aws_iam_instance_profile.ssm.name
  vpc_security_group_ids = [aws_security_group.vm.id]
}

# Security group: default-deny inbound, allow all outbound
resource "aws_security_group" "vm" {
  name        = "compliance-lab-sg"
  description = "Default-deny; allow outbound"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]   # Outbound allowed everywhere
  }
}

# IAM role for SSM Session Manager
resource "aws_iam_role" "ssm" {
  name               = "compliance-lab-ssm-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume.json
}

# Trust policy for EC2 to assume the SSM role
data "aws_iam_policy_document" "ec2_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals { type = "Service" identifiers = ["ec2.amazonaws.com"] }
  }
}

# Attach AmazonSSMManagedInstanceCore policy
resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Create instance profile (link role to EC2)
resource "aws_iam_instance_profile" "ssm" {
  name = "compliance-lab-ssm-profile"
  role = aws_iam_role.ssm.name
}