variable "region" {
    type = string
    default = "ap-south-2"
    description = "region in which resource to be created"
  
}

variable "vpc_cidr" {
    type = string
    default = "192.168.0.0/16"
  
}
# variable "subnets_names" {
#     type = list(string)
#     default = [ "web1","web2","app1","app2","db1","db2" ]
#     description = "name of the stubnets"
  
# }

# variable "subnets_cidr_ranges" {
#     type = list(string)
#     default = [ "192.168.0.0/24","192.168.1.0/24","192.168.2.0/24","192.168.3.0/24","192.168.4.0/24","192.168.5.0/24" ]
#     description = "cidr ranges of the subnets"
  
# }

# variable "subnets_azs" {
#     type = list(string)
#     default = [ "us-east-1a","us-east-1b","us-east-1a","us-east-1b","us-east-1a","us-east-1b" ]
  
# }