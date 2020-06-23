#Create servers
resource "aws_instance" "handsonlab_web" {
  ami = "ami-086c9e0eb8ef7f4cc" # preloaded web server based on Ubuntu 18.04 LTS
  instance_type = "t2.micro"
  count = 1
  subnet_id = aws_subnet.handsonlab_public_net.id
  key_name = aws_key_pair.handsonlab_pub_key.key_name
  vpc_security_group_ids = [aws_security_group.handsonlab_web_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = format("handsonlab_web%02d", count.index)
    Handsonlab = true
  }
 
}