resource "aws_lambda_function" "lambda_functions" {
  for_each      = local.lambda_functions
  function_name = each.value.name
  handler       = each.value.handler
  runtime       = each.value.runtime
  filename      = each.value.filename
  role          = aws_iam_role.lambda_role.arn
}