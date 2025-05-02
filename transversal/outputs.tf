output "websocket_api_endpoint" {
  description = "The WebSocket API endpoint"
  value       = aws_apigatewayv2_api.websocket_api.api_endpoint
}