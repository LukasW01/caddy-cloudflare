FROM docker.io/caddy:builder-alpine AS builder

RUN caddy-builder \
    github.com/caddy-dns/cloudflare \
    github.com/mholt/caddy-webdav

FROM docker.io/caddy:alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

