#!/bin/sh

log() {
	printf '%s\n' "$@"
}

action="$1"

if [ "$action" = "info" ]; then
	openssl x509 -text -noout
elif [ "$action" = "get" ]; then
	shift; endpoint="$1"
	if [ -z "$endpoint" ]; then
		log "endpoint is mandatory"
		exit 1
	fi
	shift; port="${1:-443}"
	echo | openssl s_client -servername NAME -connect "$endpoint:$port" | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'
else
	echo "Faltou a acao get ou info"
fi
