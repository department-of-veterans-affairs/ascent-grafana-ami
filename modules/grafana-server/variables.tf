###############################################################################
# REQUIRED VARIABLES
###############################################################################
variable "ami_id" {
  description = "The ID of the AMI to start this EC2 instance as."
}
variable "ssh_key_name" {
  description = "The name of the ssh key that will connect with the instance"
}
variable "subnet_id" {
  description = "The subnet ID to launch the EC2 instance into."
}
variable "vpc_id" {
  description = "The ID of the VPC to launch the security group into"
}
variable "instance_name" {
  description = "The name of the instance and other resources associated with it"
}

variable "allowed_ssh_cidr_blocks" {
  description = "The CIDR blocks allowed SSH access to the instance"
  type        = "list"
}
variable "allowed_http_cidr_blocks" {
  description = "The CIDR blocks allowed HTTP access to the instance"
  type        = "list"
}

variable "db_subnet_ids" {
  description = "A list of subnet IDs to launch the RDS instance into"
  type        = "list"
}

variable "grafana_db_username" {
  description = "The username with which to authenticate to the grafana database."
}

variable "grafana_db_password" {
  description = "The password with which to authenticate to the grafana database."
}

variable "prometheus_url" {
  description = "The URL of the prometheus instance (e.g http://localhost:9090)"
}

variable "private_key_file_path" {
  description = "The path to the private key so you can upload the dashboards directory to the instance."
}

variable "dashboard_dir_name" {
  description = "The name of the local dashboard directory to copy to the grafana instance"
}

variable "grafana_url_name" {
  description = "The URL of the grafana instance to which you want your clients to connect."
}

###############################################################################
# DEFAULT VARIABLES
###############################################################################

variable "database_name" {
  description = "The name of the database. Since the database module doesn't specify an actual database name, and it's using the postgres engine, then the default is postgres"
  default     = "postgres"
}

variable "tags" {
  description = "Tags to apply to the EC2 instance. Name will be applied by default."
  type        = "map"
  default     = {}
}
variable "instance_type" {
  description = "The type of the EC2 instance (m4.large, t2.micro, etc)"
  default     = "t2.micro"
}
variable "associate_public_ip_address" {
  description = "Specify whether you want to associate a public IP address with the EC2 instance. Default is false"
  default     = "false"
}
variable "aws_security_group_ids" {
  description = "A list of security group IDs to allow inbound/outbound traffic to the instance."
  default     = []
  type        = "list"
}
variable "user_data" {
  description = "The user data to run on the instance. If left blank, will run user data provided by the template"
  default     = ""
}

variable "grafana_http_port" {
  description = "The port to access grafana though. Grafana's default when first installed is 3000"
  default     = "3000"
}
