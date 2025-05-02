
locals {
  lambda_functions = [{
    name     = "ws_connect",
    handler  = "connect.lambda_handler"
    runtime  = "python3.9"
    filename = "connect.zip"
  }]
}