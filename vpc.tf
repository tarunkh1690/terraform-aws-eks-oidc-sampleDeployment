resource "aws_vpc" "k8s-vpc" {
  cidr_block           = var.aws_vpc_cidr
  enable_dns_support   = "true" #gives you an internal domain name
  enable_dns_hostnames = "true" #gives you an internal host name
  enable_classiclink   = "false"
  instance_tenancy     = "default"

  tags = {
    Name = "${var.cluster_name}-vpc"
  }
}
