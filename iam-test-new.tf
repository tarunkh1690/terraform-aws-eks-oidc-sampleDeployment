##data "aws_iam_policy_document" "test_oidc_assume_role_policy" {
#  statement {
#    actions = ["sts:AssumeRoleWithWebIdentity"]
#    effect  = "Allow"
#
#    condition {
#      test     = "StringEquals"
#      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
#      values   = ["system:serviceaccount:default:aws-test"]
#    }
#
#    principals {
#      identifiers = [aws_iam_openid_connect_provider.eks.arn]
#      type        = "Federated"
#    }
#  }
#}*/

resource "aws_iam_role" "test_oidc" {
  #assume_role_policy = data.aws_iam_policy_document.test_oidc_assume_role_policy.json
  #assume_role_policy = aws_iam_policy.test-policy.name 
  name               = "test-oidc"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  
  inline_policy {
    name = "my_inline_policy"
    policy =   jsonencode({
      Statement = [{
        Action = [
          "s3:ListAllMyBuckets",
          "s3:GetBucketLocation"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::*"
      }]
      Version = "2012-10-17"
    }) 
}

#resource "aws_iam_policy" "test-policy" {
#  name = "test-policy"
#
#  policy = jsonencode({
#    Statement = [{
#      Action = [
#        "s3:ListAllMyBuckets",
#        "s3:GetBucketLocation"
#      ]
#      Effect   = "Allow"
#      Resource = "arn:aws:s3:::*"
#    }]
#    Version = "2012-10-17"
#  })
#}

#resource "aws_iam_role_policy_attachment" "test_attach" {
#  role       = aws_iam_role.test_oidc.name
#  policy_arn = aws_iam_policy.test-policy.arn
#}

