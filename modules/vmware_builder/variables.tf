variable "esx_connection" {
  type = object({
    esx_server    = string
    esx_username  = string
    esx_password  = string
    esx_network   = string
    esx_datastore = string
  })
}

variable "vm_name_prefix" {
  default = "vm"
}

variable "vm_username" {
  default = "sysuser"
}

variable "s3_bucket_name" {
  type = string
}

variable "vm_ssh_authorized_key" {
  type = string
}

variable "vm_ssh_ca_public_key" {
  type = string
}
