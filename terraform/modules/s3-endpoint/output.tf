output "s3_endpoint_id" {
  value = aws_vpc_endpoint.s3.id
}

output "s3_endpoint_state" {
  value = aws_vpc_endpoint.s3.state
}