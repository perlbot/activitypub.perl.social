FROM alpine:latest AS config_builder

RUN apk add perl perl-yaml 
RUN mkdir /config
WORKDIR /config
COPY ./config.yaml.tmpl /config/ 
COPY ./template.pl /config

ARG GTS_DB_TYPE
ARG GTS_DB_ADDRESS
ARG GTS_DB_PORT
ARG GTS_DB_USER
ARG GTS_DB_PASSWORD
ARG GTS_DB_DATABASE

RUN perl template.pl

FROM superseriousbusiness/gotosocial:latest

RUN mkdir /config
COPY --from=config_builder /config/config.yaml /config/
