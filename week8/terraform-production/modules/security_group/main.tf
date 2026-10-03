resource "aws_security_group" "web" {
  #checkov:skip=CKV2_AWS_5: Security group is attached through the web_server module using vpc_security_group_ids

  name        = "ei-week8-web-sg"
  description = "Allow HTTP verification for the classroom web server"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP from the classroom verifier"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

    cidr_blocks = [var.allowed_http_cidr]
  }

  egress {
    description = "Allow HTTP outbound for Ubuntu package downloads"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow HTTPS outbound"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }
}
