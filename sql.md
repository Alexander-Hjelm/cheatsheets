# SQL

<!--ts-->
* [SQL](sql.md#sql)
   * [Sample query](sql.md#sample-query)
* [SQL Server](sql.md#sql-server)
   * [Show all tables](sql.md#show-all-tables)

<!-- Added by: runner, at: Mon Feb 14 07:33:19 UTC 2022 -->

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
