variable "resource_prefix" {
  type        = string
  description = "A prefix for naming resources."
}

variable "env" {
  type        = string
  description = "Environment identifier."
}

variable "location" {
  type        = string
  description = "Main resource location."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group."
}

variable "folder_path" {
  type        = string
  description = "Path to the folder containing files to upload."
  # You may consider setting a default value here if applicable.
}

variable "authorized_ip_ranges" {
  type        = list(string)
  description = "List of authorized IP ranges."
}

variable "sub_main_id" {
  type        = list(string)
  description = "ID of the Azure subnet within the Virtual Network."
}
