terraform {
  required_version = ">= 0.15"
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc1"
    }
    bitwarden-secrets = {
      source  = "registry.terraform.io/sebastiaan-dev/bitwarden-secrets"
      version = ">=0.1.2"
    }
    environment = {
      source = "registry.terraform.io/MorganPeat/environment"
      version = "0.2.7"
    }
  }
  backend "s3" {
    bucket = "terraform-state"
    key    = "tailnet/samba.tfstate"
    endpoints = { s3 = "https://f64539ced264ccd0bc76ff2b1ad1e383.r2.cloudflarestorage.com" }
    region = "us-east-1"
    skip_credentials_validation = true
    skip_region_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum = true
  }

}

# Or, read a pre-existing secret
data "bitwarden-secrets_secret" "cl_access_key" {
  id = "7a4f65d4-1532-4b46-a0e2-b1a300bff43b"
}

data "environment_variable" "bws_access_token" {
  name = "BWS_ACCESS_TOKEN"
}

# Configure the provider
provider "bitwarden-secrets" {
  access_token = data.environment_variable.bws_access_token.value
}

# Or, read a pre-existing secret
data "bitwarden-secrets_secret" "pm_password" {
  id = "7a4f65d4-1532-4b46-a0e2-b1a300bff43b"
}

provider "proxmox" {
  # pm_debug = true
  # pm_tls_insecure = true

  pm_api_url = "https://pve.chk.no/api2/json"
  pm_user = "terraform@pve"
  pm_password = data.bitwarden-secrets_secret.pm_password.value
}
