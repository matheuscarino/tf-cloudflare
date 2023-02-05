resource "cloudflare_zone" "example_domain" {
  zone       = var.domain
}

resource "cloudflare_record" "example_record" {
  zone_id = cloudflare_zone.example_domain.id
  name = "example"
  type = "A"
  value = "192.168.1.100"
  ttl = "120"
}

resource "aws_s3_bucket" "tfstate" {
  bucket = "tfstate-cloudflare.${var.domain}"
  tags = {
    Name        = "project"
    Environment = "${var.domain}"
  }
}

resource "aws_s3_bucket_acl" "tfstate-acl" {
  bucket = aws_s3_bucket.tfstate.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "tfstate_versioning" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "tfstate-lock" {
  name           = "tfstate-cloudflare"
  hash_key       = "LockID"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  backend "s3" {
    bucket         = "tfstate-cloudflare.matheuscarino.com.br"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tfstate-cloudflare"
  }
}