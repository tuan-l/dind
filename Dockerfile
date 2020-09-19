# Dockerize an SSH service
# The following code sets up an SSHd service in a container that you can use
# to connect and inspect other container's volumes, or to get quick access to
# a test container.
FROM alpine:latest

## Create user account with password
ARG USER_ID=${USER_ID}
ARG USER_PW=${USER_PW}

RUN adduser --disabled-password ${USER_ID}
RUN echo "root:${USER_PW}" | chpasswd > /dev/null 2>&1
RUN echo "${USER_ID}:${USER_PW}" | chpasswd > /dev/null 2>&1
RUN echo "${USER_ID} ALL=(ALL:ALL) ALL" >> /etc/sudoers
# RUN echo "${USER_ID} ALL=NOPASSWD: ALL" >> /etc/sudoers

## Update the 'world' cache and install necessary packages
RUN apk update
RUN apk add --no-cache sudo bash openrc curl vim htop git zip unzip iptables openssh

## Docker-CE
RUN apk add --no-cache docker docker-compose
RUN addgroup root docker
RUN addgroup "${USER_ID}" docker

## OpenSSH
RUN apk add --no-cache openssh
RUN mkdir -p /run/openrc && \
    touch /run/openrc/softlevel && \
    rc-update add sshd default && \
    rc-update add docker boot
## To start docker daemon at boot
## openrc package is used for rc-update
RUN rc-status

RUN mkdir /var/run/sshd
RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
# ## SSH login fix. Otherwise user is kicked off after login
# RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

## Select work user
USER ${USER_ID}
WORKDIR /home/${USER_ID}
RUN ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa

## Working directory
USER root
WORKDIR /workspace
RUN ssh-keygen -A
# RUN /etc/init.d/ssh start

## Run SSHd in the background
ENTRYPOINT ["/bin/bash"]
CMD ["-c", "echo `ifconfig -a eth0 | grep inet` && /usr/sbin/sshd -D"]

## Expose SSH port
EXPOSE 22
