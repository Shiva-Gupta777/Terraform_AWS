import {
  to = aws_lambda_function.this
  id = "manually-created-lambda"
}

//copied from generated.tf

resource "aws_lambda_function" "this" {
 
  description                        = "A starter AWS Lambda function."
  filename                           = null
  function_name                      = "manually-created-lambda"
  handler                            = "index.handler"
  region                             = "ap-south-1"
  role                               = "arn:aws:iam::529396655234:role/service-role/manually-created-lambda-role-6chc6zcz"
  runtime                            = "nodejs22.x"
  source_kms_key_arn                 = null
  tags = {
    "lambda-console:blueprint" = "hello-world"
  }

 
  ephemeral_storage {
    size = 512
  }
  logging_config {
    application_log_level = null
    log_format            = "Text"
    log_group             = "/aws/lambda/manually-created-lambda"
    
  }
  
}
