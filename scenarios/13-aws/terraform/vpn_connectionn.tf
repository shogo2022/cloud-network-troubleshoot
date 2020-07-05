#Create vpn gateway in backend vpc
resource "aws_vpn_gateway" "handsonlab_backend_vgw" {
  vpc_id = aws_vpc.handsonlab_backend_vpc.id

  tags = {
    Name = "handsonlab_backend_vgw"
    Handsonlab = true
  }
}

#Register customer gateway
resource "aws_customer_gateway" "handsonlab_frontend_cgw" {
  bgp_asn    = var.frontend_asn
  ip_address = aws_eip.handsonlab_frontend_csr_eip.public_ip
  type       = "ipsec.1"

  tags = {
    Name = "handsonlab_frontend_cgw"
    Handsonlab = true
  }
}

#Create vpn connection
resource "aws_vpn_connection" "handsonlab_front2back_vpn" {
  vpn_gateway_id      = aws_vpn_gateway.handsonlab_backend_vgw.id
  customer_gateway_id = aws_customer_gateway.handsonlab_frontend_cgw.id
  type                = "ipsec.1"

  tags = {
    Name = "handsonlab_front2back_vpn"
    Handsonlab = true
  }
}

#Add route for DB connection in frontend subnet - to CSR.
resource "aws_route" "handsonlab_route_to_db" {
  route_table_id            = aws_route_table.handsonlab_public_rt.id
  destination_cidr_block    = aws_subnet.handsonlab_private_net.cidr_block
  instance_id = aws_instance.handsonlab_frontend_csr[0].id
}

#Enable route injection from vpn gateway
resource "aws_vpn_gateway_route_propagation" "handsonlab_front2back_propagation" {
  vpn_gateway_id = aws_vpn_gateway.handsonlab_backend_vgw.id
  route_table_id = aws_route_table.handsonlab_private_rt.id
}