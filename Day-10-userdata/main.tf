
resource "aws_instance" "test" {
    ami = "ami-0f1dcc636b69a6438"
    instance_type = "t2.micro"
    user_data= file("test.sh")
}