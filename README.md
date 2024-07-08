# DB-Snippets

## Description
This repository contains a collection of database query snippets designed to help you brush up on your SQL skills. These snippets cover a variety of common tasks and queries, from basic data retrieval to more complex operations involving multiple tables and advanced SQL functions.

## Features
- Basic SQL queries for data retrieval
- CRUD (Create, Read, Update, Delete) operations
- Joins and subqueries
- Aggregate functions and grouping
- Advanced SQL functions and operations

## Requirements
- A SQL database management system (e.g., MySQL, PostgreSQL, SQLite)
- A database client (e.g., MySQL Workbench, pgAdmin, DBeaver) or command-line access to your DBMS

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/Ali-Ch-001/DB-Snippets.git
   ```
2. Navigate to the project directory:
   ```bash
   cd DB-Snippets
   ```

## Usage
1. Choose the desired SQL snippet from the repository.
2. Copy the SQL code into your database client's query editor.
3. Execute the query to see the results.

### Example
To run a basic data retrieval query:
```sql
SELECT * FROM employees;
```

## Snippets
The repository includes the following snippets:

### Basic Queries
- **Select All**: Retrieve all columns from a table.
  ```sql
  SELECT * FROM table_name;
  ```
- **Select Specific Columns**: Retrieve specific columns from a table.
  ```sql
  SELECT column1, column2 FROM table_name;
  ```

### CRUD Operations
- **Insert Data**: Insert a new row into a table.
  ```sql
  INSERT INTO table_name (column1, column2) VALUES (value1, value2);
  ```
- **Update Data**: Update existing data in a table.
  ```sql
  UPDATE table_name SET column1 = value1 WHERE condition;
  ```
- **Delete Data**: Delete data from a table.
  ```sql
  DELETE FROM table_name WHERE condition;
  ```

### Joins and Subqueries
- **Inner Join**: Retrieve related data from multiple tables.
  ```sql
  SELECT a.column1, b.column2
  FROM table1 a
  INNER JOIN table2 b ON a.common_column = b.common_column;
  ```
- **Subquery**: Use a query inside another query.
  ```sql
  SELECT column1
  FROM table_name
  WHERE column2 IN (SELECT column2 FROM another_table WHERE condition);
  ```

### Aggregate Functions and Grouping
- **Count**: Count the number of rows in a table.
  ```sql
  SELECT COUNT(*) FROM table_name;
  ```
- **Group By**: Group rows that have the same values.
  ```sql
  SELECT column1, COUNT(*)
  FROM table_name
  GROUP BY column1;
  ```

### Advanced SQL Functions
- **Case Statement**: Conditionally select values.
  ```sql
  SELECT column1,
         CASE
             WHEN condition1 THEN result1
             WHEN condition2 THEN result2
             ELSE result3
         END
  FROM table_name;
  ```
- **Window Functions**: Perform calculations across a set of table rows related to the current row.
  ```sql
  SELECT column1,
         ROW_NUMBER() OVER (PARTITION BY column2 ORDER BY column3) AS row_num
  FROM table_name;
  ```

Each snippet is contained in its own file with comments explaining the code.

## Contributing
Contributions are welcome! If you have any suggestions, improvements, or new snippets, please create an issue or submit a pull request.

1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature-branch
   ```
3. Commit your changes:
   ```bash
   git commit -m "Description of your changes"
   ```
4. Push to the branch:
   ```bash
   git push origin feature-branch
   ```
5. Create a new pull request.

## Contact
For any questions or feedback, please contact:
- GitHub: [Ali-Ch-001](https://github.com/Ali-Ch-001)
