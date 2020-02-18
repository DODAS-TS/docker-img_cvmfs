#!/bin/bash

if [ -z $REPO_LIST ]; then

    echo "Env variable REPO_LIST must be specified in the form REPO_LIST=\"cms.cern.ch oasis.cern.ch\""

else

    for repo in $REPO_LIST; do
        if ! [ -d /cvmfs/$repo ]; then
            mkdir /cvmfs/$repo
        fi
        umount /cvmfs/$repo
        mount -t cvmfs $repo /cvmfs/$repo
    done
    sleep infinity


fi
