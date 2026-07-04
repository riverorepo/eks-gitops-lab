output "ecr_repository_url" {
  description = "Push/pull URL for the app image"
  value       = aws_ecr_repository.app.repository_url
}

output "github_actions_role_arn" {
  description = "Role ARN for GitHub Actions to assume via OIDC"
  value       = aws_iam_role.github_actions.arn
}