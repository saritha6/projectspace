resource "aws_subnet" "my_subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.my_vpc.id
  availability_zone = "us-east-1a"

  tags = {
    Name = "my-subnet"
}
}
