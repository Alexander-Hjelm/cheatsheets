# Regex
<!--ts-->
* [Regex](regex.md#regex)
   * [[a-z]](regex.md#a-z)
   * [[0-9], d](regex.md#0-9-d)
   * [How to match big integers](regex.md#how-to-match-big-integers)
   * [* at the end of a query](regex.md#-at-the-end-of-a-query)
   * [any character except whitespace](regex.md#any-character-except-whitespace)
* [Repetition](regex.md#repetition)
* [Start, end of string](regex.md#start-end-of-string)
   * [Start](regex.md#start)
   * [End](regex.md#end)
   * [Exact match, full string](regex.md#exact-match-full-string)

<!-- Added by: runner, at: Fri Aug  6 09:44:46 UTC 2021 -->

<!--te-->

## .*

Any character, any number of times

## [a-z]

Any lowercase letter

## [0-9], d

Any digit

## How to match big integers

Use [0-9]* for arbitrarily large integers.

## * at the end of a query

Repeat the query until it fails. For example `[a-z]*` will match any word in lowercase leters.

## any character except whitespace

[^\s]

# Repetition

`\d{3}` will match 3 digits

`\d{3, 5}` will match 3 to 5 digits

# Start, end of string

## Start
'^'

## End
'$'

## Exact match, full string
Use both ^ and $ to mark start and end of string
'^\d{9}$'
