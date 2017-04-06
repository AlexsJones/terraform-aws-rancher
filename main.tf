provider "aws" {
  region = "${lookup(var.region,"dev")}"
}

module "network" {
  source                   = "./modules/network"
  name                     = "default"
  vpc_cidr_block           = "${lookup(var.vpc_cidr_block,"dev")}"
  public_subnet_cidr_block = "${lookup(var.public_subnet_cidr_block,"dev")}"
  root_zone                = "crystal-basilica.com"
  hosted_zone              = "www.crystal-basilica.com"
  availability_zone        = "${lookup(var.availability_zone,"dev")}"
  amazon_ami               = "${lookup(var.amazon_ami,"dev")}"
  rancher_instance_size    = "${lookup(var.rancher_instance_size,"dev")}"
  region                   = "${lookup(var.region,"dev")}"
  key_name                 = "terraform"
  key_path                 = "${file("keys/ami_keys.pub")}"

  name_servers = [
    "${lookup(var.aws_nameserver_dev,"one")}",
    "${lookup(var.aws_nameserver_dev,"two")}",
    "${lookup(var.aws_nameserver_dev,"three")}",
    "${lookup(var.aws_nameserver_dev,"four")}",
  ]
}
