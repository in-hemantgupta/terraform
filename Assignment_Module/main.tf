provider "aws" {
  region="ap-south-1"
}

module "ec2module" {
   source = "./modules" 
   ec2name = "testec2"
}

output "ec2ip" {
 value = module.ec2module.eip
}