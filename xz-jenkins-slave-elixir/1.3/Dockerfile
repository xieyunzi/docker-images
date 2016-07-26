# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
FROM xz-otp-18-elixir:1.3
MAINTAINER xieyunzi <xieyunzi@foxmail.com>

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

# fix locales shit, EVER !
COPY shared/locale.gen /etc/
RUN DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew"  --no-install-recommends locales &&\
    locale-gen

RUN apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin

COPY shared/sources.list /etc/apt/

USER jenkins
# install Elixir Hex
RUN mix local.hex --force
# install Rebar
RUN mix local.rebar --force

USER root
# Standard SSH port
EXPOSE 22
# Default command
CMD ["/usr/sbin/sshd", "-D"]
