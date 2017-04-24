provider "aws" {
  region = "${lookup(var.region,"dev")}"
}

# Keypair #####################################################################
module "keypair" {
  source     = "./modules/keypair"
  key_name   = "terraform"
  public_key = "${file("keys/ami_keys.pub")}"
}

# VPC #########################################################################
module "vpc" {
  source         = "./modules/vpc"
  vpc_cidr_block = "${lookup(var.vpc_cidr_block,"dev")}"

  vpc_name    = "rancher-vpc"
  vpc_project = "rancher"
}

# Gateway######################################################################
module "gateway" {
  source = "./modules/gateway"
  vpc_id = "${module.vpc.id}"

  gateway_name    = "rancher-gateway"
  gateway_project = "Rancher"
}

#Public subnets ----------------------------------------------------------------
resource "aws_subnet" "rancher_ha" {
  vpc_id                  = "${module.vpc.id}"
  count                   = "${var.count}"
  cidr_block              = "${element(var.public_subnet_cidr_block,count.index)}"
  availability_zone       = "${element(var.availability_zone,count.index)}"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.name} Subnet Public ${var.count}"
  }
}

# Route table -----------------------------------------------------------------
resource "aws_route" "rancher_ha" {
  route_table_id         = "${module.vpc.route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${module.gateway.id}"
  depends_on             = ["module.vpc", "module.gateway"]
}

resource "aws_vpc_dhcp_options" "rancher_dns" {
  domain_name         = "ec2.internal"
  domain_name_servers = ["169.254.169.253", "AmazonProvidedDNS"]
}

resource "aws_vpc_dhcp_options_association" "rancher_dns" {
  vpc_id          = "${module.vpc.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.rancher_dns.id}"
}
