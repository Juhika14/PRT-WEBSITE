provider "aws" {
        region = "us-east-2"
        access_key = ""     ## Add your key
        secret_key = ""
}

# Creating VPC
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "PRT-VPC"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "PRT_IGW"
  }
}

# Subnet
resource "aws_subnet" "my_subnet" {
  vpc_id                 = aws_vpc.myvpc.id
  cidr_block             = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

# Route Table
resource "aws_route_table" "myrt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }

  tags = {
    Name = "PRT-RT"
  }
}

# Route Table Association
resource "aws_route_table_association" "myrta" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.myrt.id
}

# Security Group
resource "aws_security_group" "mysg" {
  name        = "my-sg"
  description = "This is my security group"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "PRT-SG"
  }
}

# Instances
resource "aws_instance" "inst1" {
  ami           = ""  # Add your AMI ID
  instance_type = "t2.medium"
  key_name      = "richa"
  subnet_id     = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.mysg.id]

  tags = {
    Name = "J-M"
  }
}

resource "aws_instance" "inst2" {
  ami           = ""  # Add your AMI ID
  instance_type = "t2.medium"
  key_name      = "richa"
  subnet_id     = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.mysg.id]

  tags = {
    Name = "K-M"
  }
}

resource "aws_instance" "inst3" {
  ami           = ""  # Add your AMI ID
  instance_type = "t2.medium"
  key_name      = "richa"
  subnet_id     = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.mysg.id]

  tags = {
    Name = "K-S"
  }
}
