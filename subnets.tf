resource "aws_subnet" "my-pub-sub" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.0.0/22"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "MY-PUB-SUB"
  }
}

resource "aws_subnet" "my-pvt-sub" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.4.0/22"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "MY-PVT-SUB"
  }
}

resource "aws_subnet" "my-pub-1sub" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.8.0/21"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "MY-PUB-1SUB"
  }
}

resource "aws_subnet" "my-pvt-1sub" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.16.0/20"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "MY-PVT-1SUB"
  }
}
