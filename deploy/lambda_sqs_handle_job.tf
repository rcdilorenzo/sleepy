resource "aws_lambda_function" "handle_job" {
  filename = "../build/handleJob.zip"
  function_name = "HandleJob"
  handler = "handleJob.handler"

  source_code_hash = "${filebase64sha256("../build/handleJob.zip")}"

  runtime = "nodejs10.x"
  role = "${aws_iam_role.lambda_exec_with_sqs.arn}"

  depends_on    = ["aws_iam_role_policy_attachment.lambda_logs", "aws_cloudwatch_log_group.handle_job"]
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  batch_size        = 1
  event_source_arn  = "${aws_sqs_queue.job_queue.arn}"
  enabled           = true
  function_name     = "${aws_lambda_function.handle_job.arn}"
}
