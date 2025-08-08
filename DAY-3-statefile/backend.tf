terraform {
  backend "s3" {
    bucket = "terraform-to-s3-statefile"
    key    = "terraform.tfstate"
    region = "us-west-1"
  }
}
