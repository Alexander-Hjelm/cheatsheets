# SQL

<!--ts-->
* [SQL](sql.md#sql)
   * [Sample query](sql.md#sample-query)
* [SQL Server](sql.md#sql-server)
   * [Show all tables](sql.md#show-all-tables)

<!-- Added by: runner, at: Mon Feb 14 07:33:19 UTC 2022 -->

<!--te-->

## Simple sample query

```sql
SELECT Id, CompanyName, City, Country
  FROM Supplier
 WHERE Country IN ('USA', 'UK', 'Japan')
```

## MySQL specifics

### Connect to a MySQL instance from the commandline

```bash
sudo mysql -u root
```

## Datatypes

* **INT** (whole number)
* **DECIMAL (M,N)** (decimal number, M=total digits, N=decimal digits)
* **VARCHAR(M)** (string of text, M=length)
* **BLOB** (Binary Large Object)
* **DATE** ('YYYY-MM-DD')
* **TIMESTAMP** (YYYY-MM-DD HH:MM:SS)

## MySQL Sample queries

### Database

#### Create a database

```sql
CREATE DATABASE <DB name>;
```

#### List databases

```sql
SHOW DATABASES;
```

#### Use a database

```sql
USE <DB name>;
```

### Table

#### Create a table

```sql
CREATE TABLE table_name (
   student_id INT PRIMARY KEY AUTO_INCREMENT,
   name VARCHAR(50) NOT NULL,
   major VARCHAR(50) DEFAULT 'undecided'
);
```

#### Create a table with foreign keys

```sql
CREATE TABLE other_table (
   other_id INT PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE table_name (
   student_id INT PRIMARY KEY AUTO_INCREMENT,
   dpt_id INT,
   FOREIGN KEY(dpt_id) REFERENCES other_table(other_id) ON DELETE SET NULL
);
```

##### Constraints

* **NOT NULL**: The column cannot be NULL
* **UNIQUE**: The column must be unique inside the table
* **PRIMARY KEY**: The primary key of the table. Implicitly **NOT NULL** and **UNIQUE**
* **DEFAULT** 'string val': Default value
* **AUTO_INCREMENT**: Automatically infer the next value when inserting.

#### Describe a table

```sql
DESCRIBE table_name;
```

* Output:

```sql
+------------+-------------+------+-----+---------+-------+
| Field      | Type        | Null | Key | Default | Extra |
+------------+-------------+------+-----+---------+-------+
| student_id | int         | NO   | PRI | NULL    |       |
| name       | varchar(50) | YES  |     | NULL    |       |
| major      | varchar(50) | YES  |     | NULL    |       |
+------------+-------------+------+-----+---------+-------+
```

#### Delete a table

```sql
DROP TABLE table_name;
```

#### Add a column

```sql
ALTER TABLE table_name ADD column_name DECIMAL(3, 2);
```

##### Add a foreign key

```sql
ALTER TABLE table_name 
ADD FOREIGN KEY(dpt_id)
REFERENCES other_table(other_id)
ON DELETE SET NULL;
```

#### Remove a column

```sql
ALTER TABLE table_name DROP COLUMN column_name;
```

#### Rename a column

```sql
ALTER TABLE table_name RENAME COLUMN old_column_name TO new_column_name;

```

### Rows

#### Insert row into table

```sql
INSERT INTO table_name VALUES(1, 'Alexander', 'Comp Sci', 4.50);
```

```sql
INSERT INTO table_name(student_id, name) VALUES(1, 'Alexander');
```

#### Update row

```sql
UPDATE table_name
SET name = 'Shanshan', major = 'Economy'
WHERE student_id = 4 OR name = 'Stella';
```

#### Update all rows

```sql
UPDATE table_name
SET name = 'Shanshan', major = 'Economy'
```

#### Delete row

```sql
DELETE FROM table_name
WHERE student_id = 4 OR name = 'Stella';
```

### Table: Get row queries

#### Select rows from table

```sql
SELECT * FROM table_name;
```

#### Select specific columns

```sql
SELECT column1, column2
FROM table_name
WHERE column2 = 'some value'
ORDER BY column1 ASC
LIMIT 10;
```

#### Select by composite ORDER BY

```sql
SELECT column1, column2
FROM table_name
WHERE column2 = 'some value'
ORDER BY column1, column2
```

#### Select rows where a column is in a list

```sql
SELECT *
FROM table_name
WHERE column2 IN ('value 1', 'value 2', 'value 3');
```

#### Select with alias columns

```sql
SELECT column1 AS columnA, column2 AS columnB
FROM table_name;
```

#### Select distinct columns

* This SQL snippet will return all distinct values of column1 in the table:

```sql
SELECT DISTINCT column1
FROM table_name;
```

#### Count rows

* This SQL snippet will return the count of all (non-distinct) rows in the table that fulfil some condition:

```sql
SELECT COUNT(student_id)
FROM table_name
WHERE major = 'Chemistry';
```

#### Average rows

* This SQL snippet will return the average of all (non-distinct) rows in the table that fulfil some condition:

```sql
SELECT AVG(salary)
FROM table_name
WHERE major = 'Chemistry';
```

#### Sum rows

* This SQL snippet will return the sum of all (non-distinct) rows in the table that fulfil some condition:

```sql
SELECT Sum(salary)
FROM table_name
WHERE major = 'Chemistry';
```

#### Aggregate queries

* This SQL snippet will group the requested information by column, and return the information for every entry.

The following example will return the row count for each sex:

```sql
SELECT COUNT(sex), sex
FROM table_name
GROUP BY sex;
```

Another composite example:

```sql
-- Find the total sales of each salesman
SELECT SUM(total_sales), client_id
FROM table_name
GROUP BY client_id;
```

#### wildcards, LIKE keyword

* This SQL snippet will return all rows where client_name ends with "LLC".

```sql
SELECT *
FROM client
WHERE client_name LIKE '%LLC;
```

String wildcards:

* **%**: any sequence of characters
* **_**: any single character

#### union, merge keys

* Combine SELECT statements and aggregate the result. The following query will return a list of all ngo_names, company_names and client_names as organization_names in a single column.

```sql
SELECT ngo_name AS organization_name
FROM ngos
UNION
SELECT company_name
FROM companies
UNION
SELECT client_name
FROM clients
```

String wildcards:

* **%**: any sequence of characters
* **_**: any single character

#### join

##### inner join

* Combine rows from many tables based on similar keys. Only take the results whose shared key exists in the primary table.

```sql
SELECT employee.firstname
FROM employee
JOIN branch
ON employee.emp_id = branch.mgr_id
```

##### left join

* Combine rows from many tables based on similar keys. Take all the rows from the left (primary, employee) table. Only take the results from the right table whose shared key exists in the primary table.

```sql
SELECT employee.firstname
FROM employee
LEFT JOIN branch
ON employee.emp_id = branch.mgr_id
```

##### left join

* Combine rows from many tables based on similar keys. Take all the rows from the right table. Only take the results from the left table whose shared key exists in the right table.

```sql
SELECT employee.firstname
FROM employee
RIGHT JOIN branch
ON employee.emp_id = branch.mgr_id
```

##### full outer join

* Combine rows from many tables based on similar keys. Take all the rows from both the left and the right table.

```sql
SELECT employee.firstname
FROM employee
FULL OUTER JOIN branch
ON employee.emp_id = branch.mgr_id
```

#### Nested queries

* Useful in situations where parts of the required information are in different tables

```sql
SELECT firstname
FROM employee
WHERE emp_id IN (
   SELECT emp_id
   FROM works_with
   Where total_sales > 10000;
)
```

### Triggers

#### Example trigger

```sql
DELIMITER $$
CREATE
   TRIGGER my_trigger BEFORE INSERT
   ON employee
   FOR EACH ROW BEGIN
      INSERT INTO trigger_test VALUES(NEW.firstname, 'new employee');
   END$$
DELIMITER;
```

## Comparison operators

* **--**: Comment
* **<**: Less than
* **>**: Greater than
* **<=**: Less than or equal to
* **>=**: Greater than or equal to
* **=**: Equal to
* **<>**: Not equal to
* **AND**: And
* **OR**: Or
* **IN**: Element in array

## Metadata queries

### Show all tables

```sql
SELECT * FROM INFORMATION_SCHEMA.TABLES
```
