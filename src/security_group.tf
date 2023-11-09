resource "aws_security_group" "sagemaker_endpoint" {
  vpc_id      = local.vpc_id
  name        = "${var.md_metadata.name_prefix}-sg"
  description = "AWS SageMaker ${var.md_metadata.name_prefix} security group"
  tags = merge(
    var.md_metadata.default_tags,
    {
      Name = var.md_metadata.name_prefix
    }
  )
}

resource "aws_security_group_rule" "sagemaker_egress_all" {
  description = "Allow all egress"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.sagemaker_endpoint.id
}