# internet gateway, esse recurso conecta a internet a VPC, permitindo assim o trafego de dados
# apenas redes publicas devem ter um internet gateway vinculado a elas  
resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = merge(
    local.tags, {
      Name = "${var.project_name}-igw"
    }
  )
}

# route table 
resource "aws_route_table" "eks_pub_route_table" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    # rota local
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_igw.id
  }

  tags = merge(
    local.tags, {
      Name = "${var.project_name}-pub-route-table"
    }
  )
}