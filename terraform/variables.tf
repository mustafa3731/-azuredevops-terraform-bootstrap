variable "project_name" {
  description = "Lowercase, alphanumeric (used for names). Keep it short, e.g., 'tfboot'."
  type        = string
  default     = "tfboot"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "canadacentral"
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {
    environment = "dev"
    owner       = "azure-devops"
  }
}
