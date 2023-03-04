# syntax=docker/dockerfile:1

FROM nvcr.io/nvidia/omniverse/kit:104.0.0

# Install Kit services dependencies.
# This code is pulled from a extension registry and the `--ext-precache-mode` will pull down the extensions and exit.
RUN /opt/nvidia/omniverse/kit-sdk-launcher/kit \
    --ext-precache-mode \
    --enable omni.services.core \
    --enable omni.services.transport.server.http \
    --enable omni.kit.asset_converter \
    --/exts/omni.kit.registry.nucleus/registries/0/name=kit/services \
    --/exts/omni.kit.registry.nucleus/registries/0/url=https://dw290v42wisod.cloudfront.net/exts/kit/services \
    --allow-root

COPY hello_world.py /hello_world.py
EXPOSE 8011/tcp

# Also tried token here!
# OMNI_PASS=\$omni-api-token
# OMNI_USER=<token>

ENTRYPOINT [ \
    "/opt/nvidia/omniverse/kit-sdk-launcher/kit", \
    "", \
    "--exec", "hello_world.py", \
    "--enable", "omni.services.core", \
    "--enable", "omni.services.transport.server.http", \
    "--enable", "omni.client", \
    "--enable", "omni.kit.asset_converter", \
    "--allow-root" \
]
