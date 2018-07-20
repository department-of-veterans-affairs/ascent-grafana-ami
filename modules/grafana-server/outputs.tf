output "security_group_id" {
  value = "${aws_security_group.grafana_security_group.id}"
}


output "private_ip" {
  value = "${aws_instance.grafana_instance.private_ip}"
}

output "http_port" {
  value = "${var.grafana_http_port}"
}

output "db_endpoint" {
  value = "${module.grafana_db.endpoint}"
}
