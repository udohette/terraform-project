terraform {
  backend "s3" {
    bucket       = "ei-terraform-state-000624196441"
    key          = "classroom/day9/dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
