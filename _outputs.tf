/*output "subnet_cidr_blocks" {
  #value = [for s in data.aws_subnet.example : s.id]
  value = contains(data.aws_subnet.example[*].tags.subnet-type, "private") 
}*/

output "subnet_cidr_blocks" {
  #value = [for s in data.aws_subnet.example : s.id]
  value = data.aws_subnet_ids.example.ids
}

output "private_subnet_cidr_blocks" {
  #value = [for s in data.aws_subnet.example : s.id]
  value = data.aws_subnet_ids.private.ids
}

output "public_subnet_cidr_blocks" {
  #value = [for s in data.aws_subnet.example : s.id]
  value = data.aws_subnet_ids.public.ids
}

output "test_policy_arn" {
  value = aws_iam_role.test_oidc.arn
}

#output "eks_cluster_autoscaler_arn" {
#  value = aws_iam_role.eks_cluster_autoscaler.arn
#}
