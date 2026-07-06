# Prints the ArgoCD initial admin password (username is: admin).
# The password lives base64-encoded in a Kubernetes secret; this decodes it.
$enc = kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}"
$pw  = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($enc))
Write-Host "username: admin"
Write-Host "password: $pw"
