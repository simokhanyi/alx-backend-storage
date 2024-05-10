-- Index Maintenance:
-- Drops the index 'idx_name_first' on the 'names' table if it already exists.
-- Creates an index on the first letter of the 'name' column in the 'names' table.

USE holberton;

-- Drop the index if it already exists
DROP INDEX IF EXISTS idx_name_first ON names;

-- Create the index on the first letter of the name column
CREATE INDEX idx_name_first ON names (LEFT(name, 1));
