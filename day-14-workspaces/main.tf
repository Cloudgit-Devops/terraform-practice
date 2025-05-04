

resource "aws_instance" "example" {
  ami           = "ami-062f0cc54dbfd8ef1"  
  instance_type = "t2.micro"

  tags = {
    Name = "Instance-${terraform.workspace}"
  }
}
