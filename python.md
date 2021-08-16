# Python

<!--ts-->
* [Python](python.md#python)
* [pip](python.md#pip)
   * [Sample requirements.txt](python.md#sample-requirementstxt)
   * [Troubleshooting](python.md#troubleshooting)
      * [Requested MarkupSafe&gt;=2.0 from ... but installing version None](python.md#requested-markupsafe20-from--but-installing-version-none)
* [sys](python.md#sys)
   * [Arguments](python.md#arguments)
      * [getopt](python.md#getopt)
* [list](python.md#list)
   * [list from range](python.md#list-from-range)
   * [print delimited list](python.md#print-delimited-list)
   * [sort](python.md#sort)
   * [sort based on property of the elements](python.md#sort-based-on-property-of-the-elements)
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
   * [uppercase, lowercase](python.md#uppercase-lowercase)
   * [format](python.md#format)
* [file operations](python.md#file-operations)
   * [list files in directory](python.md#list-files-in-directory)
   * [Create directory, subfolders (subdirectories)](python.md#create-directory-subfolders-subdirectories)
   * [read file into string](python.md#read-file-into-string)
   * [read file lines into list](python.md#read-file-lines-into-list)
   * [write string to file](python.md#write-string-to-file)
   * [write lines to file](python.md#write-lines-to-file)
* [regex](python.md#regex)
   * [simple match, return True/False](python.md#simple-match-return-truefalse)
   * [match regex pattern into named groups](python.md#match-regex-pattern-into-named-groups)
   * [regex findall](python.md#regex-findall)
* [Math](python.md#math)
   * [max, min](python.md#max-min)
* [booleans](python.md#booleans)
   * [XOR](python.md#xor)
* [Anonymous functions](python.md#anonymous-functions)
   * [Compound comparisons](python.md#compound-comparisons)
* [csv, excel sheets](python.md#csv-excel-sheets)
* [Json](python.md#json)
   * [Read json](python.md#read-json)
   * [Write json](python.md#write-json)
* [random](python.md#random)
* [Execute command](python.md#execute-command)
* [BeautfulSoup, bs4](python.md#beautfulsoup-bs4)
   * [Create soup from html string](python.md#create-soup-from-html-string)
   * [Write to file](python.md#write-to-file)
   * [Create and append elements](python.md#create-and-append-elements)
   * [Find elements](python.md#find-elements)
   * [Set attributes](python.md#set-attributes)
   * [Edit inner html text](python.md#edit-inner-html-text)
   * [Specific elements](python.md#specific-elements)
      * [input](python.md#input)
      * [a](python.md#a)
      * [img](python.md#img)
* [Http](python.md#http)
   * [Http client](python.md#http-client)
      * [Sample get request](python.md#sample-get-request)
      * [Sample post request](python.md#sample-post-request)
   * [Flask server](python.md#flask-server)
      * [app.py](python.md#apppy)
      * [templates/index.html](python.md#templatesindexhtml)
      * [Run a flask app over https](python.md#run-a-flask-app-over-https)

<!-- Added by: runner, at: Mon Aug 16 08:51:26 UTC 2021 -->

<!--te-->

# pip

## Sample requirements.txt
```bash
beautifulsoup4==4.9.3
Flask==2.0.1
```

Install dependencies with:
```bash
pip install -r requirements.txt
```

List dependencies with:
```bash
pip freeze
```

## Troubleshooting

### Requested MarkupSafe>=2.0 from ... but installing version None

Try updating python and pip. Check the repo for requirements.

When using python inside docker, make sure to use the official python image.

# sys
test
## Arguments
```python
#!/usr/bin/python

import sys

print 'Number of arguments:', len(sys.argv), 'arguments.'
print 'Argument List:', str(sys.argv)
```

### getopt
```python
import getopt
import sys

argv = sys.argv[1:]
opts, args = getopt.getopt(argv, 'w:s:')

for k, v in opts:
    if k == "-w":
        dostuff()
    if k == "-s":
        dostuff()
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

## sort
```python
[1,3,5,2,4].sort()
#[1,2,3,4,5]
```

## sort based on property of the elements
```python
roll_list1 = [('Jack', 76), ('Beneth', 78), ('Cirus', 77), ('Faiz', 79)]
roll_list1.sort(key=lambda a: a[1])
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

## uppercase, lowercase
```python
string.upper()
string.lower()
```

## format
```python
txt2 = "My name is {0}, I'm {1}".format("John",36)
```

# file operations

## list files in directory
```python
import os
for root, dirs, files in os.walk(".", topdown=False):
   for name in files:
      print(os.path.join(root, name))
   for name in dirs:
      print(os.path.join(root, name))
```

## Create directory, subfolders (subdirectories)
```python
# For a dir
dir = "./path/to/dir"
os.makedirs(dir, exist_ok=True)

# For a path
path = "./path/to/file.txt"
dir = path.split("/")
dir.pop()
dir = "/".join(map(str, dir))

os.makedirs(dir, exist_ok=True)
```

## read file into string
```python
with open('data.txt', 'r') as file:
    data = file.read().replace('\n', '')
```

## read file lines into list

```python
with open('filename') as f:
    lines = [line.rstrip() for line in f]
```

## write string to file
```python
f = open("demofile2.txt", "a")
f.write("Now the file has more content!")
f.close()
```

## write lines to file
```python
f = open("demofile3.txt", "a")
f.writelines(["See you soon!", "Over and out."])
f.close()
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

# Math

## max, min
```python
a = min(1, 4, 10)
b = max(1, 4, 10)
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

# Json

## Read json
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

## Write json
```python
json_object = json.dumps(dictionary)

with open("sample.json", "w") as outfile:
    outfile.write(json_object)
```

# random
```python
import random
print(random.random())
```

# Execute command
```python
import subprocess
output = subprocess.check_output(["echo hello"], shell=True).decode('utf-8')
```

# BeautfulSoup, bs4

## Create soup from html string
```python
html = <html><head><title>Title</title></head><body></body></html>
soup = BeautifulSoup(html, "html.parser")
```

## Write to file
```python
with open(target_path, 'w') as f:
    f.write(soup.prettify())
```

## Create and append elements
```python
    div = BeautifulSoup("<div></div>", 'html.parser').div
    ul = BeautifulSoup("<ul></ul>", 'html.parser')
    div.append(ul)
```

## Find elements
```python
div = soup.find("div", {"id": "main_content"})
paragraphs = div.findAll('p')
```

## Set attributes
```python
div['id']="index"
div["class"] = "gh_avatar"
```

## Edit inner html text
```python
p.string = p.text.replace("[TOC]", "")
```

## Specific elements

### input
```python
input = BeautifulSoup('<input type="text" oninput="search(this.value);"></input>', 'html.parser')
```

Javscript:
```js
function search(value)
{
    alert("lol")
}
```


### a
```python
a = BeautifulSoup("<a></a>", 'html.parser').a
a["href"] = "https://github.com/"
```

### img
```python
img = BeautifulSoup("<img></img>", 'html.parser').img
img["src"] = "https://example.com/image"
```

# Http

## Http client

### Sample get request
```python
headers = {"Authorization": "Bearer: abcd1234"), "ContentType": "application/json"}
uri_api = "https://example.com/endpoint?param1=lol&param2=haha"
response = requests.post(url = uri_api, headers=headers)
return response.json()
```

### Sample post request
```python
headers = {"Authorization": "Bearer: abcd1234"), "ContentType": "application/json"}
body = {"name":team_name, "id":team_id, "description":team_description}
uri_api = "https://example.com/endpoint?param1=lol&param2=haha"
response = requests.post(url = uri_api, headers=headers, body=body)
return response.json()
```

## Flask server

### app.py
```python
from flask import Flask, render_template, request

app = Flask(__name__)

# list of cat images
image = "https://example.com/image.png

@app.route('/')
def index():
    url = random.choice(images)
    param_example = request.args.get('param')
    return render_template('index.html', url=url)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
```

### templates/index.html
```html
<html>
  <head>
  </head>
  <body>
    <div class="container">
      <h4>Cat Gif of the day</h4>
      <img src="{{url}}" />
    </div>
  </body>
</html>
```

### Run a flask app over https

Reqiures the **cryptography** library.

```python
  app.run(host="0.0.0.0", port=443, ssl_context='adhoc')
```
