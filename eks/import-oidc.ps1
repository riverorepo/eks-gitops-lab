# Adopt the account's existing GitHub OIDC provider into Terraform state,
# then apply the rest (IAM role + policy). ECR repo is already created.
$arn = "arn:aws:iam::241356815757:oidc-provider/token.actions.githubusercontent.com"

terraform import aws_iam_openid_connect_provider.github $arn
terraform plan
