variable "resource-group-name" {
  default     = "azgmc-terraform-rg-rg"
  description = "The prefix used for all resources in this example"
}

variable "app-service-name" {
  default     = "azgmc-terraform-webapp"
  description = "The name of the Web App"
}

variable "app-service-plan-name" {
  default     = "azgmc-terraform-asp"
  description = "The app service plan name"
}

variable "location" {
  default     = "canadacentral"
  description = "The Azure location where all resources in this example should be created"
}