resource "aws_instance" "EC2_instance_01" {

    ami  = "ami-02dfbd4ff395f2a1b"
    instance_type = "t3.micro"
    lifecycle {
       create_before_destroy = true
       ignore_changes = [ tags ]
      // prevent_destroy = true
    }
    tags = {
      Name="dev-lifecycle"
    }
  
}