
/*================
Create VPCs
Create respective Internet Gateways
Create subnets
Create route tables
create security groups
=================*/

variable "vpc1_cidr"      {}
variable "Subnet10-vpc1"  {}
variable "vpc2_cidr"      {}
variable "Subnet10-vpc2"  {}
variable "vpc3_cidr"      {}
variable "Subnet10-vpc3"  {}
variable "vpc4_cidr"      {}
variable "Subnet10-vpc4"  {}
variable "vpcBR_cidr" {}
variable "Subnet10-vpcBR"  {}
variable "Subnet20-vpcBR"  {}




variable "TGW_A_id"       {}
variable "TGW_B_id"       {}

variable "region"         {}




/*================
VPCs
=================*/
resource "aws_vpc" "vpc1" {
    cidr_block = "${var.vpc1_cidr}"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
         Name = "VPC1"
    }
}
resource "aws_vpc" "vpc2" {
    cidr_block = "${var.vpc2_cidr}"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
         Name = "VPC2"
    }
}
resource "aws_vpc" "vpc3" {
    cidr_block = "${var.vpc3_cidr}"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
         Name = "VPC3"
    }
}
resource "aws_vpc" "vpc4" {
    cidr_block = "${var.vpc4_cidr}"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
         Name = "VPC4"
    }
}
resource "aws_vpc" "vpcBR" {
    cidr_block = "${var.vpcBR_cidr}"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
         Name = "BridgeVPC"
    }
}
/*================
IGWs
=================*/

resource "aws_internet_gateway" "vpc1-igw" {
    vpc_id = "${aws_vpc.vpc1.id}"
    tags = {
        Name = "GCTF-VPC1-IGW"
    }

}
resource "aws_internet_gateway" "vpc2-igw" {
    vpc_id = "${aws_vpc.vpc2.id}"
    tags = {
        Name = "GCTF-VPC2-IGW"
    }

}
resource "aws_internet_gateway" "vpc3-igw" {
    vpc_id = "${aws_vpc.vpc3.id}"
    tags = {
        Name = "GCTF-VPC3-IGW"
    }

}
resource "aws_internet_gateway" "vpc4-igw" {
    vpc_id = "${aws_vpc.vpc4.id}"
    tags = {
        Name = "GCTF-VPC4-IGW"
    }

}

/*================
Subnets in VPC1
=================*/

# Get Availability zones in the Region
data "aws_availability_zones" "AZ" {}

resource "aws_subnet" "Subnet10-vpc1" {
  vpc_id     = "${aws_vpc.vpc1.id}"
  cidr_block = "${var.Subnet10-vpc1}"
  map_public_ip_on_launch = true
  availability_zone = "${data.aws_availability_zones.AZ.names[0]}"
  tags = {
    Name = "GCTF-Subnet10-vpc1"
  }
}


/*================
Subnets in VPC2
=================*/

resource "aws_subnet" "Subnet10-vpc2" {
  vpc_id     = "${aws_vpc.vpc2.id}"
  cidr_block = "${var.Subnet10-vpc2}"
  map_public_ip_on_launch = true
  availability_zone = "${data.aws_availability_zones.AZ.names[0]}"
  tags = {
    Name = "GCTF-Subnet10-vpc2"
  }
}

/*================
Subnets in VPC3
=================*/

resource "aws_subnet" "Subnet10-vpc3" {
  vpc_id     = "${aws_vpc.vpc3.id}"
  cidr_block = "${var.Subnet10-vpc3}"
  map_public_ip_on_launch = true
  availability_zone = "${data.aws_availability_zones.AZ.names[0]}"
  tags = {
    Name = "GCTF-Subnet10-vpc3"
  }
}

/*================
Subnets in VPC4
=================*/

resource "aws_subnet" "Subnet10-vpc4" {
  vpc_id     = "${aws_vpc.vpc4.id}"
  cidr_block = "${var.Subnet10-vpc4}"
  map_public_ip_on_launch = true
  availability_zone = "${data.aws_availability_zones.AZ.names[0]}"
  tags = {
    Name = "GCTF-Subnet10-vpc4"
  }
}

/*================
Subnets in Bridge VPC
=================*/

resource "aws_subnet" "Subnet10-vpcBR" {
  vpc_id     = "${aws_vpc.vpcBR.id}"
  cidr_block = "${var.Subnet10-vpcBR}"
  map_public_ip_on_launch = true
  availability_zone = "${data.aws_availability_zones.AZ.names[0]}"
  tags = {
    Name = "GCTF-Subnet10-bridge-vpc"
  }
}

