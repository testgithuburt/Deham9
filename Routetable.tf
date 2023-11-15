#creating Public Route Table
resource "aws_route_table" "public_route"{
    vpc_id = var.vpc
    route {
        cidr_block = var.cidr_blocks
        gateway_id = aws_internet_gateway.gw.id
    }
    tags = {
      Name = "dev-public-route"  
    }
}
# Associate Public Subnet to Public Route Table
resource "aws_route_table_association" "public_subnet_1_assoc"{
    count = 1
    route_table_id = aws_route_table.public_route.id
    subnet_id = aws_subnet.public_subnet_1.id
    depends_on = [aws_route_table.public_route,aws_subnet.public_subnet_1]    
}
#creating  Private Route Table
resource "aws_route_table" "private_route"{
    vpc_id = var.vpc
    route {
        cidr_block = var.cidr_blocks
        gateway_id = aws_internet_gateway.gw.id
    }
    tags = {
      Name = "dev-private-route"  
    }
}
# Associate Private Subnet to Private Route Table
resource "aws_route_table_association" "private_subnet_1_assoc"{
    count = 1
    route_table_id = aws_route_table.private_route.id
    subnet_id = aws_subnet.private_subnet_1.id
    depends_on = [aws_route_table.private_route,aws_subnet.private_subnet_1]    
}