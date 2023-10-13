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

resource "aws_subnet" "public_subnet1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"  
  availability_zone = "us-west-1a"  

  tags = {
    Name = "my-subnet"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"  
  availability_zone = "us-west-2a"  

  tags = {
    Name = "my-subnet"
  }
}


resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.3.0/24"  
  availability_zone = "us-west-1b"  

  tags = {
    Name = "my-subnet"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.4.0/24"  
  availability_zone = "us-west-2b"  

  tags = {
    Name = "my-subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-subnet"
  }
} 

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my_vpc.id

  route = []

  tags = {
    Name = "my-subnet"
  }
}


# ec2 
  
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

resource "aws_subnet" "my_vpc" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "my-subnet"
  }
}

# s3bucket

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
