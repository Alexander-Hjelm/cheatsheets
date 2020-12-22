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
