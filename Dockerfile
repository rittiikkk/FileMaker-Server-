FROM amd64/ubuntu:22.04

#Set the user to root
#USER root

# Avoid interactive prompts
#ENV DEBIAN_FRONTEND=noninteractive
#ENV TERM=xterm


# Update all software download sources
RUN DEBIAN_FRONTEND=noninteractive apt update
 
# Upgrade all installed software packages
RUN DEBIAN_FRONTEND=noninteractive apt full-upgrade -y

# Install FileMaker Server dependencies
RUN DEBIAN_FRONTEND=noninteractive      \
    apt install                      -y \
        acl                             \
        apache2-bin                     \
        apache2-utils                   \
        apt-utils                       \
        avahi-daemon                    \
        curl                            \
        fonts-baekmuk                   \
        fonts-liberation2               \
        fonts-noto                      \
        fonts-takao                     \
        fonts-wqy-zenhei                \
        libaio1                         \
        libantlr3c-3.4-0                \
        libavahi-client3                \
        libboost-chrono1.74.0           \
        libboost-system1.74.0           \
        libboost-thread1.74.0           \
        libbz2-1.0                      \
        libc++1-14                      \
        libcurl3-gnutls                 \
        libcurl4                        \
        libdjvulibre21                  \
        libetpan20                      \
        libevent-2.1-7                  \
        libexpat1                       \
        libfontconfig1                  \
        libfreetype6                    \
        libgomp1                        \
        libheif1                        \
        libicu70                        \
        libilmbase25                    \
        libjpeg-turbo8                  \
        liblqr-1-0                      \
        liblzma5                        \
        libodbc1                        \
        libomp5-14                      \
        libopencv-core4.5d              \
        libopencv-highgui4.5d           \
        libopencv-imgproc4.5d           \
        libopenexr25                    \
        libpam0g                        \
        libpng16-16                     \
        libsasl2-2                      \
        libtiff5                        \
        libuuid1                        \
        libvpx7                         \
        libwebpdemux2                   \
        libwebpmux3                     \
        libxml2                         \
        libxpm4                         \
        libxslt1.1                      \
        libzbar0                        \
        logrotate                       \
        lsb-release                     \
        net-tools                       \
        nginx                           \
        odbcinst1debian2                \
        openjdk-17-jdk                  \
        openssl                         \
        policycoreutils                 \
        sysstat                         \
        ufw                             \
        unzip                           \
        zip                             \
        zlib1g


# install user management
RUN DEBIAN_FRONTEND=noninteractive      \
    apt install                      -y \
        init


# Clean up installations
RUN DEBIAN_FRONTEND=noninteractive apt --fix-broken install -y \
    && apt autoremove -y && apt clean -y

# Copy the FileMaker Server .deb package into the container

COPY install/filemaker-server-21.0.2.202-amd64.deb /install/

ENV PATH_WITH_SPACE="Assisted Install.txt"
COPY install/${PATH_WITH_SPACE} /install/
COPY BaseElements.fmx /

# Expose the necessary ports for FileMaker Server
EXPOSE 80
EXPOSE 443
EXPOSE 2399
EXPOSE 5003

# Start the FileMaker Server process when the container runs
CMD ["/sbin/init"]
