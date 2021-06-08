provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "jenkins_instance" {
    ami               = "ami-0d5eff06f840b45e9"
    instance_type     = "t2.micro"
    associate_public_ip_address = true
    vpc_security_group_ids  = ["${aws_security_group.jenkins_security.id}"]
    key_name          = "jenkins"
    user_data         = file("./config.sh")

    tags = {
        Name = "jenkins_instance"
    }
}

resource "aws_security_group" "jenkins_security" {
    name = "jenkins_security"
    
    ingress {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 8080
        to_port   = 8080
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port   = 0
        protocol  = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
