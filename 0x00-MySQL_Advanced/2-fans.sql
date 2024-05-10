-- SQL Script Description:
-- This script ranks country origins of bands by the total number of (non-unique) fans.
-- The resulting table contains two columns: 'origin' and 'nb_fans'.
-- It can be executed on any SQL database.

-- Query Explanation:
SELECT origin, SUM(fans) as nb_fans FROM metal_bands
GROUP BY origin ORDER BY nb_fans DESC;
