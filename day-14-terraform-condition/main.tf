provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0f1dcc636b69a6438"  
  instance_type = local.instance_type

  tags = {
    Name = "MyInstance-${var.env}"
  }
}
