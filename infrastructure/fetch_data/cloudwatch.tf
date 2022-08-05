resource "aws_cloudwatch_event_rule" "every_one_hour" {
    name = "every-one-hour"
    description = "Fires every hour"
    schedule_expression = "rate(1 hour)"
}

resource "aws_cloudwatch_event_target" "fetch_data_event" {
    rule = aws_cloudwatch_event_rule.every_one_hour.name
    target_id = "fetch_cancer_data_from_api"
    arn = aws_lambda_function.fetch_cancer_data_from_api.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_fetch_data_lambda" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.fetch_cancer_data_from_api.function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.every_one_hour.arn
}