provider "aws" {
    region= "ap-south-1"
}

variable "name"{
    type = string
    default = "testvpc1"
}

resource "aws_vpc" "testvpc" {
    cidr_block="10.0.0.0/24"
    tags = {
      Name = var.name
    }
}