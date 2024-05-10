
-- SQL Script Description:
-- This SQL script retrieves the lifespan of Glam rock bands from the 'metal_bands' table.
-- Lifespan is calculated as the difference in years between the 'formed' and 'split' dates,
-- or between 'formed' and '2022-01-01' if 'split' is NULL.
-- The resulting table contains two columns: 'band_name' and 'lifespan'.
-- It is intended to be executed on any SQL database.

-- Query Explanation:
SELECT band_name, COALESCE(split, 2022) - formed as lifespan FROM metal_bands
WHERE style LIKE '%Glam rock%' ORDER BY lifespan DESC;
