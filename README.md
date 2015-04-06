# Dockerfile for Kibana master repo

Based on original from [marcbachmann](https://github.com/marcbachmann/dockerfile-kibana4).   

This Dockerfile fetch the lastest version of [Kibana master repo](https://github.com/elasticsearch/kibana). The default Kibana port 5601 is exposed.

To run this container you'll need a separate elasticsearch server.
Kibana automatically proxies all requests from the dashboard to the elasticsearch server. So the ES server doesn't need to be accessible from the internet.

## Options
Most configuration variables can be set using environment variables.


```
ENV VAR         				- default value
-----------------------------------------------
HOST                    		= 0.0.0.0
ELASTICSEARCH_URL  				= http://172.17.42.1:9200
ELASTICSEARCH_PRESERVE_HOST 	= true
KIBANA_INDEX    				= .kibana
KIBANA_ELASTICSEARCH_USERNAME	= 
KIBANA_ELASTICSEARCH_PASSWORD	=
KIBANA_ELASTICSEARCH_CLIENT_CRT	=
KIBANA_ELASTICSEARCH_CLIENT_KEY	=
CA 								=
DEFAULT_APP_ID  				= discover
REQUEST_TIMEOUT 				= 300000
SHARD_TIMEOUT   				= 0
VERIFY_SSL      				= true
SSL_KEY_FILE					=
SSL_CERT_FILE					=
PID_FILE						=
LOG_FILE						=
```


## Run
To connect to an elasticsearch server on the docker host, run this:

```bash
docker run -e ELASTICSEARCH=http://172.17.42.1:9200 -P raphinyc/dockerfile-kibana4
```
