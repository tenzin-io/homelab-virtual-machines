# README

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_s3_object.vm_ipxe_script](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_s3_object.vm_postisntall_script](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_s3_object.vm_preseed_script](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [terraform_data.vm](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.vmware_builder](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_esx_connection"></a> [esx\_connection](#input\_esx\_connection) | n/a | <pre>object({<br>    esx_server    = string<br>    esx_username  = string<br>    esx_password  = string<br>    esx_network   = string<br>    esx_datastore = string<br>  })</pre> | n/a | yes |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | n/a | `string` | n/a | yes |
| <a name="input_vm_name_prefix"></a> [vm\_name\_prefix](#input\_vm\_name\_prefix) | n/a | `string` | `"vm"` | no |
| <a name="input_vm_ssh_authorized_key"></a> [vm\_ssh\_authorized\_key](#input\_vm\_ssh\_authorized\_key) | n/a | `string` | n/a | yes |
| <a name="input_vm_ssh_ca_public_key"></a> [vm\_ssh\_ca\_public\_key](#input\_vm\_ssh\_ca\_public\_key) | n/a | `string` | n/a | yes |
| <a name="input_vm_username"></a> [vm\_username](#input\_vm\_username) | n/a | `string` | `"sysuser"` | no |
<!-- END_TF_DOCS -->
