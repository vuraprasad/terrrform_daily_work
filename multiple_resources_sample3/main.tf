resource "aws_vpc" "siapp_vpc" {
    cidr_block = var.vpc_cidr
    region = var.region
    enable_dns_support = true
    enable_dns_hostnames = true
    tags={
        Name="siapp-vpc"
    }
  
}

resource "aws_subnet" "siapp-subnets" {
    count=6
    vpc_id = aws_vpc.siapp_vpc.id
    cidr_block =cidrsubnet(var.vpc_cidr,8,count.index)
    availability_zone ="${var.region}${count.index%2==0?"a": "b"}"  //  "${var.region}${count.index%2==0?"a":"b"}"               //var.subnets_azs[count.index]
    tags = {
      Name=  "siapp_dev_${local.subnets_names[count.index]}"       //local.subnets_names[count.index]                 //"siapp_dev_${var.subnets_names[count.index]}"
    }
    depends_on = [ aws_vpc.siapp_vpc ]
     
  
}
resource "aws_internet_gateway" "siapp-igw" {
     vpc_id = aws_vpc.siapp_vpc.id
     tags = {
       Name=local.igw_name
     }
     depends_on = [ aws_vpc.siapp_vpc ]
  
}

resource "aws_route_table" "siapp-public-rtb" {

    vpc_id = aws_vpc.siapp_vpc.id

    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.siapp-igw.id
    }
    

    tags = {
      Name="siapp-public-rtb"
    }
    depends_on = [ aws_internet_gateway.siapp-igw ]
  
}

resource "aws_route_table_association" "siapp-rtb-associate" {
    count = 2
    route_table_id = aws_route_table.siapp-public-rtb.id
    subnet_id = aws_subnet.siapp-subnets[count.index].id

    depends_on = [ aws_route_table.siapp-public-rtb,aws_subnet.siapp-subnets ]
  
}

resource "aws_route_table" "siapp-private-rtb" {

    vpc_id = aws_vpc.siapp_vpc.id
     tags = {
      Name="siapp-private-rtb"
    }
    depends_on = [ aws_internet_gateway.siapp-igw,aws_subnet.siapp-subnets ]
  
}

resource "aws_route_table_association" "siapp-rtb-associate1" {
    count = 4
    route_table_id = aws_route_table.siapp-private-rtb.id
    subnet_id = aws_subnet.siapp-subnets[count.index+2].id

   depends_on = [ aws_route_table.siapp-private-rtb,aws_subnet.siapp-subnets ]
  
}