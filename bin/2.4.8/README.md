    yum update -y
    yum install -y sysstat man wget screen ntp autoconf.noarch automake file gcc \
    libtool policycoreutils-python patch quilt git make rpm-build zlib-devel \
    pam-devel openssl-devel lzo-devel unzip systemd-devel

    mkdir -p /root/download
    cd /root/download
    wget 'https://swupdate.openvpn.org/community/releases/openvpn-2.4.8.tar.gz'
    wget 'https://raw.githubusercontent.com/Tunnelblick/Tunnelblick/master/third_party/sources/openvpn/openvpn-2.4.8/patches/02-tunnelblick-openvpn_xorpatch-a.diff'
    wget 'https://raw.githubusercontent.com/Tunnelblick/Tunnelblick/master/third_party/sources/openvpn/openvpn-2.4.8/patches/03-tunnelblick-openvpn_xorpatch-b.diff'
    wget 'https://raw.githubusercontent.com/Tunnelblick/Tunnelblick/master/third_party/sources/openvpn/openvpn-2.4.8/patches/04-tunnelblick-openvpn_xorpatch-c.diff'
    wget 'https://raw.githubusercontent.com/Tunnelblick/Tunnelblick/master/third_party/sources/openvpn/openvpn-2.4.8/patches/05-tunnelblick-openvpn_xorpatch-d.diff'
    wget 'https://raw.githubusercontent.com/Tunnelblick/Tunnelblick/master/third_party/sources/openvpn/openvpn-2.4.8/patches/06-tunnelblick-openvpn_xorpatch-e.diff'
    wget 'https://raw.githubusercontent.com/Tunnelblick/Tunnelblick/master/third_party/sources/pkcs11-helper-1.22.tar.bz2'

    tar xjvf pkcs11-helper-1.22.tar.bz2
    cd /root/download/pkcs11-helper-1.22
    ./configure
    make && make install

    tar xzvf openvpn-2.4.8.tar.gz
    mv *.diff openvpn-2.4.8
    cd /root/download/openvpn-2.4.8
    git apply 02-tunnelblick-openvpn_xorpatch-a.diff
    git apply 03-tunnelblick-openvpn_xorpatch-b.diff
    git apply 04-tunnelblick-openvpn_xorpatch-c.diff
    git apply 05-tunnelblick-openvpn_xorpatch-d.diff
    git apply 06-tunnelblick-openvpn_xorpatch-e.diff

    autoreconf -i -v -f

    ./configure --prefix=/usr --enable-pkcs11=/usr/local/lib --enable-static=yes --enable-systemd=yes \
    --enable-shared --enable-crypto --disable-debug --disable-plugin-auth-pam \
    --disable-dependency-tracking
    make && make install
