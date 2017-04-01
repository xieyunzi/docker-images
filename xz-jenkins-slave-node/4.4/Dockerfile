# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
FROM node:4.4
MAINTAINER xieyunzi <xieyunzi@foxmail.com>

COPY shared/sources.list /etc/apt/

# In case you need proxy
#RUN echo 'Acquire::http::Proxy "http://127.0.0.1:8080";' >> /etc/apt/apt.conf

# Upgrade packages on image
# Preparations for sshd
RUN apt-get -q update && \
    DEBIAN_FRONTEND="noninteractive" apt-get -q upgrade -y -o Dpkg::Options::="--force-confnew" --no-install-recommends && \
    apt-get -q autoremove

RUN DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew"  --no-install-recommends openssh-server &&\
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd &&\
    mkdir -p /var/run/sshd

# Install JDK 7
RUN DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew"  --no-install-recommends openjdk-7-jre-headless

# Set user jenkins to the image
RUN useradd -m -d /home/jenkins -s /bin/sh jenkins &&\
    echo "jenkins:jenkins" | chpasswd

# sudoer group
RUN groupadd sudoer
RUN usermod -a -G sudoer jenkins

# install sudo
RUN apt-get install sudo
RUN echo '%sudoer ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# fix locales shit, EVER !
COPY shared/locale.gen /etc/
RUN DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew"  --no-install-recommends locales
# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# use cnpm
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org

# proxy anything ! thanks great wall
RUN DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew"  --no-install-recommends proxychains

RUN apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin

# Standard SSH port
EXPOSE 22
# Default command
CMD ["/usr/sbin/sshd", "-D"]
