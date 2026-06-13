variable "instance_type" {
  default = "t2.micro"
  type = string 
  description = "The type of instance to use for the EC2 instance."
}

variable "instance_tags" {
  default = {
    Name = "EC2 Instance"
  }
}
variable "aws_region" {
    type = string
    description = "The AWS region to deploy resources in ."
  default = "us-east-1"
}
variable "instance_keypair"{
    type = string
    description = "The name of the key pair to use for the EC2 instance."
    default = "terraform-key"
}

#version 2 of the code
variable "instance_type_list" {
  type = list(string)
  description ="List of instance types to use for the EC2 instances."
  default = ["t2.micro","t2.small","t2.large"]

}
#version 2 of the code
variable "instance_type_list" {
  type = map(string)
  description ="List of instance types to use for the EC2 instances."
  default = { 
    "dev" = "t2.micro",
    "test" = "t2.small", 
    "prod" = "t2.large" }

}