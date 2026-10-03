output "instance_id" {
  description = "Production web server EC2 instance ID"
  value       = module.web_server.instance_id
}

output "public_ip" {
  description = "Production web server public IPv4 address when assigned"
  value       = module.web_server.public_ip
}
