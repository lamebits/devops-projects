provider "aws" {
    region = "us-east-2"
}
data "aws_ami" "ami_id" {
  most_recent = true
  filter {
    name  = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*"]
  }
  owners = ["099720109477"]
}
output "Instance_ID" {
  description = "AMI ID of Ubuntu"
  value       = data.aws_ami.ami_id.id
}