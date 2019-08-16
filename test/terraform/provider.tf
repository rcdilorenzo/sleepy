provider "aws" {
  skip_credentials_validation = true
  skip_metadata_api_check = true
  skip_requesting_account_id = true
  s3_force_path_style = true

  endpoints {
    dynamodb = "${var.dynamodb_endpoint}"
    lambda   = "${var.lambda_endpoint}"
    sqs      = "${var.sqs_endpoint}"
    ssm      = "${var.ssm_endpoint}"
  }
}
