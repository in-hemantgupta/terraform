provider "aws" {
  region= "ap-south-1"
}


# variable "name"{
#     type = string
#     default = "vpc_web"
# }

# resource "aws_vpc" "vpc_web" {
#     cidr_block="10.0.0.0/24"
#     tags = {
#       Name = var.name
#     }
# }

resource "aws_instance" "dbserver" {
  ami="ami-0d2986f2e8c0f7d01"
  instance_type = "t2.micro"
  tags = {
    Name:"dbserver"
  }
}

resource "aws_instance" "webserver" {
  ami="ami-0d2986f2e8c0f7d01"
  instance_type = "t2.micro"
  tags = {
    Name = "webserver"
  }
  user_data = file("server-script.sh")
  security_groups = [ aws_security_group.webTraffic.name ]
}

resource "aws_eip" "webstaticip" {
  instance = aws_instance.webserver.id
}

variable "ingressrules" {
  type = list(number)
  default = [443,80]
}

variable "egressrules" {
  type = list(number)
  default = [443,80]
}


resource "aws_security_group" "webTraffic" {
  name = "Allow HTTPS"
  dynamic ingress  {
    iterator = port
    for_each = var.ingressrules
    content {
        cidr_blocks = [ "0.0.0.0/0" ]
        description = "Test SG"
        from_port = port.value
        protocol         = "tcp"
        to_port = port.value
        self = false
        ipv6_cidr_blocks = ["::/0"]
        security_groups=[]
        prefix_list_ids=[]
    }
  }

  dynamic egress {
    iterator = port
    for_each = var.egressrules
    content {
        cidr_blocks = [ "0.0.0.0/0" ]
        protocol         = "tcp"
        description = "Test SG"
        from_port = port.value
        to_port = port.value
        self = false
        ipv6_cidr_blocks = ["::/0"]
        security_groups=[]
        prefix_list_ids=[]
    }
  }
}



output "webstaticip"{
    value=aws_eip.webstaticip.public_ip
}