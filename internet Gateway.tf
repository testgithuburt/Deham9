# Creating Internet Gateway
resource "aws_internet_gateway" "gw"{
    vpc_id = var.vpc
    tags = {
        Name = "dev-gw"
    }
}