data "aws_ami" "my_image" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

data "aws_availability_zones" "azs" {
  state = "available"
}

data "aws_subnet_ids" "defsub" {
  vpc_id = aws_default_vpc.default.id
}
