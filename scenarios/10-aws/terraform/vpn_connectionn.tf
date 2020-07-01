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

#Enable route injection from vpn gateway
resource "aws_vpn_gateway_route_propagation" "handsonlab_front2back_propagation" {
  vpn_gateway_id = aws_vpn_gateway.handsonlab_backend_vgw.id
  route_table_id = aws_route_table.handsonlab_private_rt.id
}
