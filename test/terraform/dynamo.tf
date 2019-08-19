resource "aws_dynamodb_table" "sleep" {
  name = "sleep"
  hash_key = "id"

  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "N"
  }

  global_secondary_index {
    name = "TimestampIndex"
    hash_key = "timestamp"
    projection_type = "ALL"
  }
}
