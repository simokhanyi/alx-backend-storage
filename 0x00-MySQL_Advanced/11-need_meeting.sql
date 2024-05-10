-- View Description:
-- Creates a view 'need_meeting' to identify students who need a meeting based on their score and last meeting date.
-- Selects 'name' from the 'students' table where score is less than 80 and either last meeting is NULL or occurred over a month ago.

-- Create view need_meeting
CREATE VIEW need_meeting AS
SELECT name
FROM students
WHERE score < 80 AND (last_meeting IS NULL OR last_meeting < DATE_SUB(NOW(), INTERVAL 1 MONTH));
