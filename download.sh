#!/bin/sh

# download.sh

help="Download a specific version of Ubuntu\nUsage: ./download.sh [-h | bionic | focal | impish | jammy]"

version=$1
if test $version = "-h"; then
    echo $help; exit
fi

disk="${version}-server-cloudimg-amd64-disk-kvm.img"
root="${version}-server-cloudimg-amd64-root.tar.xz"

if test -f "img/$disk"; then
    echo "$disk exists"
else
    wget -O "img/$disk" "https://cloud-images.ubuntu.com/${version}/current/${disk}"
fi

echo "download done."