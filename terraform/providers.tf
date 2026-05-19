terraform {
  required_providers {
    railway = {
      source  = "jianyuan/railway"
      version = ">= 0.1.0"
    }
  }
}

variable "railway_token" {
  type      = string
  sensitive = true
}

provider "railway" {
  token = var.railway_token
}
