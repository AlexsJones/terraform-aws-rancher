provider "aws" {
  region = "${lookup(var.region,"dev")}"
}

module "network" {
  source                   = "./modules/network"
  name                     = "default"
  vpc_cidr_block           = "${lookup(var.vpc_cidr_block,"dev")}"
  public_subnet_cidr_block = "${lookup(var.public_subnet_cidr_block,"dev")}"
  availability_zone        = "${lookup(var.availability_zone,"dev")}"
  amazon_ami               = "${lookup(var.amazon_ami,"dev")}"
  rancher_instance_size    = "${lookup(var.rancher_instance_size,"dev")}"
  region                   = "${lookup(var.region,"dev")}"
  key_name                 = "terraform"
  key_path                 = "${file("keys/ami_keys.pub")}"
}
