#!/bin/sh
set -e

chown -R hexo:hexo /hexo

if [ ! -f package.json ] || [ ! -f _config.yml ]; then
  hexo init .
  npm install
fi

exec "$@"
