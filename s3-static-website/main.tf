resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "static_bucket" {
  bucket = "terraform-s3-demo-${random_id.bucket_suffix.hex}"


  tags = {
    Name = "S3_Terra_bucket"
  }

}

// Enable public access to the bucket

resource "aws_s3_bucket_public_access_block" "static_website" {
  bucket = aws_s3_bucket.static_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

//Giving Json Policy to make the bucket publicly accessible

resource "aws_s3_bucket_policy" "static_website_public_read" {
  bucket = aws_s3_bucket.static_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static_bucket.arn}/*"
      }
    ]
  })
}



