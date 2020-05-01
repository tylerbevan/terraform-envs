resource "digitalocean_droplet" "starmade" {
  image  = "centos-8-x64"
  name   = "starmade"
  region = "sfo2"
  size   = "s-2vcpu-2gb"
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.id]
}

resource "cloudflare_record" "starmade" {
  zone_id = lookup(data.cloudflare_zones.filtered.zones[0], "id")
  name    = "starmade"
  value   = digitalocean_droplet.starmade.ipv4_address
  type    = "A"
  ttl     = 600
}

output "ip_addr" {
  value = digitalocean_droplet.starmade.ipv4_address
}
