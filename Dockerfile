FROM centos:centos7.9.2009

RUN yum install -y sysstat man wget screen ntp autoconf.noarch automake file gcc \
    libtool policycoreutils-python patch quilt git make rpm-build zlib-devel \
    pam-devel openssl-devel lzo-devel unzip systemd-devel net-tools


RUN mkdir -p /root/download && cd /root/download && \
    wget 'https://swupdate.openvpn.org/community/releases/openvpn-2.4.12.tar.gz' && \
    wget 'https://raw.githubusercontent.com/Tunnelblick/Tunnelblick/master/third_party/sources/openvpn/openvpn-2.4.12/patches/02-tunnelblick-openvpn_xorpatch-a.diff' && \
    wget 'https://raw.githubusercontent.com/Tunnelblick/Tunnelblick/master/third_party/sources/openvpn/openvpn-2.4.12/patches/03-tunnelblick-openvpn_xorpatch-b.diff' && \
    wget 'https://raw.githubusercontent.com/Tunnelblick/Tunnelblick/master/third_party/sources/openvpn/openvpn-2.4.12/patches/04-tunnelblick-openvpn_xorpatch-c.diff' && \
    wget 'https://raw.githubusercontent.com/Tunnelblick/Tunnelblick/master/third_party/sources/openvpn/openvpn-2.4.12/patches/05-tunnelblick-openvpn_xorpatch-d.diff' && \
    wget 'https://raw.githubusercontent.com/Tunnelblick/Tunnelblick/master/third_party/sources/openvpn/openvpn-2.4.12/patches/06-tunnelblick-openvpn_xorpatch-e.diff' && \
    wget 'https://raw.githubusercontent.com/Tunnelblick/Tunnelblick/master/third_party/sources/pkcs11-helper-1.27.0.tar.bz2' && \
    tar xzvf openvpn-2.4.12.tar.gz && mv *.diff openvpn-2.4.12 && \
    tar xjvf pkcs11-helper-1.27.0.tar.bz2 && cd /root/download/pkcs11-helper-1.27.0 && \
    ./configure && make && make install && \
    cd /root/download/openvpn-2.4.12 && \
    git apply 02-tunnelblick-openvpn_xorpatch-a.diff &&\
    git apply 03-tunnelblick-openvpn_xorpatch-b.diff &&\
    git apply 04-tunnelblick-openvpn_xorpatch-c.diff &&\
    git apply 05-tunnelblick-openvpn_xorpatch-d.diff &&\
    git apply 06-tunnelblick-openvpn_xorpatch-e.diff &&\
    autoreconf -i -v -f && \
    ./configure --prefix=/usr --enable-pkcs11=/usr/local/lib --enable-static=yes --enable-systemd=yes \
    --enable-shared --enable-crypto --disable-debug --disable-plugin-auth-pam \
    --disable-dependency-tracking && \
    make && make install

