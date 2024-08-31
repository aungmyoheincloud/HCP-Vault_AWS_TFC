resource "hcp_hvn" "vault_hvn" {
  hvn_id         = var.vault_hvn_1
  cloud_provider = var.cloud_provider
  region         = var.region
  cidr_block     = var.cluster_cider
}

resource "hcp_vault_cluster" "vault_cluster" {
  cluster_id = var.vault_cluster_id
  hvn_id     = hcp_hvn.vault_hvn.hvn_id
  tier       = var.tier_type
  public_endpoint = true
}




