resource "aws_vpc" "main" {

  cidr_block = var.vpc_cidr

}


resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  ingress = []

  egress = []
}

resource "aws_flow_log" "main" {
  vpc_id          = aws_vpc.main.id
  traffic_type    = "ALL"
  iam_role_arn    = aws_iam_role.flow_log.arn
  log_destination = aws_cloudwatch_log_group.flow_log.arn
}


data "aws_caller_identity" "current" {}

resource "aws_kms_key" "flow_log" {

  description = "KMS key for VPC Flow Logs CloudWatch Log Group"

  enable_key_rotation = true


  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [
      {
        Sid = "Enable IAM User Permissions"

        Effect = "Allow"

        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }

        Action = "kms:*"

        Resource = "*"
      }
    ]

  })
}


resource "aws_subnet" "public" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.public_subnet_cidr

  map_public_ip_on_launch = false

}


resource "aws_internet_gateway" "main" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ei-week8-igw"
  }

}


resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.main.id

  }

  tags = {
    Name = "ei-week8-public-rt"
  }

}


resource "aws_route_table_association" "public" {

  subnet_id = aws_subnet.public.id

  route_table_id = aws_route_table.public.id

}

resource "aws_cloudwatch_log_group" "flow_log" {
  name              = "/aws/vpc/flow-logs"
  retention_in_days = 365
  kms_key_id        = aws_kms_key.flow_log.arn
}

resource "aws_iam_role" "flow_log" {
  name = "vpc-flow-log-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_role_policy" "flow_log" {
  name = "vpc-flow-log-policy"
  role = aws_iam_role.flow_log.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ]

        Resource = aws_cloudwatch_log_group.flow_log.arn
      }
    ]
  })
}
