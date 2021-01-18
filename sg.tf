resource "aws_security_group" "lbsg" {
    description = "Load Balancer SG"
    vpc_id = aws_default_vpc.default.id

    dynamic "ingress" {
      for_each = var.webports
      iterator = port
      content {
        from_port = port.value
        to_port = port.value
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
}

resource "aws_security_group" "websg" {
    description = "Ports for Apache"
    vpc_id = aws_default_vpc.default.id

    dynamic "ingress" {
      for_each = var.webports
      iterator = port
      content {
        from_port = port.value
        to_port = port.value
        protocol = "tcp"
        security_groups = [aws_security_group.lbsg.id]
      }
    }

    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
}
