ARG UID=200018
ARG GID=200018

FROM traccar/traccar:alpine

ARG UID
ARG GID

LABEL maintainer="Thien Tran contact@tommytran.io"

RUN apk -U upgrade \
    && apk add libstdc++ \
    && rm -rf /var/cache/apk/*

RUN --network=none \
    addgroup -g ${GID} traccar \
    && adduser -u ${UID} --ingroup traccar --disabled-password --system traccar

RUN chown traccar:traccar /opt/traccar/override

COPY --from=ghcr.io/polarix-containers/hardened_malloc:latest /install /usr/local/lib/
ENV LD_PRELOAD="/usr/local/lib/libhardened_malloc.so"

USER traccar