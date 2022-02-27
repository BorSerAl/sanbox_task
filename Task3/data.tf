/*
      get ami for Ununtu
*/
data "aws_ami" "Ubuntu" {
  owners      = ["099720109477"]
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu*20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
/*
      ami for Amazon_Linux
*/

data "aws_ami" "Amazon_Linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-2.0.20220207.1-*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
/*
      cidr block of subnet
*/

data "aws_subnet" "Default" {
  filter {
    name   = "tag:Name"
    values = ["Default"]
  }
}

/*
      get ssh key name
*/

data "aws_key_pair" "ssh_key" {
  key_name = "Ser-Winser"
  filter {
    name   = "tag:Name"
    values = ["Mykey"]
  }
}
