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
#!/bin/bash
dotfiles_file="./dotfiles"
 
while read line
do
    echo "$line"
done < $dotfiles_file
```
