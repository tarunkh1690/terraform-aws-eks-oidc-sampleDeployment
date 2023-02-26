
resource "aws_eip" "k8s-nat" {
  vpc = true

  tags = {
    Name = "${var.cluster_name}-nat"
  }
}

resource "aws_nat_gateway" "k8s-nat" {
  allocation_id = aws_eip.k8s-nat.id
  subnet_id     = aws_subnet.k8s-public-subnet[0].id

  tags = {
    Name = "${var.cluster_name}-nat"
  }

  depends_on = [aws_internet_gateway.k8s-igw]
}
