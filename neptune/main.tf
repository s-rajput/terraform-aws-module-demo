provider "aws" {
  region = var.aws_region
  //alias  = "qlmgt"

  assume_role {
    role_arn     = "arn:aws:iam::${var.qlmgt_account_id}:role/${var.terraform_assume_role}"   //"arn:aws:iam::465761673819:role/super-role1"
    session_name = "SR_TERRAFORM_SESSION"
    external_id  = "SR_OPS_TF"
  }
}

terraform {
  required_version = ">= 0.12.31"

  required_providers {
    aws = ">= 3.36"
  }
}
 

locals { 

 common_tags = merge(module.tags.ql_common_aws_tags, var.tags)
 engine                               = var.engine
 neptune_engine_version               = var.engine_version == null ? local.db_map[var.engine].engine : var.engine_version
 neptune_ingress_from_port            = var.ingress_from_port == null ? local.neptune_map[var.engine].port : var.ingress_from_port
 neptune_ingress_to_port              = var.ingress_to_port == null ? local.neptune_map[var.engine].port : var.ingress_to_port
 neptune_parameter_group_family       = var.parameter_group_family == null ? local.neptune_map[var.engine].parameter_group_family : var.parameter_group_family
 neptune_default_parameter_group_name = local.neptune_map[var.engine].default_parameter_group_name
 neptune_name                         = "var.neptune_name == null ? local.neptune_Config.name : var.neptune_name"
 neptune_identifier                   = var.identifier == null ? "${var.channel}-${var.env}-${local.neptune_name}" : var.identifier
 neptune_subnet_group_name            = var.subnet_group_name == null ? "${var.channel}-${var.env}-${local.neptune_name}" : var.subnet_group_name
 neptune_security_group_name          = var.security_group_name == null ? "${var.channel}-${var.env}-${local.neptune_name}" : var.security_group_name
 neptune_secret_username              = var.secret_username == null ? local.neptune_map[var.engine].secret_username : var.secret_username
 neptune_secret_password              = var.secret_password == null ? local.neptune_map[var.engine].secret_password : var.secret_password
 neptune_availability_zones           = [for subnet in data.aws_subnet.ingress : subnet.availability_zone]
 neptune_parameter_group_name         = var.use_custom_parameter_group ? aws_neptune_parameter_group.this[0].name : local.neptune_default_parameter_group_name
  
}

#data

data "aws_vpc" "this" {
  count = var.vpc_id == "" ? 1 : 0

  filter {
    name   = "tag:Env"
    values = [var.env]
  }

  filter {
    name   = "tag:Channel"
    values = [var.channel]
  }

  filter {
    name   = "tag:Type"
    values = ["vpc"]
  }

}

data "aws_subnet_ids" "this" {
  count  = length(var.subnet_ids) == 0 ? 1 : 0
  vpc_id = try(data.aws_vpc.this[0].id, var.vpc_id)
  filter {
    name   = "tag:Env"
    values = [var.env]
  }

  filter {
    name   = "tag:Channel"
    values = [var.channel]
  }

  filter {
    name   = "tag:Type"
    values = var.subnet_type
  }
}

data "aws_subnet_ids" "ingress" {
  count  = length(var.ingress_cidrs) == 0 ? 1 : 0
  vpc_id = try(data.aws_vpc.this[0].id, var.vpc_id)
  filter {
    name   = "tag:Env"
    values = [var.env]
  }

  filter {
    name   = "tag:Channel"
    values = [var.channel]
  }

  filter {
    name   = "tag:Type"
    values = var.ingress_subnet_type
  }
}

data "aws_subnet" "ingress" {
  for_each = length(var.subnet_ids) == 0 ? data.aws_subnet_ids.ingress[0].ids : toset(var.subnet_ids)
  id       = each.value
}


## AWS Neptune Cluster and instance resources
# Each Neptune DB cluster has a reader endpoint.

resource "aws_neptune_cluster" "this" {

  cluster_identifier                   = local.neptune_identifier
  engine                               = local.engine
  engine_version                       = local.neptune_engine_version
  iam_database_authentication_enabled  = true 
  neptune_subnet_group_name            = aws_neptune_subnet_group.this.name
  neptune_cluster_parameter_group_name = local.neptune_parameter_group_name 

 // vpc_security_group_ids              = [ "${aws_security_group.neptune_example.id}" ] 
  backup_retention_period              = var.retention_period
  preferred_backup_window              = var.backup_window
  storage_encrypted                    = var.at_rest_encryption_enabled
  apply_immediately                    = var.apply_immediately
  skip_final_snapshot                  = var.skip_final_snapshot
  final_snapshot_identifier            = "${local.neptune_identifier}-final"
  snapshot_identifier                  = var.snapshot_identifier != "" ? var.snapshot_identifier : null 
  tags                                 = merge(local.common_tags, var.resource_tags_rds_instance) 


}


resource "aws_neptune_cluster_instance" "this" {    

  count                        = var.primary_instance_count
  identifier                   = "${local.neptune_identifier}-${count.index + 1}"
  cluster_identifier           = aws_neptune_cluster.this.id
  engine                       = aws_neptune_cluster.this.engine
  engine_version               = aws_neptune_cluster.this.engine_version

  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  instance_class               = var.instance_type
  neptune_subnet_group_name    = aws_neptune_subnet_group.this.name
  neptune_parameter_group_name = local.neptune_parameter_group_name
  performance_insights_enabled = var.enable_performance_insights
  apply_immediately            = var.apply_immediately
  tags                         = merge(local.common_tags, var.resource_tags_rds_instance)

}

 

 