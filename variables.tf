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
