# Linux Utilities
<!--ts-->
* [Linux Utilities](linux-utilities.md#linux-utilities)
   * [sudo, su](linux-utilities.md#sudo-su)
      * [Switch user](linux-utilities.md#switch-user)
   * [scp](linux-utilities.md#scp)
      * [Paramters](linux-utilities.md#paramters)
   * [tar](linux-utilities.md#tar)
      * [Paramters](linux-utilities.md#paramters-1)
   * [nohup](linux-utilities.md#nohup)
   * [df](linux-utilities.md#df)
   * [$PATH](linux-utilities.md#path)
   * [symlink](linux-utilities.md#symlink)
   * [Mount new disk](linux-utilities.md#mount-new-disk)
   * [Key debug](linux-utilities.md#key-debug)
   * [Debug cron](linux-utilities.md#debug-cron)
   * [cp](linux-utilities.md#cp)
      * [copy all files in a dir](linux-utilities.md#copy-all-files-in-a-dir)
   * [iterate/loop/for each over multiple files](linux-utilities.md#iterateloopfor-each-over-multiple-files)
   * [batch zip from current dir:](linux-utilities.md#batch-zip-from-current-dir)
   * [record gif:](linux-utilities.md#record-gif)
   * [Read midi data from device](linux-utilities.md#read-midi-data-from-device)
   * [Xrandr](linux-utilities.md#xrandr)
   * [List manually installed packages:](linux-utilities.md#list-manually-installed-packages)
      * [apt](linux-utilities.md#apt)
   * [tr](linux-utilities.md#tr)
   * [See distro](linux-utilities.md#see-distro)
   * [sed](linux-utilities.md#sed)
      * [pipe](linux-utilities.md#pipe)
      * [substitution](linux-utilities.md#substitution)
      * [\1 \2 \3...](linux-utilities.md#1-2-3)
      * [use sed to extract a substring](linux-utilities.md#use-sed-to-extract-a-substring)
   * [pdftk](linux-utilities.md#pdftk)
      * [Combine pfds](linux-utilities.md#combine-pfds)
      * [Combine pfds, certain pages](linux-utilities.md#combine-pfds-certain-pages)
   * [networking](linux-utilities.md#networking)
      * [netcat, nc](linux-utilities.md#netcat-nc)
      * [Find host ip address](linux-utilities.md#find-host-ip-address)
      * [stress](linux-utilities.md#stress)
   * [apt, apt-get](linux-utilities.md#apt-apt-get)
      * [Download a package locally, do not install](linux-utilities.md#download-a-package-locally-do-not-install)
   * [curl](linux-utilities.md#curl)
      * [curl POST with parameters](linux-utilities.md#curl-post-with-parameters)
      * [curl to post json](linux-utilities.md#curl-to-post-json)
   * [dotnet](linux-utilities.md#dotnet)
      * [new project](linux-utilities.md#new-project)
      * [build/run project](linux-utilities.md#buildrun-project)
      * [Misc](linux-utilities.md#misc)
         * [List SKDs](linux-utilities.md#list-skds)
      * [Troubleshooting](linux-utilities.md#troubleshooting)
         * [The framework 'Microsoft.AspNetCore.App', version '2.2.0' was not found.](linux-utilities.md#the-framework-microsoftaspnetcoreapp-version-220-was-not-found)
   * [openssl](linux-utilities.md#openssl)
      * [Create a certificate](linux-utilities.md#create-a-certificate)
      * [convert pem to crt](linux-utilities.md#convert-pem-to-crt)
      * [Install trusted certificates](linux-utilities.md#install-trusted-certificates)
   * [sqlcmd](linux-utilities.md#sqlcmd)

<!-- Added by: runner, at: Sat Feb  5 10:39:56 UTC 2022 -->

<!--te-->

## sudo, su

### Switch user
```bash
$ sudo su
$ su - <other user name>
```

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

## See distro
```bash
lsb_release -a
```

## sed

Usage:
```bash
sed [-n] [-e] '' [-e] '' [file]
```

**Note** that sed operates once per line

Paramters:
- -n: no printing
- -e '': edit command, command inside '', multiple -e-commands possible

Commands (''):
- d: delete
- p: print

### pipe
Example of a sed pipe:
```bash
echo "test" | sed [-n] [-e] '' [-e] ''
```
### substitution
Syntax:
```
echo "test" | sed "s/[search pattern]/[replacement]/"
```

Example:
```
echo "day morning day" | sed "s/day/night/"
> night morning day
```

### &

& corresponds to the pattern found.

Example:
```
echo "test" | sed "s/[a-z]*/prefix: & :suffix/"
> prefix: test :suffix
```

### \1 \2 \3...

\1 \2 \3... keeps part of the pattern, must be combined with escaped parenthesises, \\( \\).

Example:
```
echo "test 123" | sed "s/\([a-z]*\)/not-a-\1/"
> not-a-test 123
```


### use sed to extract a substring

The following sed command will extract the substring that is between the underscores in the sentence:

```bash
echo "huh dam _wtf_ now" | sed 's/[^_]*_\([^_]*\).*/\1/'
> wtf
```

**Note** that if the regex pattern is not matched, the full original string will be returned

sed pattern explained:

- \[^_\]*: any character except for _, any number of times
- _: the character _
- \\( )\\: the escaped parentheses. Anything inside here will be kept in the replacement pattern
- \[^_\]*: any character except for _, any number of times
- .*: any character, any number of times

## pdftk

### Combine pfds

```bash
pdftk file1.pdf file2.pdf file3.pdf cat output newfile.pdf
```

### Combine pfds, certain pages

```bash
pdftk A=one.pdf B=two.pdf cat A1-7 B1-5 A8 output combined.pdf
```

## networking

### netcat, nc
```bash
nc -v google.com 443
```

### Find host ip address
```bash
wget http://ipecho.net/plain -O - -q ; echo
```

### stress

stress is a load tester utility for network applications.

Install and run with 8 cpu cores:
```bash
sudo yum install stress -y
stress -c 8
```

## apt, apt-get

### Download a package locally, do not install
```bash
sudo apt-get install --download-only git
```

The .deb packages will be downloaded to `/var/cache/apt/archives`.

## curl

### curl POST with parameters
```bash
curl -X POST --data "this is raw data" https://example.com/endpoints?req_param_1=hello&req_param_2=hi
```
### curl to post json
```bash
curl --header "Content-Type: application/json" --request POST --data "{\"name\": \"eddie\"}" https://<your-url-here
```

## dotnet

### new project
List available templates
```bash
dotnet new
```

Create new projects
```bash
dotnet new webapi -n mywebapi
```

### build/run project
```bash
dotnet build
dotnet run -- -u 3 -s 10 -p 1 -r 75 -e 5
```

### Misc
#### List SKDs
```bash
dotnet --list-sdks
```

### Troubleshooting

#### The framework 'Microsoft.AspNetCore.App', version '2.2.0' was not found.
Get the correct version of the dotnet core SDK with:
```bash
sudo snap refresh dotnet-sdk --classic --channel=2.2
```
Remember to roll back to the previous version you were using afterwards.

## openssl

### Create a certificate
```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -out knote-ingress-tls.crt -keyout knote-ingress-tls.key -subj "/CN=secretscanner.info/O=knote-ingress-tls" -addext "subjectAltName = DNS:secretscanner.info"
```

### convert pem to crt
```bash
openssl x509 -outform der -in your-cert.pem -out your-cert.crt
```

### Install trusted certificates
```bash
sudo cp knote-ingress-tls.crt /usr/share/ca-certificates/extra/knote-ingress-tls.crt
sudo dpkg-reconfigure ca-certificates
sudo update-ca-certificates
```

Note: You may also have to add the certifiactes manually in chrome or firefox


## sqlcmd
```bash
sqlcmd -S localhost -U sa -P Dev_12345 -d secret-scanner-dev
SELECT * from collection
GO
```
