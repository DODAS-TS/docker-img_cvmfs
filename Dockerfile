FROM ubuntu

RUN apt-get update && apt install -y wget lsb-release
RUN wget  https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest_all.deb
RUN dpkg -i cvmfs-release-latest_all.deb 
RUN rm -f cvmfs-release-latest_all.deb
RUN apt-get update
RUN apt-get install -y cvmfs cvmfs-server

#RUN cvmfs_server mkfs test
RUN echo "user_allow_other" >> /etc/fuse.conf

COPY scripts/entrypoint.sh /root/entrypoint.sh

RUN chmod +x /root/entrypoint.sh


ENTRYPOINT [ "/root/entrypoint.sh" ]