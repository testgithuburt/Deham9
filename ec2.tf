# Instance Configuration
resource "aws_instance" "provisioner-remoteVM"{
    ami = "ami-0e2e9c570f999a4c8"
    instance_type = var.instance_type
    key_name = "app"
    vpc_security_group_ids = [aws_security_group.dev_terraform_sg_allow_ssh_http.id]
    subnet_id = aws_subnet.public_subnet_1.id
    tags = {
        Name = "remote-instance"
    }
    provisioner "remote-exec"{
        inline = [
            "sudo yum update -y",
            "sudo yum install -y nginx",
            "sudo service nginx start"
        ]
        on_failure = continue
    }
    provisioner "local-exec"{
        #ami=data.aws_ami.packeramis.id
        #instance_type="t2.micro"
        #when = "destroy"
        command = "echo Instance Type=${self.instance_type},Instance ID=${self.id},Public DNS=${self.public_dns},AMI ID=${self.ami} >> allinstancedetails"
    }
    connection {
        type = "ssh"
        host = aws_instance.provisioner-remoteVM.public_ip
        user = "ec2-user"
        private_key = file("${path.module}/app.pem")
    }
}