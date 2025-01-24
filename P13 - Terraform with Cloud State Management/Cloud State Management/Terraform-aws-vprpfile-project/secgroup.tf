resource "aws_security_group" "vprofile-bean-elb-sg" {
  name        = "vprofile-bean-elb-sg"
  description = "Security Group for Elatic BeanStalk"
  vpc_id      = module.vpc.vpc_id
  tags = {
    Name      = "vprofile-bean-elb"
    Project   = "Vprofile"
    ManagedBy = "Terraform"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_forELB" {
  security_group_id = aws_security_group.vprofile-bean-elb-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allowAllOutBound_ipv4forELB" {
  security_group_id = aws_security_group.vprofile-bean-elb-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allowAllOutBound_ipv6forELB" {
  security_group_id = aws_security_group.vprofile-bean-elb-sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
}

resource "aws_security_group" "vprofile-bastion-sg" {
  name        = "vprofile-bastion-sg"
  description = "Security Group for Bastion EC2 Instance"
  vpc_id      = module.vpc.vpc_id
  tags = {
    Name      = "vprofile-bastion-sg"
    Project   = "Vprofile"
    ManagedBy = "Terraform"
  }
}

resource "aws_vpc_security_group_ingress_rule" "sshFromMyIPforBastion" {
  security_group_id = aws_security_group.vprofile-bastion-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allowAllOutBound_ipv4forBastion" {
  security_group_id = aws_security_group.vprofile-bastion-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allowAllOutBound_ipv6forBastion" {
  security_group_id = aws_security_group.vprofile-bastion-sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
}

resource "aws_security_group" "vprofile-prodbean-sg" {
  name        = "vprofile-prodbean-sg"
  description = "Security Group for BeanStalk Instance"
  vpc_id      = module.vpc.vpc_id
  tags = {
    Name      = "vprofile-prodbean-sg"
    Project   = "Vprofile"
    ManagedBy = "Terraform"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_fromELB" {
  security_group_id            = aws_security_group.vprofile-prodbean-sg.id
  referenced_security_group_id = aws_security_group.vprofile-bean-elb-sg.id
  ip_protocol                  = "tcp"
  from_port                    = 80
  to_port                      = 80
}

resource "aws_vpc_security_group_ingress_rule" "sshFromAnyWhere" {
  security_group_id = aws_security_group.vprofile-prodbean-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allowAllOutBound_ipv4forBastInst" {
  security_group_id = aws_security_group.vprofile-prodbean-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allowAllOutBound_ipv6forBastInst" {
  security_group_id = aws_security_group.vprofile-prodbean-sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
}

resource "aws_security_group" "vprofile-backend-sg" {
  name        = "vprofile-backend-sg"
  description = "Security Group for AWS RDS, Elastic Cache and Rabbit MQ"
  vpc_id      = module.vpc.vpc_id
  tags = {
    Name      = "vprofile-backend-sg"
    Project   = "Vprofile"
    ManagedBy = "Terraform"
  }
}

resource "aws_vpc_security_group_ingress_rule" "AllowAllFromBeanInstance" {
  security_group_id            = aws_security_group.vprofile-backend-sg.id
  referenced_security_group_id = aws_security_group.vprofile-prodbean-sg.id
  ip_protocol                  = "tcp"
  from_port                    = 0
  to_port                      = 65535
}

resource "aws_vpc_security_group_ingress_rule" "Allow3306FromBeanInstance" {
  security_group_id            = aws_security_group.vprofile-backend-sg.id
  referenced_security_group_id = aws_security_group.vprofile-bastion-sg.id
  ip_protocol                  = "tcp"
  from_port                    = 3306
  to_port                      = 3306
}

resource "aws_vpc_security_group_egress_rule" "allowAllOutBound_ipv4forbackend" {
  security_group_id = aws_security_group.vprofile-backend-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allowAllOutBound_ipv6forbackend" {
  security_group_id = aws_security_group.vprofile-backend-sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "BackendSec_group_allow_itself" {
  security_group_id            = aws_security_group.vprofile-backend-sg.id
  referenced_security_group_id = aws_security_group.vprofile-backend-sg.id
  ip_protocol                  = "tcp"
  from_port                    = 0
  to_port                      = 65535
}