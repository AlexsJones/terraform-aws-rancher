output "key_name" {
  value = "${var.key_name}"
}

output "public_key" {
  value = "${aws_key_pair.terraform.public_key}"
}
