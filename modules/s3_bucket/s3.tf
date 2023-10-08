resource "random_id" "this" {
  byte_length = 2
}

resource "aws_s3_bucket" "this" {
  bucket = "${var.bucket_name_prefix}-${random_id.this.dec}"
  tags = {
    Name = "${var.bucket_name_prefix}-${random_id.this.dec}"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id

  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "s3:GetObject"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "${aws_s3_bucket.this.arn}/*"
        },
      ]
      Version = "2012-10-17"
    }
  )
}
