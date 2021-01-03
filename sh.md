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

## dir name, file name from path
Get the directory name or a file name from a file path.
```console
VAR=/path/to/file
dirname=${VAR%/*}
filename=${VAR##*/}
```

## Example scripts

### For each line in file
```console
filename="/path/to/file"
 
while read line
do
    echo "$line"
done < $filename
```

### Split string
```console
IN="bla@some.com;john@home.com"
arrIN=(${IN//;/ })
echo ${arrIN[1]}

# Output: john@home.com
```
Remember to escape special characters with \.

### copy file and make subdirectories
```console
target=/path/to/target
subdirs=${target%/*}
mkdir -p $subdirs      
eval cp $file $target
```
