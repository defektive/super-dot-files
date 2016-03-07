# Installing Arch over Existing Linux
## Or, How I switched an existing ubuntu install to arch linux without losing data, or rejoining my domain.

The official installation guide (https://wiki.archlinux.org/index.php/Installation_Guide) contains a more verbose description.

This guide has been forked from https://gist.github.com/binaerbaum/535884a7f5b8a8697557

I've successfully switched existing ubuntu and fedora installations to arch linux without data loss.

## Boot Arch Install
Download the archiso image from https://www.archlinux.org/. Copy to a usb-drive
```
dd if=archlinux.img of=/dev/sdX bs=16M && sync # on linux
```

Boot from the usb. If the usb fails to boot, make sure that secure boot is disabled in the BIOS configuration.

### Get some internets
```
wifi-menu
```

## Mount existing partitions
My ubuntu install had `/boot` and `/boot/efi` as separate partitions. Systemd-boot doesnt like multiple partitions, so I just mount the efi partion at `/boot`. The leaves the `/boot` partition unused. One could reallocate that a later time.

```
cryptsetup open --type=luks /dev/nvme0n1p3 crypted
mount /dev/mapper/ubuntu--vg-root /mnt
mount /dev/nvme0n1p3 /mnt/boot
swapon /dev/mapper/ubuntu--vg-swap1
```

## Move things around so we can get them later
```
cd /mnt
mkdir ubuntu
setopt extended_glob
test mv -- {^,}ubuntu
```

## Install the system
This includes stuff needed for starting wifi when first booting into the newly installed system

```
pacstrap /mnt base base-devel zsh vim git sudo efibootmgr dialog wpa_supplicant
genfstab -pU /mnt >> /mnt/etc/fstab
tmpfs	/tmp	tmpfs	defaults,noatime,mode=1777	0	0
```

Change relatime on all non-boot partitions to noatime (reduces wear if using an SSD)

## Enter the new system
```bash
arch-chroot /mnt /bin/bash
```
### Setup system clock
```
ln -s /usr/share/zoneinfo/Europe/Zurich /etc/localtime
hwclock --systohc --utc
```
### Set the hostname
```
echo MYHOSTNAME > /etc/hostname
```
### Generate locale
Uncomment wanted locales in /etc/locale.gen
```
vim /etc/locale.gen
locale-gen
localectl set-locale LANG=en_US.UTF-8
```
To avoid problems with gnome-terminal set locale system wide
Do NOT set LC_ALL=C. It overrides all the locale vars and messes up special characters
Pay attention to the UTF-8. Capital letters !
```
echo LANG=en_US.UTF-8 >> /etc/locale.conf
echo LC_ALL= >> /etc/locale.conf
```

### Set password for root
```
passwd
```

Add real user remove -s flag if you don't whish to use zsh
```
useradd -m -g users -G wheel,storage,power -s /bin/zsh MYUSERNAME
passwd MYUSERNAME
```

### Configure mkinitcpio with modules needed for the initrd image
```
vim /etc/mkinitcpio.conf
```
- Add 'ext4' to MODULES
- Add 'encrypt' and 'lvm2' to HOOKS before filesystems
- Add 'resume' after 'lvm2' (also has to be after 'udev')

### Regenerate initrd image
```
mkinitcpio -p linux
```
# Setup systembootd (grub will not work on nvme at this moment)
```
bootctl --path=/boot install
```
# Create loader.conf
```
echo 'default arch' >> /boot/loader/loader.conf
echo 'timeout 5' >> /boot/loader/loader.conf
```
# Create arch.conf (or XYZ.conf for default XYZ in loader.conf)
```
vim /boot/loader/entries/arch.conf
```
Add the following content to arch.conf
__<UUID> is the the one of the raw encrypted device (/dev/nvme0n1p2). It can be found with the 'blkid' command__
__Make sure you use the name of volumes for root/swap__
```
title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options cryptdevice=UUID=<UUID>:vg0 root=/dev/mapper/fedora-root resume=/dev/mapper/fedora-swap rw intel_pstate=no_hwp
```
# Exit new system and go into the cd shell
```
exit
```
# Unmount all partitions
```
umount -R /mnt
swapoff -a
```
# Reboot into the new system, don't forget to remove the cd/usb
```
reboot
```
