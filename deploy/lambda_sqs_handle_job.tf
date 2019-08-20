resource "aws_lambda_function" "handle_job" {
  filename = "../build/handleJob.zip"
  function_name = "HandleJob"
  handler = "handleJob.handler"

  source_code_hash = "${filebase64sha256("../build/handleJob.zip")}"

  runtime = "nodejs10.x"
  role = "${aws_iam_role.handle_job.arn}"

  depends_on    = ["aws_cloudwatch_log_group.handle_job"]
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  batch_size        = 1
  event_source_arn  = "${aws_sqs_queue.job_queue.arn}"
  enabled           = true
  function_name     = "${aws_lambda_function.handle_job.arn}"
}

resource "aws_iam_role" "handle_job" {
  name = "handle_job"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "handle_job" {
  policy_arn = "${aws_iam_policy.handle_job.arn}"
  role = "${aws_iam_role.handle_job.name}"
}

resource "aws_iam_policy" "handle_job" {
  name = "handle_job"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "${aws_cloudwatch_log_group.handle_job.arn}",
      "Effect": "Allow"
    },
    {
      "Action": [
        "sqs:ChangeMessageVisibility",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes",
        "sqs:ReceiveMessage"
      ],
      "Resource": "${aws_sqs_queue.job_queue.arn}",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_cloudwatch_log_group" "handle_job" {
  name              = "/aws/lambda/HandleJob"
  retention_in_days = 14
}
