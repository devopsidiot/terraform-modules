output "ip" {
  value = aws_eip.eip.*.public_ip
}
output "id" {
  value = aws_eip.eip.*.id
}