resource "aws_subnet" "Subnet20-vpcBR" {
  vpc_id     = "${aws_vpc.vpcBR.id}"
  cidr_block = "${var.Subnet20-vpcBR}"
  map_public_ip_on_launch = true
  availability_zone = "${data.aws_availability_zones.AZ.names[0]}"
  tags = {
    Name = "GCTF-Subnet20-bridge-vpc"
  }
}
/*================
default route table VPC1
=================*/

resource "aws_default_route_table" "vpc1-RT" {
  default_route_table_id = "${aws_vpc.vpc1.default_route_table_id}"

  lifecycle {
    ignore_changes = ["route"] # ignore any manually or ENI added routes
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc1-igw.id}"
  }
  route {
    cidr_block = "${var.Subnet10-vpc2}"
    transit_gateway_id = "${var.TGW_A_id}"
  }
  route {
    cidr_block = "${var.Subnet10-vpc3}"
    transit_gateway_id = "${var.TGW_A_id}"
  }
  route {
    cidr_block = "${var.Subnet10-vpc4}"
    transit_gateway_id = "${var.TGW_A_id}"
  }

tags = {
    Name = "GCTF-RT-VPC1"
  }
}
/*================
default route table VPC2
=================*/

resource "aws_default_route_table" "vpc2-RT" {
  default_route_table_id = "${aws_vpc.vpc2.default_route_table_id}"

  lifecycle {
    ignore_changes = ["route"] # ignore any manually or ENI added routes
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc2-igw.id}"
  }
  route {
    cidr_block = "${var.Subnet10-vpc1}"
    transit_gateway_id = "${var.TGW_A_id}"
  }
  route {
    cidr_block = "${var.Subnet10-vpc3}"
    transit_gateway_id = "${var.TGW_A_id}"
  }
  route {
    cidr_block = "${var.Subnet10-vpc4}"
    transit_gateway_id = "${var.TGW_A_id}"
  }
tags = {
    Name = "GCTF-RT-VPC2"
  }
}
/*================
route table VPC3
=================*/

resource "aws_default_route_table" "vpc3-RT" {
  default_route_table_id = "${aws_vpc.vpc3.default_route_table_id}"

  lifecycle {
    ignore_changes = ["route"] # ignore any manually or ENI added routes
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc3-igw.id}"
  }
  route {
    cidr_block = "${var.Subnet10-vpc1}"
    transit_gateway_id = "${var.TGW_B_id}"
  }
  route {
    cidr_block = "${var.Subnet10-vpc2}"
    transit_gateway_id = "${var.TGW_B_id}"
  }
  route {
    cidr_block = "${var.Subnet10-vpc4}"
    transit_gateway_id = "${var.TGW_B_id}"
  }
  tags = {
    Name = "GCTF-RT-VPC3"
  }
}

/*================
route table VPC4
=================*/

resource "aws_default_route_table" "vpc4-RT" {
  default_route_table_id = "${aws_vpc.vpc4.default_route_table_id}"

  lifecycle {
    ignore_changes = ["route"] # ignore any manually or ENI added routes
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc4-igw.id}"
  }
  route {
    cidr_block = "${var.Subnet10-vpc1}"
    transit_gateway_id = "${var.TGW_B_id}"
  }
  route {
    cidr_block = "${var.Subnet10-vpc2}"
    transit_gateway_id = "${var.TGW_B_id}"
  }
  route {
    cidr_block = "${var.Subnet10-vpc3}"
    transit_gateway_id = "${var.TGW_B_id}"
  }
  tags = {
    Name = "GCTF-RT-VPC4"
  }
}
/*================
route table VPC bridge
=================*/

resource "aws_default_route_table" "vpcBR-RT" {
  default_route_table_id = "${aws_vpc.vpcBR.default_route_table_id}"

  lifecycle {
    ignore_changes = ["route"] # ignore any manually or ENI added routes
  }

  route {
    cidr_block = "${var.Subnet10-vpc1}"
    transit_gateway_id = "${var.TGW_A_id}"
  }
  route {
    cidr_block = "${var.Subnet10-vpc2}"
    transit_gateway_id = "${var.TGW_A_id}"
  }
  route {
    cidr_block = "${var.Subnet10-vpc3}"
    transit_gateway_id = "${var.TGW_B_id}"
  }  
  route {
    cidr_block = "${var.Subnet10-vpc4}"
    transit_gateway_id = "${var.TGW_B_id}"
  }

  tags = {
    Name = "GCTF-RT-Bridge-VPC"
  }
}
/*================
Route Table association
=================*/

