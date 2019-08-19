resource "aws_dynamodb_table" "sleep" {
  name = "sleep"
  hash_key = "id"
  range_key = "timestamp"

  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "N"
  }
}
