FROM alpine:latest

COPY entrypoint.sh /entrypoint.sh

RUN apk add --no-cache \
    git \
    nodejs \
    npm && \
    npm install -g --loglevel=error --unsafe-perm=true \
    hexo-cli \
    hexo-server && \
    rm -rf /var/cache/apk/* && \
    addgroup -S hexo -g 1000 && \
    adduser -S hexo -u 1000 -G hexo && \
    mkdir -p /hexo && \
    chmod +x /entrypoint.sh && \
    chown -R hexo:hexo /hexo /entrypoint.sh

USER hexo
WORKDIR /hexo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["hexo", "server"]
