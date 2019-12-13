

variable "VPC1_id" {}
variable "VPC2_id" {}
variable "VPC3_id" {}
variable "VPC4_id" {}
variable "VPCBR_id" {}

variable "Subnet10-vpc1" {}
variable "Subnet10-vpc2" {}
variable "Subnet10-vpc3" {}
variable "Subnet10-vpc4" {}
variable "Subnet10-vpcBR" {}
variable "Subnet20-vpcBR" {}

variable "AWS_ASN_A" {}
variable "AWS_ASN_B" {}




resource "aws_ec2_transit_gateway" "TGW_A" {
  description     = "TGW_A"
  amazon_side_asn = "${var.AWS_ASN_A}"
  tags = {
    Name = "TGW_A"
  }
}
resource "aws_ec2_transit_gateway" "TGW_B" {
  description     = "TGW_B"
  amazon_side_asn = "${var.AWS_ASN_B}"
  tags = {
    Name = "TGW_B"
  }
}
resource "aws_ec2_transit_gateway_vpc_attachment" "TGW-attach-VPC1" {
  subnet_ids          = ["${var.Subnet10-vpc1}"]
  transit_gateway_id  = "${aws_ec2_transit_gateway.TGW_A.id}"
  vpc_id              = "${var.VPC1_id}"
  tags = {
    Name = "GC-attach-VPC1"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "TGW-attach-VPC2" {
  subnet_ids          = ["${var.Subnet10-vpc2}"]
  transit_gateway_id  = "${aws_ec2_transit_gateway.TGW_A.id}"
  vpc_id              = "${var.VPC2_id}"
  tags = {
    Name = "GC-attach-VPC2"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "TGW-attach-VPC3" {
  subnet_ids          = ["${var.Subnet10-vpc3}"]
  transit_gateway_id  = "${aws_ec2_transit_gateway.TGW_B.id}"
  vpc_id              = "${var.VPC3_id}"
  tags = {
    Name = "GC-attach-VPC3"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "TGW-attach-VPC4" {
  subnet_ids          = ["${var.Subnet10-vpc4}"]
  transit_gateway_id  = "${aws_ec2_transit_gateway.TGW_B.id}"
  vpc_id              = "${var.VPC4_id}"
  tags = {
    Name = "GC-attach-VPC4"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "TGW-attach-bridge-A" {
  subnet_ids          = ["${var.Subnet10-vpcBR}"]
  transit_gateway_id  = "${aws_ec2_transit_gateway.TGW_A.id}"
  transit_gateway_default_route_table_propagation = false
  vpc_id              = "${var.VPCBR_id}"
  tags = {
    Name = "GC-attach-VPCBR-A"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "TGW-attach-bridge-B" {
  subnet_ids          = ["${var.Subnet20-vpcBR}"]
  transit_gateway_id  = "${aws_ec2_transit_gateway.TGW_B.id}"
  transit_gateway_default_route_table_propagation = false
  vpc_id              = "${var.VPCBR_id}"
  tags = {
    Name = "GC-attach-VPCBR-B"
  }
}
resource "aws_ec2_transit_gateway_route" "default_A" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.TGW-attach-bridge-A.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway.TGW_A.association_default_route_table_id}"
}

resource "aws_ec2_transit_gateway_route" "default_B" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.TGW-attach-bridge-B.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway.TGW_B.association_default_route_table_id}"
}

/*================
Outputs variables
=================*/

output "TGW_A_id"                   {value = "${aws_ec2_transit_gateway.TGW_A.id}"}
output "TGW_B_id"                   {value = "${aws_ec2_transit_gateway.TGW_B.id}"}

