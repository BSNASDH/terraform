# Creating RDS Instance
resource "aws_db_instance" "my-rds" {
  allocated_storage    = 10
  db_subnet_group_name = aws_db_subnet_group.my-subnet.id
  engine               = "mysql"
  engine_version       = "5.7.37"
  instance_class       = "db.t2.micro"
  db_name              = "mydb"
  username             = "admin"
  password             = "admin123"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.db-sql.id]
}

resource "aws_db_subnet_group" "my-subnet" {
  name       = "db subnet group"
  subnet_ids = [aws_subnet.my-pvt-sub.id, aws_subnet.my-pvt-1sub.id]

  tags = {
    Name = "db subnet group"
  }
}

outputs "lb_dns_name" {
  description = "my-lb-1552007277.us-east-1.amazonaws.com"
  value       = aws_lb.my-lb.dns_name
}
