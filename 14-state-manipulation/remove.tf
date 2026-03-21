# resource "aws_s3_bucket" "remove_state" {
#   bucket = "remove-bucket-09"

#   tags = {
#     ManagedBy = "Terraform"
#   }
  
# }

removed {
  from = aws_s3_bucket.remove_state

  lifecycle {
    destroy = false
  }
}