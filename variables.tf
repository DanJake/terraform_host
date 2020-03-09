variable "credentials_file_demo3" {
  description = "TF_VAR = Path to the service account key file in JSON format"
  type        = string
}
variable "project_id_demo3" {
  description = "TF_VAR = The ID of the project"
  type        = string
}
variable "region" {
  description = "Default project region"
  default     = "europe-west4"
}
variable "zone" {
  description = "Default project zone"
  default     = "europe-west4-b"
}
variable "bucket_state_name" {
  description = "The name of the bucket"
  default     = "terraform_state_demo3"
}
variable "bucket_state_location" {
  description = "The location of the bucket"
  default     = "EU"
}
variable "bucket_state_storage_class" {
  description = "The storage class of the bucket"
  default     = "STANDARD"
}
variable "bucket_state_force_destroy" {
  description = "When deleting a bucket, this boolean option will delete all contained objects"
  default     = "true"
}
variable "bucket_state_bucket_policy_only" {
  description = "If true then Bucket Policy Only access is enabled on this bucket."
  default     = "false"
}
variable "bucket_state_versioning_enabled" {
  description = "If true then versioning is enabled for all objects in this bucket."
  default     = "true"
}
variable "disk_name" {
  description = "Name of the disk resource"
  default     = "terraform-disk"
}
variable "disk_zone" {
  description = "A reference to the zone where the disk resides"
  default     = "europe-north1-b"
}
variable "disk_type" {
  description = "URL of the disk type resource describing which disk type to use to create the disk(pd-standard or pd-ssd)"
  default     = "pd-standard"
}
variable "disk_image" {
  description = " The image from which to initialize this disk"
  default     = "ubuntu-os-cloud/ubuntu-1804-lts"
}
variable "disk_size" {
  description = "Size of the persistent disk, specified in GB"
  default     = 10
}
variable "statick_ip_name" {
  description = "Name of the static ip resource"
  default     = "terraform-ip"
}
variable "statick_ip_region" {
  description = "The Region in which the created address should reside"
  default     = "europe-north1"
}
variable "network_tier" {
  description = "The networking tier used for configuring this address."
  default     = "STANDARD"
}
variable "instance_terraform_name" {
  description = "A unique name for the terraform machine "
  default     = "terraform"
}
variable "machine_type" {
  description = "The machine type to create"
  default     = "n1-standard-1"
}
variable "instance_terraform_zone" {
  description = "zone that the terraform machine should be created in"
  default     = "europe-north1-b"
}
variable "network_name" {
  description = "The default zone to manage resources in"
  default     = "default"
}
variable "connection_type" {
  description = "The connection type that should be used. Valid types are ssh and winrm"
  default     = "ssh"
}
variable "agent_ssh" {
  description = "Using ssh-agent or not"
  default     = "false"
}
variable "user_name_demo3" {
  description = "The user that we should use for the SSH connection"
  type        = string
}
variable "p_key" {
  description = "The path of an SSH key to use for the connection"
  type        = string
}
variable "home_dir_demo3" {
  description = "Home user directory"
  type        = string
}
variable "ansible_vault_key" {
  description = " Path to the ansible vault key file."
  type        = string
}
variable "sa_id" {
  description = "The account id that is used to generate the service account email address and a stable unique id"
  type        = string
}
variable "sa_name" {
  description = "The display name for the service account. "
  default     = "SA for demo3"
}
