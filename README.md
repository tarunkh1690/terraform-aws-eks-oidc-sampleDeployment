# terraform-aws-eks-oidc-sampleDeployment
Using terraform to create EKS cluster with sample deployment and used OIDC to access AWS service from pod like S3 storage

Steps - 
1- cd terraform-aws-eks-oidc-sampleDeployment/
2- terraform init
3- terraform plan
4- terraform apply
5- aws eks --region ${region} update-kubeconfig --name ${cluster_name] # replace regin & cluster_name
6- copy test-oidc arn from output and update in terraform-aws-eks-oidc-sampleDeployment/aws-test.yaml file in front of 'eks.amazonaws.com/role-arn'.
