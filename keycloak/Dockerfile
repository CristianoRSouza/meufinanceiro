FROM quay.io/keycloak/keycloak:23.0

# Bake custom theme into the image (no volume mount needed on Railway)
COPY themes /opt/keycloak/themes

# Bake realm import into the image
COPY import /opt/keycloak/data/import

# Railway sits behind an HTTPS reverse proxy
ENV KC_PROXY=edge
ENV KC_HTTP_ENABLED=true
ENV KC_HOSTNAME_STRICT=false
ENV KC_HOSTNAME_STRICT_HTTPS=false

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start-dev", "--import-realm"]
