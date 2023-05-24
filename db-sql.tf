resource "aws_security_group" "db-sql" {
  name        = "allow_sql"
  description = "Allow sql inbound traffic"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description = "SQL from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "db-sql"
  }
}

