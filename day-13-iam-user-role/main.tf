provider "aws" {
  region = "ap-south-1"
}

# -------------------------------
# IAM USER
# -------------------------------
resource "aws_iam_user" "demo_user" {  
  name = "demo-user"
}

# -------------------------------
# IAM ROLE (trust policy allows demo-user)  
# -------------------------------
resource "aws_iam_role" "demo_role" {
  name = "demo-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = aws_iam_user.demo_user.arn
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# -------------------------------
# Attach Permission to Role (example: S3 Full Access)
# -------------------------------
resource "aws_iam_role_policy_attachment" "role_s3_full" {
  role       = aws_iam_role.demo_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# -------------------------------
# Allow User to Assume the Role
# -------------------------------
resource "aws_iam_user_policy" "allow_assume_role" { # this is the user to attaching role to the user
  name = "AllowAssumeDemoRole"
  user = aws_iam_user.demo_user.name  # user detail 

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRole",
        Resource = aws_iam_role.demo_role.arn   # role details
      }
    ]
  })
}

# -------------------------------
# (Optional) Access Keys for User
# -------------------------------
resource "aws_iam_access_key" "demo_user_key" {
  user = aws_iam_user.demo_user.name
}

# -------------------------------
# OUTPUTS
# -------------------------------
output "iam_user_name" {
  value = aws_iam_user.demo_user.name
}

output "iam_user_access_key" {
  value     = aws_iam_access_key.demo_user_key.id
  sensitive = true
}

output "iam_user_secret_key" {
  value     = aws_iam_access_key.demo_user_key.secret
  sensitive = true
}

output "iam_role_arn" {
  value = aws_iam_role.demo_role.arn
}
