# terraform-aws

Projeto Terraform para provisionar uma base de infraestrutura AWS com foco em EKS.

Hoje a raiz do projeto orquestra os modulos e centraliza configuracoes compartilhadas, enquanto cada modulo cuida de uma parte especifica da infra:

- `network`: VPC, subnets publicas e privadas, internet gateway, NAT gateways e route tables
- `cluster`: EKS cluster e recursos associados
- `managed-node-group`: node group gerenciado do EKS
- `aws-load-balancer-controller`: IAM/policies para o AWS Load Balancer Controller

## Estrutura

```text
.
|-- locals.tf
|-- modules.tf
|-- provider.tf
|-- terraform.tfvars
|-- variables.tf
`-- modules/
    |-- aws-load-balancer-controller/
    |-- cluster/
    |-- managed-node-group/
    `-- network/
```

## Como o projeto esta organizado

- A raiz concentra as configuracoes compartilhadas do projeto.
- As tags comuns sao definidas em `locals.tf`.
- As variaveis de entrada do modulo raiz ficam em `variables.tf`.
- A composicao dos modulos fica em `modules.tf`.
- Cada modulo declara seus proprios inputs em `inputs.tf`, porque no Terraform os modulos sao isolados e nao herdam variaveis da raiz automaticamente.

## Fluxo entre os modulos

1. O modulo `network` cria a rede e expoe os IDs das subnets por `output`.
2. O modulo `cluster` consome as subnets publicas para criar o EKS.
3. O modulo `managed-node-group` consome o nome do cluster e as subnets privadas.
4. O modulo `aws-load-balancer-controller` usa as tags e o contexto do projeto para configurar IAM/policies relacionadas ao controller.

## Pre-requisitos

- Terraform instalado na maquina
- Credenciais AWS configuradas no ambiente
- Bucket S3 do backend remoto existente

Backend configurado atualmente:

- Bucket: `terraformaws`
- Key: `dev/terraform/state`
- Region: `us-east-1`

Provider AWS configurado atualmente:

- Region: `us-east-1`

## Variaveis da raiz

As variaveis principais do projeto ficam em `variables.tf`:

- `cidr_block`: faixa CIDR da VPC
- `project_name`: nome base usado nos recursos
- `tags`: mapa de tags compartilhadas

Exemplo de `terraform.tfvars`:

```hcl
cidr_block   = "10.0.0.0/16"
project_name = "primary-project"
```

As tags comuns sao definidas em `locals.tf`:

```hcl
locals {
  tags = {
    Department   = "DevOps"
    Organization = "Infrastructure and Operations"
    Project      = "EKS"
    Environment  = "Development"
  }
}
```

## Comandos basicos

Inicializar o projeto:

```powershell
terraform init
```

Formatar os arquivos:

```powershell
terraform fmt -recursive
```

Validar a configuracao:

```powershell
terraform validate
```

Gerar o plano:

```powershell
terraform plan -var-file terraform.tfvars
```

Aplicar a infraestrutura:

```powershell
terraform apply -var-file terraform.tfvars
```

Destruir a infraestrutura:

```powershell
terraform destroy -var-file terraform.tfvars
```

## Tags compartilhadas

As tags sao centralizadas na raiz e repassadas para os modulos via `modules.tf`.

Exemplo:

```hcl
module "eks_network" {
  source       = "./modules/network"
  cidr_block   = var.cidr_block
  project_name = var.project_name
  tags         = local.tags
}
```

Dentro de cada modulo, as tags entram como input:

```hcl
variable "tags" {
  type = map(string)
}
```

Isso evita duplicar os valores das tags em varios lugares, mantendo uma unica fonte de verdade na raiz.

## Observacoes

- O bucket do backend S3 precisa existir antes do `terraform init`.
- Modulos Terraform nao acessam `local` ou `variable` da raiz diretamente; eles recebem dados por argumentos do bloco `module`.
- Se novos modulos forem adicionados, o ideal e continuar usando o mesmo padrao: valores compartilhados na raiz e inputs declarados dentro do modulo.
