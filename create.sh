#!/bin/sh

help="create and resize image\nUsage: ./create.sh [-h | bionic | focal | impish | jammy] [name] [size]"

version=$1
if test $version = "-h"; then
    echo $help; exit
fi

name=$2
size=$3
if test "$size" = ""; then
    echo "missing arguments."
    echo $help; exit
fi

./download.sh ${version}

cp "img/${version}-server-cloudimg-amd64-disk-kvm.img" ${name}
qemu-img resize ${name} ${size}

echo "create image done."
