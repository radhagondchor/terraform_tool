data "aws_vpc" "default_vpc" {
  default = true
}


data "aws_route_table" "default-rt" {
 vpc_id = data.aws_vpc.default_vpc.id  
 filter {
    name   = "association.main"
    values = ["true"]
  }
}


resource "aws_route_table" "route-table" {
  vpc_id = data.aws_vpc.default_vpc.id
  
}

resource "aws_route" "default-rt" {
  route_table_id = data.aws_route_table.default-rt.id
  destination_cidr_block = var.cidr_range
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}



# vpc creation
resource "aws_vpc" "vpc_test" {
  cidr_block = var.cidr_range
  instance_tenancy = var.instance_tenancy
  tags = {
    Name = var.vpc_name
  }
}

# subnet creation

# creation of public subnet01

resource "aws_subnet" "public01" {
  vpc_id     = var.vpc_id
  cidr_block = var.subnet1cidr
  availability_zone = var.availability_zone_01

  tags = {
    Name = var.subnet_01
  }
  
}

# creation of public subnet02

resource "aws_subnet" "public02" {
vpc_id     = var.vpc_id
  cidr_block = var.subnet2cidr
  availability_zone = var.availability_zone_02

  tags = {
    Name = var.subnet_02
  }
  
}

# creation of private subnet01

resource "aws_subnet" "private01" {
vpc_id     = var.vpc_id
  cidr_block = var.subnet3cidr
  availability_zone = var.availability_zone_01

  tags = {
    Name = var.subnet_03
  }
  
}

# creation of private subnet02

resource "aws_subnet" "private02" {
  vpc_id     = var.vpc_id
  cidr_block = var.subnet4cidr
  availability_zone = var.availability_zone_02

  tags = {
    Name = var.subnet_04
  }
  
}


# creation of internet gateway

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = var.vpc_id
  tags = {
    Name = var.internet_gateway_name
  }
}

# Elastic Ip creation

resource "aws_eip" "elastic_ip" {
  
  tags = {
    Name = var.elastic_ip_name
  }
}

# creation NAT GW
resource "aws_nat_gateway" "Nat_gate01" {
connectivity_type = var.connection_type
subnet_id         = var.public01_id
allocation_id = var.eip_id

tags = {
    Name = var.name_nat
  }
  
}

# creation of route table

#creation of public RT
resource "aws_route_table" "Route01" {
  vpc_id = var.vpc_id
  route  {
  cidr_block = var.nat_cidr_range
  gateway_id = var.IG_id
  
 }
 
  tags = {
    Name = var.rt01_name
  }
}

resource "aws_route" "route-table-id-01" {
  route_table_id = aws_route_table.Route01.id
  destination_cidr_block = var.default_vpc-cidr-range
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}


# creation of private RT
resource "aws_route_table" "Route02" {
  vpc_id = var.vpc_id
  route  {
  cidr_block = var.nat_cidr_range
  gateway_id = var.NAT_id
 }
 
  tags = {
    Name = var.rt02_name
  }
}

resource "aws_route" "route-table-id-02" {
  route_table_id = aws_route_table.Route02.id
  destination_cidr_block = var.default_vpc-cidr-range
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}

# subnet association

# public subnet-01 association
resource "aws_route_table_association" "public_subnet01_association" {
  subnet_id      = var.public01_id 
  route_table_id = var.RT01_id
}

# public subnet-02 association

resource "aws_route_table_association" "public_subnet02_association" {
  subnet_id      = var.public02_id
  route_table_id = var.RT01_id
}

# private subnet-01 association

resource "aws_route_table_association" "private_subnet01_association" {
  subnet_id      = var.private01_id
  route_table_id = var.RT02_id
}

# private subnet-02 association

resource "aws_route_table_association" "private_subnet02_association" {
  subnet_id      = var.private02_id
  route_table_id = var.RT02_id
}


# security grp creation

# security group for public
resource "aws_security_group" "SG_01" {
  
  vpc_id      = var.vpc_id
  ingress  {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = var.protocol_tcp
    cidr_blocks = [var.sg_cidr_range]
  }
  egress  {
    from_port   = var.allow_port
    to_port     = var.allow_port
    protocol    = var.protocol_01
    cidr_blocks = [var.sg_cidr_range]
  }

  tags = {
    Name = var.public_sg01_name
  }
}

data "aws_security_group" "default-sg" {
  vpc_id = data.aws_vpc.default_vpc.id
  filter {
    name   = "group-name"
    values = ["default"]
  }
}


# security group for private
resource "aws_security_group" "SG_02" {
  
  vpc_id      = var.vpc_id 
  ingress  {
    from_port   = var.ES_port
    to_port     = var.ES_port
    protocol    = var.protocol_tcp
    cidr_blocks = [var.sg_cidr_range]
  }
  egress  {
    from_port   = var.allow_port
    to_port     = var.allow_port
    protocol    = var.protocol_01
    cidr_blocks = [var.sg_cidr_range]
  }
   ingress  {
    from_port   = var.kibana_port
    to_port     = var.kibana_port
    protocol    = var.protocol_tcp
    cidr_blocks = [var.sg_cidr_range]
  }
  egress  {
    from_port   = var.allow_port
    to_port     = var.allow_port
    protocol    = var.protocol_01
    cidr_blocks = [var.sg_cidr_range]
  }

  ingress  {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = var.protocol_tcp
    cidr_blocks = [var.sg_cidr_range]
  }
  egress  {
    from_port   = var.allow_port
    to_port     = var.allow_port
    protocol    = var.protocol_01
    cidr_blocks = [var.sg_cidr_range]
  }

  ingress  {
    from_port   = var.HTTP_port
    to_port     = var.HTTP_port
    protocol    = var.protocol_tcp
    cidr_blocks = [var.sg_cidr_range]
  }
  egress  {
    from_port   = var.allow_port
    to_port     = var.allow_port
    protocol    = var.protocol_01
    cidr_blocks = [var.sg_cidr_range]
  }
  ingress {
    from_port   = -1                # ICMP allows -1 for all types
    to_port     = -1                # ICMP allows -1 for all codes
    protocol    = "icmp"
    cidr_blocks = []
    security_groups = [data.aws_security_group.default-sg.id] # Allow traffic from the default SG
    ipv6_cidr_blocks = []
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.private_sg02_name
  }
}

resource "aws_vpc_peering_connection" "vpc_peering" {
  vpc_id        = data.aws_vpc.default_vpc.id
  peer_vpc_id   = var.vpc_id
  peer_region   = var.region

  tags = {
    Name = var.vpc_peering_name
  }
}

resource "aws_vpc_peering_connection_accepter" "accepter" {
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  auto_accept               = true
}

