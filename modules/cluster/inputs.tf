variable "cidr_block" {
  type        = string
  description = "Networking CIDR block to be used for the VPC"
}

variable "project_name" {
  type        = string
  description = "Project name"
}

variable "tags" {
  type        = map(string)
  description = "Common tags shared by the root module"
}
