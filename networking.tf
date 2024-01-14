data "aws_subnet" "public_subnet_c" {
  vpc_id = local.vpc_id
  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }
  filter {
    name   = "availability-zone"
    values = ["us-east-1c"]
  }
}

resource "aws_subnet" "private_subnet_c" {
  vpc_id                  = local.vpc_id
  cidr_block              = "10.0.64.0/20"
  map_public_ip_on_launch = false
}

resource "aws_eip" "nat_ip" {
  domain = "vpc"
  tags   = {
    Name = "nat ip"
  }
}

resource "aws_nat_gateway" "nat_for_private" {
  subnet_id     = data.aws_subnet.public_subnet_c.id
  allocation_id = aws_eip.nat_ip.id
}

resource "aws_route_table" "nat_to_private" {
  vpc_id = local.vpc_id
}
resource "aws_route" "routing" {
  route_table_id         = aws_route_table.nat_to_private.id
  nat_gateway_id         = aws_nat_gateway.nat_for_private.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "subnet" {
  route_table_id = aws_route_table.nat_to_private.id
  subnet_id      = aws_subnet.private_subnet_c.id
}
