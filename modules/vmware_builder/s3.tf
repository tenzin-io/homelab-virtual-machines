resource "aws_s3_object" "vm_ipxe_script" {
  bucket = var.s3_bucket_name
  key    = "${terraform_data.vm.output.vm_name}-ipxe.sh"
  content = templatefile("${path.module}/templates/linux/debian/bookworm/ipxe.sh.tftpl", {
    preseed_url = "https://${var.s3_bucket_name}.s3.amazonaws.com/${terraform_data.vm.output.vm_name}-preseed.cfg"
  })
}

resource "aws_s3_object" "vm_preseed_script" {
  bucket = var.s3_bucket_name
  key    = "${terraform_data.vm.output.vm_name}-preseed.cfg"
  content = templatefile("${path.module}/templates/linux/debian/bookworm/preseed.cfg.tftpl", {
    vm_name         = terraform_data.vm.output.vm_name
    vm_username     = var.vm_username,
    vm_password     = terraform_data.vm.output.vm_password
    postinstall_url = "https://${var.s3_bucket_name}.s3.amazonaws.com/${terraform_data.vm.output.vm_name}-postinstall.sh"
  })
}

resource "aws_s3_object" "vm_postisntall_script" {
  bucket = var.s3_bucket_name
  key    = "${terraform_data.vm.output.vm_name}-postinstall.sh"
  content = templatefile("${path.module}/templates/linux/debian/bookworm/postinstall.sh.tftpl", {
    vm_username           = var.vm_username
    vm_ssh_authorized_key = var.vm_ssh_authorized_key
    vm_ssh_ca_public_key  = var.vm_ssh_ca_public_key
  })
}
