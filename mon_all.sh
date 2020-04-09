#!/bin/bash
# monitor n transmission daemons

export RED='\e[0;31m'
export NC='\e[0m' # No Color

if [[ "$OSTYPE" == "linux-gnu" ]] ; then
    # Linux
    cmd='/usr/bin/transmission-remote'
elif [[ "$OSTYPE" == "darwin"* ]] ; then
    # MacOS
    cmd='/usr/local/bin/transmission-remote'
else
    # Unknown.
    echo -e "I don't know what OS you are using. Exiting.\n"
    exit 1
fi


host1='hos1.local:9091'
host2='host2.local:9091'
host3='host3.local:9091'
#cmd='/usr/bin/transmission-remote'

watch -t --color  "echo ${host1} ; \
	${cmd} ${host1} -l | egrep -v 'Idle|Stopped' ; \
	echo "" ; \
	${cmd} ${host1} -st | grep -A 5 'TOTAL' ; \
	echo "" ; \
        echo ${host2} ; \
	${cmd} ${host2} -l | egrep -v 'Idle|Stopped' ; \
	echo "" ; \
	${cmd} ${host2} -st | grep -A 5 'TOTAL'
        echo "" ; \
        echo ${host3} ; \
	${cmd} ${host3} -l | egrep -v 'Idle|Stopped' ; \
	echo "" ; \
	${cmd} ${host3} -st | grep -A 5 'TOTAL'"
