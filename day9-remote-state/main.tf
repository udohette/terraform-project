terraform {
  required_version = ">= 1.10.0"
}

resource "terraform_data" "classroom" {
  input = "Day 9 remote state demonstration"
}

resource "terraform_data" "lock_demo" {
  provisioner "local-exec" {
    command = "sleep 60"
  }
}

output "classroom_message" {
  value = terraform_data.classroom.output
}
