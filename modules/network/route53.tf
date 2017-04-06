variable "root_zone" {}
variable "hosted_zone" {}

variable "name_servers" {
  type = "list"
}

# route53 zone ----------------------------------------------------------------
resource "aws_route53_zone" "root-host" {
  name = "${var.root_zone}"
}

# route53 record --------------------------------------------------------------
resource "aws_route53_record" "dev-hosted_zone_record" {
  zone_id = "${aws_route53_zone.root-host.id}"
  name    = "${var.hosted_zone}"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.elb.dns_name}"]
}

# route53 record --------------------------------------------------------------
resource "aws_route53_record" "dev-ns-hosted_zone_record" {
  zone_id = "${aws_route53_zone.root-host.id}"
  name    = "${var.hosted_zone}"
  type    = "NS"
  ttl     = "60"
  records = ["${var.name_servers}"]
}
