resource "aws_security_group" "web" {
  #checkov:skip=CKV2_AWS_5: Security group is attached to EC2 instance through web_server module using vpc_security_group_ids

  name = "ei-week8-web-sg"

  description = "Allow HTTP for Week 8 classroom web server"

  vpc_id = var.vpc_id


  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

    cidr_blocks = [
      var.allowed_http_cidr
    ]
  }


  egress {
    description = "Allow HTTPS outbound"

    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

}
