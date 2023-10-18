terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}


#Provider profile and region in which all the resources will create
provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"  

  tags = {
    Name = "my-vpc"
  }
}
# creating public and private subnets 
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"  

  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"  

  map_public_ip_on_launch = false

  tags = {
    Name = "private_subnet"
  }
}

# Creating Internet Gateway

resource "aws_internet_gateway" "my_gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my_gw"
  }
} 
# Public Route Table
resource "aws_route_table" "public_route"{
    vpc_id = aws_vpc.my_vpc.id

    route {
        cidr_block = "10.0.1.0/24"
        gateway_id = aws_internet_gateway.my_gw.id
    }
    tags = {
      Name = "public-route"  
    }
}
# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public_subnet_route" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route.id
}

# Private Route Table
resource "aws_route_table" "private_route"{
    vpc_id = aws_vpc.my_vpc.id

    route {
        cidr_block = "10.0.2.0/24"
        gateway_id = aws_internet_gateway.my_gw.id
    }
    tags = {
      Name = "private-route"  
    }
}

# Associate Private Subnet with Private Route Table
resource "aws_route_table_association" "private_subnet_route" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route.id
}
# NACL 
resource "aws_network_acl" "my_network_acl" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_network_acl_rule" "my_network_acl" {
  network_acl_id = aws_network_acl.my_network_acl.id
  rule_number    = 200
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = aws_vpc.my_vpc.cidr_block
  from_port      = 22
  to_port        = 22
}
# Security Group Creation for provisionerVPC
resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow SSH and http inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id


  # Ingress Security Port 22 (Inbound)
  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.my_vpc.cidr_block]
  }
  # Ingress Security Port 80 (Inbound)
  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.my_vpc.cidr_block]
  }
  # All egress/outbound Access
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tcp"
  }
}

#ec2 creating
# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 3.27"
#     }
#   }

#   required_version = ">= 0.14.9"
# }

#Provider profile and region in which all the resources will create
# provider "aws" {
#   profile = "default"
#   region  = "us-west-2"
# }
resource "aws_instance" "web_server" {
  ami           = "ami-0e2e9c570f999a4c8" # This is an example Amazon Linux AMI ID. Change it according to your requirements.
  instance_type = "t2.micro"
  key_name      = "web-key"   

  tags = {
    Name = "my-web"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "my-subnet"
  }
}


# resource "aws_subnet" "my_vpc" {
#   vpc_id     = aws_vpc.my_vpc.id
#   cidr_block = "10.0.1.0/24"

#   tags = {
#     Name = "my-subnet"
#   }
# }

# creating S3 bucket

# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 3.27"
#     }
#   }

#   required_version = ">= 0.14.9"
# }

#  # #Provider profile and region in which all the resources will create
#  provider "aws" {
#    profile = "default"
#    region  = "us-west-2"
#  }

# #Resource to create s3 bucket
# resource "aws_s3_bucket" "neno-bucket" {
#   bucket = "nb-neno-bucket"
#    tags = {
#     Name        = "My bucket"
#     Environment = "Dev"
#   }

# }

