resource "aws_default_vpc" "default" {
    tags = {
      name = "default_vpc"
    }
}

resource "aws_lb_target_group" "mytg" {
    health_check {
      healthy_threshold = 5
      unhealthy_threshold = 2
      timeout = 5
      protocol = "HTTP"
      interval = 10
    }

    target_type = "instance"
    vpc_id = aws_default_vpc.default.id
    port = "80"
    protocol = "HTTP"
}

resource "aws_default_subnet" "default_az1" {
    availability_zone = "us-east-1a"

    tags = {
      Name = "Default subnet for us-east-1a"
  }
}

resource "aws_default_subnet" "default_az2" {
    availability_zone = "us-east-1b"

    tags = {
      Name = "Default subnet for us-east-1b"
    }

}

resource "aws_lb" "weblb" {
    name = "weblb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.lbsg.id]
    subnets = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
    ip_address_type = "ipv4"
}

resource "aws_lb_listener" "mylistener" {
    load_balancer_arn = aws_lb.weblb.arn
    port = element(var.webports, 0) # chooses the second value
    protocol = "HTTP"
    default_action {
      target_group_arn = aws_lb_target_group.mytg.arn
      type = "forward"
    }
}

resource "aws_lb_target_group_attachment" "ec2attach" {
    target_group_arn = aws_lb_target_group.mytg.arn
    target_id = aws_instance.ec2_inst.id
}
