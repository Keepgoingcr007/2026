#####################################################################
# Block-1: Terraform Settings Block
terraform {
  required_version = "~> 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }



  backend "s3" {
    bucket = "mybucket-1001"
    key    = "June2026-practice/2026/June-Practice/terraform.tfstate"
    region = "us-east-1"
    #for state locking
dynamodb_table = "my-lock-table-1001"
  }

}



#####################################################################
# Block-2: Provider Block
provider "aws" {
  profile = "default" # AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
  region = var.region
  
}

#####################################################################
# Block-3: Resource Block
/*

resource "aws_instance" "example-1001" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name = "practice-1001"
  }
}  */

#####################################################################

#####################################################################
# Block-4: Input Variables Block
variable "region" {
    default = "us-east-1"
    description = "AWS Region"
    type = string
}
variable "instance_type" {
    default = "t3.micro"
    description = "EC2 Instance Type"
    type = string
}

# Either define these variables:
variable "app_name" {
  description = "Application name"
  type        = string
  default     = "myapp"
}

variable "environment_name" {
  description = "Environment name"
  type        = string
  default     = "dev"
}


# Add these if you're using hardcoded values in the module
variable "vpc_security_group_id" {
  description = "VPC Security Group ID"
  type        = string
  default     = "sg-0a1b2c3d4e5f6g7h8"
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
  default     = "subnet-0a1b2c3d4e5f6g7h8"
}

# Or remove/comment the locals block if not needed
#####################################################################
# Block-5: Output Values Block
output "ec2_instance_public_ip" {
  description = "EC2 Public IP"
  value = module.ec2_instance.public_ip
}

#####################################################################
# Block-6: Local Values Block
# Create S3 Bucket - with Input Variables & Local Values
locals {
  bucket_name_prefix = "${var.app_name}-${var.environment_name}"
}

#####################################################################
# Block-7: Data sources Block

# Block-7: Data sources Block (Add these)
# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get subnets in default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Get first available subnet
data "aws_subnet" "selected" {
  id = data.aws_subnets.default.ids[0]
}

# Get default security group for the VPC
data "aws_security_group" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  filter {
    name   = "group-name"
    values = ["default"]
  }
}
# Get latest AMI ID for amazon ubuntu
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
#####################################################################
# Block-8: Modules Block
# AWS EC2 Instance Module
# Block-8: Modules Block - Using Public Module
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"

  name = "module-1001"

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  monitoring             = true
  vpc_security_group_ids = [data.aws_security_group.default.id]
  subnet_id              = data.aws_subnet.selected.id 
  user_data              = file("user_data.sh")

  tags = {
    Name        = "module-1001"
    Terraform   = "true"
    Environment = var.environment_name
  }
}

#####################################################################