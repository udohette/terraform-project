resource "aws_instance" "web" {
  #checkov:skip=CKV_AWS_88: Disposable classroom server requires a public IP for Day 10 HTTP verification; inbound HTTP is restricted to the verifier IP

  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  associate_public_ip_address = true
  vpc_security_group_ids      = var.security_group_ids
  iam_instance_profile        = aws_iam_instance_profile.web.name

  ebs_optimized = true
  monitoring    = true

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    encrypted = true
  }

  user_data = var.user_data

  tags = merge(
    var.tags,
    {
      Name = var.name
    }
  )
}
