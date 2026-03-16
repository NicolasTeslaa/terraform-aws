# subnets privadas

resource "aws_subnet" "eks_subnet_private_1a" {
  # vpc vinculada
  vpc_id = aws_vpc.eks_vpc.id

  #faixa disponivel, uso o cidrsubnet para pegar um range diferente na mesma faixa
  cidr_block = cidrsubnet(var.cidr_block, 8, 4)

  # datacenter
  availability_zone = "${data.aws_region.current.name}a"

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-subnet-priv-1a"
      # essa tag faz com que o AWS Load Balancer funcione corretamente com o k8s
      "kubernetes.io/role/internal-elb" = 1
    }
  )
}

resource "aws_subnet" "eks_subnet_private_1b" {
  # vpc vinculada
  vpc_id = aws_vpc.eks_vpc.id

  #faixa disponivel, uso o cidrsubnet para pegar um range diferente na mesma faixa
  cidr_block = cidrsubnet(var.cidr_block, 8, 6)

  # datacenter
  availability_zone = "${data.aws_region.current.name}b"

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-subnet-priv-1b"
      # essa tag faz com que o AWS Load Balancer funcione corretamente com o k8s
      "kubernetes.io/role/internal-elb" = 1
    }
  )
}


# associação das route tables com as subnets
resource "aws_route_table_association" "eks_rtb_assoc_priv_1a" {
  subnet_id      = aws_subnet.eks_subnet_private_1a.id
  route_table_id = aws_route_table.eks_priv_route_table-1a.id
}

resource "aws_route_table_association" "eks_rtb_assoc_priv_1b" {
  subnet_id      = aws_subnet.eks_subnet_private_1b.id
  route_table_id = aws_route_table.eks_priv_route_table-1b.id
}