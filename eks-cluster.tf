resource "aws_iam_role" "eksass" {
  name = "eks-cluster-ass"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eksass-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eksass.name
}

resource "aws_eks_cluster" "eksass" {
  #count = length(data.aws_availability_zones.available.names)
  name     = "eksass"
  role_arn = aws_iam_role.eksass.arn

  vpc_config {
    count = length(data.aws_availability_zones.available.names)
    security_group_ids = [aws_security_group.k8s_cluster_sg.id]
    #subnet_ids        = data.aws_subnet_ids.example.ids
    subnet_ids         = [
      aws_subnet.k8s-private-subnet[count.index].id,
      aws_subnet.k8s-public-subnet[count.index].id
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eksass-AmazonEKSClusterPolicy,
    aws_security_group.k8s_cluster_sg,
    aws_instance.bastion
  ]
}