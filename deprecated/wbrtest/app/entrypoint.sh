#!/bin/bash
set -ex

RUN_FLUXBOX=${RUN_FLUXBOX:-yes}
RUN_XTERM=${RUN_XTERM:-yes}

case $RUN_FLUXBOX in
  false|no|n|0)
    sudo rm -f /app/conf.d/fluxbox.conf
    ;;
esac

case $RUN_XTERM in
  false|no|n|0)
    sudo rm -f /app/conf.d/xterm.conf
    ;;
esac

#sudo /bin/sh -c "supervisord -c /app/supervisord.conf"
sudo gosu root /bin/tini -- supervisord -n -c /app/supervisord.conf