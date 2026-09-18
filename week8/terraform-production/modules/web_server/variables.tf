variable "name" {
  type        = string
  description = "Name tag for the EC2 instance"
}

variable "ami_id" {
  type        = string
  description = "AMI ID to launch"

}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "subnet_id" {
  type        = string
  description = "Subnet in which the instance is launched"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security groups attached to the instance"
}

variable "user_data" {
  type        = string
  description = "Startup script"
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Additional resource tags"
  default     = {}
}
