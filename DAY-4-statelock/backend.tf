terraform {
  backend "s3" {
    bucket = "bucketsivananda123"
    key    = "DAY-4/terraform.tfstate"
    region = "us-west-1"
    dynamodb_table = "test"
    encrypt = true
    #use_lockfile = true #s3 support this feature but terraform version>1.10 latest version>=1.10

  }
}
