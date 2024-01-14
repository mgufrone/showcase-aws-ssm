
data "aws_ami" "linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Amazon
}

resource "aws_instance" "private" {
  lifecycle {
    create_before_destroy = true
  }
  security_groups = [
    aws_security_group.outbond_sg.id
  ]
  tags                        = local.tags
  tags_all                    = local.tags
  subnet_id                   = aws_subnet.private_subnet_c.id
  ami                         = data.aws_ami.linux.id
#  key_name                    = "gufy-mac"
  instance_type               = "t3.nano"
  iam_instance_profile        = aws_iam_instance_profile.ssm_role.name
  user_data_replace_on_change = true
  user_data                   = <<-USERDATA
#!/bin/bash
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent
USERDATA
}
