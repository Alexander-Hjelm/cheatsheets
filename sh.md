# Shellscript
<!--ts-->
<!--te-->

## Shebang
Shebang is the path to the sh interpreter, sending this file as input
```bash
#!/bin/sh
```

## Printing
```bash
echo Hello World!
```

## Variables
Variable assignment, remmeber: no spaces on either side of the =-sign!
```bash
MY_VAR="some text"
```

## Command output
This is how you assign a variable
```bash
DATE=$(date)
```

## dir name, file name from path
Get the directory name or a file name from a file path.
```bash
VAR=/path/to/file
dirname=${VAR%/*}
filename=${VAR##*/}
```

## Functions
Parameters can be reached via $1, $2, $3, etc...
```bash
example_function()
{
  echo $1
  return
}

example_function "Hello World!"
```

## Arrays

### Assignment
```bash
array_name=("f1.txt" "f2.txt" "f3.txt" "f4.txt" "f5.txt")
```

### Append
```bash
array_name=()
array_name+="test"
array_name+=("$line")
```

### Access

#### By index
```bash
echo ${files[1]}
```

#### Iterate over elements
```bash
names=(Anna Linda Hanna)
for name in ${names[@]};
do
  echo $name
# other stuff on $name
done
```

#### Print the whole list
```bash
echo ${files[*]}
```

### Read lines of file into an array
```bash
readarray -t node_versions_to_keep <nvm-versions-to-keep.txt
```

## Example scripts

### For each line in file
```bash
filename="/path/to/file"
 
while read line
do
    echo "$line"
done < $filename
```

### Split string
```bash
IN="bla@some.com;john@home.com"
arrIN=(${IN//;/ })
echo ${arrIN[1]}

# Output: john@home.com
```
Remember to escape special characters with \.

### copy file and make subdirectories
```bash
target=/path/to/target
subdirs=${target%/*}
mkdir -p $subdirs      
eval cp $file $target
```

## Find host machine platform
```bash
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
```bash
if [ $var_name == value ]; then
    <set_of_commands_to_be_executed>
fi
```


