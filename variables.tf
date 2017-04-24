variable "region" {
  default = {
    dev = "eu-west-1"
  }
}

variable "name" {
  default = "rancher"
}

variable "availability_zone" {
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "vpc_cidr_block" {
  default = {
    dev = "10.0.0.0/16"
  }
}

variable "public_subnet_cidr_block" {
  default = ["10.0.128.0/24", "10.0.129.0/24", "10.0.130.0/24"]
}

variable "aws_nameserver_dev" {
  default = {
    one   = "ns-1813.awsdns-34.co.uk"
    two   = "ns-1434.awsdns-51.org"
    three = "ns-911.awsdns-49.net"
    four  = "ns-53.awsdns-06.com"
  }
}

variable "instance_size" {
  default = {
    dev = "t2.large"
  }
}

variable "rds_size" {
  default = {
    dev = "db.r3.large"
  }
}

variable "ami" {
  default = {
    dev = "ami-52d1fe34"
  }
}

variable "count" {
  default = 3
}

variable "db_name" {
  default     = "rancher"
  description = "Name of the RDS DB"
}

variable "db_user" {
  default     = "rancher"
  description = "Username used to connect to the RDS database"
}

variable "db_pass" {
  description = "Password used to connect to the RDS database"
  default     = "Temp123!"
}

variable "rancher_version" {
  default     = "stable"
  description = "Rancher version to deploy"
}
