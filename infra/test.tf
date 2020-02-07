provider "aws" {
  profile    = "default"
  region     = var.region
}

locals {
  # Lambda ZIP file path related to module
  gg_server_info_zipfile = "${path.module}/../dist/gg_server_info.zip"
}

resource aws_iam_role "iam_for_gg_server_info_lambda" {
  assume_role_policy = data.aws_iam_policy_document.basic_assume_role.json
  name               = "gg_server_info_${var.envname}_lambda_role"
}

resource "aws_lambda_function" "lambda_gg_server_info" {
  filename         = local.gg_server_info_zipfile
  function_name    = "${var.envtype}_gg_server_info"
  role             = aws_iam_role.iam_for_gg_server_info_lambda.arn
  handler          = "lambda_handler"
  source_code_hash = filebase64sha256(local.gg_server_info_zipfile)
  runtime          = "python2.7"
  publish          = true
}


resource "aws_lambda_alias" "lambda_gg_server_info_alias" {
  name             = "LatestVersion"
  description      = "gg_server_info lambda for ${var.envtype} latest version"
  function_name    = aws_lambda_function.lambda_gg_server_info.arn
  function_version = aws_lambda_function.lambda_gg_server_info.version
}