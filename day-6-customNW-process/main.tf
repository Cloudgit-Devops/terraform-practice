 resource "aws_vpc" "dev" {
   cidr_block = "10.0.0.0/16"
   tags = {
    Name="devvpc"
   }
 }
 resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.dev.id
   
 }
 resource "aws_subnet" "public" {
    cidr_block = "10.0.0.0/24"
    vpc_id = aws_vpc.dev.id
   
 }
 resource "aws_eip" "nat_eip" {
    vpc = true

  tags = {
    Name = "NAT EIP"
  }
  }

resource "aws_nat_gateway"
{
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.public.id
    tags = {
        Name = "Nat Gateway"
    }
    depends_on = [aws_internet_gateway.name]
}


 resource "aws_subnet" "private" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.dev.id
   
 }
 resource "aws_route_table" "name" {
    vpc_id = aws_vpc.dev.id
    route{
        cidr_block="0.0.0.0/0"
        gateway_id = aws_internet_gateway.name.id
    }
   
 }
resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.dev.id
    route  {
        cidr_block="0.0.0.0/0"
        gateway_id = aws_nat_gateway.name.id
    }
  
}
 resource "aws_route_table_association" "private_subnet_association" {
    subnet_id = aws_subnet.private.id
    route_table_id = aws_route_table.name.id
 }


 resource "aws_route_table_association" "public_subnet_association" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.name.id
   
 }
 resource "aws_instance" "my_ec2" {
    ami="ami-002f6e91abff6eb96"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public.id
    associate_public_ip_address = true
   
 }
 resource "aws_instance" "name" {
    ami="ami-0f1dcc636b69a6438"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.private.id
    associate_public_ip_address = true
 }
 resource "aws_security_group" "allow_tls" {
    name = "allow_tls"
    vpc_id = aws_vpc.dev.id
    tags = {
        Name = "dev_sg"
    }
    ingress {
        description = "TLS from VPC"
        from_port = 80
        to_port   = 80
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]   
         }
        
        ingress {
        description = "TLS from VPC"
        from_port = 22
        to_port   =22
        protocol  ="tcp"
        cidr_blocks =["0.0.0.0/0"]  
          }

        egress {
            from_port = 0
            to_port   =0
            protocol  ="-1"
            cidr_blocks = ["0.0.0.0/0"]
        }
   
   
 }