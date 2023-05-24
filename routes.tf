resource "aws_route_table" "my-pub-rt" {
  vpc_id = aws_vpc.my-vpc.id

   tags = {
    Name = "MY-PUB-RT"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.my-pub-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my-igw.id
}

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
