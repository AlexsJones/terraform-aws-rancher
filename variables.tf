variable "region" {
  default = {
    dev = "eu-west-1"
  }
}

variable "availability_zone" {
  default = {
    dev = "eu-west-1a"
  }
}

variable "vpc_cidr_block" {
  default = {
    dev = "10.0.0.0/16"
  }
}

variable "public_subnet_cidr_block" {
  default = {
    dev = "10.0.128.0/16"
  }
}

variable "aws_nameserver_dev" {
  default = {
    one   = "ns-1813.awsdns-34.co.uk"
    two   = "ns-1434.awsdns-51.org"
    three = "ns-911.awsdns-49.net"
    four  = "ns-53.awsdns-06.com"
  }
}

variable "rancher_instance_size" {
  default = {
    dev = "m1.small"
  }
}

variable "amazon_ami" {
  default = {
    dev = "ami-2acaf54c"
  }
}
