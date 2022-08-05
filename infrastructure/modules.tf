module "fetch_data" {
    source = "./fetch_data"

    data_table_name = aws_dynamodb_table.cancer_research_table.name
    role_arn = local.role_arn
}