provider "aws" {
  version = "~> 2.7"
  region  = "eu-north-1"
}

resource "aws_s3_bucket" "asset_bucket" {
  bucket = "martin-sine-assets"

  tags = {
    Managed = "Terraform"
  }
}

resource "aws_s3_bucket" "host_bucket" {
  bucket = "martin-sin-host"

  tags = {
    Managed = "Terraform"
  }
}

resource "aws_s3_bucket_policy" "asset_bucket" {
  bucket = "${aws_s3_bucket.asset_bucket.id}"
  policy = templatefile("policy/public_bucket.json.tpl", { bucket_arn = "${aws_s3_bucket.asset_bucket.arn}" })
}

resource "aws_s3_bucket_policy" "host_bucket" {
  bucket = "${aws_s3_bucket.host_bucket.id}"
  policy = templatefile("policy/public_bucket.json.tpl", { bucket_arn = "${aws_s3_bucket.host_bucket.arn}" })
}
