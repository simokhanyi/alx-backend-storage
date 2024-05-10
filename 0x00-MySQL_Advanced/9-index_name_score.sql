-- Index Maintenance:
-- Drops the index 'idx_name_first_score' on the 'names' table if it already exists.
-- Creates an index on the first letter of the 'name' column and the 'score' column in the 'names' table.

USE holberton;

-- Drop the index if it already exists
DROP INDEX IF EXISTS idx_name_first_score ON names;

-- Create the index on the first letter of the name column and the score column
CREATE INDEX idx_name_first_score ON names (LEFT(name, 1), score);
