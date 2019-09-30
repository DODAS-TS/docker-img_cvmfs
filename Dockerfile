FROM centos:7

RUN yum install https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest.noarch.rpm &&\
       yum install cvmfs  cvmfs-server

RUN cvmfs_server mkfs test

COPY scripts/entrypoint.sh /root/entrypoint.sh

RUN chmod +x /root/entrypoint.sh


ENTRYPOINT [ "/root/entrypoint.sh" ]