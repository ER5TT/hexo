#!/bin/sh
set -e

PUID=${PUID:-1000}
PGID=${PGID:-1000}

if ! getent group hexo > /dev/null; then
    addgroup -g $PGID -S hexo
fi

if ! getent passwd hexo > /dev/null; then
    adduser -u $PUID -G hexo -S hexo
fi

chown -R hexo:hexo /hexo

su-exec hexo sh -c '
  if [ ! -f package.json ] || [ ! -f _config.yml ]; then
    hexo init .
    npm install
  fi

  exec "$@"
' "$@"
