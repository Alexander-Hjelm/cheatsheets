# Python

<!--ts-->
   * [Python](python.md#python)
   * [sys](python.md#sys)
      * [Arguments](python.md#arguments)
   * [enum](python.md#enum)
   * [dict](python.md#dict)
   * [string](python.md#string)
      * [Enumerate through alphabet](python.md#enumerate-through-alphabet)
      * [count occurences of a character in a string](python.md#count-occurences-of-a-character-in-a-string)
      * [split, rsplit](python.md#split-rsplit)
         * [split](python.md#split)
         * [rsplit](python.md#rsplit)
      * [list files in directory](python.md#list-files-in-directory)
      * [read file lines into list](python.md#read-file-lines-into-list)
   * [regex](python.md#regex)
      * [match regex pattern into named groups](python.md#match-regex-pattern-into-named-groups)
      * [regex findall](python.md#regex-findall)
   * [booleans](python.md#booleans)
      * [XOR](python.md#xor)

<!-- Added by: runner, at: Mon Feb  1 10:26:37 UTC 2021 -->

<!--te-->

# sys
test
## Arguments
```python
#!/usr/bin/python

import sys

print 'Number of arguments:', len(sys.argv), 'arguments.'
print 'Argument List:', str(sys.argv)
```

# enum
```python
from enum import Enum
class Color(Enum):
    RED = 1
    GREEN = 2
    BLUE = 3
```

# dict
```python
newdict = {
  "brand": "Ford",
  "model": "Mustang",
  "year": 1964
}
```
# string

## Enumerate through alphabet
```python
import string
alphabet = string.ascii_lowercase
upper_limit = 10
for c in alphabet[0:upper_limit:1] : 
    print(c)    
```

## count occurences of a character in a string

```python
test_str = "GeeksforGeeks"
test_str.count('e') 

>>

4
```

## split, rsplit

Split a string on first, last occurrence(s) of a substring, with max number of splits

### split

```python
my_string = "hipp-hipp-hooray"
str.split(my_string, '-', 1)
```

### rsplit

```python
my_string = "hipp-hipp-hooray"
str.rsplit(my_string, '-', 1)
```

## list files in directory

```python
import os
for root, dirs, files in os.walk(".", topdown=False):
   for name in files:
      print(os.path.join(root, name))
   for name in dirs:
      print(os.path.join(root, name))
```

## read file lines into list

```python
with open('filename') as f:
    lines = [line.rstrip() for line in f]
```

# regex

## match regex pattern into named groups

```python
m = re.match(r'(?P<i1>\d+)-(?P<i2>\d+) (?P<c>\w): (?P<w>\w+)', 6-90 x: xdtqxbdwx)
print(m.group('i1'))
print(m.group('i2'))
print(m.group('c'))
print(m.group('w'))

>>
6
90
x
xdtqxbdwx
```

## regex findall
```python
m = re.findall(r'\w+:', line)
```

# booleans

## XOR

```python
xor = True ^ False
```
