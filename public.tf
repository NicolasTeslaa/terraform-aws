resource "aws_subnet" "eks_subnet_public_1a" {
  # vpc vinculada
  vpc_id = aws_vpc.eks_vpc.id

  #faixa disponivel, uso o cidrsubnet para pegar um range diferente na mesma faixa
  cidr_block = cidrsubnet(var.cidr_block, 8, 1)

  # datacenter
  availability_zone = "${data.aws_region.current.name}a"

  map_public_ip_on_launch = true
  tags = merge(
    local.tags,
    {
      Name = "subnet-1a"
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

  map_public_ip_on_launch = true
  tags = merge(
    local.tags,
    {
      Name = "subnet-1b"
      # essa tag faz com que o AWS Load Balancer funcione corretamente com o k8s
      "kubernetes.io/role/elb" = 1
    }
  )
}