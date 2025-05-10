#!/bin/sh
set -e

PUID=${PUID:-1000}
PGID=${PGID:-1000}

if ! getent group "$PGID" > /dev/null; then
    addgroup -g "$PGID" -S hexo
fi

if ! getent passwd hexo > /dev/null; then
    adduser -u "$PUID" -S -D -H -g "$PGID" hexo
fi

chown -R "$PUID":"$PGID" /hexo

su-exec hexo sh -c '
  if [ ! -f package.json ] || [ ! -f _config.yml ]; then
    hexo init .
    npm install
  fi
'

exec su-exec hexo "$@"
