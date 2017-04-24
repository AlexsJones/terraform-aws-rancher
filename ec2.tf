resource "aws_instance" "instance-rancher" {
  connection {
    user     = "ubuntu"
    key_file = "${module.keypair.key}"
  }

  count             = "${var.count}"
  availability_zone = "${element(var.availability_zone,count.index)}"
  ami               = "${lookup(var.ami,"dev")}"
  instance_type     = "${lookup(var.instance_size,"dev")}"

  subnet_id                   = "${element(sort(aws_subnet.rancher_ha.*.id),count.index)}"
  security_groups             = ["${aws_security_group.rancher_ha.id}"]
  key_name                    = "${module.keypair.id}"
  associate_public_ip_address = true
  user_data                   = "${data.template_file.rancher-data.rendered}"

  tags {
    Name = "Rancher Server"
  }

  root_block_device {
    volume_size           = "16"
    delete_on_termination = true
  }
}

data "template_file" "rancher-data" {
  template = <<-EOF
                #cloud-config
                write_files:
                - content: |
                    #!/bin/bash
                    wait-for-docker
                    docker run -d --restart=unless-stopped \
                      -p 8080:8080 -p 9345:9345 \
                      rancher/server:$${rancher_version} \
                      --db-host $${db_host} \
                      --db-name $${db_name} \
                      --db-port $${db_port} \
                      --db-user $${db_user} \
                      --db-pass $${db_pass} \
                      --advertise-address $(ip route get 8.8.8.8 | awk '{print $NF;exit}')
                  path: /etc/rc.local
                  permissions: "0755"
                  owner: root
                EOF

  vars {
    rancher_version = "${var.rancher_version}"
    db_host         = "${aws_rds_cluster.rancher_ha.endpoint}"
    db_name         = "${aws_rds_cluster.rancher_ha.database_name}"
    db_port         = "${aws_rds_cluster.rancher_ha.port}"
    db_user         = "${var.db_user}"
    db_pass         = "${var.db_pass}"
  }
}
