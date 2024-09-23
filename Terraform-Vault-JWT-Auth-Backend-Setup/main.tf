resource "vault_jwt_auth_backend" "tfc_jwt" {
  path               = var.jwt_backend_path
  type               = "jwt"
  oidc_discovery_url = "https://${var.tfc_hostname}"
  bound_issuer       = "https://${var.tfc_hostname}"
}

resource "vault_jwt_auth_backend_role" "tfc_role" {
  backend        = vault_jwt_auth_backend.tfc_jwt.path
  role_name      = var.tfc_role_name
  token_policies = [vault_policy.tfc_policy.name]

  bound_audiences = [var.tfc_vault_audience]

  bound_claims_type = "glob"
  bound_claims = {
    sub = "organization:${var.tfc_organization_name}:project:${var.tfc_project_name}:workspace:${var.tfc_workspace_name}:run_phase:*"
  }

  user_claim = "terraform_full_workspace"
  role_type  = "jwt"
  token_ttl  = 1200
}

resource "vault_policy" "tfc_policy" {
  name = "tfc-policy"

  policy = <<EOT
# Allow tokens to query themselves
path "auth/token/lookup-self" {
  capabilities = ["read"]
}

# Allow tokens to renew themselves
path "auth/token/renew-self" {
    capabilities = ["update"]
}

# Allow tokens to revoke themselves
path "auth/token/revoke-self" {
    capabilities = ["update"]
}

path "sys/mounts" {
  capabilities = ["list", "read"]
}

path "sys/mounts/example" {
  capabilities = ["create", "read", "update", "patch", "delete", "list"]
}

path "example/*" {
  capabilities = ["create", "read", "update", "patch", "delete", "list"]
}
EOT
}

# resource "vault_jwt_auth_backend" "main" {
#     description         = "Terraform Dyanmic Provider Credential"
#     path                = "jwt"
#     oidc_discovery_url  = "https://app.terraform.io"
#     bound_issuer        = "https://app.terraform.io"
# }

# resource "vault_policy" "main" {
#   name = "admin-policy"

#   policy = <<EOT
# path "auth/*"
# {
#   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
# }
# # Create, update, and delete auth methods
# path "sys/auth/*"
# {
#   capabilities = ["create", "update", "delete", "sudo"]
# }
# # List auth methods
# path "sys/auth"
# {
#   capabilities = ["read"]
# }
# # Enable and manage the key/value secrets engine at `secret/` path
# # List, create, update, and delete key/value secrets
# path "secret/*"
# {
#   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
# }
# # Manage secrets engines
# path "sys/mounts/*"
# {
#   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
# }
# # List existing secrets engines.
# path "sys/mounts"
# {
#   capabilities = ["read"]
# }
# # Manage system backend
# path "db/*"
# {
#   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
# }
# # List existing secrets engines.
# path "db/"
# {
#   capabilities = ["read"]
# }
# path "aws-master/" {
#   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
# }
# path "aws-master/*" {
#   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
# }
# path "sys/policy/*" {
#   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
# }
# path "sys/policy/" {
#   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
# }
# path "sys/policies/*" {
#   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
# }
# path "sys/policies/" {
#   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
# }
# path "sys/mounts/example" {
#   capabilities = ["create", "read", "update", "patch", "delete", "list"]
# }
# path "example/*" {
#   capabilities = ["create", "read", "update", "patch", "delete", "list"]
# }
# EOT
# }

# resource "vault_jwt_auth_backend_role" "example" {
#   backend         = vault_jwt_auth_backend.main.path
#   role_name       = "tfc-admin-role"
#   token_policies  = [vault_policy.main.name]

#   bound_audiences = ["vault.workload.identity"]
#   bound_claims_type = "glob"
#   bound_claims = {
#     sub = "organization:hc-tfc:project:Default Project:workspace:*:run_phase:*"
#   }
#   user_claim = "terraform_full_workspace"
#   role_type  = "jwt"
#   token_ttl  = 1200
}

