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
