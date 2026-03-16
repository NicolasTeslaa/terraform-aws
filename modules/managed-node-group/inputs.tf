variable "project_name" {
  type        = string
  description = "Project name"
}

variable "tags" {
  type        = map(string)
  description = "Common tags shared by the root module"
}

variable "cluster-name" {
  type = string
}

variable "subnet_private_1a" {
  type = string
}

variable "subnet_private_1b" {
  type = string
}