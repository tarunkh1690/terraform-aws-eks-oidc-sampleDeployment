## For private subnet
resource "aws_route_table" "k8s-private-rt" {
  vpc_id = aws_vpc.k8s-vpc.id

  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    //CRT uses this IGW to reach internet
    nat_gateway_id = aws_nat_gateway.k8s-nat.id
  }

  tags = {
    Name = "k8s-private-rt"
  }
  depends_on = [aws_subnet.k8s-private-subnet]
}


resource "aws_route_table_association" "k8s-private-rta" {
  count          = length(data.aws_availability_zones.available.names)
  subnet_id      = element(aws_subnet.k8s-private-subnet.*.id, count.index)
  route_table_id = aws_route_table.k8s-private-rt.id
  depends_on     = [aws_subnet.k8s-private-subnet]
}



## For Public subnet

resource "aws_route_table" "k8s-public-rt" {
  vpc_id = aws_vpc.k8s-vpc.id

  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    //CRT uses this IGW to reach internet
    gateway_id = aws_internet_gateway.k8s-igw.id
  }

  tags = {
    Name = "k8s-public-rt"
  }
  depends_on = ["aws_subnet.k8s-public-subnet"]
}

resource "aws_route_table_association" "k8s-public-rta" {
  count          = length(data.aws_availability_zones.available.names)
  subnet_id      = element(aws_subnet.k8s-public-subnet.*.id, count.index)
  route_table_id = aws_route_table.k8s-public-rt.id
  depends_on     = ["aws_subnet.k8s-public-subnet"]
}