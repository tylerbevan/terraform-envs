resource "digitalocean_droplet" "kf2" {
  image  = "49555831"
  name   = "killingfloor2"
  region = "sfo2"
  size   = "s-2vcpu-2gb"
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.id]
}

resource "cloudflare_record" "kf2" {
  zone_id = lookup(data.cloudflare_zones.filtered.zones[0], "id")
  name    = "kf2"
  value   = digitalocean_droplet.kf2.ipv4_address
  type    = "A"
  ttl     = 600
}
