resource "aws_instance" "this" {
  ami                     = "ami-0152204c1a187337c"
  instance_type           = "t2.micro"
  user_data = file("${path.module}/app1-install.sh")
  
  tags ={
    Name = "EC2 Instance"
  }
}