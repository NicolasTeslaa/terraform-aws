locals {
  # essas tags são variaveis locais que serão usadas para popular varios recursos diferentes, assim: se 
  # precisar adicionar uma variavel em todos os recursos, pode só adicionar abaixo
  tags = {
    Department   = "DevOps"
    Organization = "Infrastructure and Operations"
    Project      = "EKS"
    Environment  = "Development"
  }
}