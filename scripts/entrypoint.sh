while true; do
    df -H | grep -vE '^Filesystem|tmpfs' | awk '{ print $5 " " $1 }' | while read output;
    do
	   usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )
       partition=$(echo $output | awk '{ print $2 }' )
        if [ $usep -ge 90 ]; then
               echo "Running out of space \"$partition ($usep%)\" on $(hostname) as on $(date)" 
               cvmfs_talk cleanup 1000
              #cvmfs_config wipecache
        fi
    done
    cmd="ls /cvmfs/cms.cern.ch/cmsset_default.sh"
    timeout 10 $cmd
    if [ $? -ne 0 ]; then
        echo "CVMFS Problems"
        if [ $? -eq 124 ]; then
            echo "Actually timeout occurred"
        fi
        echo "Re-mount CVMFS"
		if [ -d /cvmfs/cms.cern.ch ]; then
        umount /cvmfs/cms.cern.ch ;
		umount /cvmfs/oasis.opensciencegrid.org;
		umount /cvmfs/singularity.opensciencegrid.org
	    else
			mkdir -p /cvmfs/cms.cern.ch
	    fi
		mount -t cvmfs cms.cern.ch /cvmfs/cms.cern.ch/
		mount -t cvmfs oasis.opensciencegrid.org /cvmfs/oasis.opensciencegrid.org
		mount -t cvmfs singularity.opensciencegrid.org /cvmfs/singularity.opensciencegrid.org
        echo 2
        if [ ! -f /cvmfs/cms.cern.ch/cmsset_default.sh ]; then
            echo "Failed mounting CVMFS...trying again"
        else
            echo "Successfully mounted CVMFS..."
            sleep 15
        fi;
    else
        echo "all is ok"
        sleep 15
    fi;
done;
