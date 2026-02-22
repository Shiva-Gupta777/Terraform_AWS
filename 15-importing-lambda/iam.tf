import {
  to = aws_iam_role.lambda_excution_role
  id = "manually-created-lambda-role-6chc6zcz"
}


resource "aws_iam_role" "lambda_excution_role" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  name                  = "manually-created-lambda-role-6chc6zcz"
  path                  = "/service-role/"
 
}