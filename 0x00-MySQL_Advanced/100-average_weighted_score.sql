-- Procedure Description:
-- Computes the average weighted score for a specified user.
-- Parameters:
--   - user_id: ID of the user (INT)
-- Calculates the total weighted score and total weight for the user by summing the product of correction scores and project weights.
-- Updates the 'average_score' column in the 'users' table with the computed average weighted score.
-- If the total weight is 0, sets the average score to 0 to avoid division by zero.

DELIMITER //

CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    DECLARE total_score FLOAT;
    DECLARE total_weight FLOAT;
    
    -- Calculate total weighted score for the user
    SELECT SUM(corrections.score * projects.weight) INTO total_score
    FROM corrections
    INNER JOIN projects ON corrections.project_id = projects.id
    WHERE corrections.user_id = user_id;
    
    -- Calculate total weight for the user
    SELECT SUM(projects.weight) INTO total_weight
    FROM corrections
    INNER JOIN projects ON corrections.project_id = projects.id
    WHERE corrections.user_id = user_id;
    
    -- Compute average weighted score
    IF total_weight > 0 THEN
        UPDATE users
        SET average_score = total_score / total_weight
        WHERE id = user_id;
    ELSE
        UPDATE users
        SET average_score = 0
        WHERE id = user_id;
    END IF;
END //

DELIMITER ;
