#!/bin/sh

qemu-system-x86_64 \
	--enable-kvm \
    -nographic \
    -m 8G \
    -cpu host \
    -smp 4 \
    -drive file=$1,index=0,format=qcow2