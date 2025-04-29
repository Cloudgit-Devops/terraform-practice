provider "aws" {
  region = "us-east-1"  # 💡 Change if you're in a different AWS region
}

resource "aws_key_pair" "my_key" {
  key_name   = "my-terraform-key"           # 💡 This will be the key name in AWS
  public_key = file("~/.ssh/id_ed25519.pub")    # 💡 Make sure this file exists! Adjust path if needed
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]             # 💡 Insecure for production — restrict IPs if needed
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "remote_test" {
  ami                    = "ami-0e449927258d45bc4"  # 💡 Make sure this is a valid Amazon Linux 2 AMI in your region
  instance_type          = "t2.micro"               # 💡 Use a free-tier instance if you're testing
  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  provisioner "remote-exec" {
    inline = [
      "echo Hello from Terraform > hello.txt"       # 💡 You can change this to any shell command
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"                      # 💡 Default for Amazon Linux 2
      private_key = file("~/.ssh/id_ed25519")           # 💡 Make sure your private key matches the public key above
      host        = self.public_ip
    }
  }

  tags = {
    Name = "RemoteExecExample"
  }
}
