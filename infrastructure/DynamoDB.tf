resource "aws_dynamodb_table" "cancer_research_table" {
  name           = "cancer_research_data"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

}