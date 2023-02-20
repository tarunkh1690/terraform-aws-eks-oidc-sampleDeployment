resource "tls_private_key" "sshkeys" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}


resource "aws_key_pair" "k8s-cluster-key" {
  key_name   = "k8s-cluster-key"
  public_key = tls_private_key.sshkeys.public_key_openssh
  //  depends_on = ["tls-private-key.sshkeys"]
}