#!/bin/bash

sudo gosu root /bin/tini -- supervisord -n -c /app/supervisord.conf
