import {
  to = aws_lambda_function.lambda
  id = "helloWorld"
}

locals {
  filename      = "lambda.zip"
  function_name = "helloWorld"
  handler       = "index.handler"
  package_type  = "Zip"

}

# Archive a single file.
data "archive_file" "init" {
  type        = "zip"
  source_file = "${path.root}/build/index.mjs"
  output_path = "${path.root}/lambda.zip"

}

resource "aws_lambda_function" "lambda" {
  filename         = local.filename
  function_name    = local.function_name
  handler          = local.handler
  source_code_hash = data.archive_file.init.output_base64sha256
  package_type     = local.package_type
  role             = aws_iam_role.iam_for_lambda.id
  runtime          = "nodejs18.x"
  tags = {
    "lambda-console:blueprint" = "hello-world"
  }
  logging_config {
    log_format = "Text"
    log_group  = "/aws/lambda/helloWorld"
  }
}
