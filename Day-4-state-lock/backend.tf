terraform {
  backend "s3" {
    bucket = "bucketsivananda123"
    key    = "DAY-4/terraform.tfstate"
    region = "us-west-1"
 #   profile = "TESTING"
    #use_lockfile = true #S3 supports the feature 
#    dynamodb_table = "Test"
#    encrypt = true
  }
}