resource "aws_apigatewayv2_api" "api-websocket" {
  name                       = "api-websocket"
  protocol_type              = "WEBSOCKET"
  route_selection_expression = "$request.body.action"
}


#### connect
#### Estas son las "rutas" que API Gateway usará para invocar las Lambdas.
resource "aws_apigatewayv2_route" "connect_route" {
  api_id    = aws_apigatewayv2_api.websocket_api.id
  route_key = "$connect"
  target    = "integrations/${aws_apigatewayv2_integration.connect_integration.id}"
}

#### Esto le dice al API Gateway que invoque la lambda respectiva al recibir la conexión.
resource "aws_apigatewayv2_integration" "connect_integration" {
  api_id                 = aws_apigatewayv2_api.websocket_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.connect_lambda.invoke_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

# Permisos para que API Gateway invoque las Lambdas
resource "aws_lambda_permission" "apigw_invoke_connect" {
  statement_id  = "AllowAPIGatewayInvokeConnect"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.connect_lambda.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.websocket_api.execution_arn}/*"
}

#### disconnect
#### Estas son las "rutas" que API Gateway usará para invocar las Lambdas.
resource "aws_apigatewayv2_route" "disconnect_route" {
  api_id    = aws_apigatewayv2_api.websocket_api.id
  route_key = "$disconnect"
  target    = "integrations/${aws_apigatewayv2_integration.disconnect_integration.id}"
}

#### Esto le dice al API Gateway que invoque la lambda respectiva al recibir la conexión.
resource "aws_apigatewayv2_integration" "disconnect_integration" {
  api_id                 = aws_apigatewayv2_api.websocket_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.disconnect_lambda.invoke_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

# Permisos para que API Gateway invoque las Lambdas
resource "aws_lambda_permission" "apigw_invoke_disconnect" {
  statement_id  = "AllowAPIGatewayInvokeConnect"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.disconnect_lambda.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.websocket_api.execution_arn}/*"
}

#### invoke
#### Estas son las "rutas" que API Gateway usará para invocar las Lambdas.
resource "aws_apigatewayv2_route" "invoke_route" {
  api_id    = aws_apigatewayv2_api.websocket_api.id
  route_key = "$invoke"
  target    = "integrations/${aws_apigatewayv2_integration.invoke_integration.id}"
}

#### Esto le dice al API Gateway que invoque la lambda respectiva al recibir la conexión.
resource "aws_apigatewayv2_integration" "invoke_integration" {
  api_id                 = aws_apigatewayv2_api.websocket_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.invoke_lambda.invoke_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

# Permisos para que API Gateway invoque las Lambdas
resource "aws_lambda_permission" "apigw_invoke_invoke" {
  statement_id  = "AllowAPIGatewayInvokeConnect"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.invoke_lambda.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.websocket_api.execution_arn}/*"
}