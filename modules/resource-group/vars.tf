variable "resource_prefix" {
  type        = string
  description = "A prefix used in resource names for better identification"
}

variable "env" {
  type        = string
  description = "The environment or deployment stage (e.g., dev, prod)"
}

variable "location" {
  type        = string
  description = "The Azure region or location where resources will be deployed"
}
