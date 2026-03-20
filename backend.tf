terraform {
  backend "s3" {
    bucket = "project1-project-terraform-state"
    key = "main"
    region = "us-east-1"
    dynamodb_table = "my-dynamodb-table"
  }
}
