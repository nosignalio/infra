terraform {
    backend "s3" {}
}

data "terraform_remote_state" "state" {
    backend = "s3"
    config {
        bucket      = "opshell"
        key         = "terraform.tfstate"
        access_key  = "${var.DO_SPACES_KEY}"
        secret_key  = "${var.DO_SECRET_KEY}"
        endpoint    = "https://fra1.digitaloceanspaces.com"
        region      = "eu-central-1"

        # skip s3 specific checks
        skip_credentials_validation = true
        skip_get_ec2_platforms      = true
        skip_requesting_account_id  = true
        skip_metadata_api_check     = true
    }
}