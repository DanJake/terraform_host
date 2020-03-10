provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}
#---------------------------------------------------
# Create service account
#---------------------------------------------------
resource "google_service_account" "sa" {
  account_id   = var.sa_id
  display_name = var.sa_name
}
resource "google_service_account_key" "mykey" {
  service_account_id = google_service_account.sa.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}
data "google_iam_policy" "admin" {
  binding {
    role = "roles/editor"
    members = [
      "serviceAccount:${google_service_account.sa.email}",
    ]
  }
}
resource "google_compute_instance_iam_policy" "editor" {
  project = google_compute_instance.terraform.project
  zone = google_compute_instance.terraform.zone
  instance_name = google_compute_instance.terraform.name
  policy_data = data.google_iam_policy.admin.policy_data
}
#---------------------------------------------------
# Create storage bucket
#---------------------------------------------------
resource "google_storage_bucket" "terraform_state" {
  name               = var.bucket_state_name
  project            = var.project_id
  location           = var.bucket_state_location
  storage_class      = var.bucket_state_storage_class
  force_destroy      = var.bucket_state_force_destroy
  bucket_policy_only = var.bucket_state_bucket_policy_only
  versioning {
    enabled = var.bucket_state_versioning_enabled
  }
}
resource "google_storage_bucket_object" "tfvars" {
  name   = "terraform.tfvars"
  source = "../sentry/terraform.tfvars"
  bucket = google_storage_bucket.terraform_state.name
}
resource "google_storage_bucket_object" "pr_key" {
  name   = "id_rsa"
  source = "${var.my_home_dir}/${var.p_key}"
  bucket = google_storage_bucket.terraform_state.name
}
resource "google_storage_bucket_object" "vault" {
  name   = var.ansible_vault_key
  source = "../${var.ansible_vault_key}"
  bucket = google_storage_bucket.terraform_state.name
}
# -------------------------Disk ---------------
resource "google_compute_disk" "default_disk_terraform" {
  name  = var.disk_name
  type  = var.disk_type
  image = var.disk_image
  zone  = var.disk_zone
  size  = var.disk_size
}

resource "google_compute_address" "static-ip-terraform" {
  name         = var.statick_ip_name
  region       = var.statick_ip_region
  network_tier = var.network_tier
}

# -------------------------Instances ---------------
resource "google_compute_instance" "terraform" {
  name         = var.instance_terraform_name
  machine_type = var.machine_type
  zone         = var.instance_terraform_zone
  boot_disk {
    source = google_compute_disk.default_disk_terraform.self_link
  }
  network_interface {
    network = var.network_name
    access_config {
      network_tier = var.network_tier
      nat_ip       = google_compute_address.static-ip-terraform.address
    }
  }
  provisioner "file" {
    source      = var.credentials_file
    destination = "Project.json"
    connection {
      type        = var.connection_type
      user        = var.user_name
      private_key = file("~/${var.p_key}")
      agent       = var.agent_ssh
      host        = google_compute_address.static-ip-terraform.address
    }
  }
  provisioner "file" {
    source      = "./scripts/installterraform.sh"
    destination = "installterraform.sh"
    connection {
      type        = var.connection_type
      user        = var.user_name
      private_key = file("~/${var.p_key}")
      agent       = var.agent_ssh
      host        = google_compute_address.static-ip-terraform.address
    }
  }
  metadata = {
    ssh-keys = "${var.user_name}:${file("~/.ssh/id_rsa.pub")}"
  }
  metadata_startup_script = "chmod u+x ${var.home_dir}/installterraform.sh && ${var.home_dir}/./installterraform.sh"

}
