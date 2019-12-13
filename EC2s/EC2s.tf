

variable "key_pair"             {}
variable "VM_AMI"               {}

variable "Subnet10-vpc1"        {}
variable "Subnet10-vpc1-base"   {}
variable "GC-SG-VPC1"           {}

variable "Subnet10-vpc2"        {}
variable "Subnet10-vpc2-base"   {}
variable "GC-SG-VPC2"           {}

variable "Subnet10-vpc3"        {}
variable "Subnet10-vpc3-base"   {}
variable "GC-SG-VPC3"           {}

variable "Subnet10-vpc4"        {}
variable "Subnet10-vpc4-base"   {}
variable "GC-SG-VPC4"           {}



/*================
EC2 Instances
=================*/

resource "aws_network_interface" "VM1-Eth0" {
  subnet_id                     = "${var.Subnet10-vpc1}"
  security_groups               = ["${var.GC-SG-VPC1}"]
  private_ips                   = ["${cidrhost(var.Subnet10-vpc1-base, 100)}"]
}
resource "aws_instance" "VM1" {
  ami                           = "${var.VM_AMI}"
  instance_type                 = "t2.micro"
  network_interface {
    network_interface_id        = "${aws_network_interface.VM1-Eth0.id}"
    device_index                = 0
  }
  key_name                      = "${var.key_pair}"
  tags = {
    Name = "GCTF-VM1-vpc1"
  }
}


resource "aws_network_interface" "VM2-Eth0" {
  subnet_id                     = "${var.Subnet10-vpc2}"
  security_groups               = ["${var.GC-SG-VPC2}"]
  private_ips                   = ["${cidrhost(var.Subnet10-vpc2-base, 100)}"]
}
resource "aws_instance" "VM2" {
  ami                           = "${var.VM_AMI}"
  instance_type                 = "t2.micro"
  network_interface {
    network_interface_id        = "${aws_network_interface.VM2-Eth0.id}"
    device_index                = 0
  }
  key_name                      = "${var.key_pair}"
  tags = {
    Name = "GCTF-VM2-vpc2"
  }
}
resource "aws_network_interface" "VM3-Eth0" {
  subnet_id                     = "${var.Subnet10-vpc3}"
  security_groups               = ["${var.GC-SG-VPC3}"]
  private_ips                   = ["${cidrhost(var.Subnet10-vpc3-base, 100)}"]
}
resource "aws_instance" "VM3" {
  ami                           = "${var.VM_AMI}"
  instance_type                 = "t2.micro"
  network_interface {
    network_interface_id        = "${aws_network_interface.VM3-Eth0.id}"
    device_index                = 0
  }
  key_name                      = "${var.key_pair}"
  tags = {
    Name = "GCTF-VM3-vpc3"
  }
}

resource "aws_network_interface" "VM4-Eth0" {
  subnet_id                     = "${var.Subnet10-vpc4}"
  security_groups               = ["${var.GC-SG-VPC4}"]
  private_ips                   = ["${cidrhost(var.Subnet10-vpc4-base, 100)}"]
}
resource "aws_instance" "VM4" {
  ami                           = "${var.VM_AMI}"
  instance_type                 = "t2.micro"
  network_interface {
    network_interface_id        = "${aws_network_interface.VM4-Eth0.id}"
    device_index                = 0
  }
  key_name                      = "${var.key_pair}"
  tags = {
    Name = "GCTF-VM3-vpc4"
  }
}

/*================
Outputs variables for other modules to use
=================*/

output "EC2_VM1"           {value = "${aws_instance.VM1.public_ip}"}
output "EC2_VM2"           {value = "${aws_instance.VM2.public_ip}"}
output "EC2_VM3"           {value = "${aws_instance.VM3.public_ip}"}
output "EC2_VM4"           {value = "${aws_instance.VM4.public_ip}"}

