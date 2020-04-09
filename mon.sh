#!/bin/bash
# run on localhost
export RED='\e[0;31m'
export NC='\e[0m' # No Color

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # Linux
    command='/usr/bin/transmission-remote'
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # MacOS
    command='/usr/local/bin/transmission-remote'
else
    # Unknown.
    echo -e "I don't know what OS you are using. Exiting.\n"
    exit 1
fi

#command='/usr/bin/transmission-remote'
torrent_id=${1}
#output="${command} -t ${torrent_id} -i"
tracker="${command} -t ${torrent_id} -it | grep 'Tracker'"

#watch "${tracker} ; echo "" ; \
watch -t "${command} -t ${torrent_id} -i |egrep 'Name|Percent|Upload|Download|Peers|ETA' ; \
       echo "" ; \
       ${command} -t ${torrent_id} -if ; \
       echo  "" ; \
       ${command} -t ${torrent_id} -ip ; \
       echo  "" ; \
       ${command} -t ${torrent_id} -it"

#watch "${tracker} ; echo "" ; ${command} -t ${torrent_id} -i |egrep 'Name|Percent|Upload|Download|Peers|ETA' ; echo "" ; ${command} -t ${torrent_id} -if -ip"
#	${command} -t ${torrent_id} -if ; \
