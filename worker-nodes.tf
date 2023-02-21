resource "aws_iam_role" "worker-nodes" {
  name = "eks-node-group-workernodes"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "worker-nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.worker-nodes.name
}

resource "aws_iam_role_policy_attachment" "worker-nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.worker-nodes.name
}

resource "aws_iam_role_policy_attachment" "worker-nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.worker-nodes.name
}

resource "aws_iam_policy" "Amazon_EBS_CSI_Driver" {
  name = "Amazon_EBS_CSI_Driver"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:AttachVolume",
          "ec2:CreateSnapshot",
          "ec2:CreateTags",
          "ec2:CreateVolume",
          "ec2:DeleteSnapshot",
          "ec2:DeleteTags",
          "ec2:DeleteVolume",
          "ec2:DescribeInstances",
          "ec2:DescribeSnapshots",
          "ec2:DescribeTags",
          "ec2:DescribeVolumes",
          "ec2:DetachVolume"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "worker-nodes-AmazonEBSCSIDriver" {
  policy_arn = aws_iam_policy.Amazon_EBS_CSI_Driver.arn
  role       = aws_iam_role.worker-nodes.name
}

resource "aws_eks_node_group" "private-nodes" {
  #count = length(aws_subnet.k8s-private-subnet)
  cluster_name    = aws_eks_cluster.eksass.name
  node_group_name = "private-nodes"
  node_role_arn   = aws_iam_role.worker-nodes.arn

  #subnet_ids = [aws_subnet.k8s-private-subnet[count.index].id]
  #subnet_ids = data.aws_subnet_ids.private.ids
  subnet_ids  = aws_subnet.k8s-private-subnet[*].id

  capacity_type  = "ON_DEMAND"
  instance_types = ["t3.small"]

  scaling_config {
    desired_size = 1
    max_size     = 5
    min_size     = 0
  }

  update_config {
    max_unavailable = 1
  }

  remote_access {
    ec2_ssh_key = "k8s-cluster-key"
    source_security_group_ids = [
      aws_security_group.k8s_cluster_sg.id
    ]
  }

  labels = {
    role = "general"
  }

  depends_on = [
    aws_iam_role_policy_attachment.worker-nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.worker-nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.worker-nodes-AmazonEC2ContainerRegistryReadOnly,
    aws_subnet.k8s-public-subnet,
    aws_security_group.k8s_cluster_sg,
  ]
}