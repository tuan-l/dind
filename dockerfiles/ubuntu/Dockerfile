# Dockerize an SSH service
# The following code sets up an SSHd service in a container that you can use
# to connect and inspect other container's volumes, or to get quick access to
# a test container.
FROM ubuntu:20.04

## OpenSSH Server
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
## SSH login fix. Otherwise user is kicked off after login
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

## Docker-CE
RUN apt install -y curl
RUN curl -fsSL https://get.docker.com | sh
RUN usermod -aG docker root
RUN apt install -y docker-compose

## Install extra dependencies
RUN apt install -y curl vim git zip unzip

## Working directory
WORKDIR /docker

## Expose SSH port
EXPOSE 22

## Run SSHd in the background
CMD ["/usr/sbin/sshd", "-D"]
