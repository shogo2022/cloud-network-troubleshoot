#Create servers - db backend
resource "aws_instance" "handsonlab_db" {
  ami                         = "ami-0417fabe79d08913d" # preloaded db server based on Ubuntu 20.04
  instance_type               = "t2.micro"
  count                       = 1
  subnet_id                   = aws_subnet.handsonlab_private_net.id
  key_name                    = aws_key_pair.handsonlab_pub_key.key_name
  vpc_security_group_ids      = [aws_security_group.handsonlab_db_sg.id]
  associate_public_ip_address = false

  tags = {
    Name       = format("handsonlab_db%02d", count.index)
    Handsonlab = true
  }

}