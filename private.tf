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