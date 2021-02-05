# Regex
<!--ts-->
   * [Regex](regex.md#regex)
      * [[a-z]](regex.md#a-z)
      * [[0-9], d](regex.md#0-9-d)
      * [How to match big integers](regex.md#how-to-match-big-integers)
      * [* at the end of a query](regex.md#-at-the-end-of-a-query)
      * [any character except whitespace](regex.md#any-character-except-whitespace)

<!-- Added by: runner, at: Fri Feb  5 15:44:53 UTC 2021 -->

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


