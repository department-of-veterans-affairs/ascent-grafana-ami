###############################################################################
#
# Create Security group rules for Grafana service
#
###############################################################################

resource "aws_security_group_rule" "allow_grafana_http_inbound" {
  count       = "${length(var.allowed_http_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.http_port}"
  to_port     = "${var.http_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_http_cidr_blocks}"]

  security_group_id = "${var.security_group_id}"
}

resource "aws_security_group_rule" "allow_grafana_ssh_inbound" {
  count       = "${length(var.allowed_ssh_cidr_blocks) >= 1 ? 1 : 0}"
  type        = "ingress"
  from_port   = "${var.ssh_port}"
  to_port     = "${var.ssh_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_ssh_cidr_blocks}"]
  security_group_id = "${var.security_group_id}"
}


resource "aws_security_group_rule" "allow_all_outbound" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${var.security_group_id}"
}
