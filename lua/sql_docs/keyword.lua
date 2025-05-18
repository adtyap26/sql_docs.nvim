-- SQL keyword documentation
return {
  SELECT = {
    description = "Retrieves data from one or more tables.",
    syntax = "SELECT column1, column2, ... FROM table_name [WHERE condition];"
  },
  FROM = {
    description = "Specifies the table to query data from.",
    syntax = "SELECT column1, column2, ... FROM table_name;"
  },
  WHERE = {
    description = "Filters records based on a specified condition.",
    syntax = "SELECT column1, column2, ... FROM table_name WHERE condition;"
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
]]
  },
  JOIN = {
    description = "Combines rows from two or more tables based on a related column.",
    syntax = "SELECT columns FROM table1 JOIN table2 ON table1.column = table2.column;"
  },
  GROUP = {
    description = "Groups rows that have the same values in specified columns.",
    syntax = "SELECT column1, COUNT(*) FROM table_name GROUP BY column1;"
  },
  HAVING = {
    description = "Filters groups based on a specified condition.",
    syntax = "SELECT column1, COUNT(*) FROM table_name GROUP BY column1 HAVING COUNT(*) > 5;"
  },
  ORDER = {
    description = "Sorts the result set in ascending or descending order.",
    syntax = "SELECT column1, column2 FROM table_name ORDER BY column1 [ASC|DESC];"
  },
  INSERT = {
    description = "Adds new rows to a table.",
    syntax = "INSERT INTO table_name (column1, column2) VALUES (value1, value2);"
  },
  UPDATE = {
    description = "Modifies existing data in a table.",
    syntax = "UPDATE table_name SET column1 = value1 WHERE condition;"
  },
  DELETE = {
    description = "Removes rows from a table.",
    syntax = "DELETE FROM table_name WHERE condition;"
  },
  CREATE = {
    description = "Creates a new database object (table, view, index, etc.).",
    syntax = "CREATE TABLE table_name (column1 datatype, column2 datatype);"
  },
  ALTER = {
    description = "Modifies an existing database object.",
    syntax = "ALTER TABLE table_name ADD column_name datatype;"
  },
  DROP = {
    description = "Removes an existing database object.",
    syntax = "DROP TABLE table_name;"
  },
  UNION = {
    description = "Combines the result sets of two or more SELECT statements.",
    syntax = "SELECT column FROM table1 UNION SELECT column FROM table2;"
  }
}

