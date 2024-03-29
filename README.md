# caddy-cloudflare

This repository contains a custom build of Caddy, a powerful, enterprise-ready and extensible web server written in GO, with the `caddy-dns/cloudflare plugin` integrated. The custom build allows you to easily configure Caddy to use Cloudflare as the DNS provider for automatic SSL/TLS certificate management via the Cloudflare API.

## Configuration

### Caddyfile

The `Caddyfile` contains the server configurations and routes for your web server. Modify this file according to your specific requirements. For refrences how the Caddyfile works take a look at the offical [documentation](https://caddyserver.com/docs/).

```caddyfile
# Global Caddy Config
{
        #ACME_DNS
        acme_dns cloudflare <api-key>
        # WebDAV
        order webdav before file_server
}

#WebDAV example:
webdav.example.com {
        @notget not method GET
       	route @notget {
       	      basicauth {
       	           <USER> <BASE-64 HASH>
       	      }
       	      webdav {
       	           root /usr/share/
       	      }
        }

	      encode gzip

        import header
        import logs
}
```

### Docker Compose

The `docker-compose.yaml` file defines the service for the custom Caddy build. You can customize this file to suit your needs. By default, it uses the latest image from GitHub Packages, but you can modify it to use a different image source or version. 

```yaml
version: '3.7'

services:
  caddy:
    image: ghcr.io/lukasw01/caddy-cloudflare:latest
    restart: unless-stopped
    container_name: caddy
    networks:
      - web
    ports:
        - "80:80"
        - "443:443"
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
