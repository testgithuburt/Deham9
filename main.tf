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
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"  

  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"  

  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_2"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-west-2a"  

  tags = {
    Name = "private_subnet_1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-west-2b"  

  tags = {
    Name = "private_subnet_2"
  }
}

# Creating Internet Gateway

resource "aws_internet_gateway" "my_gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my_gw"
  }
} 
# Creating route table
resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route = []

  tags = {
    Name = "my_rt"
  }
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


# EC2 Instances
  
# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 3.27"
#     }
#   }

#   required_version = ">= 0.14.9"
# }


# #Provider profile and region in which all the resources will create
# provider "aws" {
#   profile = "default"
#   region  = "us-west-2"
# }

# resource "aws_instance" "terraform" {
#   ami           = "ami-09100e341bda441c0" # This is an example Amazon Linux AMI ID. Change it according to your requirements.
#   instance_type = "t2.micro"
#   key_name      = "terra-key"   # Change this to your AWS key pair name

#   tags = {
#     Name = "terraform-instance"
#   }
# }

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

