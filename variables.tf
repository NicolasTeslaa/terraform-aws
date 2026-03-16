# após rodar o terraform plan
# o console vai solicitar o valor de todas as variaveis abaixo, quem podem ser utilizadas em diversos arquivos
# ou posso rodar "terraform plan -var 'cidr_block=10.0.0.0/16'" que ele já vai preencher corretamente 
# o valor das variaveis tambem podem ficar no arquivo terraform.tfvars
# para o terraform pegar as variaveis desse arquivo precisa rodar:
# terraform plan -var-file terraform.tfvars
variable "cidr_block" {
  type        = string
  description = "Networking CIDR block to be used for the VPC"
}

variable "project_name" {
  type        = string
  description = "Project Name"
}

variable "tags" {
  type        = map(string)
  description = "Common tags shared by the root module"
}
