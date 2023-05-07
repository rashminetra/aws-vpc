resource "aws_subnet" "eks_public_subnets" {
  count                   = length(var.azs)
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = element(var.public_subnets, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element((var.azs), count.index)

 tags = {
    Name = format("%v-%v-vpc",var.environment, var.owner)
  }
}

resource "aws_subnet" "eks_private_subnets" {
  count             = length(var.azs)
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = element((var.private_subnets), count.index)
  availability_zone = element((var.azs), count.index)

  tags = {
    Name = format("%v-%v-private-subnet",var.environment, var.owner)
  }
}