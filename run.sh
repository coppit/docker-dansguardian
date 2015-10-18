#!/bin/bash

function ts {
  echo [`date '+%b %d %X'`]
}

#-----------------------------------------------------------------------------------------------------------------------

echo "$(ts) Starting DansGuardian container..."

[[ "$PROXYIP" != "" ]] && sed -i "s/^proxyip *=.*/proxyip = $PROXYIP/" /etc/dansguardian/dansguardian.conf

[[ "$PROXYPORT" != "" ]] && sed -i "s/^proxyport *=.*/proxyport = $PROXYPORT/" /etc/dansguardian/dansguardian.conf

squid3 start
service dansguardian start

sleep infinity
