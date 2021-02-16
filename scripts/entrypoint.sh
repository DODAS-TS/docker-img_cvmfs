#!/usr/bin/env bash

if [[ -z $REPO_LIST ]]; then

    echo "Env variable REPO_LIST must be specified in the form REPO_LIST=\"cms.cern.ch oasis.cern.ch\""

else
    for repo in $REPO_LIST; do
        if ! [[ -d /cvmfs/$repo ]]; then
            mkdir /cvmfs/$repo
        fi
	if mountpoint -q /cvmfs/$repo ; then
	    umount /cvmfs/$repo
	fi
	
    mount -t cvmfs $repo /cvmfs/$repo
    done

    sleep infinity
fi
