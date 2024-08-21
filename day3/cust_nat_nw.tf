# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~Create custom network ~~~~~~~~~~~~~~~~~~~~~~~~~~#
# create vpc
# create public subnet 
# create private subnet
# create nat gateway


# create VPC
resource "aws_vpc" "custom" {
    cidr_block = "10.0.0.0/24"
    tags = {
        Name = "tfvpc"
    }

}


# Create subnets
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.custom.id
    availability_zone = "us-east-1a"
    cidr_block = "10.0.0.0/24"
    tags = {
      Name = "pubsub1"
    }

}

# create NAT GAteway
resource "aws_nat_gateway" "cust" {
    subnet_id = aws_subnet.public.id
    #allocation_id =
  
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.custom.id
    availability_zone = "us-east-1b"
    cidr_block = "10.0.1.0/24"
    tags = {
      Name = "privatesub1"
    }
  
}


# Create security groups

resource "aws_security_group" "allow_traffic" {
    name = "allow_traffic"
    vpc_id = aws_vpc.custom.id
    tags = {
      Name = "cust_sg"
    }


ingress {
    description = " allow traffic from vpc "
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
    

ingress  {
    description = "allow traffic from vpc"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

    
egress  {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
  
}