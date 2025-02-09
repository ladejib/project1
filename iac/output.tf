# GET EC2 USER NAME AND PUBLIC IP 
output "SERVER-SSH-ACCESS" {
  value = "ubuntu@${aws_instance.my-ec2.public_ip}"
}

# GET EC2 PUBLIC IP 
output "PUBLIC-IP" {
  value = "${aws_instance.my-ec2.public_ip}"
}

# GET EC2 PRIVATE IP 
output "PRIVATE-IP" {
  value = "${aws_instance.my-ec2}"
}