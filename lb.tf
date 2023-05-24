resource "aws_lb" "my-lb" {
  name               = "my-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my-sg.id]
  subnets            = [aws_subnet.my-pub-sub.id, aws_subnet.my-pub-1sub.id]
}

resource "aws_lb_target_group_attachment" "attachment" {
  target_group_arn = aws_lb_target_group.my-tg.arn
  target_id        = aws_instance.my-ec2-1a.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attachment1" {
  target_group_arn = aws_lb_target_group.my-tg.arn
  target_id        = aws_instance.my-ec2-1b.id
  port             = 80
}

resource "aws_lb_listener" "external-elb" {
  load_balancer_arn = aws_lb.my-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-tg.arn
  }
}
