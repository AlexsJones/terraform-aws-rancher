variable "key_name" {}
variable "key_path" {}

resource "aws_key_pair" "terraform" {
  key_name   = "${var.key_name}"
  public_key = "${var.key_path}"
}
