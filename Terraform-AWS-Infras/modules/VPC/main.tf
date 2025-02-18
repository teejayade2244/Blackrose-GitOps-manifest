#create a VPC
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block 
  tags = {
    Name = "main"
  }
}

#subnet creation
#public subnets
#Each subnet is assigned to a different Availability Zone (AZ) to ensure high availability.
resource "aws_subnet" "public_subnets" {
  for_each = var.Public_subnets
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  map_public_ip_on_launch = true  #Allows EC2 instances in these subnets to be publicly accessible.
  tags = {
    Name = each.key
  }
}

#private subnets
resource "aws_subnet" "private_subnets" {
  for_each = var.Private_subnets
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags = {
    Name = each.key
  }
}