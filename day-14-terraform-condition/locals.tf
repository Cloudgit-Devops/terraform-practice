locals {
  instance_type = var.env == "test" ? "t2.micro" : "t3.micro"
}
