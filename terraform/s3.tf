resource "random_id" "bucket_id" {
  byte_length = 4
}

resource "aws_s3_bucket" "backups" {
  bucket = "${var.project_name}-backups-${random_id.bucket_id.hex}"
  
  force_destroy = true # In production, set this to false

  tags = {
    Name = "${var.project_name}-backups"
  }
}

resource "aws_s3_bucket_public_access_block" "backups_block" {
  bucket = aws_s3_bucket.backups.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "backups_encryption" {
  bucket = aws_s3_bucket.backups.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "backups_lifecycle" {
  bucket = aws_s3_bucket.backups.id

  rule {
    id     = "auto-delete-old-backups"
    status = "Enabled"

    expiration {
      days = 30
    }
  }
}
