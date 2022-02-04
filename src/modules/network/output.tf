output "vpc_id" {
  description = "Id of the VPC"
  value       = aws_vpc.vpc_main.id 
}

output "public_subnet1_id" {
  description = "Id of public subnet 1"
  value       = aws_subnet.public_subnet1.id
}

output "public_subnet2_id" {
  description = "Id of public subnet 2"
  value       = aws_subnet.public_subnet2.id
}