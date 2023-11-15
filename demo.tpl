resource "aws_instance" "jenkins-instance"{
    ami=data.aws_ami.packergenericamisjenkins.id
    instance_type=var.instance_type
    key_name= "app"
    vpc_security_group_ids = [aws_security_group.devVPC_sg_allow_ssh_http.id]
    subnet_id = aws_subnet.devVPC_public_subnet.id
template_file
    user_data = data.template_file.init.rendered
    tags = {
        Name = "dev_terraform_jenkins_instance"
    }
}
# The template file data source usually loaded from an external file.
data "template_file" "init" {
    template = file("${path.module}/userdata.tpl")
}