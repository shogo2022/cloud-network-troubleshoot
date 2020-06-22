#Temporary key pair for EC2 access
resource "tls_private_key" "my_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#Store ssh key file to procure compute instance
resource "aws_key_pair" "handsonlab_pub_key" {
  key_name   = "handsonlab_pub_key"
  public_key = tls_private_key.my_key.public_key_openssh
  tags = {
    Handsonlab = true
  }
}

#Store temporary key file in local directory
resource "local_file" "handsonlab_key_file" {
    content     = tls_private_key.my_key.private_key_pem
    filename = "handsonlab_prv_key.pem"
}
