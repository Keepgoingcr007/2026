#create a security group for ssh traffic 
resource "aws_security_group" "vpc-ssh" {
  name        = "vpc-ssh"
  description = "Allow port 22 for ssh access"
  ingress {
    description = "allow ssh access from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   egress {
    description = "allow all ip & ports outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

   tags={
    Name = "vpc-ssh"
}
}

#create a security group for web traffic 
resource "aws_security_group" "vpc-web" {
  name        = "vpc-web"
  description = "Allow port  web access"
  ingress {
    description = "allow web access from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    description = "allow port 443 for https access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    description = "allow port 443 for https access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
     description = "allow all ip & ports outbound traffic"
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
    }
   tags={
    Name = "vpc-web"
     }
   }