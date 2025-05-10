FROM alpine:latest

COPY entrypoint.sh /entrypoint.sh

RUN apk add --no-cache \
    su-exec \
    git \
    nodejs \
    npm && \
    npm install -g --loglevel=error --unsafe-perm=true \
    hexo-cli \
    hexo-server && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /hexo && \
    chmod +x /entrypoint.sh

WORKDIR /hexo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["hexo", "server"]
