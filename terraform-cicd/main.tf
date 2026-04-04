

resource "aws_instance" "terraform" {
    ami = "ami-01b14b7ad41e17ba4"
    instance_type = "t3.micro"
    tags = {
      Name = "terrefor-created"
    }
}