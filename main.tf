provider "aws" {
  region     = "us-east-2"
}


resource "aws_instance" "Test_Terraform" {
  ami           = "ami-09246ddb00c7c4fef"
  instance_type = "t2.micro"
}