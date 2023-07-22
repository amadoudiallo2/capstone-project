resource "aws_sns_topic" "example_topic" {
  name = "example-topic"
}

resource "aws_lambda_function" "example_lambda" {
  filename      = "lambda_function.zip" # Path to your Lambda deployment package (e.g., a ZIP file)
  function_name = "example_lambda_function"
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = "index.handler" # Replace with your actual handler function name (e.g., "filename.handlerFunction")

  runtime = "nodejs14.x" # Change this to your desired runtime (e.g., "python3.8")

  # Additional configuration (optional)
  memory_size = 128
  timeout     = 10
  publish     = true

  # Define the event source mapping for SNS trigger
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "lambda_execution_policy_attachment" {
  name       = "lambda_execution_policy_attachment"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole" # AWS-managed policy for basic Lambda execution permissions

  roles = [
    aws_iam_role.lambda_execution_role.name,
  ]
}
