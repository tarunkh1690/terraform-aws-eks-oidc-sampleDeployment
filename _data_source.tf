data "aws_availability_zones" "available" {}

data "aws_subnet_ids" "example" {
  vpc_id     = aws_vpc.k8s-vpc.id
  #depends_on = [time_sleep.wait_10_seconds_private]
}

data "aws_subnet_ids" "private" {
  vpc_id = aws_vpc.k8s-vpc.id
  filter {
    name   = "tag:subnet-type"
    values = ["private"]
  }
  #depends_on = [time_sleep.wait_10_seconds_private]
}

data "aws_subnet_ids" "public" {
  vpc_id = aws_vpc.k8s-vpc.id
  filter {
    name   = "tag:subnet-type"
    values = ["public"]
  }
  #depends_on = [time_sleep.wait_10_seconds_public]
}

