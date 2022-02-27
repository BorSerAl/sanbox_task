/*
    security group for Ubuntu server
      Allow inbound traffic
*/
resource "aws_security_group" "Ubuntu_security" {
  name        = "Security group for Ubuntu"
  description = "SSH, HTTP, HTTPS, ICMP"

  dynamic "ingress" {
    for_each = ["22", "80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Ubuntu_security_group"
  }
}

/*
      security group for Amazon Linux server
*/

resource "aws_security_group" "Amazon_Linux" {
  name        = "Security group for Amazon_Linux"
  description = "SSH, HTTP, HTTPS, ICMP"

  dynamic "ingress" {
    for_each = ["22", "80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [data.aws_subnet.Default.cidr_block]
    }
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [data.aws_subnet.Default.cidr_block]
  }

  dynamic "egress" {
    for_each = ["22", "80", "443"]
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = [data.aws_subnet.Default.cidr_block]
    }
  }
  egress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [data.aws_subnet.Default.cidr_block]
  }
  tags = {
    Name = "Amazon_Linux_security_group"
  }
}
