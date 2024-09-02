output "dynamic_role" {
  description = "Read the Master NetworkAdmin Role"
  value = resource.vault_aws_secret_backend_role.dynamic_role
}

output "IAM_User_IAMAdmin_Role" {
  description = "Output of IAM User Master NetworkAdmin Role"
  value = data.vault_aws_access_credentials.master_netadmin_creds
  sensitive = true
}

output "backend_path" {
  description = "Output of Vault Secret Backend Path"
  value = vault_aws_secret_backend.aws.path
}

output "backend_role" {
  description = "Output of Vault Secret Backend Role Name"
  value = vault_aws_secret_backend_role.dynamic_role.name
}