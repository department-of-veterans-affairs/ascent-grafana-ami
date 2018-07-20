########################################################################################################################################################################################################################
#
# This template deploys an ec2-instance configured as a grafana server which uses prometheus as a data source.
# It also stands up and configures an RDS instance to hold the data.
#
########################################################################################################################################################################################################################

# ---------------------------------------------------------------------------------------------------------------------
# THESE TEMPLATES REQUIRE TERRAFORM VERSION 0.8 AND ABOVE
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.9.3"
}

resource "aws_instance" "grafana_instance" {
  instance_type         = "${var.instance_type}"
  ami                   = "${var.ami_id}"
  key_name              = "${var.ssh_key_name}"
  subnet_id             = "${var.subnet_id}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  vpc_security_group_ids = ["${aws_security_group.grafana_security_group.id}", "${var.aws_security_group_ids}"]
  user_data              = "${var.user_data == "" ? data.template_file.grafana_user_data.rendered : var.user_data}"
  tags = "${merge(var.tags, map("Name", "${var.instance_name}"))}"
}

# ---------------------------------------------------------------------------------------------------------------------
# Control Traffic to Grafana Instance
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "grafana_security_group" {
  name_prefix = "${var.instance_name}"
  description = "Security group for the ${var.instance_name} instance"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name = "${var.instance_name}"
  }
}

module "security_group_rules" {
  source = "../grafana-security-group-rules"
  security_group_id = "${aws_security_group.grafana_security_group.id}"
  allowed_ssh_cidr_blocks = ["${var.allowed_ssh_cidr_blocks}"]
  allowed_http_cidr_blocks = ["${var.allowed_http_cidr_blocks}"]
  http_port                = "${var.grafana_http_port}"
}

# ---------------------------------------------------------------------------------------------------------------------
# Default User Data script
# ---------------------------------------------------------------------------------------------------------------------
data "template_file" "grafana_user_data" {
  template = "${file("${path.module}/grafana-user-data.sh")}"

  vars {
    some_var       = "Hello"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Create RDS Instance To Store Grafana Dashboard configurations
# ---------------------------------------------------------------------------------------------------------------------
module "grafana_db" {
  source = "../grafana-database"
  grafana_db_username = "grafana@1234"
  grafana_db_password = "grafana"
  grafana_db_identifier = "${var.instance_name}-db"
  grafana_subnet_ids = ["${var.db_subnet_ids}"]
  vpc_id               = "${var.vpc_id}"
  allowed_inbound_security_group_id = "${aws_security_group.grafana_security_group.id}"
}
