# output "openid_claims" {
#   description = "OpenID Claims for trust relationship"
#   value       = vault_jwt_auth_backend_role.tfc_role.bound_claims
# }

# output "run_role" {
#   description = "Name of the vault role for trust relationship"
#   value       = vault_jwt_auth_backend_role.tfc_role.role_name
# }

output "admin_role_name" {
  value       = vault_jwt_auth_backend_role.example.role_name
  description = "Admin Role Name"
}

output "admin_bound_claim" {
  value       = vault_jwt_auth_backend_role.example.bound_claims
  description = "Admin Bound Clamins Name"
}

