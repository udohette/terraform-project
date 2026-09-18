resource "aws_instance" "web" {

  ami = var.ami_id

  instance_type = var.instance_type

  subnet_id = var.subnet_id


  vpc_security_group_ids = var.security_group_ids

  iam_instance_profile = aws_iam_instance_profile.web.name

  ebs_optimized = true

  monitoring = true

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
