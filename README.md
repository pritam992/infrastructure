# infrastructure

# infrastructure

Terraform for multiple AWS environments, deployed by a Jenkins multibranch pipeline.

## Layout

```
Jenkinsfile                      # pipeline: Check -> Plan -> Approve -> Apply
terraform/
  modules/                       # shared modules (vpc, security, rds-networking, ...)
  environments/
    Development/                 # one folder per environment
      *.tf, terraform.tfvars
      backend.hcl                # remote state settings
```

## How it works

- Jenkins runs on EC2. Its instance profile role (`terraform-iac-role`) assumes a deploy role (`terraform-deploy`) in the target account. No AWS keys are stored.
- The deploy role ARN comes from the Jenkins credential `aws-role-<folder>`.
- State is stored in S3 with native locking (`use_lockfile`).

## One-time setup (per environment)

1. **State bucket** – create an S3 bucket with versioning on and public access blocked.
2. **Deploy role `terraform-deploy`** (in the environment's account)
   - Trust policy: allow `arn:aws:iam::<JENKINS_ACCOUNT_ID>:role/terraform-iac-role` to `sts:AssumeRole`.
   - Permissions: `AmazonVPCFullAccess`, `AmazonRDSFullAccess`, `AmazonRoute53FullAccess`, plus an inline policy for the state bucket:
     `s3:ListBucket` on the bucket, `s3:GetObject/PutObject/DeleteObject` on `infrastructure/<folder>/*`.
3. **Jenkins role `terraform-iac-role`** (once, in the Jenkins account)
   - Trust policy: `ec2.amazonaws.com` (keep it).
   - Permissions: `sts:AssumeRole` on every `terraform-deploy` role ARN.
4. **Jenkins credential** – Manage Jenkins → Credentials → Global → Add:
   - Kind: Secret text
   - Secret: `arn:aws:iam::<ENV_ACCOUNT_ID>:role/terraform-deploy`
   - ID: `aws-role-<folder>` (exact, case-sensitive, e.g. `aws-role-Development`)
5. **Repo files** in `terraform/environments/<folder>/`:
   - `version.tf` contains `backend "s3" {}` inside the `terraform {}` block.
   - `backend.hcl`:
     ```hcl
     bucket       = "<state-bucket>"
     key          = "infrastructure/<folder>/terraform.tfstate"
     region       = "<bucket-region>"   # region of the bucket, not of the resources
     use_lockfile = true
     ```

Verify from the Jenkins EC2:

```bash
aws sts assume-role --role-arn arn:aws:iam::<ENV_ACCOUNT_ID>:role/terraform-deploy \
  --role-session-name test --query 'AssumedRoleUser.Arn' --output text
```

## Running the pipeline

| Parameter     | Values                 | Notes                                    |
|---------------|------------------------|------------------------------------------|
| `ENVIRONMENT` | folder name            | e.g. `Development`                       |
| `ACTION`      | `plan` / `apply`       | `apply` only from `main`, needs approval |

- A push runs a plan only. Review `plan.txt` under Build Artifacts.
- To deploy: merge to `main` → Build with Parameters → `ACTION=apply` → approve.

## Adding an environment

1. Copy `terraform/environments/Development` to `terraform/environments/<NewEnv>`.
2. Update `terraform.tfvars` (environment name, non-overlapping CIDRs) and `backend.hcl` (key `infrastructure/<NewEnv>/...`).
3. Complete the one-time setup steps above for `<NewEnv>`.

## Troubleshooting

| Error | Fix |
|-------|-----|
| `Could not find credentials entry with ID 'aws-role-...'` | Credential ID must match the folder name exactly. |
| `Missing .../backend.hcl` | Add `backend.hcl` to the environment folder. |
| `Missing backend configuration` warning | Add `backend "s3" {}` to `version.tf`; otherwise state stays local. |
| `requested bucket from "X", actual location "Y"` | Set `region` in `backend.hcl` to the bucket's region (`Y`). |
| `AccessDenied` on assume-role or S3 | Check both trust policies, `sts:AssumeRole` on `terraform-iac-role`, and the bucket policy path. |
| `Apply is only allowed from the main branch` | Merge to `main`, then run apply there. |

> NAT gateways and Elastic IPs are billed hourly. Destroy lab environments when done.
