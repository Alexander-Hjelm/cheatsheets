# Python

<!--ts-->
* [Python](python.md#python)
* [sys](python.md#sys)
   * [Arguments](python.md#arguments)
* [list](python.md#list)
   * [list from range](python.md#list-from-range)
   * [print delimited list](python.md#print-delimited-list)
* [set](python.md#set)
   * [set from list](python.md#set-from-list)
   * [set intersection](python.md#set-intersection)
* [enum](python.md#enum)
* [dict](python.md#dict)
   * [Enumerate over dict](python.md#enumerate-over-dict)
* [string](python.md#string)
   * [Enumerate through alphabet](python.md#enumerate-through-alphabet)
   * [count occurences of a character in a string](python.md#count-occurences-of-a-character-in-a-string)
   * [split, rsplit](python.md#split-rsplit)
      * [split](python.md#split)
      * [rsplit](python.md#rsplit)
   * [startswith, endswith](python.md#startswith-endswith)
   * [list files in directory](python.md#list-files-in-directory)
   * [read file lines into list](python.md#read-file-lines-into-list)
   * [uppercase, lowercase](python.md#uppercase-lowercase)
* [regex](python.md#regex)
   * [simple match, return True/False](python.md#simple-match-return-truefalse)
   * [match regex pattern into named groups](python.md#match-regex-pattern-into-named-groups)
   * [regex findall](python.md#regex-findall)
* [booleans](python.md#booleans)
   * [XOR](python.md#xor)
* [Anonymous functions](python.md#anonymous-functions)
   * [Compound comparisons](python.md#compound-comparisons)
* [csv, excel sheets](python.md#csv-excel-sheets)
* [Read json](python.md#read-json)

<!-- Added by: runner, at: Wed May 19 08:32:20 UTC 2021 -->

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

# list

## list from range
```python
list(range(0,10))
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
```

## print delimited list
```python
a = [1, 2, 3]
','.join(map(str,a))
```

# set

## set from list
```python
set('aaaabbcdddee')
set([1, 1, 2, 3, 4, 4, 5])

{'e', 'c', 'b', 'a', 'd'}
{1, 2, 3, 4, 5}
```

## set intersection
```python
lists = ['aabcd', 'abd', 'abc']
set.intersection(*[set(x) for x in lists])

{'a', 'b'}
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

## Enumerate over dict
```python
example_dict = {1:'a', 2:'b', 3:'c', 4:'d'}

for i, k in enumerate(example_dict):
    print(i, k)
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

## startswith, endswith

str_val.endswith("cm")
str_val.startswith("0_")

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

## uppercase, lowercase
```python
string.upper()
string.lower()
```

# regex

## simple match, return True/False
```python
re.match("[0-9a-f]{6}", x) is not None
```

## match regex pattern into named groups

```python
m = re.match(r'(?P<i1>\d+)-(?P<i2>\d+) (?P<c>\w): (?P<w>\w+)', "6-90 x: xdtqxbdwx")
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

# Anonymous functions
```python
x = lambda a : a + 10
print(x(5)) 
```

## Compound comparisons
```python
2002 >= x >= 1920
```

# csv, excel sheets
```python
from openpyxl import load_workbook
from openpyxl import Workbook

wb = load_workbook(output_filename)
for sheet_name in wbt.sheetnames:
    sheet = wb.get_sheet_by_name(sheet_name)
    b1 = sheet['B1']
    sheet['B2'] = "test"

# Load active sheet
    sheet_active = wb.active

wb_new = Workbook()
wb_new.create_sheet('new sheet')

# Remove sheet
we_new.remove_sheet(wb.active)

# Save sheet
wb_new.save("filename")
```

# Read json
```python
import json

# read file
with open('example.json', 'r') as myfile:
    data=myfile.read()

# parse file
obj = json.loads(data)

# show values
print("usd: " + str(obj['usd']))
print("eur: " + str(obj['eur']))
print("gbp: " + str(obj['gbp']))
```
