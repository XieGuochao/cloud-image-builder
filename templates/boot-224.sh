#!/bin/sh

help="Usage: ./boot-224.sh [disk-file]"

./qemu-system-x86_64 \
	--enable-kvm \
	-m 128G \
	-cpu host \
	-smp cores=28,threads=1,sockets=8 \
	-numa node,nodeid=0,mem=16G,cpus=0-27 \
	-numa node,nodeid=1,mem=16G,cpus=28-55 \
	-numa node,nodeid=2,mem=16G,cpus=56-83 \
	-numa node,nodeid=3,mem=16G,cpus=84-111 \
	-numa node,nodeid=4,mem=16G,cpus=112-139 \
	-numa node,nodeid=5,mem=16G,cpus=140-167 \
	-numa node,nodeid=6,mem=16G,cpus=168-195 \
	-numa node,nodeid=7,mem=16G,cpus=196-223 \
	-drive file=$1,format=raw \
	-nographic \
	-overcommit mem-lock=off \
	-device virtio-serial-pci,id=virtio-serial0,bus=pci.0,addr=0x6 \
	-device virtio-net-pci,netdev=hostnet0,id=net0,bus=pci.0,addr=0x3 \
	-netdev user,id=hostnet0,hostfwd=tcp::4444-:22 \
	-qmp tcp:127.0.0.1:5555,server,nowait \