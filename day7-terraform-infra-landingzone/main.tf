
#Creation of VPC
resource "aws_vpc" "app-vpc-01" {
    cidr_block = "10.0.0.0/16"
   tags = {
     Name ="dev-vpc"
   }
  
}
resource "aws_subnet" "app-public-subnet-01" {
  vpc_id = aws_vpc.app-vpc-01.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  tags = {
    Name="dev-public-subnet"
  }
  
}

resource "aws_subnet" "app-private-subnet-01" {
  vpc_id = aws_vpc.app-vpc-01.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2a"
  tags = {
    Name="dev-private-subnet"
  }
  
}

resource "aws_internet_gateway" "app-ig" {
  vpc_id = aws_vpc.app-vpc-01.id
  tags = {
    Name="dev-ig"
  }
  
}

resource "aws_route_table" "app-rt01" {

  vpc_id = aws_vpc.app-vpc-01.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app-ig.id
  }
  tags = {
    Name="dev-rt01"
  }
   
}

resource "aws_route_table_association" "app-rtass01" {
  route_table_id = aws_route_table.app-rt01.id
  subnet_id = aws_subnet.app-public-subnet-01.id
  
}

resource "aws_security_group" "app-pub-sg-01" {
  name = "pub-sg-01"
  description = "allow ssh and http traffic"
  vpc_id = aws_vpc.app-vpc-01.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  
  egress {
    description = "all all outbound"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = {
    Name="pub-sg-01"
  }
}

resource "aws_instance" "app-public-ec2-01" {
  ami="ami-03caad32a158f72db"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.app-public-subnet-01.id
  associate_public_ip_address = true
  vpc_security_group_ids = [ aws_security_group.app-pub-sg-01.id ]
   tags = {
        Name = "app-pub-ec2-01"
    }
  
}