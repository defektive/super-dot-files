# Super Dot Files
## Hackistan Edition

**Arch linux, bspwm, yay, BlackArch Repos**
![Screenshot](screenshot.png)
---

## Usage

### Keyboard Shortcuts


|Keys                           | action                                |
|-------------------------------|---------------------------------------|
| `super + enter`               | New terminal window                   |
| `super + ctrl + shift + 4`    | Take screen shot                      |
| `super + [1-6]`               | Switch to desktop [1-6]               |
| `super + ctrl + [1-6]`        | Move current window to desktop [1-6]  |


## Installation

### Existing Arch Linux install

I've always used these as a reference when installing
- https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS
- https://wiki.archlinux.org/index.php/installation_guide

```
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
```

now follow https://wiki.archlinux.org/index.php/installation_guide#Time_zone

- create a user, with sudo permissions


```
echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel.conf
useradd -m -G wheel -s /bin/bash operator
```


```
git clone ...
cd super-dot-files
provisioners/install.sh
```

### Vagrant

This uses vagrant, but everything should work on a clean install of Arch

**OSX Note: sadly I couldn't get certain key combinations to work (super + {Left, Right, Up, Down}) so that has been mapped to alt**

```
vagrant up
```

## Making things work better

### Low battery warnings and hibernate

- Add `resume` to `HOOKS` after `filesystems` before `fsck`
- Add `resume=/dev/mapper/[LVM SWAP NAME]` to kernel options in `/boot/loaders/*.conf`
- run `sudo mkinitcpio -p linux`
