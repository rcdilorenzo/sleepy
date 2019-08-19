resource "aws_lambda_function" "post_sleep_event" {
  filename = "../build/postEvent.zip"
  function_name = "PostSleepEvent"
  handler = "postEvent.handler"

  source_code_hash = "${filebase64sha256("../build/postEvent.zip")}"

  runtime = "nodejs10.x"
  role = "${aws_iam_role.lambda_exec.arn}"

  depends_on    = ["aws_iam_role_policy_attachment.lambda_logs", "aws_cloudwatch_log_group.post_sleep_event"]
}
