variable "vpc_cidr_block" {}
variable "public_subnet_cidr_block" {}
variable "name" {}

# VPC -------------------------------------------------------------------------
resource "aws_vpc" "default" {
  cidr_block           = "${var.vpc_cidr_block}"
  enable_dns_hostnames = true

  tags {
    Name = "${var.name}"
  }
}

# Gateway ---------------------------------------------------------------------
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
}

#Public subnet ----------------------------------------------------------------
resource "aws_subnet" "Public" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${var.public_subnet_cidr_block}"
  availability_zone       = "${var.availability_zone}"
  map_public_ip_on_launch = true
  depends_on              = ["aws_internet_gateway.default"]

  tags {
    Name = "${var.name} Subnet Public"
  }
}

# Route table -----------------------------------------------------------------
resource "aws_route_table" "PublicRouteTable" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags {
    Name = "${var.name} Subnet Public Routing"
  }
}

# Route table association -----------------------------------------------------
resource "aws_route_table_association" "PublicAssociationTable" {
  subnet_id      = "${aws_subnet.Public.id}"
  route_table_id = "${aws_route_table.PublicRouteTable.id}"
}
