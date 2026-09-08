## Production Change Path
1. A developer creates a feature branch from `main`.
2. Terraform changes are committed and pushed to GitHub.
3. A pull request is opened against `main`.
4. GitHub Actions runs formatting, `terraform validate`, security scanning,
and a Terraform plan for review.
5. Reviewers inspect the code, scanner findings, and the plan. Changes that
include unexpected destroy/replacement actions are not merged until explained.
6. After required PR checks and approvals pass, the change is merged to `main`.
7. The production deployment job references the protected `production`
GitHub environment and waits for deployment approval where configured.
8. GitHub requests an OIDC identity token. AWS STS evaluates the production
IAM role trust policy and returns short-lived AWS credentials if the claims match.
9. Terraform initializes the S3 backend, acquires the state lock, creates a plan,
and applies the approved production configuration using the least-privilege role.
10. The workflow verifies Terraform outputs and application reachability.
11. If verification fails, the team stops further deployment and chooses a
corrective change or rollback path based on the failure and data risk.
