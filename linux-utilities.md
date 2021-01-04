## scp

Copy files to a remote over ssh:

```console
$ scp myfile.txt myfile2.txt remoteuser@remoteserver:/remote/folder/
```

Copy multiple files:

```console
$ scp * remoteuser@remoteserver:/remote/folder/
```

### Paramters

- **r**: recursive

## tar

Extract tar files:


```console
$ tar xvf tarfile.tar
```

### Paramters

- **x**: extract
- **v**: verbose
- **f**: specify file
- **z**: specific for .gz-files

## nohup

Run commands in the background, detached from the terminal

```console
nohup command &>/dev/null &
```

Notes: the pipe to /dev/null exists to prevent nohup from generating a nohup.out-file.


## df

View disk usage

```console
df -h
```

## $PATH

Add a directory to $PATH
```console
export PATH=[/path/to/dir]:$PATH
```

## symlink

Create symlink, path to link, in the current folder with the same name
```console
ln -s /path/to/link
```

## Mount new disk
```console
dmesg  # Check on which volume the drive is, eg /dev/sda1
sudo mount /dev/sda1 ~/usb-drive
umount /dev/sda1
```

## Key debug
```console
xev
```

## Debug cron

```console
grep CRON /var/log/syslog
```
## cp

### copy all files in a dir
```console
cp -a source/. dest/
```

## iterate/loop/for each over multiple files
```console
for i in *; do echo "$i"; done
```

## batch zip from current dir:
```console
for i in */; do zip -r "${i%/}.zip" "$i"; done
```

## record gif:
```console
kazam
```
or
```console
ffmpeg -i video.avi -r 30 -vf scale=500x500 video.gif
```

## Read midi data from device
```console
amidi -p hw:1,0,0 --dump
```

## Xrandr
```console
xrandr --output HDMI-1-1 --right-of eDP-1-1
```
