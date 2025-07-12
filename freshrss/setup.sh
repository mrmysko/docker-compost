#!/bin/bash

if [ -n "$TRUSTED_PROXY" ]; then
	if [ "$TRUSTED_PROXY" = "0" ]; then
		# Disable RemoteIPHeader and RemoteIPInternalProxy
		find /etc/apache2/ -type f -name FreshRSS.Apache.conf -exec sed -r -i "/^\s*RemoteIP.*$/s/^/#/" {} \;
	else
		# Custom list for RemoteIPInternalProxy
		find /etc/apache2/ -type f -name FreshRSS.Apache.conf -exec sed -r -i "\\#^\s*RemoteIPInternalProxy#s#^.*#\tRemoteIPInternalProxy $TRUSTED_PROXY#" {} \;
	fi
fi

if [ -n "$OIDC_ENABLED" ] && [ "$OIDC_ENABLED" -ne 0 ]; then
	# Default values
	export OIDC_SESSION_INACTIVITY_TIMEOUT="${OIDC_SESSION_INACTIVITY_TIMEOUT:-300}"
	export OIDC_SESSION_MAX_DURATION="${OIDC_SESSION_MAX_DURATION:-27200}"
	export OIDC_SESSION_TYPE="${OIDC_SESSION_TYPE:-server-cache}"

	# Debian
	(which a2enmod >/dev/null && a2enmod -q auth_openidc)

	if [ -n "$OIDC_SCOPES" ]; then
		# Compatibility with : as separator instead of space
		OIDC_SCOPES=$(echo "$OIDC_SCOPES" | tr ':' ' ')
		export OIDC_SCOPES
	fi
fi