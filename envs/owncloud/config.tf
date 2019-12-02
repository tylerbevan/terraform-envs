provider "digitalocean" {
  token = var.digitalocean_token
}

data "digitalocean_ssh_key" "ssh_key" {
  name = var.digitalocean_ssh_key_name
}

provider "cloudflare" {
  version = "~> 2.0"
  email   = var.cloudflare_email
  api_key = var.cloudflare_key
}

data "cloudflare_zones" "filtered" {
  filter {
    name   = var.cloudflare_zone_name
  }
}

terraform {
  backend "s3" {
    access_key = var.s3_access_key
    secret_key = var.s3_secret_key
    bucket = var.s3_bucket
    region = var.s3_region
    key = var.s3_state_key
    endpoint = var.s3_endpoint
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}

