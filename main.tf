terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_secretsmanager_secret" "app" {
  name = "classroom/app/demo"
}

output "secret_demo" {
  value = data.aws_secretsmanager_secret.app.arn
}
