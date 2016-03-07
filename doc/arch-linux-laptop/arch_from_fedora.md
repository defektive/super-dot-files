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
My ubuntu and fedora installs had `/boot` and `/boot/efi` as separate partitions. Systemd-boot doesnt like multiple partitions, so I just mounted the efi partion to `/boot`. The leaves the `/boot` partition unused. One could reallocate that a later time.

Be sure to make note of what the volume is mapped as, since we'll need it later. here is mapped as `fedora-home`, `fedora-root`, `fedora-swap`.
your device may have different names.

```
cryptsetup open --type=luks /dev/nvme0n1p3 crypted
mount /dev/mapper/fedora-root /mnt
```

## Move things around so we can get them later
since I migrated fedora, i moved everything to a fedora folder
```
cd /mnt
mkdir fedora
setopt extended_glob
test mv -- {^,}fedora
```

## Finish mounting partitions

```
mount /dev/mapper/fedora-home /mnt/home
swapon /dev/mapper/fedora-swap
```


## Install the system
This includes stuff needed for starting wifi when first booting into the newly installed system

```
pacstrap /mnt base base-devel zsh vim git sudo efibootmgr dialog wpa_supplicant
genfstab -pU /mnt >> /mnt/etc/fstab
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
### Copy stuff from old install
```
cp /fedora/etc/hostname > /etc/hostname
cp /fedora/etc/machine-id > /etc/machine-id
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
### Setup systembootd (grub will not work on nvme at this moment)
```
bootctl --path=/boot install
```
### Create loader.conf
```
echo 'default arch' >> /boot/loader/loader.conf
echo 'timeout 5' >> /boot/loader/loader.conf
```
### Create arch.conf (or XYZ.conf for default XYZ in loader.conf)
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
### Exit new system and go into the cd shell
```
exit
```
### Unmount all partitions
```
umount -R /mnt
swapoff -a
```
### Reboot into the new system, don't forget to remove the cd/usb
```
reboot
```

## Moar configs

I had to add `/usr/bin/core_perl` to my `PATH`


### Install yaourt
there are probably some packaages you need to install for this to work...
```
cd /tmp
git clone https://aur.archlinux.org/package-query.git
cd package-query/
makepkg -si
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt/
makepkg -si
```

### getting graphical
```
pacman -Syu
pacman -S xorg xorg-xinit dmenu xautolock i3-gaps sxhkd rxvt-unicode-patched xf86-video-fbdev xf86-video-nouveau ttf-dejavu
echo exec i3 > .xinitrc
startx
```
### getting active directory

```
pacman -S krb5 samba sssd gamin extra/libpwquality
cp -r /etc/pam.d/ /etc/pam.d.backup
cp /fedora/etc/pam.d/system-auth /etc/pam.d
cp /fedora/etc/pam.d/passwd /etc/pam.d
cp -r /fedora/etc/krb5.* /etc/
cp -r /fedora/var/lib/sss /var/lib/
cp /etc/nsswitch.conf /etc/nsswitch.conf.backup
cp /fedora/etc/nsswitch.conf /etc/

# remove oddjob mkdir
vim /etc/pam.d/system-auth

rm /etc/krb5.conf.d/crypto-policies
cp /fedora/usr/share/crypto-policies/DEFAULT/krb5.txt /etc/krb5.conf.d/crypto-policies

systemctl restart sssd
systemctl enable sssd
```

### Remote Connections

```
yaourt -S openconnect openssh
```

### Fix sudoer
```
vim /etc/sudoers
```
### Moar graphics
```
yaourt -S bspwm lemonbar-xft-git feh xdo xtitle bc
yaourt -S ttf-font-icons
```

### set zsh as `default_shell` in sssd.conf
```
sudo vim /etc/sssd/
sudo systemctl restart sssd
```

### Productivity Apps, and Docker
```
yaourt -S google-chrome slack-desktop docker-compose

# i had some custom docker setting in `/fedora/etc/systemd/system/docker.service.d/`
sudo cp -r /fedora/etc/systemd/system/docker.service.d/ /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl start docker
sudo systemctl enable docker
```

### other misc crap i did
```

yaourt -S ruby
yaourt -S acpi
yaourt -S mpd mpc ncmpcpp
yaourt -S pulseaudio paprefs pavucontrol
yaourt -S sutils-git
yaourt -S lemonbar-xft-git
sudo vim /etc/mpd.conf
sudo vim /etc/pulse/default.pa
cat /fedora/etc/pulse/default.pa
sudo vim /etc/pulse/default.pa
```
