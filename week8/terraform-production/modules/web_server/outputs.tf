output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.web.id
}

output "public_ip" {
  description = "Public IPv4 address when assigned"
  value       = aws_instance.web.public_ip
}

output "security_group_ids" {
  description = "Security groups attached to instance"
  value       = aws_instance.web.vpc_security_group_ids
}
