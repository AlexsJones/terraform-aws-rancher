variable "availability_zone" {}
variable "amazon_ami" {}
variable "rancher_instance_size" {}
variable "region" {}

resource "aws_instance" "instance-rancher" {
  connection {
    user     = "ubuntu"
    key_file = "${aws_key_pair.terraform.public_key}"
  }

  availability_zone = "${var.availability_zone}"
  ami               = "${var.amazon_ami}"
  instance_type     = "${var.rancher_instance_size}"

  subnet_id                   = "${aws_subnet.Public.id}"
  security_groups             = ["${aws_security_group.web.id}"]
  key_name                    = "${aws_key_pair.terraform.id}"
  associate_public_ip_address = true
  user_data                   = "${data.template_file.user_data.rendered}"

  tags {
    Name = "Rancher Server"
  }

  ebs_block_device {
    device_name           = "/dev/sdg"
    volume_size           = 15
    volume_type           = "gp2"
    delete_on_termination = true
  }
}

data "template_file" "user_data" {
  template = "${file("config/cloud-config.yml")}"
}

resource "aws_eip" "rancher-eu-west-1-eip" {
  instance = "${aws_instance.instance-rancher.id}"
  vpc      = true
}
