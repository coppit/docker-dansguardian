#!/bin/bash

function ts {
  echo [`date '+%b %d %X'`]
}

#-----------------------------------------------------------------------------------------------------------------------

if [[ ! -e "/config/lists" ]]
then
  echo "$(ts) Copying configuration to /config"

  cp -ra /etc/dansguardian/lists /config
fi

#-----------------------------------------------------------------------------------------------------------------------

echo "$(ts) Starting DansGuardian container..."

[[ "$PROXYIP" != "" ]] && sed -i "s/^proxyip *=.*/proxyip = $PROXYIP/" /etc/dansguardian/dansguardian.conf

[[ "$PROXYPORT" != "" ]] && sed -i "s/^proxyport *=.*/proxyport = $PROXYPORT/" /etc/dansguardian/dansguardian.conf

rm -rf /etc/dansguardian/lists
ln -s /config/lists /etc/dansguardian/lists

squid3 start
service dansguardian start

sleep infinity
