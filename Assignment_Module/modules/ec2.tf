variable "ec2name" {
  type = string
  description = "Please enter ec2 name"
}

resource "aws_instance" "ec2" {
  ami="ami-0d2986f2e8c0f7d01"
  instance_type="t2.micro"
  tags = {
      Name:var.ec2name
  }
}

#elastic ip will remain same even after restart of ec2
resource "aws_eip" "elasticip" {
  instance = aws_instance.ec2.id
}

output "eip"{
    value=aws_eip.elasticip.public_ip
}