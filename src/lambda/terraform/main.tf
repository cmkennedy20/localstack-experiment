resource "aws_lambda_function" "my_lambda_function" {
  function_name    = "localstack-lambda-function"
  runtime          = "python3.9"
  handler          = "lambda.lambda_handler"
  role             = aws_iam_role.my_lambda_role.arn
  filename         = data.archive_file.lambda_function_file.output_path
  source_code_hash = data.archive_file.lambda_function_file.output_base64sha256
}

resource "aws_lambda_function_url" "lambda_endpoint" {
  function_name      = aws_lambda_function.my_lambda_function.function_name
  authorization_type = "NONE"
  depends_on = [ aws_lambda_function.my_lambda_function ]
}

data "archive_file" "lambda_function_file" {
  type             = "zip"
  output_path = "lambda.zip"
  source_content_filename = "lambda.zip"
}

resource "aws_iam_role" "my_lambda_role" {
  name = "my-lambda-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
    }
  )
}

output "lambda_url" {
  description = "Lambda endpoint"
  value       = aws_lambda_function_url.lambda_endpoint.function_url
}
