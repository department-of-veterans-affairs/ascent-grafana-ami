# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "grafana_db_username" {
  description = "The master username to use to authenticate the database"
}

variable "grafana_db_password" {
  description = "The master password to use to authenticate to the database"
}

variable "grafana_db_identifier" {
  description = "The name of the rds instance"
}

variable "grafana_subnet_ids" {
  description = "A list of VPC subnet IDs."
  type        = "list"
}

variable "vpc_id" {
  description = "The ID of the VPC in which to deploy the sonar instance"
}


variable "allowed_inbound_security_group_id" {
  description = "The security group ID that the sonar instance uses, so the sonar instance will be allowed"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "root_db_name" {
  description = "The name of the database first created by rds"
  default     = "rootdb"
}

# Version determined from https://docs.sonarqube.org/display/SONAR/Requirements
variable "postgres_version" {
  description = "The version of the postgres engine"
  default     = "9.6.6"
}
