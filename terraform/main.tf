resource "aws_instance" "ec2_instance" {
    ami             = "${var.ami}"
    instance_type   = "${var.instance_type}"
    key_name        = "${var.key_name}"
    security_groups = ["${aws_security_group.mysql_allow_ssh.id}"]
    subnet_id          = "${var.subnet_id}"
    
    user_data = "${file("userdata/userdata.sh")}"
    tags = "${merge(
        map("Name", "mysql instance")
    )}"

    volume_tags = "${merge(
        map("Name", "mysql instance")
    )}"



}

resource "aws_security_group" "mysql_allow_ssh" {
    name        = "mysql_allow_ssh"
    description = "Allow SSH inbound traffic"
    vpc_id      = "${var.vpc_id}"
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
     
}

