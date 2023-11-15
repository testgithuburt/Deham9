# Network ACL in VPC 
resource "aws_network_acl" "nacl" {
  vpc_id = var.vpc 
}
resource "aws_network_acl_rule" "allow_all_inbound" {
  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 100
  protocol       = -1
  rule_action    = "allow"
  egress         = false
  cidr_block     = aws_subnet.public_subnet_1.cidr_block
}
resource "aws_network_acl_rule" "allow_all_outbound" {
  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 100
  protocol       = -1
  rule_action    = "allow"
  egress         = true
  cidr_block     = aws_subnet.public_subnet_2.cidr_block
}
