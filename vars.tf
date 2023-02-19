variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "aws_vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "subnet_cidrs" {
  type    = list(string)
  default = []
}


variable "tags" {
  default = {
    Name = ""
  }
}
