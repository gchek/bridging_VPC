/*================
REGIONS map:
==================
us-east-1	    US East (N. Virginia)
us-east-2	    US East (Ohio)
us-west-1	    US West (N. California)
us-west-2	    US West (Oregon)
ca-central-1	Canada (Central)
eu-west-1	    EU (Ireland)
eu-central-1	EU (Frankfurt)
eu-west-2	    EU (London)
ap-northeast-1	Asia Pacific (Tokyo)
ap-northeast-2	Asia Pacific (Seoul)
ap-southeast-1	Asia Pacific (Singapore)
ap-southeast-2	Asia Pacific (Sydney)
ap-south-1	    Asia Pacific (Mumbai)
sa-east-1	    South America (São Paulo)
=================*/


/*================
AWS Credentials, region and Key-pair in that region
Data Base credentials
=================*/
variable "access_key"   {}
variable "secret_key"   {}
variable "SDDC_region"  {default = "eu-central-1"}
variable "key_pair"     {default = "my-fra-key" }

/*================
Subnets IP ranges
=================*/
variable "My_subnets" {
  default = {

    VPC1                = "172.201.0.0/16"
    Subnet10-vpc1       = "172.201.10.0/24"
    Subnet20-vpc1       = "172.201.20.0/24"
    Subnet30-vpc1       = "172.201.30.0/24"

    VPC2                = "172.202.0.0/16"
    Subnet10-vpc2       = "172.202.10.0/24"
    Subnet20-vpc2       = "172.202.20.0/24"
    Subnet30-vpc2       = "172.202.30.0/24"

    VPC3                = "172.203.0.0/16"
    Subnet10-vpc3       = "172.203.10.0/24"
    Subnet20-vpc3       = "172.203.20.0/24"
    Subnet30-vpc3       = "172.203.30.0/24"

    VPC4                = "172.204.0.0/16"
    Subnet10-vpc4       = "172.204.10.0/24"
    Subnet20-vpc4       = "172.204.20.0/24"
    Subnet30-vpc4       = "172.204.30.0/24"

    VPCBR               = "10.100.0.0/16"
    Subnet10-vpcBR      = "10.100.10.0/24"
    Subnet20-vpcBR      = "10.100.20.0/24"

  }
}


/*================
VM AMIs
=================*/
variable "VM_AMI"               { default = "ami-0d4c3eabb9e72650a" } # Amazon Linux 2 AMI (HVM), SSD Volume Type - Frankfurt

variable "AWS_ASN_A"              {default = "64512"}
variable "AWS_ASN_B"              {default = "64514"}


