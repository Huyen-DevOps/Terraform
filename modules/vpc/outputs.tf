output "vpc_id" {
  value = aws_vpc.main.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

output "public_subnets" {
  value = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}

output "private_subnets" {
  value = [aws_subnet.private_a.id, aws_subnet.private_b.id]
}

output "public_subnet_ids" {
  value = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}

output "private_subnet_ids" {
  value = [aws_subnet.private_a.id, aws_subnet.private_b.id]
}

output "route_table_public_id" {
  value = aws_route_table.public.id
}

output "route_table_public_association_ids" {
  value = [aws_route_table_association.public_a.id, aws_route_table_association.public_b.id]
}

output "route_table_private_id" {
  value = aws_route_table.private.id
}

output "route_table_private_association_ids" {
  value = [aws_route_table_association.private_a.id, aws_route_table_association.private_b.id]
}
