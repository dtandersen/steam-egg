#!/bin/bash -x
set -e

sleep 2
env
id

HOME=/home/container
CONTAINER_HOME=/home/container

if [ ! -d ${CONTAINER_HOME}/steamcmd ]; then
  mkdir -p ${CONTAINER_HOME}/steamcmd
  curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -xz -C ${CONTAINER_HOME}/steamcmd
fi

if [ -n "${BETA}" ]; then
  EXTRA_ARGS="-beta ${BETA}"
fi

${CONTAINER_HOME}/steamcmd/steamcmd.sh +login anonymous +force_install_dir ${CONTAINER_HOME} +app_update 600760 ${EXTRA_ARGS} validate +quit
#find . -depth -name ".svn" -type d -exec rm -r "{}" \;

MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

exec ${MODIFIED_STARTUP}
