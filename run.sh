#!/bin/bash

set -e

PLUGIN_TXT=${PLUGIN_TXT:-/usr/share/elasticsearch/plugins.txt}

mkdir -p /usr/share/elasticsearch/config/scripts

while [ ! -f "/usr/share/elasticsearch/config/elasticsearch.yml" ]; do
    sleep 1
done

if [ -f "$PLUGIN_TXT" ]; then
    for plugin in $(<"${PLUGIN_TXT}"); do
        if [ ! -d "/usr/share/elasticsearch/plugins/$plugin" ]; then
            /usr/share/elasticsearch/bin/elasticsearch-plugin install $plugin
        fi
    done
fi

exec /docker-entrypoint.sh elasticsearch
