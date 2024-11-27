output "dev" {
  description = "print public ip"
  value = aws_instance.dev.public_ip
}