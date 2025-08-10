output "public_ip_pu" {
    value = aws_instance.pu_server.public_ip
  
}
output "private_ip_pu" { 
    value = aws_instance.pu_server.private_ip
}
output "private_ip_pv" {
    value = aws_instance.pv_server.private_ip
}