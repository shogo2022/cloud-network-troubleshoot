#Create vpc
resource "aws_vpc" "handsonlab_vpc" {
    cidr_block = "172.16.0.0/16"
    tags = {
        Name = "handsonlab_vpc"
        Handsonlab = true
    }
}

#Create internet gateway
resource "aws_internet_gateway" "handsonlab_igw" {
    vpc_id = aws_vpc.handsonlab_vpc.id
    tags = {
        Name = "handson_igw"
        Handsonlab = true
    }
}

#Create route table
resource "aws_route_table" "handsonlab_public_rt" {
  vpc_id = aws_vpc.handsonlab_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.handsonlab_igw.id
  }
  tags = {
      Name = "handsonlab_public_rt"
      Handsonlab = true
  }
}

#Create subnet
resource "aws_subnet" "handsonlab_public_net" {
    vpc_id = aws_vpc.handsonlab_vpc.id
    cidr_block = "172.16.0.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "handsonlab_public_net"
        Handsonlab = true
    }
}

# associate route table with subnet
resource "aws_route_table_association" "handsonlab_public_assoc" {
  subnet_id      = aws_subnet.handsonlab_public_net.id
  route_table_id = aws_route_table.handsonlab_public_rt.id
}

resource "aws_security_group" "handsonlab_web_sg" {
  vpc_id      = aws_vpc.handsonlab_vpc.id

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  
  name = "handsonlab_web_sg"
  tags = {
    Handsonlab = true
  }
}