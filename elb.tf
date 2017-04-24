# Load balancer ---------------------------------------------------------------
resource "aws_elb" "elb" {
  name            = "elb"
  security_groups = ["${aws_security_group.elb.id}"]
  internal        = true

  listener {
    lb_protocol       = "tcp"
    lb_port           = 8080
    instance_protocol = "tcp"
    instance_port     = 80
  }

  idle_timeout                = 400
  subnets                     = ["${aws_subnet.rancher_ha.*.id}"]
  instances                   = ["${aws_instance.instance-rancher.*.id}"]
  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400
}
