resource "aws_lambda_function" "fetch_cancer_data_from_api" {

  filename      = "build/fetch_data_lambda.zip"
  function_name = "fetch_cancer_data_from_api"
  role          = "${var.role_arn}"
  handler       = "fetch_data.handler"

  source_code_hash = filebase64sha256("build/fetch_data_lambda.zip")

  runtime = "python3.9"
  timeout = 600
  layers = [ aws_lambda_layer_version.requests_layer.arn ]

   environment {
    variables = {
      DATA_TABLE_NAME = var.data_table_name
      
    }
  }
}

