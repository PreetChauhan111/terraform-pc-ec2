locals {
  common_tags = {
    Owner       = "pc"
    Environment = var.environment
    GithubRepo  = "pc-ec2-wrapper"
  }
  name                = var.name == "" ? "${local.common_tags["Owner"]}-ec2-${var.environment}-${var.region}" : var.name
  security_group_name = var.security_group_name == "" ? "${local.name}-sg" : var.security_group_name
  key_name            = var.key_name == "" ? "${local.name}-key" : var.key_name
  eip_tags            = merge(local.common_tags, { Name = "${local.name} eip" })
  iam_role_tags       = merge(local.common_tags, { Name = "${local.name} role" })
  instance_tags       = merge(local.common_tags, { Name = local.name })
  tags                = merge(local.common_tags, { Name = local.name })
  security_group_tags = merge(local.common_tags, { Name = "${local.name} sg" })
}