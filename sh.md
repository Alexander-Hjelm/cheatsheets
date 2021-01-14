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

## Functions
Parameters can be reached via $1, $2, $3, etc...
```console
example_function()
{
  echo $1
  return
}

example_function "Hello World!"
```

## Arrays

### Assignment
```console
array_name=("f1.txt" "f2.txt" "f3.txt" "f4.txt" "f5.txt")
```

### Append
```console
array_name=()
array_name+="test"
array_name+=("$line")
```

### Access

#### By index
```console
echo ${files[1]}
```

#### Iterate over elements
```console
names=(Anna Linda Hanna)
for name in ${names[@]};
do
  echo $name
# other stuff on $name
done
```

#### Print the whole list
```console
echo ${files[*]}
```

### Read lines of file into an array
```console
readarray -t node_versions_to_keep <nvm-versions-to-keep.txt
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

## Find host machine platform
```console
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac
echo ${machine}
```

## if statement
Pay attention to whitespace
```console
if [ $var_name == value ]; then
    <set_of_commands_to_be_executed>
fi
```


