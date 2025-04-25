module "dev" {
  source = "../Day-1"
  ami_id = "ami-002f6e91abff6eb96"

  instance_type = "t2.micro"
}