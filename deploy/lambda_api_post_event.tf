resource "aws_lambda_function" "post_sleep_event" {
  filename = "../build/postEvent.zip"
  function_name = "PostSleepEvent"
  handler = "postEvent.handler"

  source_code_hash = "${filebase64sha256("../build/postEvent.zip")}"

  runtime = "nodejs10.x"
  role = "${aws_iam_role.post_sleep_event.arn}"

  depends_on    = ["aws_cloudwatch_log_group.post_sleep_event"]
}

resource "aws_iam_role" "post_sleep_event" {
  name = "post_sleep_event"

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

resource "aws_iam_role_policy_attachment" "post_sleep_event" {
  policy_arn = "${aws_iam_policy.post_sleep_event.arn}"
  role = "${aws_iam_role.post_sleep_event.name}"
}

resource "aws_iam_policy" "post_sleep_event" {
  name = "post_sleep_event"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "${aws_cloudwatch_log_group.post_sleep_event.arn}",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_cloudwatch_log_group" "post_sleep_event" {
  name              = "/aws/lambda/PostSleepEvent"
  retention_in_days = 14
}
