# vpc variable
variable "cidr_range" {
  type = string
  default = "10.0.0.0/17"
}

variable "instance_tenancy" {
  type = string
  default = "default"
}

variable "vpc_name" {
  type = string
  default = "Tool_vpc"
}

# subnet variable

variable "subnet1cidr" {
  type = string
  default = "10.0.1.0/24"
}

variable "subnet2cidr" {
  type = string
  default = "10.0.2.0/24"
}


variable "subnet3cidr" {
  type = string
  default = "10.0.3.0/24"
}

variable "subnet4cidr" {
  type = string
  default = "10.0.4.0/24"
}

variable "availability_zone_01" {
  type = string
  default = "ap-south-1a"
}

variable "availability_zone_02" {
  type = string
  default = "ap-south-1b"
}

variable "subnet_01" {
  type = string
  default = "public_01"
}

variable "subnet_02" {
  type = string
  default = "public_02"
}

variable "subnet_03" {
  type = string
  default = "private_01"
}

variable "subnet_04" {
  type = string
  default = "private_02"
}

# Internet gateway variable

variable "internet_gateway_name" {
  type = string
  default = "internet-gateway"
}

# elastic ip variable

variable "elastic_ip_name" {
  type = string
  default = "elastic-ip"
}

# NAT GW variable

variable "name_nat" {
  type = string
  default = "NAT01"
}

variable "connection_type" {
  type = string
  default = "public"
}


# route table variable

variable "rt01_name" {
  type = string
  default = "public-RT"
}

variable "rt02_name" {
  type = string
  default = "private-RT"
}

variable "nat_cidr_range" {
  type = string
  default = "0.0.0.0/0"
}

# Security group variable

variable "public_sg01_name" {
  type = string
  default = "public-sg"
}

variable "private_sg02_name" {
  type = string
  default = "private-sg"
}

variable "ssh_port" {
  type = string
  default = "22"
}

variable "protocol_tcp" {
   type = string
  default = "tcp"
}

variable "protocol_01" {
   type = string
  default = "-1"
}

variable "ES_port" {
  type = string
  default = "9200"
}

variable "allow_port" {
  type = string
  default = "0"
}

variable "HTTP_port" {
  type = string
  default = "80"
}

variable "sg_cidr_range" {
  type = string
  default = "0.0.0.0/0"
}

variable "kibana_port" {
  type = string
  default = "5601"
}

# compute variable


variable "AMI_ID" {
  type = string
  default = "ami-0ea3c35c5c3284d82"
}

variable "instance_type" {
  type = string
  default = "t3.medium"
}

variable "key_name" {
  type = string
  default = "tool"
}

variable "instance_name" {
  type = string
  default = "public-instance"
}

variable "instance02_name" {
  type = string
  default = "private-instance-01"
}

variable "instance03_name" {
  type = string
  default = "private-instance-02"
}


# target grp variable

variable "TG_name" {
  type = string
  default = "tool-tg"
}


variable "HTTP_port_tg" {
  type = string
  default = "80"
}

variable "protocol_type" {
  type = string
  default = "HTTP"
}

variable "interval" {
  type = string
  default = "30"
}

variable "timeout" {
  type = string
  default = "5"
}

variable "healthy_threshold" {
  type = string
  default = "5"
}

variable "unhealthy_threshold" {
  type = string
  default = "2"
}

variable "path" {
  type = string
  default = "/"
}



# register target variable
variable "port_nums" {
  type        = list(number)
  default     = [9200, 5601]
}

# ALB variable

variable "ALB_type" {
  type = string
  default = "application"
}

variable "alb_name" {
  type = string
  default = "ES-alb"
}

variable "internal_value" {
  type = bool
  default = false
}

# vpc peering variables

variable "requester_CIDR" {
  type = string
  default = "172.31.0.0/16 "
}

variable "accepter_CIDR" {
  type = string
  default = "10.0.0.0/17"
}

variable "region" {
  type = string
  default = "us-east-2"
}

variable "vpc_peering_name" {
  type = string
  default = "Vpc-peering"
}
