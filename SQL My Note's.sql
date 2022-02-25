--==<MY SQL NOTE'S>==--

SQL Documentation
SELECT * FROM Table;

Selecting only certain fields from a table.
SELECT field1, field2 FROM Table;

WHERE clauses.
-- Basic WHERE clause
SELECT * FROM Table
WHERE condition;

-- Compound WHERE clauses
SELECT * FROM Table
WHERE condition1
AND condition2;
Condition operators
=					equal
<					less than
>					greater than
<>					not equal
IN (a, b, c)		Value is in a list
BETWEEN x AND y		Value is between x and y
LIKE "%"			String matches a pattern
String patterns.
"A%" (words starting with "A")
"%a" (words ending with "a")
"%a%" (words with "a" in it)
Ordering / Sorting queries.
// Sort by a field name
ORDER BY field_name;

-- Sort by a field name in reverse
ORDER BY field_name DESC;

-- Sort by a field and then sort by a 2nd field when the 1st field is equal
ORDER BY field_1, field_2;
Renaming fields in results
SELECT field_name AS "Field Name"

SELECT first_name AS "First Name"
Joining Tables.
-- Select all fields in both tables combined.
SELECT *
FROM TableA JOIN TableB;

-- Select only the rows in the joined table where the ids match
SELECT *
FROM TableA JOIN TableB
WHERE TableA.id = TableB.id;

-- Select only the relevant columns from each table
-- Where their ids match
SELECT TableA.value, TableB.value
FROM TableA JOIN TableB
WHERE TableA.id = TableB.id;
The COUNT Function
-- Return the number of rows in Table
SELECT COUNT(*) FROM Table;

-- Return the number of houses and name
-- the column "Num Houses"
SELECT COUNT(*) As "Num Houses" FROM House;
Grouping
-- Syntax for grouping and counting
SELECT field_name, COUNT(*)
FROM Table
GROUP BY field_name;
Filtering with HAVING
-- You use HAVING instead of WHERE if you are
-- filtering after a GROUP BY
SELECT field_name, COUNT(*)
FROM Table
GROUP BY field_name
HAVING condition;
Limiting results
-- Use LIMIT after any query to limit the number of results
SELECT * FROM Table LIMIT 10;

-- Ex) Show the 5 highest values only
SELECT field_name, COUNT(*)
FROM Table
GROUP BY field_name
ORDER BY COUNT(*) DESC
LIMIT 5;

