resource "aws_api_gateway_rest_api" "post_sleep_event" {
  name        = "PostSleepEvent"
  description = "POST sleep event for processing"
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = "${aws_api_gateway_rest_api.post_sleep_event.id}"
  parent_id   = "${aws_api_gateway_rest_api.post_sleep_event.root_resource_id}"
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = "${aws_api_gateway_rest_api.post_sleep_event.id}"
  resource_id   = "${aws_api_gateway_resource.proxy.id}"
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = "${aws_api_gateway_rest_api.post_sleep_event.id}"
  resource_id = "${aws_api_gateway_method.proxy.resource_id}"
  http_method = "${aws_api_gateway_method.proxy.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.post_sleep_event.invoke_arn}"
}

resource "aws_api_gateway_method" "proxy_root" {
  rest_api_id   = "${aws_api_gateway_rest_api.post_sleep_event.id}"
  resource_id   = "${aws_api_gateway_rest_api.post_sleep_event.root_resource_id}"
  http_method   = "ANY"
  authorization = "NONE"
}

/* Unfortunately the proxy resource cannot match an empty path at the root of
 * the API. To handle that, a similar configuration must be applied to the
 * root resource that is built in to the REST API object:
 */

resource "aws_api_gateway_integration" "lambda_root" {
  rest_api_id = "${aws_api_gateway_rest_api.post_sleep_event.id}"
  resource_id = "${aws_api_gateway_method.proxy_root.resource_id}"
  http_method = "${aws_api_gateway_method.proxy_root.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.post_sleep_event.invoke_arn}"
}

resource "aws_api_gateway_deployment" "post_sleep_event" {
  depends_on = [
    "aws_api_gateway_integration.lambda",
    "aws_api_gateway_integration.lambda_root",
  ]

  rest_api_id = "${aws_api_gateway_rest_api.post_sleep_event.id}"
  stage_name  = "test"
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.post_sleep_event.arn}"
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_deployment.post_sleep_event.execution_arn}/*/*"
}

output "base_url" {
  value = "${aws_api_gateway_deployment.post_sleep_event.invoke_url}"
}
