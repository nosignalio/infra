terraform {
    backend "s3" {
        bucket      = "opshell"
        key         = "terraform.tfstate"
        endpoint    = "https://fra1.digitaloceanspaces.com"
        region      = "eu-central-1"

        # skip s3 specific checks
        skip_credentials_validation = true
        skip_get_ec2_platforms      = true
        skip_requesting_account_id  = true
        skip_metadata_api_check     = true
    }
}