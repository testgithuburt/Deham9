# Security Group Creation for provisionerVPC
resource "aws_security_group" "dev_terraform_sg_allow_ssh_http"{
    name="dev-sg"
    vpc_id = var.vpc
}
# Ingress Security Port 22 (Inbound)
resource "aws_security_group_rule" "ssh_ingress_access"{
    from_port = 22
    protocol = "tcp"
    security_group_id = aws_security_group.dev_terraform_sg_allow_ssh_http.id
    to_port = 22
    type = "ingress"
    cidr_blocks = [var.cidr_blocks]
}
# Ingress Security Port 80 (Inbound)
resource "aws_security_group_rule" "http_ingress_access"{
    from_port = 80
    protocol = "tcp"
    security_group_id = aws_security_group.dev_terraform_sg_allow_ssh_http.id
    to_port = 80
    type = "ingress"
    cidr_blocks = [var.cidr_blocks]
}
# Ingress Security Port 80 (Inbound)
resource "aws_security_group_rule" "https_ingress_access"{
    from_port = 443
    protocol = "tcp"
    security_group_id = aws_security_group.dev_terraform_sg_allow_ssh_http.id
    to_port = 443
    type = "ingress"
    cidr_blocks = [var.cidr_blocks]
}
# Ingress Security Port 3306 (Inbound)
resource "aws_security_group_rule" "rds_ingress_access"{
    from_port = 3306
    protocol = "tcp"
    security_group_id = aws_security_group.dev_terraform_sg_allow_ssh_http.id
    to_port = 3306
    type = "ingress"
    cidr_blocks = [var.cidr_blocks]
}
# All egress/outbound Access
resource "aws_security_group_rule" "all_egress_access"{
    from_port = 0
    protocol = "-1"
    security_group_id = aws_security_group.dev_terraform_sg_allow_ssh_http.id
    to_port = 0
    type = "egress"
    cidr_blocks = [var.cidr_blocks]
}
