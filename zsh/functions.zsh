#!/usr/bin/env bash

# jcurl get localhost:4000/foo/bar {'hello': 'world'}
jcurl() {
  VERB=`echo "print '$1'.upper()" | python`
  echo 'curl -v -X$VERB -H -d '$3' -H "Content-Type: application/json" $2 | python -mjson.tool'
}
export jcurl
