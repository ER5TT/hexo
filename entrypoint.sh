#!/bin/sh
set -e

if [ ! -f package.json ] || [ ! -f _config.yml ]; then
  hexo init .
  npm install
fi

exec "$@"
