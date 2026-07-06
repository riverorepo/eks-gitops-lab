# Adopt the account's existing GitHub OIDC provider into Terraform state,
# then apply the rest (IAM role + policy). ECR repo is already created.
$acct = (aws sts get-caller-identity --query Account --output text)
$arn = "arn:aws:iam::${acct}:oidc-provider/token.actions.githubusercontent.com"

terraform import aws_iam_openid_connect_provider.github $arn
terraform plan
