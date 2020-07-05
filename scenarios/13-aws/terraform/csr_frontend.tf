#Create a security group for csr
resource "aws_security_group" "handsonlab_frontend_csr_sg" {
  vpc_id      = aws_vpc.handsonlab_frontend_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 500
    to_port     = 500
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 4500
    to_port     = 4500
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  
  name = "handsonlab_frontend_csr_sg"
}

#Deploy cisco csr1000v
data "aws_ami" "csr" {
    most_recent = true

    filter {
        name   = "name"
        values = ["cisco-CSR-.16.09.02-BYOL-HVM*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["679593333241"] 
}


#Register vpn config to be injected into csr1000v
data "template_file" "frontend_csr_vpnconfig" {
  template = file("./frontend_csr_vpn.cfg.tpl")

  vars = {
    primary_vgw_ip = aws_vpn_connection.handsonlab_front2back_vpn.tunnel1_address
    primary_vgw_psk = aws_vpn_connection.handsonlab_front2back_vpn.tunnel1_preshared_key
    primary_cgw_inip = aws_vpn_connection.handsonlab_front2back_vpn.tunnel1_cgw_inside_address
    cgw_asn = var.frontend_asn
    primary_vgw_asn = aws_vpn_connection.handsonlab_front2back_vpn.tunnel1_bgp_asn
    primary_vgw_inip = aws_vpn_connection.handsonlab_front2back_vpn.tunnel1_vgw_inside_address
    subnet_network = cidrhost("${aws_subnet.handsonlab_public_net.cidr_block}",0)
    subnet_netmask = cidrnetmask("${aws_subnet.handsonlab_public_net.cidr_block}")
    secondary_vgw_ip = aws_vpn_connection.handsonlab_front2back_vpn.tunnel2_address
    secondary_vgw_psk = aws_vpn_connection.handsonlab_front2back_vpn.tunnel2_preshared_key
    secondary_cgw_inip = aws_vpn_connection.handsonlab_front2back_vpn.tunnel2_cgw_inside_address
    secondary_vgw_asn = aws_vpn_connection.handsonlab_front2back_vpn.tunnel2_bgp_asn
    secondary_vgw_inip = aws_vpn_connection.handsonlab_front2back_vpn.tunnel2_vgw_inside_address
  }
}

resource "aws_instance" "handsonlab_frontend_csr" {
  ami = data.aws_ami.csr.id
  instance_type = "t2.medium"
  count = 1
  subnet_id = aws_subnet.handsonlab_public_net.id
  key_name = aws_key_pair.handsonlab_pub_key.key_name
  vpc_security_group_ids = [aws_security_group.handsonlab_frontend_csr_sg.id]
  source_dest_check = false

  tags = {
    Name = format("handsonlab_frontend_csr%02d", count.index)
    Handsonlab = true
  }
 
  user_data = data.template_file.frontend_csr_vpnconfig.rendered

}

# allocate eip
resource "aws_eip" "handsonlab_frontend_csr_eip" {
  vpc = true
}

# associate eip to csr
resource "aws_eip_association" "handsonlab_frontend_csr_eipassoc" {
  instance_id   = aws_instance.handsonlab_frontend_csr[0].id
  allocation_id = aws_eip.handsonlab_frontend_csr_eip.id
}
