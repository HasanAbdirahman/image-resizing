import {
  to = aws_iam_role.iam_for_lambda
  id = "helloWorld-role-ialm6hu1"
}

import {
  to = aws_iam_policy.lambda_execution
  id = "arn:aws:iam::619858587411:policy/service-role/AWSLambdaBasicExecutionRole-e52e9e1d-224a-4c39-a017-925d8e59c56b"
}

import {
  to = aws_iam_role_policy_attachment.lambda_execution
  id = "${aws_iam_role.iam_for_lambda.name}/${aws_iam_policy.lambda_execution.arn}"
}

resource "aws_iam_role" "iam_for_lambda" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  path               = "/service-role/"
}

data "aws_iam_policy_document" "assume_role_policy" {
  version = "2012-10-17"
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    resources = ["*"]
  }
}

resource "aws_iam_policy" "lambda_execution" {
  name = "AWSLambdaBasicExecutionRole-e52e9e1d-224a-4c39-a017-925d8e59c56b"
  path = "/service-role/"
  policy = jsonencode({
    Statement = [{
      Action   = "logs:CreateLogGroup"
      Effect   = "Allow"
      Resource = "arn:aws:logs:us-east-2:619858587411:*"
      }, {
      Action   = ["logs:CreateLogStream", "logs:PutLogEvents"]
      Effect   = "Allow"
      Resource = ["arn:aws:logs:us-east-2:619858587411:log-group:/aws/lambda/helloWorld:*"]
    }]
    Version = "2012-10-17"
  })

}


resource "aws_iam_role_policy_attachment" "lambda_execution" {
  policy_arn = aws_iam_policy.lambda_execution.arn
  role       = aws_iam_policy.lambda_execution.name
}
