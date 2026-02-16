import {
  to = aws_lambda_function.this
  id = "manually-created-lambda"
}

data "archive_file" "lambda_code" {
  type        = "zip"
  source_file = "${path.root}/build/index.mjs"
  output_path = "${path.root}/lambda.zip"
}


//copied from generated.tf

resource "aws_lambda_function" "this" {

  description      = "A starter AWS Lambda function."
  filename         = "${path.root}/lambda.zip"
  function_name    = "manually-created-lambda"
  handler          = "index.handler"
  role             = "arn:aws:iam::529396655234:role/service-role/manually-created-lambda-role-6chc6zcz"
  runtime          = "nodejs22.x"
  source_code_hash = data.archive_file.lambda_code.output_base64sha256

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
