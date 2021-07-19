# SQL

<!--ts-->
* [SQL](sql.md#sql)
   * [Sample query](sql.md#sample-query)
* [SQL Server](sql.md#sql-server)
   * [Show all tables](sql.md#show-all-tables)

<!-- Added by: runner, at: Mon Jul 19 06:59:43 UTC 2021 -->

<!--te-->

## Sample query

```sql
SELECT Id, CompanyName, City, Country
  FROM Supplier
 WHERE Country IN ('USA', 'UK', 'Japan')
```

# SQL Server

## Show all tables

```sql
SELECT * FROM INFORMATION_SCHEMA.TABLES
```
