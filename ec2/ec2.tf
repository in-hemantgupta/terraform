provider "aws" {
  region="ap-south-1"
}

resource "aws_instance" "ec2" {
  ami="ami-0d2986f2e8c0f7d01"
  instance_type="t2.micro"
  tags = {
      "name":"test_ec2"
  }
}

#elastic ip will remain same even after restart of ec2
resource "aws_eip" "elasticip" {
  instance = aws_instance.ec2.id
}

output "eip"{
    value=aws_eip.elasticip.public_ip
}