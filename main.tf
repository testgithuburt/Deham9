# resource "aws_instance" "ec2_instance" {
#   ami=var.AMIS[var.AWS_REGION] 
#   instance_type = "t2.micro"
#   associate_public_ip_address = true
#   tags = {
#     Name = "Terraform_test_ec2"
#   }
# }
# output public_ip{
#   value=aws_instance.ec2_instance.public_ip
# }
# resource "aws_instance" "webserver" {
#   for_each = var.webservers
#     ami=var.AMIS[var.AWS_REGION] 
#     instance_type = "t2.micro"
#     associate_public_ip_address = true
#     tags = {
#       Name = each.value["name"]
#     }
# }
# Create Public Subnet 1
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = var.vpc
  cidr_block              = var.public_cidr_1
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}
# Create Private Subnet 1
resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = var.vpc
  cidr_block              = var.private_cidr_1
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-1"
  }
}

# create Public Subnet 2
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = var.vpc
  cidr_block              = var.public_cidr_2
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}

# Create Private Subnet 2
resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = var.vpc
  cidr_block              = var.private_cidr_2
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-2"
  }
}





