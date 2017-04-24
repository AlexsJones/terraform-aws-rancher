resource "aws_security_group" "rancher_ha_rds" {
  name        = "${var.name}-rds-secgroup"
  description = "Rancher RDS Ports"
  vpc_id      = "${module.vpc.id}"

  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    self      = true
  }

  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "udp"
    self      = true
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${lookup(var.vpc_cidr_block,"dev")}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
