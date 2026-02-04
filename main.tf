provider "aws" {
  region = "eu-north-1" # Stockholm Region
}

# Calling the EC2 Module
module "my_strapi_ec2" {
  source = "./modules/ec2"
}

# Final Output to show on Screen
output "application_url" {
  value = "http://${module.my_strapi_ec2.instance_ip}:1337"
}