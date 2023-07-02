FROM quay.io/keycloak/keycloak:latest as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configure a database vendor
ENV KC_DB=postgres

WORKDIR /opt/keycloak
# for demonstration purposes only, please make sure to use proper certificates in production instead
RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=keycloak" -alias server -ext "SAN:c=DNS:keycloak,IP:127.0.0.1" -keystore conf/server.keystore
RUN /opt/keycloak/bin/kc.sh build --features=preview,declarative-user-profile

FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/
#COPY keycloak-username-password-attribute-authenticator-0.3.0.jar /opt/keycloak/providers/
RUN /opt/keycloak/bin/kc.sh build --features=preview,declarative-user-profile

# change these values to point to a running postgres instance
ENV KC_DB_URL=postgres
ENV KC_DB_USERNAME=user
ENV KC_DB_PASSWORD=1234
ENV KC_HOSTNAME=localhost
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
