provider "digitalocean" {}

data "digitalocean_domain" "opshell" {
  name      = "opshell.io"
}

# primary shell server
resource "digitalocean_droplet" "cnc" {
  image     = "ubuntu-18-04-x64"
  name      = "cnc.opshell.io"
  region    = "lon1"
  size      = "s-2vcpu-4gb"

  ssh_keys            = ["26123638"]
  private_networking  = true
}

resource "digitalocean_record" "cnc" {
  domain    = data.digitalocean_domain.opshell.name
  type      = "A"
  name      = "cnc"
  value     = digitalocean_droplet.cnc.ipv4_address
  ttl       = "300"
}

# kubernetes cluster
resource "digitalocean_kubernetes_cluster" "opshell" {
  name      = "opshell"
  region    = "lon1"
  version   = "1.16.2-do.1"

  node_pool {
    name        = "worker-pool"
    size        = "s-2vcpu-4gb"
    node_count  = "3"
  }
}
