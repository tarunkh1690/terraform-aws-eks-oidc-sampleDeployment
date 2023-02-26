# terraform-aws-eks-oidc-sampleDeployment
Using terraform to create EKS cluster with sample deployment and used OIDC to access AWS service from pod like S3 storage

Steps - 

1- cd terraform-aws-eks-oidc-sampleDeployment/

2- terraform init

3- terraform plan

4- terraform apply

5- aws eks --region region-name update-kubeconfig --name cluster-name # replace region & cluster_name.

6- kubectl get svc # to check cluster access

7- copy test-oidc arn from output and update in terraform-aws-eks-oidc-sampleDeployment/aws-test.yaml file in front of 'eks.amazonaws.com/role-arn'.

8- kubectl apply -f terraform-aws-eks-oidc-sampleDeployment/aws-test.yaml # To deploy awscli pod.

9- kubectl exec aws-cli -- aws s3api list-buckets  # list s3 bucket to check s3 access from pod.

# Deploy EBS CSI Driver
kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=master"

# Verify ebs-csi pods running
kubectl get pods -n kube-system


