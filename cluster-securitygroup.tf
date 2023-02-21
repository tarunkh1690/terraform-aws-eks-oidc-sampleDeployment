resource "aws_security_group" "k8s_cluster_sg" {
  name        = "${var.cluster_name}-security-group"
  description = "Cluster communication with worker nodes & bastion"
  vpc_id      = aws_vpc.k8s-vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-security-group"
  }
}

resource "aws_security_group_rule" "cluster-ingress-workstation-https" {
  cidr_blocks       = [var.aws_vpc_cidr]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.k8s_cluster_sg.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "cluster-ingress-workstation-ssh" {
  cidr_blocks       = [var.aws_vpc_cidr]
  description       = "Allow bastion to ssh"
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.k8s_cluster_sg.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "cluster-ingress-workstation-publicssh" {
  cidr_blocks       = ["103.163.201.246/32"]
  description       = "Allow bastion to ssh"
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.k8s_cluster_sg.id
  to_port           = 22
  type              = "ingress"
}