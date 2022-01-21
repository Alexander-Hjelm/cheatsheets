# GoLang
<!--ts-->
* [GoLang](go.md#golang)
   * [main function](go.md#main-function)
   * [function](go.md#function)
   * [printing](go.md#printing)
   * [build](go.md#build)
   * [string](go.md#string)
      * [iterate over runes in string](go.md#iterate-over-runes-in-string)
   * [split](go.md#split)
   * [file, I/O](go.md#file-io)
      * [Read file contents to string](go.md#read-file-contents-to-string)
      * [read file lines into array of strings](go.md#read-file-lines-into-array-of-strings)
   * [os](go.md#os)
      * [Command line arguments](go.md#command-line-arguments)
   * [type conversions](go.md#type-conversions)
      * [string to int](go.md#string-to-int)
      * [string to float64](go.md#string-to-float64)
   * [math](go.md#math)
      * [max, min](go.md#max-min)

<!-- Added by: runner, at: Fri Jan 21 14:41:03 UTC 2022 -->

<!--te-->

## main function
```go
func main() {
//  Main code here!
}
```

## function
```go
func function_name(input_s string, input_f float64) {
    input_f += 1
    return inpput_s
}
```

## printing
```go
import "fmt"
fmt.Println("test!")
```

## build
```bash
go build -o [Executable name]
```

## string

### iterate over runes in string
```go
for _, letter := range test_string {
    ...
}
```

## split
```go
import "strings"
a := strings.Split(b, ".")
```

## file, I/O

### Read file contents to string
```go
import {
    "io/ioutil"
    "log"
}

content, err := ioutil.ReadFile("file.txt")
if err != nil {
    log.Fatal(err)
}
content_str := string(content)
```

### read file lines into array of strings
```go
import {
    "io/ioutil"
    "log"
    "bufio"
}

file, err := os.Open("file.txt")
if err != nil {
    return nil, err
}
defer file.Close()

var lines []string
scanner := bufio.NewScanner(file)
for scanner.Scan() {
    lines = append(lines, scanner.Text())
}
```

## os

### Command line arguments
```go
import "os"
arg := os.Args[1]
```

## type conversions
```go
import "strconv"
```

### string to int
```go
strconv.Atoi("12345")
```

### string to float64
```go
strconv.ParseFloat("123.12", 64)
```

## math
```go
import "math"
```

### max, min
```go
min := math.Min(1, 2)
max := math.Max(1, 2)
```
