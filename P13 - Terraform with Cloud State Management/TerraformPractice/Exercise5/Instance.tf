resource "aws_instance" "web" {
  ami                    = var.amiID[var.region]
  instance_type          = "t3.micro"
  key_name               = "dove-key"
  vpc_security_group_ids = [aws_security_group.dove-sg.id]
  availability_zone      = var.zone

  tags = {
    Name    = "Dove-Instance"
    Project = "Dove"
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  connection {
    type        = "ssh"
    user        = var.webuser
    private_key = file("dove")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }
}

resource "aws_ec2_instance_state" "web_state" {
  instance_id = aws_instance.web.id
  state       = "running"
}

output "WebPublicIP"{
  description = "Public IP"
  value = aws_instance.web.public_ip
}

output "WebPrivateIP"{
  description = "Private IP"
  value = aws_instance.web.private_ip
}