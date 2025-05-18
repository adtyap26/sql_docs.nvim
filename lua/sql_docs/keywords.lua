-- SQL keyword documentation
return {
	SELECT = {
		description = "Retrieves data from one or more tables.",
		syntax = "SELECT column1, column2, ... FROM table_name [WHERE condition];",
	},
	FROM = {
		description = "Specifies the table to query data from.",
		syntax = "SELECT column1, column2, ... FROM table_name;",
	},
	WHERE = {
		description = "Filters records based on a specified condition.",
		syntax = "SELECT column1, column2, ... FROM table_name WHERE condition;",
	},
	WITH = {
		description = "Creates a temporary named result set (Common Table Expression).",
		syntax = "WITH cte_name AS (SELECT ...) SELECT ... FROM cte_name",
		examples = [[
-- Calculate revenue by category
WITH revenue_by_product AS (
  SELECT product_id, SUM(quantity * price) AS revenue
  FROM order_items
  GROUP BY product_id
)
SELECT c.name, SUM(r.revenue) AS total_revenue
FROM revenue_by_product r
JOIN products p ON r.product_id = p.id
JOIN categories c ON p.category_id = c.id
GROUP BY c.name;

-- Recursive CTE for hierarchical data
WITH RECURSIVE category_tree AS (
  SELECT id, name, parent_id, 0 AS level
  FROM categories
  WHERE parent_id IS NULL
  UNION ALL
  SELECT c.id, c.name, c.parent_id, ct.level + 1
  FROM categories c
  JOIN category_tree ct ON c.parent_id = ct.id
)
SELECT * FROM category_tree ORDER BY level, name;
]],
	},
	JOIN = {
		description = "Combines rows from two or more tables based on a related column.",
		syntax = "SELECT columns FROM table1 JOIN table2 ON table1.column = table2.column;",
	},
	GROUP = {
		description = "Groups rows that have the same values in specified columns.",
		syntax = "SELECT column1, COUNT(*) FROM table_name GROUP BY column1;",
	},
	HAVING = {
		description = "Filters groups based on a specified condition.",
		syntax = "SELECT column1, COUNT(*) FROM table_name GROUP BY column1 HAVING COUNT(*) > 5;",
	},
	ORDER = {
		description = "Sorts the result set in ascending or descending order.",
		syntax = "SELECT column1, column2 FROM table_name ORDER BY column1 [ASC|DESC];",
	},
	INSERT = {
		description = "Adds new rows to a table.",
		syntax = "INSERT INTO table_name (column1, column2) VALUES (value1, value2);",
	},
	UPDATE = {
		description = "Modifies existing data in a table.",
		syntax = "UPDATE table_name SET column1 = value1 WHERE condition;",
	},
	DELETE = {
		description = "Removes rows from a table.",
		syntax = "DELETE FROM table_name WHERE condition;",
	},
	CREATE = {
		description = "Creates a new database object (table, view, index, etc.).",
		syntax = "CREATE TABLE table_name (column1 datatype, column2 datatype);",
	},
	ALTER = {
		description = "Modifies an existing database object.",
		syntax = "ALTER TABLE table_name ADD column_name datatype;",
	},
	DROP = {
		description = "Removes an existing database object.",
		syntax = "DROP TABLE table_name;",
	},
	UNION = {
		description = "Combines the result sets of two or more SELECT statements.",
		syntax = "SELECT column FROM table1 UNION SELECT column FROM table2;",
	},
	CASE = {
		description = "Provides conditional logic in SQL.",
		syntax = "CASE WHEN condition1 THEN result1  WHEN condition2 THEN result2;",
	},
	DISTINCT = {
		description = "Removes duplicate values from the result set",
		syntax = "SELECT DISTINCT column1, column2, ... FROM table_name;",
	},

	TRIM = {
		description = "Removes leading and/or trailing characters (typically spaces).",
		syntax = "TRIM([LEADING|TRAILING|BOTH] [characters] FROM string);",
	},

	INNER = {
		description = "Returns rows when there is a match in both tables.",
		syntax = "SELECT columns FROM table1 INNER JOIN table2 ON table1.column = table2.column;",
	},
	LEFT = {
		description = "Returns all rows from the left table, and the matched rows from the right table.",
		syntax = "SELECT columns FROM table1 LEFT [OUTER] JOIN table2 ON table1.column = table2.column;",
	},
	RIGHT = {
		description = "Returns all rows from the right table, and the matched rows from the left table.",
		syntax = "SELECT columns FROM table1 RIGHT [OUTER] JOIN table2 ON table1.column = table2.column;",
	},
	FULL = {
		description = "Returns all rows when there is a match in one of the tables.",
		syntax = "SELECT columns FROM table1 FULL [OUTER] JOIN table2 ON table1.column = table2.column;",
	},
	AS = {
		description = "Assigns a temporary name (alias) to a column or a table.",
		syntax = "SELECT column_name AS alias_name FROM table_name AS table_alias;",
	},
	LIMIT = {
		description = "Limits the number of rows returned by a query (common in MySQL/PostgreSQL). Note: Other databases use TOP or FETCH FIRST.",
		syntax = "SELECT column1, column2 FROM table_name LIMIT row_count [OFFSET offset_value];",
	},
	INTERSECT = {
		description = "Returns only the rows that are present in both result sets.",
		syntax = "SELECT column FROM table1 INTERSECT SELECT column FROM table2;",
	},
	EXCEPT = { -- Or MINUS in Oracle
		description = "Returns rows that are in the first result set but not in the second.",
		syntax = "SELECT column FROM table1 EXCEPT SELECT column FROM table2;", -- Use MINUS for Oracle
	},
	IN = {
		description = "Used in a WHERE clause to check if a value is in a list of values or a subquery result.",
		syntax = "SELECT columns FROM table_name WHERE column_name IN (value1, value2, ...); OR SELECT columns FROM table_name WHERE column_name IN (SELECT other_column FROM other_table WHERE condition);",
	},
	EXISTS = {
		description = "Used in a WHERE clause to test for the existence of rows in a subquery.",
		syntax = "SELECT columns FROM table_name WHERE EXISTS (SELECT 1 FROM other_table WHERE condition);",
	},
	IS = {
		description = "Used to test for TRUE, FALSE, or NULL values.",
		syntax = "SELECT columns FROM table_name WHERE column_name IS NULL; OR SELECT columns FROM table_name WHERE column_name IS NOT NULL;",
	},
	LIKE = {
		description = "Used in a WHERE clause to search for a specified pattern in a column.",
		syntax = "SELECT columns FROM table_name WHERE column_name LIKE pattern;", -- Use % for any sequence, _ for any single character
	},
	PRIMARY = { -- Typically used with KEY
		description = "A constraint that uniquely identifies each record in a table and enforces non-NULL values.",
		syntax = "CREATE TABLE table_name ( id INT PRIMARY KEY, ...);",
	},
	FOREIGN = { -- Typically used with KEY
		description = "A constraint that links two tables together; it references the PRIMARY KEY in another table.",
		syntax = "CREATE TABLE table_name ( ..., other_table_id INT, FOREIGN KEY (other_table_id) REFERENCES other_table(id) );",
	},
	NOT = { -- Typically used with NULL
		description = "A constraint that ensures a column cannot have a NULL value.",
		syntax = "CREATE TABLE table_name ( column_name datatype NOT NULL, ...);",
	},
	UNIQUE = {
		description = "A constraint that ensures all values in a column (or a set of columns) are different.",
		syntax = "CREATE TABLE table_name ( column_name datatype UNIQUE, ...);",
	},
	-- Aggregate functions (often listed separately or noted)
	COUNT = {
		description = "Returns the number of rows that matches a specified criterion.",
		syntax = "SELECT COUNT(column_name) FROM table_name WHERE condition; OR SELECT COUNT(*) FROM table_name;",
	},
	SUM = {
		description = "Calculates the sum of values in a column.",
		syntax = "SELECT SUM(column_name) FROM table_name WHERE condition;",
	},
	AVG = {
		description = "Calculates the average value of a column.",
		syntax = "SELECT AVG(column_name) FROM table_name WHERE condition;",
	},
	MIN = {
		description = "Returns the smallest value of the selected column.",
		syntax = "SELECT MIN(column_name) FROM table_name WHERE condition;",
	},
	MAX = {
		description = "Returns the largest value of the selected column.",
		syntax = "SELECT MAX(column_name) FROM table_name WHERE condition;",
	},
	COMMIT = {
		description = "Saves all changes made during the current transaction.",
		syntax = "COMMIT;",
	},
	ROLLBACK = {
		description = "Undoes all changes made during the current transaction.",
		syntax = "ROLLBACK;",
	},
}
