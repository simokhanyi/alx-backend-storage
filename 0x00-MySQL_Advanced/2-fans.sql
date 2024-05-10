-- SQL Script Description:
-- This script ranks country origins of bands by the total number of (non-unique) fans.
-- The resulting table contains two columns: 'origin' and 'nb_fans'.
-- It can be executed on any SQL database.

-- Query Explanation:

SELECT origin, COUNT(*) AS nb_fans
FROM bands
GROUP BY origin
ORDER BY nb_fans DESC;
