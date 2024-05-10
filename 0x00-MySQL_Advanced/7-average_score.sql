-- Procedure Description:
-- Adds bonus scores for a user and project in the database.
-- Parameters: 
--   - p_user_id: User ID (INT)
--   - p_project_name: Project name (VARCHAR)
--   - p_score: Bonus score (INT)
-- Checks if the project exists; if not, creates it.
-- Inserts a new record into the 'corrections' table with user ID, project ID, and bonus score.

DELIMITER //

CREATE PROCEDURE ComputeAverageScoreForUser(
    IN p_user_id INT
)
BEGIN
    DECLARE avg_score DECIMAL(10, 2);

    -- Calculate average score for the user
    SELECT AVG(score) INTO avg_score
    FROM corrections
    WHERE user_id = p_user_id;

    -- Update the average_score for the user
    UPDATE users
    SET average_score = avg_score
    WHERE id = p_user_id;
END//

DELIMITER ;
