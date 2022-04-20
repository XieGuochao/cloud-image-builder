#!/bin/sh

help="Setup VM password on the first boot.\nUsage: ./setup-password.sh [disk]"

disk=$1
if test $disk = "-h"; then
    echo $help; exit
fi

if test $disk = ""; then
    echo "missing argument."
    echo $help; exit
fi

# echo "#cloud-config
# users:
#   - name: root
#     password: $(mkpasswd --method=SHA-512 --rounds=4096)
#     lock_passwd: false" > tmp-user-data

read -p "Password: " password
echo "#cloud-config 
password: $password 
chpasswd: { expire: False }
ssh_pwauth: True" > user-data

genisoimage -output tmp-seed.iso -volid cidata -joliet -rock user-data meta-data

qemu-system-x86_64 \
	--enable-kvm \
    -nographic \
    -m 8G \
    -cpu host \
    -smp 4 \
    -drive file=$disk,index=1,format=qcow2 \
    -drive file=./tmp-seed.iso,index=0,if=virtio,format=raw \
    
rm tmp-seed.iso user-data