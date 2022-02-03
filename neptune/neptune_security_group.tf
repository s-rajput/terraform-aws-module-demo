resource "aws_security_group" "this" {
  name        = local.neptune_security_group_name
  description = "Security Group for RDS ${local.neptune_name}"
  vpc_id      = try(data.aws_vpc.this[0].id, var.vpc_id)

  tags = local.common_tags
}

resource "aws_security_group_rule" "ingress" {
  security_group_id = aws_security_group.this.id
  type              = "ingress"
  from_port         = local.neptune_ingress_from_port
  to_port           = local.neptune_ingress_to_port
  protocol          = "tcp"
  cidr_blocks       = concat(var.ingress_cidrs, [for subnet in data.aws_subnet.ingress : subnet.cidr_block])
  description       = "application CIDR Block"
}

data "aws_security_group" "ansible" {
  provider = aws.qlmgt

  filter {
    name   = "tag:Type"
    values = ["ansible"]
  }

  filter {
    name   = "tag:Env"
    values = ["mgt"]
  }

  filter {
    name   = "tag:Channel"
    values = ["lto"]
  }
}

resource "aws_security_group_rule" "ansible" {
  type                     = "ingress"
  from_port                = local.neptune_ingress_from_port
  to_port                  = local.neptune_ingress_to_port
  protocol                 = "tcp"
  source_security_group_id = data.aws_security_group.ansible.id
  security_group_id        = aws_security_group.this.id
  description              = "Allow Ansible server to connect to RDS instance"
}
