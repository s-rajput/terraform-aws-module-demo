# RDS subnet group resource

resource "aws_neptune_subnet_group" "this" {
  name       = local.neptune_subnet_group_name
  subnet_ids = try(tolist(data.aws_subnet_ids.this[0].ids), var.subnet_ids)

  tags = local.common_tags
}
 