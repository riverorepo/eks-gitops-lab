# eks-gitops-lab

Learning a production-style GitOps pipeline one command at a time: a container
image built once and promoted from Docker all the way to EKS, with ArgoCD keeping
the cluster in sync with git.

See the visual stage map: [`diagrams/pipeline.html`](diagrams/pipeline.html)

## The pipeline

| Stage | What | Status |
|-------|------|--------|
| 1 | Docker: tiny Python app + Dockerfile | done |
| 2 | AWS foundation: ECR repo + GitHub OIDC trust (Terraform) | done |
| 3 | CI: GitHub Actions builds and pushes the image | done |
| 4 | EKS cluster (eksctl) running the image | done |
| 5 | ArgoCD watches this repo and syncs to the cluster | done |

The full loop was built, proven end to end (CI push -> ECR -> EKS -> ArgoCD
auto-sync + self-heal), then torn down to avoid cost. Rebuild the cluster with
`eksctl create cluster -f eks/cluster.yaml`.

## Layout

```
docker/      app.py + Dockerfile (the hello app)
eks/         Terraform (ECR + OIDC + IAM) and cluster.yaml (eksctl cluster spec)
k8s/         Deployment + Service that ArgoCD syncs
argocd/      app.yaml: the ArgoCD Application pointing at k8s/
scripts/     helpers (e.g. get-argocd-password.ps1)
diagrams/    pipeline.html + aws-architecture.html (visual maps)
```

## Key idea: passwordless CI

GitHub Actions authenticates to AWS with a short-lived OIDC token, not stored
access keys. AWS only trusts tokens from this specific repo (the `sub` condition
in `eks/github-oidc.tf`). Nothing secret lives in the repo.

## Notes

- Terraform state and `*.tfvars` are gitignored (never commit state, it can hold secrets).
- The GitHub OIDC provider is account-wide and shared with other labs, so it was
  imported into state rather than recreated.
- Region: `us-east-1`.
