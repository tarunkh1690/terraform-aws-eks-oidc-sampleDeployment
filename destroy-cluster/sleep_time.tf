/*resource "time_sleep" "wait_10_seconds_public" {
  depends_on = [aws_subnet.k8s-public-subnet]

  create_duration = "10s"
}

resource "time_sleep" "wait_10_seconds_private" {
  depends_on = [aws_subnet.k8s-private-subnet]

  create_duration = "10s"
}*/