ARG GOLANG_VERSION=1.19.3
ARG ALPINE_VERSION=3.16

FROM golang:${GOLANG_VERSION}-alpine${ALPINE_VERSION} as gobuild
ARG GOLANG_VERSION
ARG ALPINE_VERSION

WORKDIR /go/src/github.com/caddyserver/xcaddy/cmd/xcaddy

RUN apk add --no-cache git gcc build-base; \
	go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

RUN  xcaddy build \
	 --output /go/src/github.com/caddyserver/xcaddy/cmd/caddy \
	 --with github.com/caddy-dns/cloudflare

FROM alpine:${ALPINE_VERSION}

ARG GOLANG_VERSION
ARG ALPINE_VERSION

RUN apk add --no-cache ca-certificates curl tzdata bash; \
             rm -rf /var/cache/apk/*;

LABEL maintainer "HomeAll"

EXPOSE 80 443 2019

ENV XDG_CONFIG_HOME /config

ENV XDG_DATA_HOME /data

COPY --from=gobuild /go/src/github.com/caddyserver/xcaddy/cmd/caddy /bin/
COPY ./start_caddy.sh /
ENTRYPOINT [ "/bin/bash", "/start_caddy.sh" ]