FROM alpine

ARG VERSION=v7.0.13

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.7.0/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

RUN apk add --no-cache nginx && \
    ln -sf /dev/stdout /var/log/nginx/access.log \
    ln -sf /dev/stderr /var/log/nginx/error.log

COPY root/ /

WORKDIR /directus

RUN apk add --no-cache git && \
    git clone -b $VERSION https://github.com/directus/app.git . && \
    mv config_example.js config.js

ENTRYPOINT ["/init"]
