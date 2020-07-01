#Create servers - web frontend
resource "aws_instance" "handsonlab_web" {
  ami                         = "ami-00d4cc3cf2de35c57" # preloaded web server based on Ubuntu 20.04
  instance_type               = "t2.micro"
  count                       = 1
  subnet_id                   = aws_subnet.handsonlab_public_net.id
  key_name                    = aws_key_pair.handsonlab_pub_key.key_name
  vpc_security_group_ids      = [aws_security_group.handsonlab_web_sg.id]
  associate_public_ip_address = true

  tags = {
    Name       = format("handsonlab_web%02d", count.index)
    Handsonlab = true
  }

  user_data = <<EOF
#!/bin/bash
echo DB_IPADDRESS = \""${aws_instance.handsonlab_db[0].private_ip}"\" >> /app/portfolio-demo-flask-simple/config.py
python3 /app/portfolio-demo-flask-simple/main.py
EOF
}
