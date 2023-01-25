output "ec2_instance_frontend" {
    value = aws_instance.FrontEnd.public_ip
}

output "ec2_instance_backend" {
    value = aws_instance.BackendInstance.public_ip
}