resource "digitalocean_droplet" "owncloud" {
  image  = "centos-7-x64"
  name   = "cloud.tbevan.us"
  region = "sfo2"
  size   = "s-1vcpu-2gb"
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.id]
  private_networking = true
}

resource "cloudflare_record" "owncloud" {
  zone_id = lookup(data.cloudflare_zones.filtered.zones[0], "id")
  name    = "cloud"
  value   = digitalocean_droplet.owncloud.ipv4_address
  type    = "A"
  ttl     = 1
  proxied = true
}

