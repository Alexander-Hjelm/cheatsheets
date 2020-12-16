# sys

## Arguments
```console
#!/usr/bin/python

import sys

print 'Number of arguments:', len(sys.argv), 'arguments.'
print 'Argument List:', str(sys.argv)
```

# enum
```console
from enum import Enum
class Color(Enum):
    RED = 1
    GREEN = 2
    BLUE = 3
```

# dict
```console
newdict = {
  "brand": "Ford",
  "model": "Mustang",
  "year": 1964
}
```
# string

## Enumerate through alphabet
```console
import string
alphabet = string.ascii_lowercase
upper_limit = 10
for c in alphabet[0:upper_limit:1] : 
    print(c)    
```

## split, rsplit

Split a string on first, last occurrence(s) of a substring, with max number of splits

### split

```console
my_string = "hipp-hipp-hooray"
str.split(my_string, '-', 1)
```

### rsplit

```console
my_string = "hipp-hipp-hooray"
str.rsplit(my_string, '-', 1)
```

