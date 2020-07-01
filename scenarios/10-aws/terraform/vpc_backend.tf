#Create vpc
resource "aws_vpc" "handsonlab_backend_vpc" {
  cidr_block = "172.16.0.0/16"
  tags = {
    Name       = "handsonlab_backend_vpc"
    Handsonlab = true
  }
}

#Create route table - private
resource "aws_route_table" "handsonlab_private_rt" {
  vpc_id = aws_vpc.handsonlab_backend_vpc.id

  tags = {
    Name       = "handsonlab_private_rt"
    Handsonlab = true
  }
}

# associate route table with subnet - private
resource "aws_route_table_association" "handsonlab_private_assoc" {
  subnet_id      = aws_subnet.handsonlab_private_net.id
  route_table_id = aws_route_table.handsonlab_private_rt.id
}


#Create subnet - private
resource "aws_subnet" "handsonlab_private_net" {
  vpc_id            = aws_vpc.handsonlab_backend_vpc.id
  cidr_block        = "172.16.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name       = "handsonlab_private_net"
    Handsonlab = true
  }
}

# security group for db backend
resource "aws_security_group" "handsonlab_db_sg" {
  vpc_id = aws_vpc.handsonlab_backend_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"]
  }

  name = "handsonlab_db_sg"
  tags = {
    Handsonlab = true
  }
}