#!/data/data/com.termux/files/usr/bin/bash
folder=ubuntu-fs
if [ -d "$folder" ]; then
	first=1
	echo "skipping downloading"
fi
tarball="ubuntu-rootfs.tar.xz"

if [ "$first" != 1 ];then
	if [ ! -f $tarball ]; then
		echo "Download Rootfs, this may take a while base on your internet speed."
		case `dpkg --print-architecture` in
		aarch64)
			arch="arm64" ;;
		arm)
			arch="armhf" ;;
		amd64)
			arch="amd64" ;;
		x86_64)
			arch="amd64" ;;	
		i*86)
			arch="i386" ;;
		x86)
			arch="i386" ;;
		*)
			echo "unknown architecture"; exit 1 ;;
		esac
    wget "https://partner-images.canonical.com/core/disco/current/ubuntu-disco-core-cloudimg-${arch}-root.tar.gz" -O $tarball
  fi
	cur=`pwd`
	mkdir -p "$folder"
	cd "$folder"
	echo "Decompressing Rootfs, please be patient."
	proot --link2symlink tar -xJf ${cur}/${tarball} --exclude=dev||:
	echo "fixing nameserver, otherwise it can't connect to the internet"
	echo "nameserver 8.8.8.8" > etc/resolv.conf
	echo "nameserver 8.8.4.4" > etc/resolv.conf
	cd "$cur"
fi
mkdir -p ubuntu-binds
bin=start-ubuntu.sh
echo "writing launch script"
cat > $bin <<- EOM
#!/bin/bash
cd \$(dirname \$0)
## unset LD_PRELOAD in case termux-exec is installed
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" -0"
command+=" -r /data/data/com.termux/files/home/$folder"
if [ -n "\$(ls -A /data/data/com.termux/files/home/ubuntu-binds)" ]; then
    for f in /data/data/com.termux/files/home/ubuntu-binds/* ;do
      . \$f
    done
fi
command+=" -b /dev"
command+=" -b /proc"
command+=" -b /data/data/com.termux/files/home/ubuntu-fs/root:/dev/shm"
## uncomment the following line to have access to the home directory of termux
command+=" -b /data/data/com.termux/files/home:/root"
## uncomment the following line to mount /sdcard directly to / 
command+=" -b /sdcard"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=\$TERM"
command+=" LANG=C.UTF-8"
command+=" /bin/bash --login"
com="\$@"
if [ -z "\$1" ];then
    exec \$command
else
    \$command -c "\$com"
fi
EOM

mkdir -p /data/data/com.termux/files/home/ubuntu-fs/var/tmp
rm -rf /data/data/com.termux/files/home/ubuntu-fs/usr/local/bin/*

echo "fixing shebang of $bin"
termux-fix-shebang $bin
echo "making $bin executable"
chmod +x $bin
echo "adding group ids for group errors"
echo "group3001:x:3001:" >> /data/data/com.termux/files/home/ubuntu-fs/etc/groups
echo "group3003:x:3003:" >> /data/data/com.termux/files/home/ubuntu-fs/etc/groups
echo "group9997:x:9997:" >> /data/data/com.termux/files/home/ubuntu-fs/etc/groups
echo "group20139:x:20139:" >> /data/data/com.termux/files/home/ubuntu-fs/etc/groups
echo "group50139:x:50139:" >> /data/data/com.termux/files/home/ubuntu-fs/etc/groups
echo "group99909997:x:99909997:" >> /data/data/com.termux/files/home/ubuntu-fs/etc/groups
echo "removing image for some space"
rm $tarball
mv $bin /data/data/com.termux/files/usr/bin
mv /data/data/com.termux/files/usr/bin/$bin /data/data/com.termux/files/usr/bin/startubuntu
chmod 700 /data/data/com.termux/files/usr/bin/startubuntu
echo "You can now launch Ubuntu with startubuntu"
