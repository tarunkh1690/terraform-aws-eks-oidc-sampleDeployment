resource "aws_subnet" "k8s-private-subnet" {
  count = length(data.aws_availability_zones.available.names)

  cidr_block              = cidrsubnet(var.aws_vpc_cidr, 8, count.index + 1)
  vpc_id                  = aws_vpc.k8s-vpc.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = "false" //it makes this a private subnet
  depends_on              = [aws_vpc.k8s-vpc]

  tags = {
    Name                           = "${var.cluster_name}-private-subnet-${data.aws_availability_zones.available.names[count.index]}"
    subnet-type                    = "private"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/${var.cluster_name}"    = "owned"
  }
}


resource "aws_subnet" "k8s-public-subnet" {
  count = length(data.aws_availability_zones.available.names)

  cidr_block              = cidrsubnet(var.aws_vpc_cidr, 8, count.index + length(data.aws_availability_zones.available.names) + 1)
  vpc_id                  = aws_vpc.k8s-vpc.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = "true" //it makes this a public subnet
  depends_on              = [aws_vpc.k8s-vpc]

  tags = {
    Name                           = "${var.cluster_name}-public-subnet-${data.aws_availability_zones.available.names[count.index]}"
    subnet-type                    = "public"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/${var.cluster_name}"    = "owned"
  }
}
