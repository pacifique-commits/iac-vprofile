# IAM policy for KMS permissions for gitops user
resource "aws_iam_policy" "gitops_kms_policy" {
  name        = "GitOpsKMSPolicy"
  description = "KMS permissions for GitOps user to manage EKS cluster encryption"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "kms:CreateKey",
          "kms:CreateAlias",
          "kms:UpdateAlias",
          "kms:DeleteAlias",
          "kms:DescribeKey",
          "kms:ListKeys",
          "kms:ListAliases",
          "kms:GetKeyPolicy",
          "kms:PutKeyPolicy",
          "kms:EnableKey",
          "kms:DisableKey",
          "kms:TagResource",
          "kms:UntagResource",
          "kms:ScheduleKeyDeletion",
          "kms:CancelKeyDeletion"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach the policy to the gitops user
resource "aws_iam_user_policy_attachment" "gitops_kms_policy_attachment" {
  user       = "gitops"
  policy_arn = aws_iam_policy.gitops_kms_policy.arn
}