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

#Create nacl
resource "aws_network_acl" "handsonlab_nacl_public" {
  vpc_id = "${aws_vpc.handsonlab_vpc.id}"
  subnet_ids = ["${aws_subnet.handsonlab_public_net.id}"]

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  tags = {
    Name = "handsonlab_nacl"
    Handsonlab = true
  }
}

resource "aws_security_group" "handsonlab_web_sg" {
  vpc_id      = aws_vpc.handsonlab_vpc.id

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  
  name = "handsonlab_web_sg"
  tags = {
    Handsonlab = true
  }
}
