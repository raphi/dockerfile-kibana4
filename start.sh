#!/bin/bash

export ELASTICSEARCH_URL=${ELASTICSEARCH_URL:-http://172.17.42.1:9200}
export ELASTICSEARCH_PRESERVE_HOST=${ELASTICSEARCH_PRESERVE_HOST:-true}
export KIBANA_INDEX=${KIBANA_INDEX:-.kibana}
export DEFAULT_APP_ID=${DEFAULT_APP_ID:-discover}
export REQUEST_TIMEOUT=${REQUEST_TIMEOUT:-300000}
export SHARD_TIMEOUT=${SHARD_TIMEOUT:-0}
export VERIFY_SSL=${VERIFY_SSL:-true}
export HOST=${HOST:-0.0.0.0}

REPLACE=(
 "s|^# host:.*$|host: \"$HOST\"|;"
 "s|^# elasticsearch_url:.*$|elasticsearch_url: \"$ELASTICSEARCH_URL\"|;"
 "s|^# elasticsearch_preserve_host:.*$|elasticsearch_preserve_host: $ELASTICSEARCH_PRESERVE_HOST|;"
 "s|^# kibana_index:.*$|kibana_index: \"$KIBANA_INDEX\"|;"
 "s|^# default_app_id:.*$|default_app_id: \"$DEFAULT_APP_ID\"|;"
 "s|^# request_timeout:.*$|request_timeout: $REQUEST_TIMEOUT|;"
 "s|^# shard_timeout:.*$|shard_timeout: $REQUEST_TIMEOUT|;"
 "s|^# verify_ssl:.*$|verify_ssl: $VERIFY_SSL|;"
)

if [ "$KIBANA_ELASTICSEARCH_USERNAME" != "" ] && [ "$KIBANA_ELASTICSEARCH_PASSWORD" != "" ]
then
 REPLACE=(
  ${REPLACE[@]}
  "s|^# kibana_elasticsearch_username:.*|kibana_elasticsearch_username: $KIBANA_ELASTICSEARCH_USERNAME|;"
  "s|^# kibana_elasticsearch_password:.*|kibana_elasticsearch_password: $KIBANA_ELASTICSEARCH_PASSWORD|;"
 )
fi

if [ "$KIBANA_ELASTICSEARCH_CLIENT_CRT" != "" ] && [ "$KIBANA_ELASTICSEARCH_CLIENT_KEY" != "" ]
then
 REPLACE=(
  ${REPLACE[@]}
  "s|^# kibana_elasticsearch_client_crt:.*|kibana_elasticsearch_client_crt: $KIBANA_ELASTICSEARCH_CLIENT_CRT|;"
  "s|^# kibana_elasticsearch_client_key:.*|kibana_elasticsearch_client_key: $KIBANA_ELASTICSEARCH_CLIENT_KEY|;"
 )
fi

if [ "$CA" != "" ]
then
 REPLACE=(
  ${REPLACE[@]}
  "s|^# ca:.*|ca: $CA|;"
 )
fi

if [ "$SSL_KEY_FILE" != "" ] && [ "$SSL_CERT_FILE" != "" ]
then
 REPLACE=(
  ${REPLACE[@]}
  "s|^# ssl_key_file:.*|ssl_key_file: $SSL_KEY_FILE|;"
  "s|^# ssl_cert_file:.*|ssl_cert_file: $SSL_CERT_FILE|;"
 )
fi

if [ "$PID_FILE" != "" ]
then
 REPLACE=(
  ${REPLACE[@]}
  "s|^# pid_file:.*|pid_file: $PID_FILE|;"
 )
fi

if [ "$LOG_FILE" != "" ]
then
 REPLACE=(
  ${REPLACE[@]}
  "s|^# log_file:.*|log_file: $LOG_FILE|;"
 )
fi

sed -i.bak -e "${REPLACE[*]}" kibana*/config/kibana.yml
kibana*/bin/kibana