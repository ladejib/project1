# GET EC2 USER NAME AND PUBLIC IP 
output "SERVER-SSH-ACCESS" {
  value = "ubuntu@${aws_instance.my-ec2.public_ip}"
}

# GET APP URL 
output "APP_URL" {
  value = "http://${aws_instance.my-ec2.public_ip}:5000"
}

# GET LOKI/METRICS URL 
output "LOKI_METRICS_URL" {
  value = "http://${aws_instance.my-ec2.public_ip}:3100/metrics"
}

# GET LOKI/READY URL 
output "LOKI_READY_URL" {
  value = "http://${aws_instance.my-ec2.public_ip}:3100/ready"
}

# GET PROMETHEUS URL 
output "PROMETHEUS" {
  value = "http://${aws_instance.my-ec2.public_ip}:9090"
}


# GET grafana URL 
output "grafana" {
  value = "http://${aws_instance.my-ec2.public_ip}:3000"
}

# GET EC2 PUBLIC IP 
output "PUBLIC-IP" {
  value = aws_instance.my-ec2.public_ip
}
