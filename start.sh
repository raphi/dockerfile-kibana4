#!/bin/bash

export ELASTICSEARCH_URL=${ELASTICSEARCH_URL:-http://172.17.42.1:9200}
export ELASTICSEARCH_PRESERVE_HOST=${ELASTICSEARCH_PRESERVE_HOST:-true}
export KIBANA_INDEX=${KIBANA_INDEX:-.kibana}
export DEFAULT_APP_ID=${DEFAULT_APP_ID:-discover}
export REQUEST_TIMEOUT=${REQUEST_TIMEOUT:-60}
export SHARD_TIMEOUT=${SHARD_TIMEOUT:-30000}
export VERIFY_SSL=${VERIFY_SSL:-true}
export HOST=${HOST:-0.0.0.0}

REPLACE=(
 "s|^host:.*$|host: \"$HOST\"|;"
 "s|^elasticsearch_url:.*$|elasticsearch_url: \"$ELASTICSEARCH_URL\"|;"
 "s|^elasticsearch_preserve_host:.*$|elasticsearch_preserve_host: $ELASTICSEARCH_PRESERVE_HOST|;"
 "s|^kibana_index:.*$|kibana_index: \"$KIBANA_INDEX\"|;"
 "s|^default_app_id:.*$|default_app_id: \"$DEFAULT_APP_ID\"|;"
 "s|^request_timeout:.*$|request_timeout: $REQUEST_TIMEOUT|;"
 "s|^shard_timeout:.*$|shard_timeout: $REQUEST_TIMEOUT|;"
 "s|^verify_ssl:.*$|verify_ssl: $VERIFY_SSL|;"
)

if [ "$ELASTICSEARCH_USERNAME" != "" ] && [ "$ELASTICSEARCH_PASSWORD" != "" ]
then
 REPLACE=(
  ${REPLACE[@]}
  "s|^# elasticsearch_username:.*|elasticsearch_username: $ELASTICSEARCH_USERNAME|;"
  "s|^# elasticsearch_password:.*|elasticsearch_password: $ELASTICSEARCH_PASSWORD|;"
 )
fi

sed -i.bak -e "${REPLACE[*]}" config/kibana.yml
bin/kibana