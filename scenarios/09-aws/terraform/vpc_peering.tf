#Create vpc peering
resource "aws_vpc_peering_connection" "handsonlab_peering" {
  peer_vpc_id = aws_vpc.handsonlab_backend_vpc.id
  vpc_id      = aws_vpc.handsonlab_frontend_vpc.id
  
  auto_accept = true

  tags = {
    Name = "handsonlab_peering"
    Handsonlab = true
  }
}

# inject route into route tables

resource "aws_route" "handsonlab_route-db2-web" {
  route_table_id            = aws_route_table.handsonlab_private_rt.id
  destination_cidr_block    = aws_subnet.handsonlab_public_net.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.handsonlab_peering.id
}