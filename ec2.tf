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
  }
}

resource "aws_instance" "my-ec2-1b" {
  ami           = "ami-011996ff98de391d1" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my-pub-1sub.id
  availability_zone       = "us-east-1b"
  key_name      = "project"
  vpc_security_group_ids = [ aws_security_group.my-sg.id ]
  user_data     = file("food.sh")
  
  tags = {
    Name = "my-ec2-1b"
  }
}

