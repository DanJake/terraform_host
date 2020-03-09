# Google Cloud Platform Project Demo3

# Terraform Service Accounts Module

This terraform file  allows  creation.

- one service accounts
- IAM role bindings for instance
- one storage bucket and upload ansilble vault key to the bucket
- one static ip address and one disk
- one instance

## Compatibility

This project is meant for use with Terraform v0.12.20 and Google provider v3.8.0
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type |
|------|-------------|:----:|
| TF\_VAR\_project\_id  | The ID of the project | string |
| TF\_VAR\_credentials\_file | Path to the service account key file in JSON format. | string |
| TF\_VAR\_user\_name | The user that we should use for the SSH connection. | string |
| TF\_VAR\_p\_key | The path of an SSH key to use for the connection. | string |
| TF\_VAR\_home\_dir | Home user directory. | string |
| TF\_VAR\_ansible\_vault\_key | Path to the ansible vault key file. | string |
| TF\_VAR\_sa\_id | The account id that is used to generate the service account email address and a stable unique id. | string |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this file.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.12.20
- [Terraform Provider for GCP][terraform-provider-gcp] plugin = v3.8.0

### IAM
In order to execute this module you must have a Service Account with the
following roles:


Service account or user credentials with the following roles must be used to provision the resources of this module:

- Compute Admin: `roles/compute.admin`
- Compute Network Admin: `roles/compute.networkAdmin`
- Storage Admin: `roles/storage.admin`
- Service Account Admin: `roles/iam.serviceAccountAdmin`


[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html
