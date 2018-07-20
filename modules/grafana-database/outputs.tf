output "port" {
  value = "${aws_db_instance.grafana_database_instance.port}"
}

output "endpoint" {
  value = "${aws_db_instance.grafana_database_instance.endpoint}"
}

output "security_group_id" {
  value = "${aws_security_group.grafana_database_security_group.id}"
}
