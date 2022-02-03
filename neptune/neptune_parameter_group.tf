# RDS parameter group resource
resource "aws_neptune_parameter_group" "this" {
  count  = var.use_custom_parameter_group ? 1 : 0
  name   = coalesce(var.parameter_group_name, replace("${var.channel}-${var.env}-${local.neptune_parameter_group_family}", ".", ""))
  family = local.neptune_parameter_group_family

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }

  tags = local.common_tags
}
