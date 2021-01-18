resource "aws_instance" "ec2_inst" {
  ami = data.aws_ami.my_image.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.websg.id]

  tags = {
    Name = "test"
  }
}
