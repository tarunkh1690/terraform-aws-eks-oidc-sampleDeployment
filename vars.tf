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

variable "public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDi0tFrpdzHinebYCHiAB/pQ+vXkB0I+QRXnimKCQXUfePnKEtCbAb8Y2aX5C9+T4pYtdo842uULgbPgwafAAP5/+QuMu1+muINQK18TDNOcFx0g590dq+bzJpkZFt94s09cek6cxqdbtzwTN7jxXJRYXH14JjC1SGTvOEToAaAsZwB82YdxUFJvyNghRQHAwpF4lYfQoO55puLwXLrUdVCFfahINwsLTonwfyvDcgsVhSJgzhr7hEoIx0S8hxhAoUDDMbbqel1N2zOGOGiH2BYocDg1ud28/ultwdmh9OMmTxsVpvup3h68RFf2dj9P4re1mmIjb3QSghCTuozBPc5"
}

variable "AWS_ACCESS_KEY_ID" {
  default = ""
}

variable "AWS_SECRET_ACCESS_KEY" {
  default = ""
}