variable "do_token" {}

provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "cnc" {
  image     = "ubuntu-18-04-x64"
  name      = "cnc.opshell.io"
  region    = "lon1"
  size      = "s-2vcpu-4gb"

  ssh_keys            = ["26123638"]
  private_networking  = true
  tags                = ["shell", "ubuntu", "18.04"]
}

resource "digitalocean_domain" "opshell" {
  name      = "opshell.io"
}

resource "digitalocean_record" "cnc" {
  domain    = digitalocean_domain.opshell.name
  type      = "A"
  name      = "cnc"
  value     = digitalocean_droplet.cnc.ipv4_address
  ttl       = "300"
}
