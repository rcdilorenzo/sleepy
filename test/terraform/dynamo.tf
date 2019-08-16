resource "aws_dynamodb_table" "sleep" {
  name = "sleep"
  hash_key = "id"
  billing_mode = "PAY_PER_REQUEST"
  range_key = "timestamp"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "N"
  }
}
