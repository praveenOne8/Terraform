# ~~~~~~~~~~~~~~~~~  custom Network Creation  ~~~~~~~~~~~~~~~~~~~~  #
# create VPC
resource "aws_vpc" "custom" {
    cidr_block = "10.0.0.0/24"
    tags = {
        Name = "tfvpc"
    }

}

# Create internet gateway and attach vpc

resource "aws_internet_gateway" "custom" {
    vpc_id = aws_vpc.custom.id
    tags = {
      Name = "cust_ig"
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

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.custom.id
    availability_zone = "us-east-1b"
    cidr_block = "10.0.1.0/24"
    tags = {
      Name = "privatesub1"
    }
  
}

# Create Route Table and attach t0 ig using edit routes
resource "aws_route_table" "custom" {
    vpc_id = aws_vpc.custom.id

route {
    gateway_id = aws_internet_gateway.custom.id
    cidr_block = "0.0.0.0/0"

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