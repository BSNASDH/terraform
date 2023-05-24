outputs "lb_dns_name" {
  description = "my-lb-1552007277.us-east-1.amazonaws.com"
  value       = aws_lb.my-lb.dns_name
}

output "lb_dns_name" {
     description = "lb dns address"
     value       = aws_lb.my-lb.dns_name
}     
