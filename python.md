# Python

<!--ts-->
   * [Python](python.md#python)
   * [sys](python.md#sys)
      * [Arguments](python.md#arguments)
   * [enum](python.md#enum)
   * [dict](python.md#dict)
   * [string](python.md#string)
      * [Enumerate through alphabet](python.md#enumerate-through-alphabet)
      * [split, rsplit](python.md#split-rsplit)
         * [split](python.md#split)
         * [rsplit](python.md#rsplit)
      * [list files in directory](python.md#list-files-in-directory)

<!-- Added by: runner, at: Fri Jan 22 13:52:50 UTC 2021 -->

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
