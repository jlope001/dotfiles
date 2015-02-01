#!/usr/bin/env bash

# jcurl get localhost:4000/foo/bar {'hello': 'world'}
jcurl() {
  VERB=`echo "print '$1'.upper()" | python`
  echo 'curl -v -X$VERB -H -d '$3' -H "Content-Type: application/json" $2 | python -mjson.tool'
}

# fix folder permissions: 755 folder 664 files
fperms() {
  chmod -R 644 $1
  find $1 -type d -print0 | xargs -0 -II chmod 755 'I'
}

# displays all README information for all private dotfiles stuff
function dotfiles() {
  echo "-- =================================================="
  echo "-- $ fperms folder_name"
  echo "-- =================================================="
  echo "--"
  echo "-- reset folder permissions"
  echo "\n\n"

  echo "-- =================================================="
  echo "-- $ jcurl post localhost/resource {'hello': 'world'}"
  echo "-- =================================================="
  echo "--"
  echo "-- json request to remote host"
  echo "\n\n"

  echo "-- =================================================="
  echo "-- aliases"
  echo "--"
  echo "-- alias ..=cd .."
  echo "-- alias ...=cd ../.."
  echo "-- alias ....=cd ../../.."
  echo "-- alias .....=cd ../../../.."
  echo "-- alias ~=cd ~"
  echo "-- alias -- -=cd -"
  echo "\n\n"
}
