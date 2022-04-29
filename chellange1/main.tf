provider "aws" {
    region = "ap-south-1"
}

variable "vpcName" {
 type=string
 default="tarrafromVPC"
}

resource "aws_vpc" terraformVPC {
  cidr_block = "192.168.0.0/24"
  tags = {
    "Name" = var.vpcName
  }
}

output "VPC_ID" {
 value  = aws_vpc.terraformVPC.id
}