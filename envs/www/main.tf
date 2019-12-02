resource "digitalocean_droplet" "www" {
  image  = "centos-7-x64"
  name   = "www.tbevan.us"
  region = "sfo2"
  size   = "s-1vcpu-1gb"
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.id]
  private_networking = true
}

output "ip_addr" {
  value = digitalocean_droplet.www.ipv4_address
}

resource "cloudflare_record" "www" {
  zone_id = lookup(data.cloudflare_zones.filtered.zones[0], "id")
  name    = "www"
  value   = digitalocean_droplet.www.ipv4_address
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "tbevanus" {
  zone_id = lookup(data.cloudflare_zones.filtered.zones[0], "id")
  name    = "@"
  value   = "www.tbevan.us"
  type    = "CNAME"
  ttl     = 1
}

resource "cloudflare_record" "recipes" {
  zone_id = lookup(data.cloudflare_zones.filtered.zones[0], "id")
  name    = "recipes"
  value   = digitalocean_droplet.www.ipv4_address
  type    = "A"
  ttl     = 1
  proxied = true
}
