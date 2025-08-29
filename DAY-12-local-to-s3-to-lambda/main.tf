terraform {
  required_providers {
    aws = { source = "hashicorp/aws", version = ">= 5.0" }
  }
}

provider "aws" {
  region = "us-east-2"
}



# --- IAM for Lambda ---
resource "aws_iam_role" "lambda_role" {
  name = "lambda-exec-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Action    = "sts:AssumeRole",
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "basic_logs" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# --- S3 bucket (versioned) to hold code ---
resource "aws_s3_bucket" "lambda_code" {
  bucket = "kljndcjbbdsklamckj" # must be globally unique
}

resource "aws_s3_bucket_versioning" "lambda_code" {
  bucket = aws_s3_bucket.lambda_code.id
  versioning_configuration { status = "Enabled" }
}

# Upload your existing local zip to S3 (keeps Terraform in control)
resource "aws_s3_object" "lambda_zip" {
  bucket       = aws_s3_bucket.lambda_code.id
  key          = "lambda_function.zip"
  source       = "lambda_function.zip"     # local file path
  content_type = "application/zip"
  etag         = filemd5("lambda_function.zip")#  In S3 → Use ETag to verify file integrity + detect changes.

  depends_on = [aws_s3_bucket_versioning.lambda_code]
}

# --- Lambda from the uploaded S3 object ---
resource "aws_lambda_function" "example" {
  function_name     = "hello-python-lambda"
  role              = aws_iam_role.lambda_role.arn
  handler           = "lambda_function.lambda_handler"
  runtime           = "python3.12"
  timeout           = 900
  memory_size       = 128

  s3_bucket         = aws_s3_bucket.lambda_code.id
  s3_key            = aws_s3_object.lambda_zip.key
  s3_object_version = aws_s3_object.lambda_zip.version_id
 
  depends_on = [aws_iam_role_policy_attachment.basic_logs]
}