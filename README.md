# cloud-image-builder
A command-line tool to easily build and initialize KVM cloud image.

- Author: Guochao Xie
- Date: 20-04-2022

## Usage

### 1. Create a disk

```
$ ./create.sh [-h | bionic | focal | impish | jammy] [name] [size]

E.g. Create a jammy (Ubuntu 22.04) server image with name disk1.img and size 20G:

$ ./create.sh jammy disk1.img 20G
```

Note: the template image will be cached.

### 2. Set up password for the first time

```
./setup-password.sh [disk]

E.g.

./setup-password.sh disk1.img
```

It will `prompt` to input your initial password for the user `ubuntu`.

Then, it will boot up with 4 cores and 8G memory for the set up of password.

**Important:** You need to **wait** (for around 15 seconds after the prompt of log in) until the cloud-init runs and has the log like this:

```
cloudimg login: cloud-init[1003]: Cloud-init v. 22.1-14-g2e17a0d6-0ubuntu1~22.04.5 running.
cloud-init[1022]: Cloud-init v. 22.1-14-g2e17a0d6-0ubuntu1~22.04.5 running 'modules:final'.
ci-info: no authorized SSH keys fingerprints found for user ubuntu.
<14>Apr 20 10:39:11 cloud-init: ###########################################################
<14>Apr 20 10:39:11 cloud-init: -----BEGIN SSH HOST KEY FINGERPRINTS-----
<14>Apr 20 10:39:11 cloud-init: 1024 SHA256:oxqMWatvXmARpHtwH7awwearUz/TRmPEOFWHCujwWNI ro)
<14>Apr 20 10:39:11 cloud-init: 256 SHA256:8cTQ3pH+e91vidG4rlAEwRMFCATTTsiK1GCOjWfwd1Y roo)
<14>Apr 20 10:39:11 cloud-init: 256 SHA256:vLaOGEVv6Q6eZ+CYSNFPtU8fWNprGgmb/aCwKiBswxo roo)
<14>Apr 20 10:39:11 cloud-init: 3072 SHA256:wyZst2G4BzsHBTtsLB4WNEy92la5RbD7D87qVXJkBHg ro)
<14>Apr 20 10:39:11 cloud-init: -----END SSH HOST KEY FINGERPRINTS-----
<14>Apr 20 10:39:11 cloud-init: ###########################################################
-----BEGIN SSH HOST KEY KEYS-----
ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBDm0sKnOG28pEEFa+7g
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDouZ55unYbrBgUqpBgm/VMmOuUpy2qRM9TVkcHc6m9e root@cloug
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6kk7Cp656dmIcH4pbHI2874ibrvbMv5aAJoeQ5IG786dpHIFJJPg
-----END SSH HOST KEY KEYS-----
cloud-init[1022]: Cloud-init v. 22.1-14-g2e17a0d6-0ubuntu1~22.04.5 finished at Wed, 20 Aprs
```

Now log in with user `ubuntu` and your password. You can now log in and configure your image like the SSH.

You can now run `sudo poweroff` to shut down the password setup process.

### 3. Use your image

Now, you've use your image disk. For example, to boot your `disk1.img` with 4 cores and 8G memory:

```
./boot.sh disk1.img
```

## Possible Issues

By default we will download the `kvm` image to speed up. In case this image is incompatible, you can switch to the original image by removing `-disk-kvm`:

- `download.sh`: `disk="${version}-server-cloudimg-amd64-disk-kvm.img"` -> `disk="${version}-server-cloudimg-amd64.img"`
- `create.sh`: `cp "img/${version}-server-cloudimg-amd64-disk-kvm.img" ${name}` -> `cp "img/${version}-server-cloudimg-amd64.img" ${name}`

## Motivation

I have a Mac M1 machine, but I need to hack Linux kernel. I can use the lab's server, but no x11 is available. Therefore, I create this repo for everyone in this situation... 

Tried and failed many times with all disk data unaccessible...

Hope to save remote developers' lives.

## Credits: 

- [NoCloud](https://cloudinit.readthedocs.io/en/latest/topics/datasources/nocloud.html)
