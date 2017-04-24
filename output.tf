output "elb_http_dns" {
  value = "${aws_elb.elb.dns_name}"
}
