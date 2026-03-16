# subnets publicas

resource "aws_subnet" "eks_subnet_public_1a" {
  # vpc vinculada
  vpc_id = aws_vpc.eks_vpc.id

  #faixa disponivel, uso o cidrsubnet para pegar um range diferente na mesma faixa
  cidr_block = cidrsubnet(var.cidr_block, 8, 1)

  # datacenter
  availability_zone = "${data.aws_region.current.name}a"

  # apenas subnets publicas terão essa configuração, devido que elas terão um ipv4 exposto 
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-subnet-pub-1a"
      # essa tag faz com que o AWS Load Balancer funcione corretamente com o k8s
      "kubernetes.io/role/elb" = 1
    }
  )
}

resource "aws_subnet" "eks_subnet_public_1b" {
  # vpc vinculada
  vpc_id = aws_vpc.eks_vpc.id

  #faixa disponivel, uso o cidrsubnet para pegar um range diferente na mesma faixa
  cidr_block = cidrsubnet(var.cidr_block, 8, 2)

  # datacenter
  availability_zone = "${data.aws_region.current.name}b"

  # apenas subnets publicas terão essa configuração, devido que elas terão um ipv4 exposto 
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-subnet-pub-1b"
      # essa tag faz com que o AWS Load Balancer funcione corretamente com o k8s
      "kubernetes.io/role/elb" = 1
    }
  )
}

# associação das route tables com as subnets
resource "aws_route_table_association" "eks_rtb_assoc_pub_1a" {
  subnet_id      = aws_subnet.eks_subnet_public_1a
  route_table_id = aws_route_table.eks_pub_route_table
}

resource "aws_route_table_association" "eks_rtb_assoc_pub_1b" {
  subnet_id      = aws_subnet.eks_subnet_public_1b
  route_table_id = aws_route_table.eks_pub_route_table
}
