terraform {
  backend "s3" {
    bucket         = "tenzin-io"
    key            = "terraform/homelab-virtual-machines.state"
    dynamodb_table = "tenzin-io"
    region         = "us-east-1"
  }
}

module "vm_scripts_bucket" {
  source = "./modules/s3_bucket"
}

module "vm_requests" {
  source = "./modules/vmware_builder"
  count  = 2

  esx_connection = {
    esx_server    = data.vault_generic_secret.vmware_builder.data.esx_server
    esx_username  = data.vault_generic_secret.vmware_builder.data.esx_username
    esx_password  = data.vault_generic_secret.vmware_builder.data.esx_password
    esx_datastore = "datastore1"
    esx_network   = "VM Network"
  }
  vm_name_prefix        = "homelab-test"
  vm_ssh_authorized_key = data.vault_generic_secret.vmware_builder.data.vm_ssh_authorized_key
  vm_ssh_ca_public_key  = data.vault_generic_secret.vmware_builder.data.vm_ssh_ca_public_key
  s3_bucket_name        = module.vm_scripts_bucket.name
}
