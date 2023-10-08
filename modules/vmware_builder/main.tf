resource "random_id" "this" {
  byte_length = 2
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!?#-._"
}

resource "terraform_data" "vm" {
  input = {
    vm_name     = "${var.vm_name_prefix}-${random_id.this.dec}"
    vm_password = "${random_password.password.result}"
  }
}

resource "terraform_data" "vmware_builder" {

  provisioner "local-exec" {
    working_dir = "${path.module}/templates/packer"
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOT
      set -e
      packer init vm_template.pkr.hcl
      packer validate vm_template.pkr.hcl
      packer build -on-error=abort vm_template.pkr.hcl
    EOT

    environment = {
      PKR_VAR_esx_server    = var.esx_connection.esx_server
      PKR_VAR_esx_username  = var.esx_connection.esx_username
      PKR_VAR_esx_password  = var.esx_connection.esx_password
      PKR_VAR_esx_network   = var.esx_connection.esx_network
      PKR_VAR_esx_datastore = var.esx_connection.esx_datastore

      PKR_VAR_vm_name     = terraform_data.vm.output.vm_name
      PKR_VAR_vm_username = var.vm_username
      PKR_VAR_vm_password = terraform_data.vm.output.vm_password

      PKR_VAR_ipxe_url = "http://${var.s3_bucket_name}.s3.amazonaws.com/${terraform_data.vm.output.vm_name}-ipxe.sh"
    }
  }

  depends_on = [aws_s3_object.vm_ipxe_script, aws_s3_object.vm_preseed_script, aws_s3_object.vm_postisntall_script]

}
