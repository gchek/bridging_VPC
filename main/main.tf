/*================
To preserve the AWS Credentials, 
the keys are only in one file "terraform.tfvars" and
should not appear anywhere else
=================*/

provider "aws" {
    access_key          = "${var.access_key}"
    secret_key          = "${var.secret_key}"
    region              = "${var.SDDC_region}"
}

/*================
Create VPCs
The VPCs and subnets CIDR are set in "variables.tf" file
=================*/
module "VPCs" {
  source = "../VPCs"

  vpc1_cidr           = "${var.My_subnets["VPC1"]}"
  Subnet10-vpc1       = "${var.My_subnets["Subnet10-vpc1"]}"

  vpc2_cidr           = "${var.My_subnets["VPC2"]}"
  Subnet10-vpc2       = "${var.My_subnets["Subnet10-vpc2"]}"

  vpc3_cidr           = "${var.My_subnets["VPC3"]}"
  Subnet10-vpc3       = "${var.My_subnets["Subnet10-vpc3"]}"

  vpc4_cidr           = "${var.My_subnets["VPC4"]}"
  Subnet10-vpc4       = "${var.My_subnets["Subnet10-vpc4"]}"

  vpcBR_cidr          = "${var.My_subnets["VPCBR"]}"
  Subnet10-vpcBR      = "${var.My_subnets["Subnet10-vpcBR"]}"
  Subnet20-vpcBR      = "${var.My_subnets["Subnet20-vpcBR"]}"

  region              = "${var.SDDC_region}"


  TGW_A_id            = "${module.TGW.TGW_A_id}"
  TGW_B_id            = "${module.TGW.TGW_B_id}"

}
/*================
Create EC2s
=================*/
module "EC2s" {

  source = "../EC2s"

  VM_AMI              = "${var.VM_AMI}"

  Subnet10-vpc1       = "${module.VPCs.Subnet10-vpc1}"
  Subnet10-vpc1-base  = "${var.My_subnets["Subnet10-vpc1"]}"

  Subnet10-vpc2       = "${module.VPCs.Subnet10-vpc2}"
  Subnet10-vpc2-base  = "${var.My_subnets["Subnet10-vpc2"]}"

  Subnet10-vpc3       = "${module.VPCs.Subnet10-vpc3}"
  Subnet10-vpc3-base  = "${var.My_subnets["Subnet10-vpc3"]}"

  Subnet10-vpc4       = "${module.VPCs.Subnet10-vpc4}"
  Subnet10-vpc4-base  = "${var.My_subnets["Subnet10-vpc4"]}"


  GC-SG-VPC1          = "${module.VPCs.GC-SG-VPC1}"
  GC-SG-VPC2          = "${module.VPCs.GC-SG-VPC2}"
  GC-SG-VPC3          = "${module.VPCs.GC-SG-VPC3}"
  GC-SG-VPC4          = "${module.VPCs.GC-SG-VPC4}"


  key_pair            = "${var.key_pair}"

}


/*================
Create TGW
=================*/

module "TGW" {
  source = "../TGW"

  VPC1_id             = "${module.VPCs.VPC1_id}"
  VPC2_id             = "${module.VPCs.VPC2_id}"
  VPC3_id             = "${module.VPCs.VPC3_id}"
  VPC4_id             = "${module.VPCs.VPC4_id}"
  
  Subnet10-vpc1       = "${module.VPCs.Subnet10-vpc1}"
  Subnet10-vpc2       = "${module.VPCs.Subnet10-vpc2}"
  Subnet10-vpc3       = "${module.VPCs.Subnet10-vpc3}"
  Subnet10-vpc4       = "${module.VPCs.Subnet10-vpc4}"
  
  VPCBR_id            = "${module.VPCs.VPCBR_id}"
  Subnet10-vpcBR      = "${module.VPCs.Subnet10-vpcBR}"
  Subnet20-vpcBR      = "${module.VPCs.Subnet20-vpcBR}"

  AWS_ASN_A           = "${var.AWS_ASN_A}"
  AWS_ASN_B           = "${var.AWS_ASN_B}"


}