resource "aws_route_table_association" "vpc1_10" {
  subnet_id      = "${aws_subnet.Subnet10-vpc1.id}"
  route_table_id = "${aws_default_route_table.vpc1-RT.id}"
}


resource "aws_route_table_association" "vpc2_10" {
  subnet_id      = "${aws_subnet.Subnet10-vpc2.id}"
  route_table_id = "${aws_default_route_table.vpc2-RT.id}"
}

resource "aws_route_table_association" "vpc3_10" {
  subnet_id      = "${aws_subnet.Subnet10-vpc3.id}"
  route_table_id = "${aws_default_route_table.vpc3-RT.id}"
}

resource "aws_route_table_association" "vpc4_10" {
  subnet_id      = "${aws_subnet.Subnet10-vpc4.id}"
  route_table_id = "${aws_default_route_table.vpc4-RT.id}"
}

resource "aws_route_table_association" "vpcB_10" {
  subnet_id      = "${aws_subnet.Subnet10-vpcBR.id}"
  route_table_id = "${aws_default_route_table.vpcBR-RT.id}"
}

resource "aws_route_table_association" "vpcB_20" {
  subnet_id      = "${aws_subnet.Subnet20-vpcBR.id}"
  route_table_id = "${aws_default_route_table.vpcBR-RT.id}"
}
/*================
Security Groups
=================*/

resource "aws_security_group" "GC-SG-VPC1" {
  name    = "GC-SG-VPC1"
  vpc_id  = "${aws_vpc.vpc1.id}"
  tags = {
    Name = "GCTF-SG-VPC1"
  }
  ingress {
    description = "Allow SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow all PING"
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow iPERF3"
    from_port = 5201
    to_port = 5201
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_security_group" "GC-SG-VPC2" {
  name    = "GC-SG-VPC2"
  vpc_id  = "${aws_vpc.vpc2.id}"
  tags = {
    Name = "GCTF-SG-VPC2"
  }
  #SSH and all PING
  ingress {
    description = "Allow SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow all PING"
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow iPERF3"
    from_port = 5201
    to_port = 5201
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "GC-SG-VPC3" {
  name    = "GC-SG-VPC3"
  vpc_id  = "${aws_vpc.vpc3.id}"
  tags = {
    Name = "GCTF-SG-VPC3"
  }
  #SSH and all PING
  ingress {
    description = "Allow SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow all PING"
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow iPERF3"
    from_port = 5201
    to_port = 5201
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "GC-SG-VPC4" {
  name    = "GC-SG-VPC4"
  vpc_id  = "${aws_vpc.vpc4.id}"
  tags = {
    Name = "GCTF-SG-VPC4"
  }
  #SSH and all PING
  ingress {
    description = "Allow SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow all PING"
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow iPERF3"
    from_port = 5201
    to_port = 5201
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



/*================
Outputs variables for other modules to use
=================*/
output "VPC1_id"              {value = "${aws_vpc.vpc1.id}"}
output "VPC2_id"              {value = "${aws_vpc.vpc2.id}"}
output "VPC3_id"              {value = "${aws_vpc.vpc3.id}"}
output "VPC4_id"              {value = "${aws_vpc.vpc4.id}"}
output "VPCBR_id"             {value = "${aws_vpc.vpcBR.id}"}

output "Subnet10-vpc1"        {value = "${aws_subnet.Subnet10-vpc1.id}"}
output "Subnet10-vpc2"        {value = "${aws_subnet.Subnet10-vpc2.id}"}
output "Subnet10-vpc3"        {value = "${aws_subnet.Subnet10-vpc3.id}"}
output "Subnet10-vpc4"        {value = "${aws_subnet.Subnet10-vpc4.id}"}
output "Subnet10-vpcBR"       {value = "${aws_subnet.Subnet10-vpcBR.id}"}
output "Subnet20-vpcBR"       {value = "${aws_subnet.Subnet20-vpcBR.id}"}


output "GC-SG-VPC1"           {value = "${aws_security_group.GC-SG-VPC1.id}"}
output "GC-SG-VPC2"           {value = "${aws_security_group.GC-SG-VPC2.id}"}
output "GC-SG-VPC3"           {value = "${aws_security_group.GC-SG-VPC3.id}"}
output "GC-SG-VPC4"           {value = "${aws_security_group.GC-SG-VPC4.id}"}




