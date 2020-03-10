#!/bin/bash
set -e
set -x
curl https://sdk.cloud.google.com > install.sh
bash install.sh --disable-prompts
exec -l $SHELL
apt-get install unzip
wget https://releases.hashicorp.com/terraform/0.12.20/terraform_0.12.20_linux_amd64.zip
unzip terraform_0.12.20_linux_amd64.zip
mv terraform /usr/local/bin/
rm terraform_0.12.20_linux_amd64.zip
gcloud auth activate-service-account --key-file /home/rasavo99/Project.json
git clone https://github.com/DanJake/terraform.git /home/rasavo99/terraform/all
git clone https://github.com/DanJake/terraform_sentry.git /home/rasavo99/terraform/sentry
git clone https://github.com/DanJake/terraform_monitoring.git /home/rasavo99/terraform/monitoring
gsutil -m cp -r gs://terraform_state_demo3/terraform.tfvars /home/rasavo99/terraform/sentry
mkdir -p /home/rasavo99/terraform/sentry/.terraform/plugins/linux_amd64
chown -R rasavo99:rasavo99 /home/rasavo99/terraform/all
chown -R rasavo99:rasavo99 /home/rasavo99/terraform/sentry
cd /home/rasavo99/terraform/sentry/.terraform/plugins/linux_amd64
wget https://github.com/jianyuan/terraform-provider-sentry/releases/download/v0.5.3/terraform-provider-sentry_0.5.3_linux_amd64.tar.gz
tar -xvzf terraform-provider-sentry_0.5.3_linux_amd64.tar.gz
rm terraform-provider-sentry_0.5.3_linux_amd64.tar.gz
chown -R rasavo99:rasavo99 /home/rasavo99/terraform