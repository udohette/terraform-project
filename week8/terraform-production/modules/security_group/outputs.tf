output "security_group_id" {
  description = "Security group attached to web instances"
  value       = aws_security_group.web.id
}
