resource "aws_instance" "prod" {
    ami = "ami-0492447090ced6eb5"
    instance_type = "t2.micro"
    key_name = "hyd"
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.allow_traffic.id]
    tags = {
      Name = "myec2"
    }

  
}