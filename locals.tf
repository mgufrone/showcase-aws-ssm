locals {
  tags = {
    Name = "ec2-ssm"
  }
  # change it to your vpc
  vpc_id = "vpc-0eb8c63e023a56df4"
  # change it to your existing route table that resides in the vpc
  rt_id  = "rtb-0f938b92edb6fdc5f"
}
