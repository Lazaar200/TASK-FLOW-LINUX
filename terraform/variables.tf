variable "mysql_root_password" {
  description = "Mot de passe root MySQL"
  type        = string
  default     = "root"
}

variable "mysql_database" {
  description = "Nom de la base de données"
  type        = string
  default     = "todolist"
}

variable "backend_image" {
  description = "Image Docker du backend"
  type        = string
  default     = "sheymaa2/task-flow-linux:latest"
}
