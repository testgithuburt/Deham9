#Load Balancer
resource "aws_lb" "loadBalancer" {
  name                              = "myWebserver-alb"
  internal                          = false
  load_balancer_type                = "application"
  security_groups                   = [aws_security_group.dev_terraform_sg_allow_ssh_http.id]
  subnets                           = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  enable_deletion_protection        = false
    tags = {
        Environment                 = "production"
  }
}
#Target Group
resource "aws_lb_target_group" "target-group" {
  name                              = "CPUtest-tg"
  port                              = 80
  protocol                          = "HTTP"
  vpc_id                            = var.vpc
}
#Listener
resource "aws_lb_listener" "listener" {
  load_balancer_arn                 = aws_lb.loadBalancer.arn
  port                              = 80
  protocol                          = "HTTP"
  default_action {
    type                            = "forward"
    target_group_arn                = aws_lb_target_group.target-group.arn
  }
}
