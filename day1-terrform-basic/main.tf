resource "aws_vpc" "my_vpc" {

  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my-vpc"
  }

}

resource "aws_instance" "my_server" {

  ami           = "ami-0f559c3642608c138"
  instance_type = "t3.micro"

  tags = {
    Name = "my-ec2-server"
  }
}