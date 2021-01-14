## scp

Copy files to a remote over ssh:

```bash
$ scp myfile.txt myfile2.txt remoteuser@remoteserver:/remote/folder/
```

Copy multiple files:

```bash
$ scp * remoteuser@remoteserver:/remote/folder/
```

### Paramters

- **r**: recursive

## tar

Extract tar files:


```bash
$ tar xvf tarfile.tar
```

### Paramters

- **x**: extract
- **v**: verbose
- **f**: specify file
- **z**: specific for .gz-files

## nohup

Run commands in the background, detached from the terminal

```bash
nohup command &>/dev/null &
```

Notes: the pipe to /dev/null exists to prevent nohup from generating a nohup.out-file.


## df

View disk usage

```bash
df -h
```

## $PATH

Add a directory to $PATH
```bash
export PATH=[/path/to/dir]:$PATH
```

## symlink

Create symlink, path to link, in the current folder with the same name
```bash
ln -s /path/to/link
```

## Mount new disk
```bash
dmesg  # Check on which volume the drive is, eg /dev/sda1
sudo mount /dev/sda1 ~/usb-drive
umount /dev/sda1
```

## Key debug
```bash
xev
```

## Debug cron

```bash
grep CRON /var/log/syslog
```
## cp

### copy all files in a dir
```bash
cp -a source/. dest/
```

## iterate/loop/for each over multiple files
```bash
for i in *; do echo "$i"; done
```

## batch zip from current dir:
```bash
for i in */; do zip -r "${i%/}.zip" "$i"; done
```

## record gif:
```bash
kazam
```
or
```bash
ffmpeg -i video.avi -r 30 -vf scale=500x500 video.gif
```

## Read midi data from device
```bash
amidi -p hw:1,0,0 --dump
```

## Xrandr
```bash
xrandr --output HDMI-1-1 --right-of eDP-1-1
```

## List manually installed packages:

### apt
```bash
comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u)
```

## tr
Translate/replace character sequences.
```bash
echo example_string_hello | tr _ -
# example-string-hello
```
