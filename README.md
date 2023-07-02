# caddy-cloudflare

This repository contains a custom build of Caddy, a powerful, enterprise-ready and extensible web server written in GO, with the `caddy-dns/cloudflare plugin` integrated. The custom build allows you to easily configure Caddy to use Cloudflare as the DNS provider for automatic SSL/TLS certificate management via the Cloudflare API.

## Configuration

### Caddyfile

The `Caddyfile` contains the server configurations and routes for your web server. Modify this file according to your specific requirements. For refrences how the Caddyfile works take a look at the offical [documentation](https://caddyserver.com/docs/). An [example](https://github.com/LukasW01/caddy-cloudflare/blob/main/Caddyfile) Caddyfile is provided in this repository.

```caddyfile
{
    #CDN-ACME
    acme_dns cloudflare <api-key>
}
```

### Docker Compose

The `docker-compose.yaml` file defines the service for the custom Caddy build. You can customize this file to suit your needs. By default, it uses the latest image from GitHub Packages, but you can modify it to use a different image source or version. An [example](https://github.com/LukasW01/caddy-cloudflare/blob/main/docker-compose.yaml) docker-compose file is also provided in this repository.

```yaml
version: '3.7'

services:
  caddy:
    image: ghcr.io/lukasw01/caddy-cloudflare:main
    restart: unless-stopped
    container_name: caddy
    networks:
      - web
    ports:
        - "80:80"
        - "443:443"
        - "2019:2019"
    volumes:
        - ./Caddyfile:/etc/caddy/Caddyfile:ro
        - ./data:/data
        - ./config:/config
        - ./logs:/var/log/
        - ./www:/usr/share/www
    labels:
      - io.containers.autoupdate=registry        


networks:
  web:
    external: true
```

## Contributing

If you'd like to contribute to this repository, feel free to open issues or submit pull requests. Contributions are always welcome!

## Acknowledgments

This repository is based on the original [Caddy](https://github.com/caddyserver/caddy) project.
