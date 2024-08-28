# SQL_Data_Cleaning_Essentials

SQL data cleaning is crucial for maintaining the quality and accuracy of your data. Here are some essential steps and techniques:

### 1. **Identify and Remove Duplicates**
   - Use the `ROW_NUMBER()` window function or `GROUP BY` with aggregate functions to identify and remove duplicates.

   ```sql
   WITH duplicates AS (
       SELECT 
           column1, column2, 
           ROW_NUMBER() OVER (PARTITION BY column1, column2 ORDER BY id) AS row_num
       FROM your_table
   )
   DELETE FROM your_table
   WHERE id IN (SELECT id FROM duplicates WHERE row_num > 1);
   ```

### 2. **Handle Missing Values**
   - Use `IS NULL` or `COALESCE()` to handle null values and replace them with default values.

   ```sql
   SELECT column1, COALESCE(column2, 'default_value') AS column2
   FROM your_table;
   ```

### 3. **Standardize Data Formats**
   - Use functions like `UPPER()`, `LOWER()`, `TRIM()`, and `CONVERT()` to standardize data formats.

   ```sql
   UPDATE your_table
   SET column1 = TRIM(UPPER(column1));
   ```

### 4. **Remove Unnecessary Whitespace**
   - Use `TRIM()` to remove leading and trailing spaces.

   ```sql
   UPDATE your_table
   SET column1 = TRIM(column1);
   ```

### 5. **Validate Data Integrity**
   - Implement constraints and use `CHECK` constraints to ensure data validity.

   ```sql
   ALTER TABLE your_table
   ADD CONSTRAINT valid_age CHECK (age >= 0);
   ```

### 6. **Normalize Data**
   - Normalize your data to reduce redundancy and improve data integrity.

   ```sql
   CREATE TABLE normalized_table (
       id INT PRIMARY KEY,
       data_value VARCHAR(255)
   );

   INSERT INTO normalized_table (id, data_value)
   SELECT DISTINCT id, data_value
   FROM your_table;
   ```

### 7. **Correct Data Entry Errors**
   - Use `REPLACE()` or `UPDATE` statements to correct common data entry mistakes.

   ```sql
   UPDATE your_table
   SET column1 = REPLACE(column1, 'wrong_value', 'correct_value');
   ```

### 8. **Remove Outliers**
   - Use statistical methods or SQL queries to identify and handle outliers.

   ```sql
   SELECT *
   FROM your_table
   WHERE column1 NOT BETWEEN (SELECT AVG(column1) - 2 * STDDEV(column1) FROM your_table)
                           AND (SELECT AVG(column1) + 2 * STDDEV(column1) FROM your_table);
   ```

### 9. **Automate Data Cleaning**
   - Use scheduled jobs or scripts to automate regular data cleaning tasks.

   ```sql
   CREATE EVENT clean_data_event
   ON SCHEDULE EVERY 1 WEEK
   DO
   BEGIN
       -- Your cleaning queries here
   END;
   ```

These practices will help maintain clean, accurate, and reliable data in your SQL databases.
