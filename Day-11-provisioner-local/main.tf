resource "null_resource" "example_local_exec" {
  provisioner "local-exec" {
    command = "echo 'Hello from Terraform local-exec!' > hello_from_terraform.txt"
  }
}
