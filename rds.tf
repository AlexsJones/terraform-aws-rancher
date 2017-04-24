# RDS Database Configuration ##################################################
resource "aws_rds_cluster_instance" "rancher_ha" {
  count                = 2
  identifier           = "${var.name}-db-${count.index}"
  cluster_identifier   = "${aws_rds_cluster.rancher_ha.id}"
  instance_class       = "${lookup(var.rds_size,"dev")}"
  publicly_accessible  = false
  db_subnet_group_name = "${aws_db_subnet_group.rancher_ha.name}"
}

resource "aws_rds_cluster" "rancher_ha" {
  cluster_identifier     = "${var.name}-db"
  database_name          = "${var.db_name}"
  master_username        = "${var.db_user}"
  master_password        = "${var.db_pass}"
  db_subnet_group_name   = "${aws_db_subnet_group.rancher_ha.name}"
  vpc_security_group_ids = ["${aws_security_group.rancher_ha_rds.id}"]
  skip_final_snapshot    = true
}

resource "aws_db_subnet_group" "rancher_ha" {
  name        = "${var.name}-db-subnet-group"
  description = "Rancher HA Subnet Group"
  subnet_ids  = ["${aws_subnet.rancher_ha.*.id}"]

  tags {
    Name = "${var.name}-db-subnet-group"
  }
}
