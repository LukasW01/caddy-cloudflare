FROM docker.io/caddy:builder AS builder

RUN caddy-builder \
    github.com/caddy-dns/cloudflare 

FROM docker.io/caddy:alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

