resource "aws_route53_zone" "web-elb" {
  name              = "crystal-basilica.com"
  delegation_set_id = "${aws_route53_delegation_set.main.id}"
}

resource "aws_route53_delegation_set" "main" {
  reference_name = "DNS"
}

resource "aws_route53_record" "web-elb-record" {
  zone_id = "${aws_route53_zone.web-elb.zone_id}"
  name    = "www"
  type    = "A"

  alias {
    zone_id                = "${aws_elb.elb.zone_id}"
    name                   = "${aws_elb.elb.dns_name}"
    evaluate_target_health = true
  }
}
