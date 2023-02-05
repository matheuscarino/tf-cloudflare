terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "3.33.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "4.53.0"
    }
  }
}

provider "cloudflare" {
  email     = var.cloudflare_email
  api_key   = var.cloudflare_api_key
}

provider "aws" {
  region = "us-east-1"
}
