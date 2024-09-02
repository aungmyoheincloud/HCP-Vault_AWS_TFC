data "terraform_remote_state" "vault_admin" {
  backend = "remote"

  config = {
    organization = "HCP-Vault_AWS_TFC"
    workspaces = {
      name = "tfc-create-vault-admin-iam-aws"
    }
  }
}


data "vault_aws_access_credentials" "master_netadmin_creds" {
  backend = vault_aws_secret_backend.aws.path
  role    = vault_aws_secret_backend_role.dynamic_role.name
}