# GoLang
<!--ts-->
   * [GoLang](go.md#golang)
      * [main function](go.md#main-function)
      * [printing](go.md#printing)
      * [build](go.md#build)

<!-- Added by: runner, at: Wed Feb 10 14:43:55 UTC 2021 -->

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
