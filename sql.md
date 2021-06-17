# SQL

<!--ts-->
* [SQL](sql.md#sql)
   * [Sample query](sql.md#sample-query)

<!-- Added by: runner, at: Thu Jun 17 16:42:57 UTC 2021 -->

<!--te-->

## Sample query

```sql
SELECT Id, CompanyName, City, Country
  FROM Supplier
 WHERE Country IN ('USA', 'UK', 'Japan')
```
