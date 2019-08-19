resource "aws_sqs_queue" "job_queue_deadletter" {
  name                      = "job_queue_deadletter"
  message_retention_seconds = 345600
}

resource "aws_sqs_queue" "job_queue" {
  name                      = "job_queue"
  message_retention_seconds = 86400
  redrive_policy            = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.job_queue_deadletter.arn}\",\"maxReceiveCount\":4}"
}

output "sqs_url" {
  value = "${aws_sqs_queue.job_queue.id}"
}
