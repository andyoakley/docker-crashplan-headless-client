FROM debian:jessie

RUN apt-get update
RUN apt-get -y install curl openjdk-7-jre
RUN apt-get -y install cpio openssh-client

COPY unattended.txt /root/

WORKDIR /root
RUN curl -L -O https://download2.code42.com/installs/linux/install/CrashPlan/CrashPlan_4.3.0_Linux.tgz
RUN tar zxf CrashPlan_4.3.0_Linux.tgz

WORKDIR /root/CrashPlan-install
RUN sed -e 's/agreed=0/agreed=1/' install.sh > install.sh.new && mv install.sh.new install.sh && chmod 700 install.sh
RUN ./install.sh <../unattended.txt

WORKDIR /root
RUN mkdir .ssh
COPY runtime.sh /root/
RUN chmod 700 runtime.sh

CMD "./runtime.sh"
