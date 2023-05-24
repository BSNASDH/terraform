#update provider
#aws as my provider

provider "aws" {
  region     = "us-east-1"
  access_key = "ABC"
  secret_key = "XYZ"
}

# VPC
resource "aws_vpc" "my-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "my-vpc"
  }
}

# Public Subnet
resource "aws_subnet" "my-pub-sub" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.0.0/22"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "MY-PUB-SUB"
  }
}

# Private Subnet
resource "aws_subnet" "my-pvt-sub" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.4.0/22"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "MY-PVT-SUB"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "my-igw"
  }
}

# Public Route Table
resource "aws_route_table" "my-pub-rt" {
  vpc_id = aws_vpc.my-vpc.id

   tags = {
    Name = "MY-PUB-RT"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.my-pub-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id               = aws_internet_gateway.my-igw.id
}

# Private Route Table
resource "aws_route_table" "my-pvt-rt" {
  vpc_id = aws_vpc.my-vpc.id

   tags = {
    Name = "MY-PVT-RT"
  }
}

# Public Route Table Association
resource "aws_route_table_association" "my-pub-association" {
  subnet_id      = aws_subnet.my-pub-sub.id
  route_table_id = aws_route_table.my-pub-rt.id
}

# Private Route Table Association
resource "aws_route_table_association" "my-pvt-association" {
  subnet_id      = aws_subnet.my-pvt-sub.id
  route_table_id = aws_route_table.my-pvt-rt.id
}

# Test SG
resources "aws_security_group" "my-sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "my-sg"
  }
}


resource "aws_key_pair" "project" {
  key_name = "project"
  public_key = tls_private_key.rsa.public_key_openssh
  }
  resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
  }
  resource "local_file" "tf-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "project.pem"
}

# Launch Instance
resource "aws_instance" "my-ec2-1a" {
  ami           = "ami-011996ff98de391d1" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my-pub-sub.id
  availability_zone       = "us-east-1a"
  key_name      = "project"
  vpc_security_group_ids = [ aws_security_group.my-sg.id ]
  user_data     = file("food.sh")
  
  tags = {
    Name = "my-ec2-1a"

#!/bin/bash
sudo yum -y install git
sudo yum -y install httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo git clone https://github.com/BSNASDH/food.git /var/www/html


