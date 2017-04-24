# VPC##########################################################################
variable "vpc_cidr_block" {}

variable "vpc_name" {}
variable "vpc_project" {}

resource "aws_vpc" "default" {
  cidr_block           = "${var.vpc_cidr_block}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name    = "${var.vpc_name}"
    Project = "${var.vpc_project}"
  }
}

output "id" {
  value = "${aws_vpc.default.id}"
}

output "route_table_id" {
  value = "${aws_vpc.default.main_route_table_id}"
}
