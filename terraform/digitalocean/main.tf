provider "digitalocean" {}

data "digitalocean_domain" "opshell" {
  name      = "opshell.io"
}

data "digitalocean_domain" "nosignal" {
  name      = "nosignal.io"
}

# primary shell server
resource "digitalocean_droplet" "shell" {
  image     = "ubuntu-18-04-x64"
  name      = "shell.nosignal.io"
  region    = "lon1"
  size      = "s-1vcpu-2gb"

  ssh_keys  = ["26123638","26424553"]
}

resource "digitalocean_record" "shell" {
  domain    = data.digitalocean_domain.nosignal.name
  type      = "A"
  name      = "shell"
  value     = digitalocean_droplet.shell.ipv4_address
  ttl       = "300"
}

# kubernetes cluster
resource "digitalocean_kubernetes_cluster" "nosignal-labs" {
  name      = "nosignal-labs"
  region    = "lon1"
  version   = "1.16.2-do.3"

  node_pool {
    name        = "worker-pool"
    size        = "s-2vcpu-4gb"
    node_count  = "3"
  }
}
