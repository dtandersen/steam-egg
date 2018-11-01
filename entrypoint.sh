#!/bin/bash -x
set -e

sleep 2
env

CONTAINER_HOME=/home/container

if [ ! -d ${CONTAINER_HOME}/steamcmd ]; then
  mkdir -p ${CONTAINER_HOME}/steamcmd
  cd ${CONTAINER_HOME}/steamcmd
  wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
  tar xf steamcmd_linux.tar.gz
  rm steamcmd_linux.tar.gz
  cd ${CONTAINER_HOME}
fi

if [ -n "${BETA}" ]; then
  EXTRA_ARGS="-beta ${BETA}"
fi

${CONTAINER_HOME}/steamcmd/steamcmd.sh +login anonymous +force_install_dir ${CONTAINER_HOME} +app_update 600760 ${EXTRA_ARGS} +quit
find . -depth -name ".svn" -type d -exec rm -r "{}" \;

MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

exec ${MODIFIED_STARTUP}
