[[_TOC_]]

## Shebang
Shebang is the path to the sh interpreter, sending this file as input
```console
#!/bin/sh
```

## Printing
```console
echo Hello World!
```

## Variables
Variable assignment, remmeber: no spaces on either side of the =-sign!
```console
MY_VAR="some text"
```

## Command output
This is how you assign a variable
```console
DATE=$(date)
```
## For each line in file
```console
filename="/path/to/file"
 
while read line
do
    echo "$line"
done < $filename
```

## Split string
```console
IN="bla@some.com;john@home.com"
arrIN=(${IN//;/ })
echo ${arrIN[1]}

# Output: john@home.com
```
Remember to escape special characters with \.

## copy files and make subdirectories
```console
if [ ! -d "$2" ]; then
    mkdir -p "$2"
fi
cp -R "$1" "$2"
```
