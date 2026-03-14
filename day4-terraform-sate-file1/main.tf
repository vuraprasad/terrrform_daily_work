resource "aws_vpc" "flip-vpc-01" {
    cidr_block = "10.0.0.0/16"
     tags = {
       Name="test-vpc"
     }
}

resource "aws_instance" "name" {
    
    ami = "ami-0f559c3642608c138"
    instance_type = "t3.micro"
    tags = {
        Name = "test-ec2"
    }   
}

