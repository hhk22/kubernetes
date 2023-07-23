resource "aws_instance" "test-ec2-bastion" {
  ami = "ami-0454bb2fefc7de534"
  associate_public_ip_address = "true"
  availability_zone           = "ap-northeast-2a"

  key_name                    = "test-kp-bastion"
  instance_type               = "t2.micro"

  tags = {
    Name        = "test-ec2-bastion"
  }

  tags_all = {
    Name        = "test-ec2-bastion"
  }

  subnet_id     = aws_subnet.test-public-subnet1.id
  vpc_security_group_ids = [aws_security_group.test-sg-bastion.id]
  
}
