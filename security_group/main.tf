provider "aws" {
  region="ap-south-1"
}

resource "aws_instance" "ec2" {
  ami="ami-0d2986f2e8c0f7d01"
  instance_type="t2.micro"
  tags = {
      "name":"test_ec2"
  }
  security_groups = [ aws_security_group.webTraffic.name ]
}


resource "aws_security_group" "webTraffic" {
  name = "Allow HTTPS"
  ingress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Test SG"
    from_port = 443
    protocol         = "tcp"
    to_port = 443
     self = false
    ipv6_cidr_blocks = ["::/0"]
    security_groups=[]
    prefix_list_ids=[]
  } ]

  egress = [ {
     cidr_blocks = [ "0.0.0.0/0" ]
     protocol         = "tcp"
    description = "Test SG"
    from_port = 443
    to_port = 443
    self = false
    ipv6_cidr_blocks = ["::/0"]
    security_groups=[]
    prefix_list_ids=[]
  } ]
}


output "eip"{
    value=aws_instance.ec2.public_ip
}