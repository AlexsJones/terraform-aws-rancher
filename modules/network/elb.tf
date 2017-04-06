# Load balancer ---------------------------------------------------------------
resource "aws_elb" "elb" {
  name            = "elb"
  security_groups = ["${aws_security_group.elb.id}"]
  subnets         = ["${aws_subnet.Public.id}"]

  listener {
    lb_protocol       = "http"
    lb_port           = 80
    instance_protocol = "http"
    instance_port     = 80
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:80"
    interval            = 10
  }

  cross_zone_load_balancing = true

  instances = ["${aws_instance.instance-rancher.id}"]
}
