data "aws_iam_policy_document" "ssm_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
    effect = "Allow"
  }
}

resource "aws_iam_role" "ssm_agent" {
  name                = "ec2-ssm-role"
  assume_role_policy  = data.aws_iam_policy_document.ssm_assume_role.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
  ]
  tags = {
    SSMSessionRunAs = "ec2-user"
  }
}

resource "aws_iam_instance_profile" "ssm_role" {
  name = "ec2-ssm-instance-profile"
  role = aws_iam_role.ssm_agent.name
  tags = {
    SSMSessionRunAs = "ec2-user"
  }
}

resource "aws_security_group" "outbond_sg" {
  vpc_id = local.vpc_id
  tags   = {
    Name = "allow-all-outbond"
  }
  tags_all = {
    Name = "allow-all-outbond"
  }
}

resource "aws_security_group_rule" "allow_outbond" {
  from_port         = 0
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.outbond_sg.id
  to_port           = 65535
  type              = "egress"
}
