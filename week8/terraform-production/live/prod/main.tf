
#Network Module Call
module "network" {

  source = "../../modules/network"

  vpc_cidr = "10.20.0.0/16"

  public_subnet_cidr = "10.20.1.0/24"

}
#Security Group Call
module "security_group" {
  source = "../../modules/security_group"

  vpc_id            = module.network.vpc_id
  allowed_http_cidr = "10.0.0.0/8"
}


# Call the module
module "web_server" {
  source = "../../modules/web_server"

  name = var.name

  ami_id = data.aws_ami.ubuntu.id

  instance_type = var.instance_type

  subnet_id = module.network.public_subnet_id

  security_group_ids = [module.security_group.security_group_id]
  depends_on = [
    module.security_group
  ]

  user_data = file("../../modules/web_server/user_data.sh")

  tags = {
    Environment = "prod"
    ManagedBy   = "Terraform"
  }
}


#AMI Look up
data "aws_ami" "ubuntu" {

  most_recent = true

  owners = ["099720109477"]

  filter {
    name = "name"
    values = [
      "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
    ]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}


# State migration
moved {
  from = aws_instance.web
  to   = module.web_server.aws_instance.web
}

moved {
  from = aws_vpc.main
  to   = module.network.aws_vpc.main
}

moved {
  from = aws_subnet.public
  to   = module.network.aws_subnet.public
}

moved {
  from = aws_internet_gateway.main
  to   = module.network.aws_internet_gateway.main
}

moved {
  from = aws_route_table.public
  to   = module.network.aws_route_table.public
}

moved {
  from = aws_route_table_association.public
  to   = module.network.aws_route_table_association.public
}

moved {
  from = aws_security_group.web
  to   = module.security_group.aws_security_group.web
}
