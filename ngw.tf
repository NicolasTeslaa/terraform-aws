
# EIP = Elastic IP é um endereço IPV4 publico estático que vai ser associado aos recursos
# Garante que tenha um ip publico fixo que não muda, extremamente essencial para serviços online
resource "aws_eip" "eks_ngw_eip_1a" {
  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-eip-1a"
    }
  )
}

resource "aws_eip" "eks_ngw_eip_1b" {
  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-eip-1b"
    }
  )
}

# NAT Gateway
# Permite a saida para Internet e bloqueia a entrada direta da intrenet 
# Fluxo de exemplo > EC2 (subnet privada) > nat gateway > internet gateway > internet 
resource "aws_nat_gateway" "eks_ngw_1a" {
  allocation_id = aws_eip.eks_ngw_eip_1a
  subnet_id     = aws_subnet.eks_subnet_public_1a

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-ngw-1a"
    }
  )
}

resource "aws_nat_gateway" "eks_ngw_1b" {
  allocation_id = aws_eip.eks_ngw_eip_1b
  subnet_id     = aws_subnet.eks_subnet_public_1b

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-ngw-1b"
    }
  )
}



# route table privada pra cada aviability
resource "aws_route_table" "eks_priv_route_table-1a" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    # rota local
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.eks_ngw_1a.id
  }

  tags = merge(
    local.tags, {
      Name = "${var.project_name}-priv-route-table-1a"
    }
  )
}

# route table privada pra cada aviability
resource "aws_route_table" "eks_priv_route_table-1b" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    # rota local
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.eks_ngw_1b.id
  }

  tags = merge(
    local.tags, {
      Name = "${var.project_name}-priv-route-table-1b"
    }
  )
}