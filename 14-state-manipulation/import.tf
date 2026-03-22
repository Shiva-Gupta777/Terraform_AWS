
resource "aws_s3_bucket" "remote_state" {
  bucket = "import-bucket-09"

  tags = {
    ManagedBy = "Terraform"
  }

}
// Now we have the bucket in our state, we can import the public access block resource

import {
  to = aws_s3_bucket_public_access_block.remote_state
  id = aws_s3_bucket.remote_state.bucket
}

// Now we have the bucket and the public access block in our state, we can move them to a new module

resource "aws_s3_bucket_public_access_block" "remote_state" {
  bucket = aws_s3_bucket.remote_state.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}




